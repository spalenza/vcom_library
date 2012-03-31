class Directory < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :files, class_name: "Vcom"
  
  has_ancestry orphan_strategy: :destroy
  
  validates_uniqueness_of :name
  
  def ls
    self.children.concat self.files
  end
end
