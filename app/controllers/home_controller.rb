class HomeController < ApplicationController

  def index
    if session[:user_id].nil?
      @oauth= Koala::Facebook::OAuth.new("184818248519177", "e65c5d4c46d30fa32fa7f52d963128d8",select_category_home_index_url)
      redirect_to @oauth.url_for_oauth_code(:permissions => ["publish_actions","public_profile","user_friends"])
    else
      redirect_to select_category_home_index_path
    end

  end

  def select_category

    if session[:user_id].nil?
      oauth= Koala::Facebook::OAuth.new("184818248519177", "e65c5d4c46d30fa32fa7f52d963128d8",select_category_home_index_url)
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
        end
      else
        session[:user_id] = @user.id
      end
    else
      @user = User.find(session[:user_id])
    end
  end

end
