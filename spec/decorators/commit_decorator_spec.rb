require 'rails_helper'

RSpec.describe CommitDecorator do
  let(:commit) { double(sha: '6dcb09b5b57875f334f61aebed695e2e4193db5e', committer_date: '2011-04-14T16:00:49Z') }
  subject { described_class.new(commit) }

  context '#readable_date' do
    it 'returns date in readable format' do
      expect(subject.readable_date).to eq '14 Apr 2011 at 16:00:49 UTC'
    end
  end

  context '#shortened_sha' do
    it 'returns first seven characters of sha' do
      expect(subject.shortened_sha).to eq '6dcb09b'
    end
  end
end
