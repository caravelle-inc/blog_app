class SearchesController < ApplicationController

  require "gracenote"
  require 'yaml'

  def index

    @result = []
    # p @result
    # redirect_to searches_path

  end

  def search

    config = YAML.load_file( 'config.yml' )
    gracenote_conf = config["gracenote"]
    spec = {:clientID => gracenote_conf["clientID"], :clientTag => gracenote_conf["clientTag"],
            :userID => gracenote_conf["userID"]}
    gracenote = Gracenote.new(spec)

    begin
    @result = gracenote.findTrack(params[:artist], params[:album_title], params[:track_title], "0")
    render 'index'
    rescue
      render 'index'
    end

  end

end

