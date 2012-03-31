class LibrariesController < ApplicationController
  respond_to :html, :json
  
  before_filter :authenticate_user!
  
  def index
  end
end
