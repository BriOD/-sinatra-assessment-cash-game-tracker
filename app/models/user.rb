class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password #,uniquness: true
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

  def total_profit
    #this method will display a users total profit.
    won = []
    self.sessions.each do |session|
      won << session.amount_won.to_i
    end
    won.inject(0, :+)
  end

end
