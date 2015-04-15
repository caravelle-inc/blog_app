class SearchesController < ApplicationController


  before_action :set_articles_new
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
    # begin
    @result = gracenote.findTrack(params[:artist], params[:album_title], params[:track_title], "0")
    p @result
    render 'index'
    # rescue
    #   render 'index'
    # end

  end

  private

  def set_articles_new
    @articles_new = Article.order('id DESC').limit(10)
  end
end


# spec = {:clientID => "5563648", :clientTag => "83EEF93A6CC7506A5E2FA67D98A56C1B",
#         :userID => "27115191738128502-AA7E50383650DED190B74E9CF9FBF8E2"}
# gracenote = Gracenote.new(spec)
# @result = gracenote.findTrack("ゆらゆら帝国", "", "美しい", "0")