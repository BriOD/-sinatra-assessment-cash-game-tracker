class User < ActiveRecord::Base
  validates_uniqueness_of :username
  has_many :sessions
  has_secure_password

  def total_profit
    #this method will display a users total profit.
    won = []
    self.sessions.each do |session|
      won << session.amount_won.to_i
    end
    won.inject(0, :+)
  end

end
