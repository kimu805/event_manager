class TicketsController < ApplicationController
  before_action :set_event

  def new
    raise ActionController::RoutingError, "ログイン状態でTicketsController#newにアクセス"
  end

  def create
    ticket = @event.tickets.build(event_params)
    if ticket.save
      redirect_to @event, notice: "「#{ @event.name }」に参加表明しました"
    else
      render "events/show", status: :unprocessable_entity
    end
  end

  def destroy
    ticket = current_user.tickets.find_by(event_id: params[:event_id])
    ticket.destroy!
    redirect_to event_path(@event.id), notice: "「#{ @event.name }」への参加をキャンセルしました"
  end

  private

  def event_params
    params.require(:ticket).permit(:comment).merge(user_id: current_user.id)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
