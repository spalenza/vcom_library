attributes :id, :name

node(:vcoms, :unless => lambda { |directory| directory.vcoms.empty? }) do |directory|
  partial("libraries/vcoms", :object => directory.vcoms)
end


node(:directories, :if => lambda { |directory| directory.has_children? }) do |directory|
  partial("libraries/children", :object => directory.children)
end

