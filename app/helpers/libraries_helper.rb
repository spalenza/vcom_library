# encoding: UTF-8
module LibrariesHelper
  def create_vcom_tree(node, html="")
    if node.has_children?
      html << "<ul>"
      node.children.each do |child|
        link = link_to child.name, '#'
        html << "<li rel='#{child.name}'>"
        html << "<span class='#{name_icon(child.name)}'></span>"
        html << "#{link}"

        create_vcom_tree(child, html) unless child.children.empty?
        
        if child.has_attributes?
          html << "<ul>"
          child.attributes.each do |atribute|
            link_attr = link_to "#{atribute.name}: #{atribute.value}" , "#"
            html << "<li rel='icon-attribute'>"
            html << "<span class='icon-pencil'></span>"
            html << "#{link_attr}</li>"
          end
          html << "</ul>"
        end
        
        html << "</li>"
      end
      html << "</ul>"
    end
    html
  end
  
  protected
    def name_icon(name)
      case name
      when "vcom"
        "icon-book"
      when "comments"
        "icon-list"
      when "comment"
        "icon-comment"
      when "title"
        "icon-font"
      when "text"
        "icon-text-height"
      when "author"
        "icon-user"
      when "users"
        "icon-user"
      when "datetime"
        "icon-time"
      when "content"
        "icon-align-justify"
      else
        "icon-file"
      end
    end
end
