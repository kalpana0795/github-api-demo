require 'rails_helper'

describe ApplicationHelper do
  context '#readable_date' do
    let(:iso8601date) { '2011-04-14T16:00:49Z' }
    subject { helper.readable_date(iso8601date) }

    it 'returns date in readable format' do
      is_expected.to eq '14 Apr 2011'
    end
  end

  context '#owner_url' do
    let(:owner) { 'owner' }
    subject { helper.owner_url(owner) }

    it 'returns correct url' do
      is_expected.to eq "#{ENV.fetch('GITHUB_BASE_HTML_URL')}/owner"
    end
  end
end
