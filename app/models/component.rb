class Component < ActiveRecord::Base
  has_many :vcoms
  has_many :children, through: :subcomponents
end
