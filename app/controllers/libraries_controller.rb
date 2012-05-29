class LibrariesController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!

  def index
    @vcoms = Vcom.page(params[:page]).per_page(5)
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
        format.js { render 'empty_search' }
      end
    end
  end
end
