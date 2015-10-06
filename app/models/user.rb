class User < ActiveRecord::Base
  enum status: [ :wait, :in_progress, :completed, :wrong ]
  def execute

    self.in_progress!
    self.save

    request_to_user = "https://api.github.com/users/#{self.name}"

    result = RestClient.get("#{request_to_user}/followers",
                 {:params => {:acess_token => Settings.access_token},
                  :accept => :json })
			
    data = JSON.parse(result.body)

    followers = data.count

    result = RestClient.get("#{request_to_user}/repos",
                 {:params => {:acess_token => Settings.access_token},
                  :accept => :json })

    data = JSON.parse(result.body)

    all_repo_watchers = 0
    all_repo_forks = 0

    data.each do |child|
        all_repo_watchers += child['watchers']
        all_repo_forks += child['forks']
    end

    self.rating1 = followers + all_repo_watchers
    self.rating2 = all_repo_forks

    self.completed!

    self.save
  rescue => exception
    self.wrong!
    self.save

    logger.error "exception"
  end

  #handle_asynchronously :execute
end
