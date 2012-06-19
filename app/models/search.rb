# encoding: UTF-8

class Search < ActiveRecord::Base
  def vcoms
    @vcoms ||= find_vcoms
  end

  protected
    def find_vcoms
      vcoms = Vcom.order(:name)
      vcoms = vcoms.where("name like ?", "%#{name}%") unless name.empty?
      vcoms = vcoms.where("author_id = ?", user_id) if user_id.present?
      vcoms
      # if author.present?
      #   author = User.find_by_name
      # end
    end
end
