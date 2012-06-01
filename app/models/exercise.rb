# encoding: utf-8
class Exercise < ActiveRecord::Base
	has_attached_file :askisi,
							:storage => :s3,
							:url => ":s3_domain_url",
							#:s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
							#:s3_credentials => "#{Rails_root.to_s}/config/s3.yml",
							:s3_credentials => "config/s3.yml",
							:path => "/:style/:id/:filename"
	has_many :users, :through => :writings
	has_many :writings

	attr_accessible :etitle, :ebody, :average, :askisi

	validates :etitle, :presence => true, :length => { :maximum => 20 }, :uniqueness => true
	validates :ebody, :presence => true
	validates :average, :inclusion => { :in => 0..10, :message => " Πρέπει να είναι δεκαδικός αριθμός από 0 έως 10" }, :on => :update
	validates :average, :presence => { :message => " δεν πρέπει να είναι κενό" }, :on => :update
	validates :average, :numericality => { :message => " Πρέπει να είναι αριθμητική τιμή" }, :on => :update
	validates_attachment_content_type :askisi, :content_type => "application/pdf"


end
