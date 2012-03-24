class Subcomponent < ActiveRecord::Base
  belongs_to :component
  belongs_to :child, class_name: "Component"
end
