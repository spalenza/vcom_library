# encoding: UTF-8

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :vcoms
  has_one :directory
  has_one :profile

  after_create :set_directories

  validates_presence_of :name

  def my_vcoms_directory
    self.directory.children.where(:name => "My Vcoms").uniq.first
  end

  private
    def set_directories
        self.directory ||= Directory.create name: "root", fixed: true
        self.directory.children.create name: "My Vcoms", user: self, fixed: true
    end
end
