class User < ActiveRecord::Base
  VALID_REGEX = /\A[a-z\d\-]+\z/i
  validates :name, presence: true, format: { with: VALID_REGEX }, length: { maximum: 39 }

  before_save { self.name = name.downcase }

  enum status: [ :wait, :in_progress, :completed, :wrong, :not_found, :rate_limit ]

  def execute

    self.in_progress!
    self.save

    begin 

      followers_data = get_user_data :followers

    rescue RestClient::Exception => e
      handle_rest_exception e
      return
    end

    followers = followers_data.count

    begin 

      repos_data = get_user_data :repos

    rescue RestClient::Exception => e
      handle_rest_exception e
      return
    end

    all_repo_watchers = 0
    all_repo_forks = 0

    repos_data.each do |child|
        all_repo_watchers += child['watchers']
        all_repo_forks += child['forks']
    end

    self.rating1 = followers + all_repo_watchers
    self.rating2 = all_repo_forks

    self.completed!

    self.save

  rescue => e
    self.wrong!
    self.save

    logger.error "Unexpected error (name = #{self.name}): #{e}, #{e.backtrace.join("\n")}"
  end

  #handle_asynchronously :execute

  private
    def get_user_data(path)
      request_to_user = "https://api.github.com/users/#{self.name}/#{path}"

      logger.info "RestClient request (url = #{request_to_user})..."

      response = RestClient.get("#{request_to_user}",
                     {:params => {:acess_token => Settings.access_token},
                      :accept => :json })

      logger.info "RestClient request done (body = #{response.body})."

      data = JSON.parse(response.body)

      return data
    end

    def handle_rest_exception e
      code = e.response.code

      if code == 403 #rate limit.
        self.rate_limit!
        self.save

        logger.info "Rate limit. (name = #{self.name}, message = #{e.response.body.message})"
        return
      end

      if code == 404 #not found.
        self.not_found!
        self.save

        logger.info "User not found. (name = #{self.name}, message = #{e.response.body.message})"
        return
      end

      self.wrong!
      self.save

      logger.debug "Handled exception (name = #{self.name}, code = #{code}): #{e}"
    end

end
