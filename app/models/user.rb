class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  acts_as_tagger
  has_many :services, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :exercises, :through => :writings
  has_many :writings
  belongs_to :lesson

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :shortbio, :weburl, :lesson_id, :user_kind
  validates :weburl, :url => {:allow_blank => true}, :length => { :maximum => 50 }
  validates :fullname, :length => { :maximum => 40 }
  validates :shortbio, :length => { :maximum => 500 }

  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'facebook'
      self.apply_facebook(omniauth)
    end
    services.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :token =>(omniauth['credentials']['token'] rescue nil))
  end

  def facebook
    @current_user ||= FbGraph::User.me(self.services.find_by_provider('facebook').token)
  end


  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end
end
