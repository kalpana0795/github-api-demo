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
      response = fetch_commits

      @data = JSON.parse(response)
    end

    def fetch_commits
      Client.new(owner: owner, repo: repo).resource(options).get
    end
  end
end
