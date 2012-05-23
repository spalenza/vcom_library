attribute :name => :data

node :attr do |u|
  if u.class == Directory
    u.fixed? ? (attributes :id => u.id, :rel => :fixed) : (attributes :id => u.id, :rel => :folder)
  else
    attributes :id => u.id, :rel => :file
  end
end

node :children do |directory|
  partial("directories/children", :object => directory.respond_to?(:ls) ? directory.ls : [])
end