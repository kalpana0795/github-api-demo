module CommitsFeed
  class Request < BaseService
    def initialize(owner:, repo:, filters: {})
      super()

      @owner = owner
      @repo = repo
      @filters = filters
    end

    private

    attr_reader :owner, :repo, :filters

    def call!
      raw_commits = fetch_commits

      @data = Response.new(raw_commits).parse if @errors.blank?
    end

    def fetch_commits
      Client.new(owner: owner, repo: repo).resource(filters).get
    rescue RestClient::NotFound
      @errors << 'Not found'
    rescue RestClient::BadRequest
      @errors << 'Bad request'
    rescue RestClient::InternalServerError
      @errors << 'Internal server error'
    rescue RestClient::Forbidden
      @errors << 'Forbidden'
    rescue StandardError => e
      @errors << 'Something went wrong.'
      Rails.logger.info e
    end
  end
end
