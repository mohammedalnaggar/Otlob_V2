class GroupMembersController < ApplicationController
  before_action :set_group_member, only: [:edit, :update, :destroy]
  before_action :get_group_members, only: [:index, :show]
  def index
    
  end

  def show
    
  end

  def new
    @users = User.where('id IN (?) AND id NOT IN (?)',Friendship.select("friend_id").where(user_id: current_user.try(:id)),GroupMember.select("user_id").where('group_id = (?)',params[:group_id]))
    @group = Group.find(params[:group_id])
  end

  # GET /group_members/1/edit
  def edit
  end

  # POST /group_members
  # POST /group_members.json
  def create
    @group = Group.find(params[:group_id])
    @group_member = @group.group_members.build(:user_id => params[:user_id])
    respond_to do |format|
      if @group_member.save
        format.html { redirect_to group_group_members_path, notice: 'Group member was successfully created.' }
        format.json { render :show, status: :created, location: @group_member }
      else
        format.html { render :new }
        format.json { render json: @group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_members/1
  # PATCH/PUT /group_members/1.json
  def update
    respond_to do |format|
      if @group_member.update(group_member_params)
        format.html { redirect_to @group_member, notice: 'Group member was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_member }
      else
        format.html { render :edit }
        format.json { render json: @group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group_member.destroy
    respond_to do |format|
      format.html { redirect_to group_group_members_path, notice: 'Group member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_member
      @group_member = GroupMember.find(params[:id])
    end

    def get_group_members
      @group_members = GroupMember.where('group_id = (?)',params[:group_id])
      @group = Group.find(params[:group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_member_params
      #params.require(:group_member).permit()
    end
end
