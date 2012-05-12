class User < ActiveRecord::Base
  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_users
  validates :github_uid, :username, :uniqueness => true, :presence => true
  validates :email, :format => { :with => /\A[^@]+@[^@]+\z/ }, :uniqueness => true, :allow_blank => true

  attr_accessible :gravatar_token, :email, :name, :site_url, :username, :github_uid

  has_many :posts

  def self.create_from_github( omniauth )
    user_info = omniauth['info']
    extras    = omniauth['extra']['raw_info']

    User.new.tap do |user|
      user.github_uid     = omniauth['uid']
      user.username       = user_info['nickname']
      user.email          = user_info['email']
      user.name           = user_info['name']

      if extras
        user.site_url       = extras['blog']
        user.gravatar_token = extras['gravatar_id']
      end

      user.save!
    end
  end

  def gravatar_url size=64
    default_image = "/assets/ruby.png"

    return "http://gravatar.com/avatar/#{ gravatar_token }.png?s=#{ size }&d=#{ CGI.escape default_image }" if gravatar_token.present?
    default_image
  end
end
