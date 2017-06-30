require 'pry'
require 'nokogiri'
require 'open-uri'

class PlaysController < ApplicationController
  def index
    @play = Play.new
  end

  def create
    @play = Play.create(plays_params)
    redirect_to play_path(@play)
  end

  def show
    @play = Play.find(params[:id])
    doc = @play.fetch_xml
    characters = @play.get_character_hash
    @playObj = {'characters'=> characters, 'name' => @play.name}
  end

  private

  def plays_params
    params.require(:play).permit(:url,:name)
  end
end
