class FetchCommits < ActiveInteraction::Base
  string :owner
  string :repo

  hash :filters do
    integer :page
    integer :per_page
    string :sha
  end

  validates_presence_of :owner, :repo

  array :error_messages, default: nil

  def execute
    result = CommitsFeed::Request.new(
      owner: owner, repo: repo, filters: filters
    ).call

    if result.success?
      CommitDecorator.decorate_collection(result.data)
    else
      @error_messages = result.error_messages
      errors.add(:error_messages)
    end
  end
end
