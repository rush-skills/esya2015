class Event < ActiveRecord::Base
  has_many :event_admins
end
