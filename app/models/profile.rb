# encoding: UTF-8

class Profile < ActiveRecord::Base
  belongs_to :user
end
