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

      vcoms = vcoms.to_a

      unless self.element_tokens.empty?
        Array.new(vcoms).each do |vcom|
          vcoms.delete(vcom) unless find_attributes(vcom)
        end
      end
      vcoms
    end

    def find_attributes(vcom)
      if vcom.body.subtree.find_all_by_name(self.element_tokens).size == self.element_tokens.size
        true
      else
        false
      end
    end
end
