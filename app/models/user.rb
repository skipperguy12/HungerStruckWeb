class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String

  #has_one :key, class_name: "Key"
  field :names, :type => Array, :default => []
  field :uuid, :type => BSON::Binary
  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :last_response, type: Time

  # Singleton methods
  class << self
    # Gets all active users
    def active_users
      users = $redis.get('active_users')
      if users
        JSON.parse(users)
      else users
        users = []
        User.where(last_response: {"$gt" => 5.minutes.ago }).each do |user|
          users << user.forum_display_name
        end
        $redis.set('active_users', users)
        $redis.expire('active_users', 1.minute)
        users
      end
    end
  end


  def get_mod_groups
    array = Array.new
    MongoidForums::Group.each do |group|
      if group.members.include?(id)
        array << group
      end
    end
    return array
  end

  def forum_display_name
    email
  end
end
