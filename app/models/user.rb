class User
  include Mongoid::Document

  field :name

  has_many :places

  #has_many :locations

end
