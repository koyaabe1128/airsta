class LikesController < ApplicationController
  
  before_action :require_user_logged_in
  
  def create
    @event = Event.find(params[:event_id])
    like = current_user.likes.build(event_id: @event.id)
    like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @event = Event.find(params[:id])
    like = current_user.likes.find_by(event_id: @event.id)
    like.destroy
    redirect_back(fallback_location: root_path)
  end
end
