class EventsController < ApplicationController

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: "「#{@event.name}」を作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :place, :content, :start_at, :end_at)
  end
end
