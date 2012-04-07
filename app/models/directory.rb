class Directory < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :files, class_name: "Vcom", :before_add => :validates_files
  
  has_ancestry orphan_strategy: :destroy
  
  validates_uniqueness_of :name, :scope => [:user_id, :ancestry]
  
  def ls
    self.children.concat self.files
  end
  
  def add_file(file)
    files.push(file)
  end
  
  def remove_file(file)
    raise ArgumentError,"File don't exist" unless self.files.include?(file)
    files.delete(file)
  end
  
  protected
    def validates_files(file)
      if self.files.include? file
        errors.add(:files, "Existing file")
        raise ActiveRecord::Rollback 
      else
        true
      end
    end
end
