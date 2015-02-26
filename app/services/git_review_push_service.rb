class GitReviewPushService
  attr_accessor :project, :user, :push_data

  # client use
  # git push origin HEAD:refs/reviews/master/201502250613
  def execute(project, user, oldrev, newrev, ref)
    @project, @user = project, user
    @newrev = newrev
    @ref = ref
    @project.ensure_satellite_exists

    @merge_request = MergeRequests::CreateService.new(project, user, merge_request_params).execute
    Review.create(merge_request: @merge_request, ref: ref) if @merge_request.valid?

    Gitlab::GitLogger.debug(@merge_request.to_json)

    true
  end

  def review_branch
    branch = @ref.gsub("refs/reviews/", "")
    branch[0..branch.rindex('/')-1]
  end

  def merge_request_params
    {
      title: "#{user.name} need a code review",
      source_project_id: project.id,
      source_branch: @newrev,
      target_project_id: project.id,
      target_branch: review_branch,
      description: "a code review",
      label_ids: []
    }
  end

  private

  def create_push_data(oldrev, newrev, ref)
    Gitlab::PushDataBuilder.
      build(project, user, oldrev, newrev, ref, [])
  end
end
