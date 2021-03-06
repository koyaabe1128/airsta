class EventsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_users_event, only: [:edit, :update, :destroy]
  
  def index
    @events = Event.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    
    if @event.save
      flash[:notice] = "イベントを投稿しました。"
      redirect_to @event
    else
      render :new
    end
    
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    
    if @event.update(event_params)
      flash[:notice] = "イベントを編集しました。"
      redirect_to @event
    else
      render :edit
    end
    
  end

  def destroy
    @event = Event.find(params[:id])
    
    @event.destroy
    flash[:notice] = "イベントを削除しました。"
    redirect_to user_path(@event.user)
  end
  
  
  private
  
  #Strong Parameter
  def event_params
    params.require(:event).permit(:title, :event_at, :price, :place, :genre, :detail, :image, :kind)
  end
  
  def correct_users_event
    @event = current_user.events.find_by(id: params[:id])
    unless @event
      redirect_to current_user
    end
  end
  
end
