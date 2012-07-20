require 'rubygems'
require 'nokogiri'
require 'open-uri'


def vcom_tree(node, n)
  node.children.each do |child|
    if child.element?
      n.times { putc "+" }
      puts " #{child.name}"
      vcom_tree(child, n + 1) unless child.children.empty?
    end
  end
end

file = File.open("example.xml")
doc = Nokogiri::XML(file)

xsd = Nokogiri::XML::Schema(File.read("schema.xsd"))
xsd.validate(doc).each do |error|
  puts error.message
end

# if xsd.valid?(doc)
#   body = doc.css("body").first
#   # body.each do |vcom|
#   #   puts vcom.name if vcom.element?
#   # end
#   vcom_tree(body, 1)
# end

file.close


