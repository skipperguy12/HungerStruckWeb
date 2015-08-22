class Key
  include Mongoid::Document
  field :user, type: String
  field :token, type: String
end
