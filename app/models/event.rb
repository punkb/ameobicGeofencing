class Event
  include Mongoid::Document

  field :title
  field :eventcoordinates, type: Array

end
