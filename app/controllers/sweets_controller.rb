class SweetsController < ApplicationController
  before_action :user_sweets
  before_action :set_user_sweet, only: %i[show_sweet update_sweet destroy_sweet]

  # GET /sweets
  def index
    #@sweets = Sweet.all
    #@sweets = current_user.sweets
    self_and_followers_ids = current_user.followers.pluck(:id) << current_user.id
    all_sweets = Sweet.where(user_id: self_and_followers_ids)
    json_response(all_sweets, :ok)
  end

  # POST /:username/sweets
  def create_sweet
    #@sweet = Sweet.create!(sweet_params)
    @sweet = current_user.sweets.create!(sweet_params)
    @sweet.save
    json_response(@sweet, :created)
      #redirect_to @sweet
  end

  # GET /:username/sweets/:sweet_id
  def show_sweet
    #if current_user.username == params[:username]
    #if @sweet.exists?
      #json_response(@sweet)
      ##end
      #else
    #json_response(@sweet, :not_found)
    json_response(@sweet)
    #end
  end

  # GET /:username/sweets
  def show_all_sweets
    #if current_user.username == params[:username]
    json_response(@sweets)
    #end
  end

  # PUT /:username/sweets/:sweet_id
  def update_sweet
    #binding.pry
    @sweet.update!(sweet_params)
    json_response(@sweet, :ok)
    #head :no_content
  end

  # DELETE /:username/sweets/favorites/:sweet_id
  def destroy_sweet
    @sweet.destroy
    json_response({ message: Message.sweet_removed }, :ok)
    #head :no_content
  end

  private

  def sweet_params
    # whitelist params
    params.permit(:description)
  end

  def user_sweets
   #@user = User.find(params[:username])
    if current_user.username == params[:username]
      @sweets = current_user.sweets
    end
  end

  def set_user_sweet
    #@sweet = Sweet.find(params[:id])
    if current_user.username == params[:username] && params[:sweet_id] != blank?
      @sweet = current_user.sweets.find_by!(id: params[:sweet_id])
    end

  rescue ActiveRecord::RecordNotFound
    json_response({ message: Message.sweet_not_found }, :not_found)
  end
end
