require 'nokogiri'

class Vcom < ActiveRecord::Base
  class Xml
    attr_accessor :xsd, :doc
    
    def initialize(opts={})
      @xsd = Nokogiri::XML::Schema(File.read(opts[:xsd]))
      @doc = Nokogiri::Slop(File.read(opts[:xml])).document
    end
  
    def valid?
      @xsd.valid?(@doc)
    end
    
    def header
      @doc.vcom.header
    end
    
    def body
      @doc.vcom.body
    end
    
    def author
      user = nil
      user_id = header.author.text.gsub(/\s+/, "")
      user = User.find user_id unless User.exist? user_id
    end
    
    def datetime
      header.datetime
    end
  end
  
  belongs_to :user
  has_one :body, class_name: "Component"
  has_and_belongs_to_many :directories
  
  validates_presence_of :attachment

  before_create :validate_xml
  after_create :create_body
  
  mount_uploader :attachment, AttachmentUploader
  
  protected    
    def get_xml
      @xml = Xml.new(
        xsd: "#{Rails.public_path}/vcom_schema.xsd",
        xml: self.attachment.current_path)
    end
    
    def validate_xml
      get_xml
      unless @xml.valid?  
        errors.add(:attachment, "Xml isn't valid.")
        raise ActiveRecord::Rollback 
      end
    end

    def create_body
      root = @xml.body
      self.build_body name: root.name
      self.body.generate_tree(root) if self.save
    end
    
    def get_header
      header = Nokogiri::Slop File.read(self.attachment.current_path).document.vcom.header
      
    end
end
