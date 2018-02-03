class User < ActiveRecord::Base
  has_many :events
  has_many :comments

  has_secure_password

  def slug
    username.downcase.gsub(" ","-" )
  end

  def self.find_by_slug(slug)
      self.all.find{ |user| user.slug == slug }
    end
  end
