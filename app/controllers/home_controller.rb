class HomeController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def index
    if session[:user_id].nil?
      @oauth= Koala::Facebook::OAuth.new(Rails.application.config.facebook_app_id, Rails.application.config.facebook_app_secret,select_category_home_index_url)
      redirect_to @oauth.url_for_oauth_code(:permissions => ["publish_actions","public_profile","user_friends"])
    else
      redirect_to select_category_home_index_path
    end

  end

  def select_category

    if session[:user_id].nil?
      oauth= Koala::Facebook::OAuth.new(Rails.application.config.facebook_app_id, Rails.application.config.facebook_app_secret,select_category_home_index_url)
      access_token = oauth.get_access_token(params[:code])
      graph = Koala::Facebook::API.new(access_token)

      @profile = graph.get_object("me")
      @friends = graph.get_connections("me", "friends")
      @user = User.find_by_fbid(@profile['id'])
      if @user.nil?
        @user = User.new
        @user.name = @profile['name']
        @user.fbid = @profile['id']
        if @user.save!
          session[:user_id] = @user.id
          session[:access_token] = access_token
        end
      else
        session[:user_id] = @user.id
      end
    else
      @user = User.find(session[:user_id])
      @user.lifes = 3
      @user.score = 0
      @user.save
    end
  end

  def game_over
    @user = User.find(session[:user_id])
  end

  def share_score
    # puts session[:access_token]
    # @user = User.find(session[:user_id])
    # unless session[:access_token].nil?
    #
    #   graph = Koala::Facebook::API.new(session[:access_token])
    #   graph.put_connections("me", "feed", message: "لقد حصلت على #{@user.score} فى لعبة اختبر معلوماتك")
    #   respond_to  do |format|
    #     format.js
    #   end
    # end
  end


end
