require 'nokogiri'

class Vcom < ActiveRecord::Base
  class Xml
    attr_accessor :xsd, :doc
    
    def initialize(opts={})
      @xsd = Nokogiri::XML::Schema(File.read(opts[:xsd]))
      slop = Nokogiri::Slop(File.read(opts[:xml]))
      slop.xpath('//text()[not(normalize-space())]').remove
      slop.xpath('//comment()').remove
      @doc = slop.document
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
      user_id = header.author.text.to_i
      user = User.find user_id if User.exists? user_id
      user
    end
    
    def registered_at
      header.datetime.text.to_datetime
    end
    
    def public?
      header.public.text == "true"
    end
    
    def name
      header.title.text
    end
    
    def description
      header.css("description").text
    end
  end
  
  belongs_to :author, class_name: "User"
  has_one :body, class_name: "Component"
  has_and_belongs_to_many :directories
  
  validates_presence_of :attachment

  before_create :validate_xml
  after_create :create_vcom
  
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
    
    def create_vcom
      self.author = @xml.author
      self.description = @xml.description
      self.name = @xml.name
      self.public = @xml.public?
      self.registered_at = @xml.registered_at
      
      root = @xml.body
      self.build_body name: root.name
      self.body.generate_tree(root) if self.save
    end
    
    def get_header
      header = Nokogiri::Slop File.read(self.attachment.current_path).document.vcom.header
    end
end
