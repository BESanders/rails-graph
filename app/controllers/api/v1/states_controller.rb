class Api::V1:StatesController < ApplicationController
  def index
    byebug
    @states= DB[:states].all
    render json: @states, callback: params["callback"]
  end
end

