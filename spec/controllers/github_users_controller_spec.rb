# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubUsersController, type: :controller do
  it 'renders search template' do
    get :search
    expect(response).to render_template :search
  end

  context 'with a valid GitHub login' do
    it 'renders the list template' do
      VCR.use_cassette('taras9393') do
        post :show, params: { login: 'taras9393' }
        expect(response).to render_template :show
      end
    end

    it 'assigns user info and repos' do
      VCR.use_cassette('m1ndg8mer') do
        post :show, params: { login: 'm1ndg8mer' }
        expect(assigns(:user_info)).to be_present
        expect(assigns(:repository)).to be_present
      end
    end
  end

  context 'with invalid GitHub login' do
    it 'renders the list template' do
      VCR.use_cassette('tarasv939djjfs3w2s') do
        post :show, params: { login: 'tarasv939djjfs3w2s' }
        expect(response).to redirect_to root_path
      end
    end

    it 'shows correct flah message' do
      VCR.use_cassette('tarasv939djjfs3w2s') do
        post :show, params: { login: 'tarasv939djjfs3w2s' }
        expect(flash[:alert]).to eq 'Помилка отримання інформації з GitHub. Можливо такого логіну не існує'
      end
    end
  end
end

# allow(HTTParty).to receive(:get).and_return(double(code: 404))
