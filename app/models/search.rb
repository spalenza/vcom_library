# encoding: UTF-8

class Search < ActiveRecord::Base
  serialize :element_tokens, Array

  def vcoms
    @vcoms ||= find_vcoms
  end

  protected
    def find_vcoms
      vcoms = Vcom.where("public = ? OR author_id = ?", true, user_id).order(:name)
      vcoms = vcoms.where("name like ?", "%#{name}%") unless name.empty?
      vcoms = vcoms.where("author_id = ?", user_id) if user_id.present?

      binding.pry
      unless self.element_tokens.empty?
        vcoms.each do |vcom|
          vcoms.delete(vcom) unless find_attributes(vcom)
        end
      end

      vcoms
    end

    def find_attributes(vcom)
      attributes = vcom.body.subtree.all.map(&:name)
      self.element_tokens.each do |element|
        if attributes.include? element
          return true
        end
      end
    end
end
