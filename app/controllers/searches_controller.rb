class SearchesController < ApplicationController
  before_action :authenticate_user!

  require "gracenote"
  require 'yaml'

  def index
    @search_result = []
  end

  def search

    config = YAML.load_file( 'config.yml' )
    gracenote_conf = config["gracenote"]
    spec = {:clientID => gracenote_conf["clientID"], :clientTag => gracenote_conf["clientTag"],
            :userID => gracenote_conf["userID"]}
    gracenote = Gracenote.new(spec)

    begin
      @search_result = gracenote.findTrack(params[:artist], params[:album_title], params[:track_title], "0")
      flash[:notice] = "楽曲情報を取得しました。"
      render 'index'
    rescue
      flash[:alert] = "楽曲情報を取得できませんでした。"
      render 'index'
    end

  end

end

