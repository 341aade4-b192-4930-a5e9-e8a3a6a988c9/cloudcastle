require 'rest_client'

class GitHubService
  API_URL = "https://api.github.com"

  class << self
    def get_user_info(id)
      followers = get_followers(id),
      repos = get_repos(id)

      all_repo_watchers = 0
      all_repo_forks = 0

      repos.each do |child|
        all_repo_watchers += child['watchers']
        all_repo_forks += child['forks']
      end

      {
          status: :ok,
          followers: followers.count,
          all_repo_watchers: all_repo_watchers,
          all_repo_forks: all_repo_forks
      }
    rescue RestClient::Exception => e
      handle_rest_exception(id, e)
    rescue => e
      handle_exception(id, e)
    end

    private

    def get_followers(id)
      make_request("#{API_URL}/users/#{id}/followers")
    end

    def get_repos(id)
      make_request("#{API_URL}/users/#{id}/repos")
    end

    def make_request(url)
      Sidekiq.logger.info "RestClient request (url = #{url})..."

      response = RestClient.get(
          url,
          {
              params: {
                  acess_token: Settings.access_token
              },
              accept: :json
          }
      )

      Sidekiq.logger.info "RestClient request done (body = #{response.body})."

      JSON.parse(response.body)
    end

    def handle_rest_exception(id, e)
      case e.response.code
      when 404
        Sidekiq.logger.info "User not found. (id = #{id}, message = #{e.response.body.message})"
        {
            status: :not_found
        }
      when 403
        Sidekiq.logger.info "Rate limit. (id = #{id}, message = #{e.response.body.message})"
        {
            status: :rate_limit
        }
      else
        Sidekiq.logger.error "Unexpected response (id = #{id}, code = #{e.response.code}): #{e}"
        {
            status: :error
        }
      end
    end

    def handle_exception(id, e)
      Sidekiq.logger.error "Unexpected error (id = #{id}): #{e}, #{e.backtrace.join("\n")}"
      {
          status: :error
      }
    end
  end
end