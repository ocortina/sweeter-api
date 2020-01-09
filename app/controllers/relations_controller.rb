class RelationsController < ApplicationController
  before_action :verify_user
  #before_action :find_favorite, only: [:destroy]

  # GET /:username/followers
  def show_all_followers
    @followers = @current_user_verified.followers
    json_response(@followers)
  end

  # GET /:username/followings
  def show_all_followings
    @followings = @current_user_verified.followings
    json_response(@followings)
  end

  # POST /:username/following/:following_id
  def start_following
    if already_following?
      json_response({ message: Message.user_already_following }, :ok)
    else
      @following = @current_user_verified.following_relationships
                                         .create!(following_id: params[:following_id])
      json_response(@following, :created)
    end
  end

  # DELETE /:username/following/:following_id
  def destroy_following
    if !already_following?
      json_response({ message: Message.user_not_following }, :ok)
    else
      @following = @current_user_verified.following_relationships
                                         .find_by!(following_id: params[:following_id])
                                         .destroy
      json_response(@favorite_sweets)
    end
  end


  private

  def already_following?
    Relation.where(follower_id: current_user.id, following_id: params[:following_id]).exists?
  end

  def verify_user
    if current_user.username == params[:username]
      @current_user_verified = current_user
    end
  end

end
