class GroupsController < ApplicationController

  def index
    @groups = Group.all
    paginate json: @groups
  end

  def show
    @group = Group.find(params[:id])
    render json: @group
  end
end
