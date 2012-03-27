class Directory < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :vcoms
  
  has_ancestry
end
