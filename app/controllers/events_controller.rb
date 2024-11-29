class EventsController < ApplicationController

  def new
    @event = current_user.events.build
  end
end
