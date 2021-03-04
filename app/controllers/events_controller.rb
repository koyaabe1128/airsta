class EventsController < ApplicationController
  
  before_action :require_user_logged_in
  
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
      flash.now[:notice] = "イベントを投稿できませんでした。"
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
      flash.now[:notice] = "イベントを編集できませんでした。"
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
    params.require(:event).permit(:title, :event_at, :price, :place, :genre, :detail, :image)
  end

end
