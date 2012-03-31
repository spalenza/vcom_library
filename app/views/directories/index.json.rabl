object @directory
attribute :name => :data

# Pasta root expandida.
node :state do
  "open"
end

node :attr do
  attributes :id => @directory.id, :rel => :root
end


node :children do
  unless @directory.ls.empty?
    partial("directories/children", :object => @directory.ls)
  end
end