class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password
  has_many :sessions
  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end

  # def total_profit
  #   #this method will display a users total profit.
  #   self.sessions.select do |session|
  #     session.amount_won
  #   end.sum
  # end

end
