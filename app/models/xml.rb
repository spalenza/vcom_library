require 'nokogiri'

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