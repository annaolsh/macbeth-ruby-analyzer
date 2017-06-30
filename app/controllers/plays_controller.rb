require 'pry'
require 'nokogiri'
require 'open-uri'

class PlaysController < ApplicationController
  def index
    @play = Play.new
  end

  def create
    playObj = Play.create(plays_params)
    redirect_to play_path(playObj)
  end

  def show
    playObj = Play.find(params[:id])
    doc = playObj.fetch_xml
    characters = playObj.get_character_hash
    @play = {'characters'=> characters, 'name' => playObj.name}
  end

  private

  def plays_params
    params.require(:play).permit(:url,:name)
  end
end
