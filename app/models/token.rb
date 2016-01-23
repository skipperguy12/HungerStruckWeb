class Token
  include Mongoid::Document
  include Mongoid::Timestamps
  validates :email, email_format: { message: "It appears the email you've entered is not a valid address!" }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :token, presence: true

  field :token,              type: String
  field :email,              type: String

  index({created_at: 1}, {expire_after_seconds: 1})

end
