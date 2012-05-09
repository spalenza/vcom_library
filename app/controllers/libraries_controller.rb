class LibrariesController < ApplicationController
  respond_to :html, :json
  
  before_filter :authenticate_user!
  
  def index
    @vcoms = Vcom.page(params[:page]).per_page(5)
  end
end
