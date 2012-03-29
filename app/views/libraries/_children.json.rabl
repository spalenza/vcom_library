attribute :name => :data

node :attr do |u|
  if u.class == Directory
    attributes :id => u.id, :rel => :folder
  else
    attributes :id => u.id, :rel => :file
  end
end

node(:children) do |directory|
  if directory.class == Directory and directory.has_children?
    partial("libraries/children", :object => directory.ls)
  end
end