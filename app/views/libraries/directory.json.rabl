object @directory
attributes :id, :name

unless @directory.vcoms.empty?
  child :vcoms do
     attributes :id, :name
  end
end

node :directories, :if => lambda { |directory| directory.has_children? } do
  partial("libraries/children", :object => @directory.children)
end