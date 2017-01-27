class EventSerializer < ActiveModel::Serializer
  attributes :id, :time, :place, :purpose
  has_one :owner
  has_many :users
end
