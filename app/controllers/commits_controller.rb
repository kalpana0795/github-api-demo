class CommitsController < ApplicationController
  def index
    result = CommitsFeed::Request.new(
      owner: 'rest-client', repo: 'rest-client', filters: filters
    ).call

    if result.success?
      @commits = result.data
    else
      @errors = result.error_messages
    end
  end

  private

  def filters
    params.permit(:sha, :page, :per_page).to_unsafe_h.symbolize_keys
  end
end
