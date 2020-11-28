class CommitsController < ApplicationController
  def index
    result = CommitsFeed::Request.new(owner: 'rest-client', repo: 'rest-client').call

    @commits = result.data if result.success?
  end
end
