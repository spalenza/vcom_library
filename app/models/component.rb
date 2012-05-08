require 'nokogiri'

class Component < ActiveRecord::Base
  belongs_to :vcom
  has_many :attributes

  has_ancestry orphan_strategy: :destroy
  
  def generate_tree(node)
    node.children.each do |child|
      if child.element?
        
        c_node = self.children.create name: child.name, vcom: self.vcom
        c_node.generate_tree(child) unless child.children.empty?
       
        child.attributes.each do |name, attribute|
          c_node.attributes.create name: attribute.name, value: attribute.value
        end
        
      end
    end
  end
  
  def has_attributes?
    !self.attributes.empty?
  end
end
