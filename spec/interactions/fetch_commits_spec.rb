require 'rails_helper'

describe FetchCommits do
  describe 'run' do
    let(:owner) { 'owner' }
    let(:repo) { 'repo' }
    let(:sha) { 'sha' }
    let(:page) { 1 }
    let(:per_page) { 10 }
    let(:success) { true }
    let(:data) { 'data' }
    let(:error_messages) { [] }
    let(:result) { double(success?: success, data: data, error_messages: error_messages) }

    let(:filters) do
      { 'sha' => sha, 'page' => page, 'per_page' => per_page }
    end

    subject { described_class.run(owner: owner, repo: repo, filters: filters) }

    context 'with valid arguments' do
      before do
        expect(CommitsFeed::Request).to receive(:new)
          .once
          .with(owner: owner, repo: repo, filters: filters)
          .and_return(double(call: result))
      end

      context 'when service result is successful' do
        let(:decorated_commits) { ['decorated_commits'] }

        before do
          expect(CommitDecorator).to receive(:decorate_collection)
            .once
            .with(data)
            .and_return(decorated_commits)
        end

        it 'returns valid outcome' do
          expect(subject.valid?).to eq true
        end

        it 'returns decorated commits in result' do
          expect(subject.result).to eq decorated_commits
        end

        it 'returns blank errors' do
          expect(subject.errors.blank?).to eq true
        end

        it 'returns blank error_messages' do
          expect(subject.error_messages.blank?).to eq true
        end
      end

      context 'when service result is not successful' do
        let(:success) { false }
        let(:error_messages) { ['Something went wrong'] }
        before { subject }

        it 'returns invalid outcome' do
          expect(subject.valid?).to eq false
        end

        it 'returns error_messages' do
          expect(subject.error_messages).to match_array error_messages
        end
      end
    end

    context 'with invalid arguments' do
      %w[owner repo].each do |arg|
        context "when #{arg} is blank" do
          let(:"#{arg}") { '' }

          it 'returns invalid outcome' do
            expect(subject.valid?).to eq false
          end

          it "returns error #{arg} cannot be blank" do
            expect(subject.errors.full_messages).to match_array ["#{arg.capitalize} can't be blank"]
          end
        end
      end
    end
  end
end
