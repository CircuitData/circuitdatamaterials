class FunctionsController < ApplicationController

  def index
    @functions = Function.all
    paginate json: @functions
  end

  def show
    @function = Function.find(params[:id])
    render json: @function#, include: 'materials'
  end
end
