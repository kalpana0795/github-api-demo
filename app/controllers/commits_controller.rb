class CommitsController < ApplicationController
  before_action :set_owner_and_repo, :set_default_params

  def index
    result = CommitsFeed::Request.new(
      owner: @owner, repo: @repo, filters: filters
    ).call

    if result.success?
      @commits = CommitDecorator.decorate_collection(result.data)
    else
      flash.now[:danger] = result.error_messages
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
