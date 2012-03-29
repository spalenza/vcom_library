class Directory < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :vcoms
  
  has_ancestry
  
  def ls
    self.children.concat self.vcoms
  end
end
