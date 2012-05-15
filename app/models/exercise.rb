# encoding: utf-8
class Exercise < ActiveRecord::Base
	has_many :users, :through => :writings
	has_many :writings

	attr_accessible :etitle, :ebody, :average

	validates :etitle, :presence => true, :length => { :maximum => 20 }
	validates :ebody, :presence => true
	validates :average, :inclusion => { :in => 0..10, :message => " Πρέπει να είναι δεκαδικός αριθμός από 0 έως 10" }, :on => :update
	validates :average, :presence => { :message => " δεν πρέπει να είναι κενό" }, :on => :update
	validates :average, :numericality => { :message => " Πρέπει να είναι αριθμητική τιμή" }, :on => :update

end
