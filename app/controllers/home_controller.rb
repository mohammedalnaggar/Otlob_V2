class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def terms
  end

  def privacy
  end
end
