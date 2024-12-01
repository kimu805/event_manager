class EventsController < ApplicationController
  skip_before_action :authenticate, only: :show
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, notice: "「#{ @event.name }」を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @ticket = @event.tickets.build
    @have_ticket = current_user && current_user.tickets.find_by(event: @event)
    @tickets = @event.tickets.includes(:user)
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "「#{ @event.name }」を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path, notice: "「#{ @event.name }」を削除しました"
  end

  private
  def event_params
    params.require(:event).permit(:name, :place, :content, :start_at, :end_at)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
