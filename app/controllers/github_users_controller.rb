# frozen_string_literal: true

class GithubUsersController < ApplicationController
  def search; end

  def show
    @login = params[:login]
    user_info_response = HTTParty.get("https://api.github.com/users/#{@login}")
    repos_response = HTTParty.get("https://api.github.com/users/#{@login}/repos")

    if user_info_response.code == 200 && repos_response.code == 200
      @user_info = JSON.parse(user_info_response.body)
      @repository = JSON.parse(repos_response.body)
    else
      flash[:alert] = 'Помилка отримання інформації з GitHub. Можливо такого логіну не існує'
      redirect_to root_path
    end
  end
end
