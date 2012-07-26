require 'nokogiri'

class Vcom < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_one :body, class_name: "Element"
  has_and_belongs_to_many :directories

  validates :attachment, :presence => true, :if => :validate_xml?

  before_validation :get_xml
  after_create :create_vcom

  mount_uploader :attachment, AttachmentUploader

  protected
    def get_xml
      @xml = Xml.new(
        xsd: "#{Rails.public_path}/project/xsd/schema.xsd",
        xml: self.attachment.current_path)
    end

    def validate_xml?
      @xml.valid?
    end

    def create_vcom
      self.vcom_id = @xml.id
      self.author = @xml.author
      self.description = @xml.description
      self.name = @xml.name
      self.public = @xml.public?
      self.registered_at = @xml.registered_at

      root = @xml.body
      self.build_body name: root.name
      self.body.generate_tree(root) if self.save
      self.author.my_vcoms_directory.add_file(self) unless self.author.nil?
    end
end