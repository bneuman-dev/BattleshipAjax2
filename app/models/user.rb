class User < ActiveRecord::Base
  attr_reader :entered_password

  validates :entered_password, :length => { :minimum => 6 }
  validates :username, :uniqueness => true

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @entered_password = pass
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(username, password)
    user = User.find_by(username: username)
    return user if user && (user.password == password)
    nil # either invalid email or wrong password
  end
end