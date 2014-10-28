class Place
  include Mongoid::Document

 belongs_to :user

  embeds_one :location

  index({location: "2dsphere"})



end
