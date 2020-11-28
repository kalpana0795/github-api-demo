module CommitsFeed
  class Client
    BASE_URL = ENV.fetch('COMMITS_FEED_BASE_URL')
    TIMEOUT_SECONDS = 30
    OPEN_TIMEOUT_SECONDS = 5

    def initialize(owner:, repo:)
      @url = "#{BASE_URL}/#{owner}/#{repo}/commits"
      @headers = { 'Accept': 'application/vnd.github.v3+json' }
    end

    def resource(options)
      url = url_with_params(options)

      RestClient::Resource.new(url, headers: headers)
    end

    private

    attr_reader :url, :headers

    def url_with_params(options)
      "#{url}?#{URI.encode_www_form(options)}"
    end
  end
end
