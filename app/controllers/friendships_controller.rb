class FriendshipsController < ApplicationController
  # before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  # GET /friendships
  # GET /friendships.json
  def index
    @users = User.where('id IN (?) AND id != (?)',Friendship.select("friend_id").where(user_id: current_user.id),current_user.id) 
  end

  # GET /friendships/1
  # GET /friendships/1.json
     
  def show
    @user = User.find(params[:id])
  end


  # GET /friendships/new
  def new
    @users = User.where('id NOT IN (?) AND id != (?)',Friendship.select("friend_id").where(user_id: current_user.id),current_user.id) 
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
        if @friendship.save
          redirect_to friendships_path
        else
          flash[:notice] = "Unable to add friend."
        end
 
  end

 

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to friendships_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.fetch(:friendship, {})
    end
end
