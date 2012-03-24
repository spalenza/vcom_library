class Vcom < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :directories # => Não sei se irá precisar.
  has_many :components
end
