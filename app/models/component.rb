class Component < ActiveRecord::Base
  has_many :vcoms
  has_many :components
  belongs_to :component
end
