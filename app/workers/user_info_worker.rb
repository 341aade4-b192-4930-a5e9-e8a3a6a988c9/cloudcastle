class UserInfoWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)

    user.update!(status: :in_progress)

    result = GitHubService.get_user_info(user.name)

    case result[:status]
    when :ok
      user.update!(
          rating1: result[:followers] + result[:all_repo_watchers],
          rating2: result[:all_repo_forks],
          status: :completed
      )
    when :not_found
      user.update!(status: :not_found)
    else
      user.update!(status: :error)
    end
  end
end
