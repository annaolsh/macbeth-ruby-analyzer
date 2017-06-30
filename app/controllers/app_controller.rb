class AppController < ApplicationController
  def index
    @play = Play.new
  end
end
