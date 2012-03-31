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
  
  private
    def set_directories
        self.directory ||= Directory.create name: "root"
        self.directory.children.create name: "My Vcoms", user: self
    end
end
