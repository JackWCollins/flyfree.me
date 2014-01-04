class Video < ActiveRecord::Base
  validates_presence_of :title, :url, :description
end