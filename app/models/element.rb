# encoding: UTF-8
require 'nokogiri'

class Element < ActiveRecord::Base
  attr_accessible :name, :vcom

  belongs_to :vcom
  has_many :attributes

  has_ancestry orphan_strategy: :destroy

  validates_presence_of :name

  def generate_tree(node)
    node.children.each do |child|
      if child.element?
        node = self.children.create name: child.get_attribute("name"), vcom: self.vcom
        node.generate_tree(child) unless child.children.empty?

        child.attributes.each do |name, attribute|
          node.attributes.create name: attribute.name, value: attribute.value unless attribute.name == "name"
        end
      end
    end
  end

  def has_attributes?
    !self.attributes.empty?
  end
end

