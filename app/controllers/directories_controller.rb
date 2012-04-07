class DirectoriesController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!
  layout :false

  def index
    @directory = current_user.directory
  end

  def create
    node_root = Directory.find params[:id]
    @node = node_root.children.create name: params[:name], user: current_user
  
    render "node.json.rabl"
  end
  
  def destroy
    @node = get_node
    
    @node.destroy unless @node.nil?
    
    render "node"
  end
  
  def update
    @node = get_node
    
    @node.update_attributes(name: params[:name]) unless @node.nil?
    
    render "node"
  end
  
  def move
    @node = get_node
    new_parent = Directory.find params[:new_parent]
    old_parent = Directory.find params[:old_parent]
  
    case @node.class.to_s
      when "Directory"
        @node.parent = new_parent unless @node.nil?
        @node.save
      when "Vcom"
        move_file(@node, old_parent, new_parent)
    end
    
    render "node"
  end
  
  protected
    def get_node
      case params[:type]
      when "folder"
        @node ||= Directory.find params[:id]
      when "file"
        @node ||= Vcom.find params[:id]
      end
      @node
    end
    
    def move_file(file, old_directory, new_directory)
      old_directory.remove_file file
      new_directory.add_file file
    end
end
