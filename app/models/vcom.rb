class Vcom < ActiveRecord::Base
  belongs_to :user
  has_many :components
  has_and_belongs_to_many :directories
end
