# encoding: UTF-8

class VcomsController < InheritedResources::Base

  def show
    @vcom = Vcom.find(params[:id])
    render :layout => false
  end
end