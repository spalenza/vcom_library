# encoding: UTF-8

class LibrariesController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!

  def index
    @vcoms = Vcom.where("public = ? OR author_id = ?", true, current_user.id).order('created_at DESC').page(params[:page]).per_page(5)
    @search = Search.new
  end

  def search
    keywords = params[:keywords]
    @vcoms = Vcom.where("name like ?", "%#{keywords}%") if keywords.present?
    unless @vcoms.empty?
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render 'searches/empty_search' }
      end
    end
  end
end
