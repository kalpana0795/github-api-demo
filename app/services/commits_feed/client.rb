module CommitsFeed
  class Client
    BASE_URL = ENV.fetch('COMMITS_FEED_BASE_URL')
    TIMEOUT_SECONDS = 30
    OPEN_TIMEOUT_SECONDS = 30

    def initialize(owner:, repo:)
      @url = "#{BASE_URL}/#{owner}/#{repo}/commits"
      @headers = { 'Accept': 'application/vnd.github.v3+json' }
    end

    def resource(filters)
      url = url_with_params(filters)

      RestClient::Resource.new(
        url,
        headers: headers,
        timeout: TIMEOUT_SECONDS,
        open_timeout: OPEN_TIMEOUT_SECONDS
      )
    end

    private

    attr_reader :url, :headers

    def url_with_params(filters)
      "#{url}?#{URI.encode_www_form(filters)}"
    end
  end
end
