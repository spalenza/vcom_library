# encoding: UTF-8

class Attribute < ActiveRecord::Base
  belongs_to :element
end
