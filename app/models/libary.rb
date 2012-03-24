class Libary < ActiveRecord::Base
  belongs_to :user
  has_many :directories
end
