class CommitsController < ApplicationController
  before_action :set_owner_and_repo

  def index
    result = CommitsFeed::Request.new(
      owner: @owner, repo: @repo, filters: filters
    ).call

    if result.success?
      @commits = result.data
    else
      @errors = result.error_messages
    end
  end

  private

  def filters
    params.permit(:sha, :page, :per_page).to_h.symbolize_keys
  end

  def set_owner_and_repo
    @owner = params[:owner].presence || ENV.fetch('DEFAULT_OWNER')
    @repo = params[:repo].presence || ENV.fetch('DEFAULT_REPO')
  end
end
