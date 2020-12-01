class CommitsController < ApplicationController
  before_action :set_owner_and_repo, :set_default_params

  def index
    outcome = FetchCommits.run(
      owner: @owner, repo: @repo, filters: filters
    )

    if outcome.valid?
      @commits = outcome.result
    else
      flash.now[:danger] = outcome.error_messages.presence || outcome.errors.full_messages
    end
  end

  private

  def filters
    params.slice(:sha, :page, :per_page).to_enum.to_h
  end

  def set_owner_and_repo
    @owner = params[:owner].presence || ENV.fetch('DEFAULT_OWNER')
    @repo = params[:repo].presence || ENV.fetch('DEFAULT_REPO')
  end

  def set_default_params
    params[:sha] = params[:sha].presence || 'master'
    params[:page] = params[:page].presence || '1'
    params[:per_page] = params[:per_page].presence || '10'
  end
end
