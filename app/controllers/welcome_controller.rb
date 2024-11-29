class WelcomeController < ApplicationController
  skip_before_action :authenticate
  def index
    @events = Event.includes(:owner)
  end
end
