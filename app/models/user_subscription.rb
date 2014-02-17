class UserSubscription < ActiveRecord::Base
	attr_accessible :user, :bill
	before_create { generate_token(:email_token) }

	validates_uniqueness_of :bill, :scope => :user
	
	def generate_token(column)
		begin
    		self[column] = SecureRandom.urlsafe_base64(64)
  		end while UserSubscription.exists?(column => self[column])
	end
end
