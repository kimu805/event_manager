class TicketsController < ApplicationController
  def new
    raise ActionController::RoutingError, "ログイン状態でTicketsController#newにアクセス"
  end

  def create
    @event = Event.find(params[:event_id])
    @ticket = @event.tickets.build(event_params)
    if @ticket.save
      redirect_to @event, notice: "「#{ @event.name }」に参加表明しました"
    else
      render "events/show", status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:ticket).permit(:comment).merge(user_id: current_user.id)
  end
end
