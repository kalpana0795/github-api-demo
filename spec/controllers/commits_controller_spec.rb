require 'rails_helper'

describe CommitsController, type: :controller do
  describe 'GET index' do
    let(:owner) { 'owner' }
    let(:repo) { 'repo' }
    let(:sha) { 'sha' }
    let(:page) { 'page' }
    let(:per_page) { 'per_page' }
    let(:valid) { true }
    let(:result) { 'result' }
    let(:error_messages) { 'error_messages' }

    let(:filters) do
      { 'sha' => sha, 'page' => page, 'per_page' => per_page }
    end

    let(:params) do
      { sha: sha, page: page, per_page: per_page, owner: owner, repo: repo }
    end

    subject { get :index, params: params }

    before do
      expect(FetchCommits).to receive(:run)
        .once
        .with(owner: owner, repo: repo, filters: filters)
        .and_return(
          double(
            valid?: valid,
            result: result,
            error_messages: error_messages,
            errors: double(full_messages: error_messages)
          )
        )
    end

    context 'calls commits feed request with correct arguments' do
      it { is_expected.to be_successful }
    end

    context 'when outcome successful' do
      before { subject }

      it 'assigns @commits value' do
        expect(assigns(:commits)).to eq result
      end

      it 'does not set error in flash' do
        expect(flash[:danger]).to eq nil
      end
    end

    context 'when outcome is not successful' do
      let(:valid) { false }
      before { subject }

      it 'does not assign @commits value' do
        expect(assigns(:commits)).to eq nil
      end

      it 'sets error in flash' do
        expect(flash[:danger]).to eq error_messages
      end
    end

    context 'when params are not sent' do
      let(:sha) { 'master' }
      let(:page) { '1' }
      let(:per_page) { '10' }
      let(:owner) { ENV.fetch('DEFAULT_OWNER') }
      let(:repo) { ENV.fetch('DEFAULT_REPO') }
      let(:params) { {} }
      before { subject }

      it 'assigns default sha' do
        expect(controller.params[:sha]).to eq sha
      end

      it 'assigns default page' do
        expect(controller.params[:page]).to eq page
      end

      it 'assigns default per_page' do
        expect(controller.params[:per_page]).to eq per_page
      end

      it 'assigns default owner' do
        expect(assigns(:owner)).to eq owner
      end

      it 'assigns default repo' do
        expect(assigns(:repo)).to eq repo
      end
    end
  end
end
