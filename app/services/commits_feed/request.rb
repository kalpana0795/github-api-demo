module CommitsFeed
  class Request < BaseService
    def initialize(owner:, repo:, **options)
      super()

      @owner = owner
      @repo = repo
      @options = options
    end

    private

    attr_reader :owner, :repo, :options

    def call!
      raw_commits = fetch_commits

      @data = Response.new(raw_commits).parse
    end

    def fetch_commits
      Client.new(owner: owner, repo: repo).resource(options).get
    end
  end
end
