class User < ActiveRecord::Base
  extend FriendlyId

  include ActiveModel::ForbiddenAttributesProtection

  acts_as_authorization_subject :association_name => :roles, :join_table_name => :enrollments
  validates :github_uid, :username, :uniqueness => true, :presence => true
  validates :email, :format => { :with => /\A[^@]+@[^@]+\z/ }, :uniqueness => true, :allow_blank => true

  after_create :update_roles

  attr_accessor :oauth_token
  attr_accessible :gravatar_token, :email, :name, :site_url, :username, :github_uid, :github_username

  has_many :posts
  has_many :enrollments
  has_many :roles, :through => :enrollments

  friendly_id :username, :use => :slugged

  def self.create_from_github( omniauth )
    user_info = omniauth['info']
    extras    = omniauth['extra']['raw_info']

    User.new.tap do |user|
      user.github_uid      = omniauth['uid']
      user.username        = user_info['nickname']
      user.github_username = user_info['nickname']
      user.email           = user_info['email']
      user.name            = user_info['name']

      if extras
        user.site_url       = extras['blog']
        user.gravatar_token = extras['gravatar_id']
      end

      user.oauth_token = omniauth['credentials']['token'] if omniauth['credentials'].present?
      user.save!
    end
  end

  def gravatar_url size=64
    default_image = "/assets/ruby.png"

    return "http://gravatar.com/avatar/#{ gravatar_token }.png?s=#{ size }&d=#{ CGI.escape default_image }" if gravatar_token.present?
    default_image
  end

  def github_url
    "http://github.com/#{github_username}"
  end

  def to_s
    self.username
  end

  private
  def update_roles
    client  = Octokit::Client.new :login => self.username, :oauth_token => self.oauth_token

    begin
      teams = client.org_teams 'rubytij'

      teams.each do |team|
        members = client.team_members( team.id ).map( &:login )
        self.has_role! team.name.parameterize if members.include? self.username
      end
    rescue
      # User is not part of github org or has wrong token
    end
  end
end
