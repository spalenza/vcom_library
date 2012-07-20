# encoding: UTF-8

class SearchesController < InheritedResources::Base
  respond_to :js

  def create
    user = User.find_by_name(params[:search][:user_id])
    params[:search][:user_id] = params[:search][:user_id].to_s.empty? ? nil : (user.nil? ? 0 : user.try(:id))
    params[:search][:element_tokens] = params[:search][:element_tokens].split(',')
    @search = Search.create!(params[:search])
    redirect_to @search
  end

  def show
    search = Search.find(params[:id])
    @vcoms = search.vcoms
    render 'empty_search' if @vcoms.empty?
  end

  def elements
    @elements = Element.where("name like ?", "%#{params[:q]}%").uniq!(&:name)
  end
end
