require 'rails_helper'

describe CommitsFeed::Request do
  let(:owner) { 'owner' }
  let(:repo) { 'repo' }
  let(:raw_commits) { [{ 'a': 1, 'b': 2 }, { 'c': 3, 'd': '4' }] }

  describe 'call!' do
    subject { described_class.new(owner: owner, repo: repo).send(:call!) }

    before do
      expect(CommitsFeed::Response).to receive(:new)
        .once
        .with(raw_commits)
        .and_return(double(parse: true))

      expect(CommitsFeed::Client).to receive(:new)
        .once
        .with(owner: owner, repo: repo)
        .and_return(double(resource: double(get: raw_commits)))
    end

    it 'calls CommitsFeed::Client and CommitsFeed::Response with correct arguments' do
      subject
    end
  end
end
