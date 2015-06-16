class Event < ActiveRecord::Base
	has_many :attendees # 複數
	has_many :category# 單數
	has_one :location
	has_many :event_groupships
  has_many :groups, :through => :event_groupships
	validates_presence_of :name
end
