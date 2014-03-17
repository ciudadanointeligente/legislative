class Notifier < ActiveRecord::Base
	attr_accessible :user_id, :bills
	serialize :bills, Array

	validates_uniqueness_of :user_id
end