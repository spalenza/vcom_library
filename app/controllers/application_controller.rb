# encoding: UTF-8

class ApplicationController < ActionController::Base
  respond_to :html

  protect_from_forgery
end
