class FavoritesController < ApplicationController
  before_action :verify_user
  #before_action :find_favorite, only: [:destroy]

  # GET /:username/favorites
  def show_all_favorite_sweets
    @favorite_sweets = @current_user_verified.favorite_sweets
    json_response(@favorite_sweets)
  end

  # POST /:username/sweets/:sweet_id/favorite
  def favorite_sweet
    if already_favorite?
      json_response({ message: Message.sweet_already_liked }, :ok)
    else
      @favorite_sweet = @current_user_verified.favorite_sweets_relationships
                                              .create!(sweet_id: params[:sweet_id])
      json_response(@favorite_sweet)
    end
  end

  # DELETE /:username/sweets/favorites/:sweet_id
  def destroy_favorite_sweet
    if !already_favorite?
      json_response({ message: Message.sweet_already_unliked }, :ok)
    else
      @favorite_sweet = @current_user_verified.favorite_sweets_relationships
                                              .find_by!(sweet_id: params[:sweet_id])
                                              .destroy
      json_response(@favorite_sweets)
      #head :no_content
    end
  end

  private

  def already_favorite?
    Favorite.where(user_id: current_user.id, sweet_id: params[:sweet_id])
            .exists?
  end

  def verify_user
    if current_user.username == params[:username]
      @current_user_verified = current_user
    end
  end
end
