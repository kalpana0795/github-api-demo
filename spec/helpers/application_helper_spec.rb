require 'rails_helper'

describe ApplicationHelper do
  context '#owner_url' do
    let(:owner) { 'owner' }
    subject { helper.owner_url(owner) }

    it 'returns correct url' do
      is_expected.to eq "#{ENV.fetch('GITHUB_BASE_HTML_URL')}/owner"
    end
  end
end
