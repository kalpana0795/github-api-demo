require 'rails_helper'

describe CommitsFeed::Client do
  describe 'resource' do
    let(:url) { "#{ENV.fetch('COMMITS_FEED_BASE_URL')}/owner/repo/commits?sha=sha&page=page&per_page=per_page" }
    let(:headers) do
      { 'Accept': 'application/vnd.github.v3+json' }
    end

    let(:owner) { 'owner' }
    let(:repo) { 'repo' }
    let(:filters) do
      { sha: 'sha', page: 'page', per_page: 'per_page' }
    end

    subject { described_class.new(owner: owner, repo: repo).resource(filters) }

    it 'returns correct RestClient::Resource object url' do
      expect(subject.url).to eq url
    end

    it 'returns correct RestClient::Resource object headers' do
      expect(subject.headers).to eq headers
    end
  end
end
