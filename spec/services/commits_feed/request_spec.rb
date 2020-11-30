require 'rails_helper'

describe CommitsFeed::Request do
  let(:owner) { 'owner' }
  let(:repo) { 'repo' }
  let(:raw_commits) do
    "[{\"url\":\"https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e\",\"sha\":\"6dcb09b5b57875f334f61aebed695e2e4193db5e\",\"node_id\":\"MDY6Q29tbWl0NmRjYjA5YjViNTc4NzVmMzM0ZjYxYWViZWQ2OTVlMmU0MTkzZGI1ZQ==\",\"html_url\":\"https://github.com/octocat/Hello-World/commit/6dcb09b5b57875f334f61aebed695e2e4193db5e\",\"comments_url\":\"https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e/comments\",\"commit\":{\"url\":\"https://api.github.com/repos/octocat/Hello-World/git/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e\",\"author\":{\"name\":\"Monalisa Octocat\",\"email\":\"support@github.com\",\"date\":\"2011-04-14T16:00:49Z\"},\"committer\":{\"name\":\"Monalisa Octocat\",\"email\":\"support@github.com\",\"date\":\"2011-04-14T16:00:49Z\"},\"message\":\"Fix all the bugs\",\"tree\":{\"url\":\"https://api.github.com/repos/octocat/Hello-World/tree/6dcb09b5b57875f334f61aebed695e2e4193db5e\",\"sha\":\"6dcb09b5b57875f334f61aebed695e2e4193db5e\"},\"comment_count\":0,\"verification\":{\"verified\":false,\"reason\":\"unsigned\",\"signature\":null,\"payload\":null}},\"author\":{\"login\":\"octocat\",\"id\":1,\"node_id\":\"MDQ6VXNlcjE=\",\"avatar_url\":\"https://github.com/images/error/octocat_happy.gif\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/octocat\",\"html_url\":\"https://github.com/octocat\",\"followers_url\":\"https://api.github.com/users/octocat/followers\",\"following_url\":\"https://api.github.com/users/octocat/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/octocat/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/octocat/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/octocat/subscriptions\",\"organizations_url\":\"https://api.github.com/users/octocat/orgs\",\"repos_url\":\"https://api.github.com/users/octocat/repos\",\"events_url\":\"https://api.github.com/users/octocat/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/octocat/received_events\",\"type\":\"User\",\"site_admin\":false},\"committer\":{\"login\":\"octocat\",\"id\":1,\"node_id\":\"MDQ6VXNlcjE=\",\"avatar_url\":\"https://github.com/images/error/octocat_happy.gif\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/octocat\",\"html_url\":\"https://github.com/octocat\",\"followers_url\":\"https://api.github.com/users/octocat/followers\",\"following_url\":\"https://api.github.com/users/octocat/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/octocat/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/octocat/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/octocat/subscriptions\",\"organizations_url\":\"https://api.github.com/users/octocat/orgs\",\"repos_url\":\"https://api.github.com/users/octocat/repos\",\"events_url\":\"https://api.github.com/users/octocat/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/octocat/received_events\",\"type\":\"User\",\"site_admin\":false},\"parents\":[{\"url\":\"https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e\",\"sha\":\"6dcb09b5b57875f334f61aebed695e2e4193db5e\"}]}]" # rubocop:disable Style/StringLiterals
  end

  let(:parsed_commits) do
    [
      {
        sha: '6dcb09b5b57875f334f61aebed695e2e4193db5e',
        url: 'https://github.com/octocat/Hello-World/commit/6dcb09b5b57875f334f61aebed695e2e4193db5e',
        message: 'Fix all the bugs',
        committer_date: '2011-04-14T16:00:49Z',
        verified: false,
        author: 'octocat',
        author_url: 'https://github.com/octocat',
        committer: 'octocat',
        committer_url: 'https://github.com/octocat'
      }
    ]
  end

  let!(:request_obj) { described_class.new(owner: owner, repo: repo) }

  before do
    expect(CommitsFeed::Response).to receive(:new)
      .once
      .with(raw_commits)
      .and_return(double(parse: parsed_commits))

    expect(CommitsFeed::Client).to receive(:new)
      .once
      .with(owner: owner, repo: repo)
      .and_return(double(resource: double(get: raw_commits)))
  end

  describe 'call!' do
    subject { request_obj.send(:call!) }

    it 'calls CommitsFeed::Client and CommitsFeed::Response with correct arguments' do
      subject
    end
  end

  describe 'call' do
    subject { request_obj.call }

    it 'assigns correct data value' do
      expect(subject.data).to match_array parsed_commits
    end

    context 'when commits are blank' do
      let(:parsed_commits) { [] }

      it 'assigns correct errors value' do
        expect(subject.errors).to match_array ['No commits found.']
      end
    end
  end
end
