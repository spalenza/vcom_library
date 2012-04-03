class Vcom < ActiveRecord::Base
  belongs_to :user
  has_many :components
  has_and_belongs_to_many :directories
  
  attr_accessible :attachment
  
  mount_uploader :attachment, AttachmentUploader
end
