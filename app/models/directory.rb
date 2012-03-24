class Directory < ActiveRecord::Base
  belongs_to :libary
  has_and_belongs_to_many :vcoms
end
