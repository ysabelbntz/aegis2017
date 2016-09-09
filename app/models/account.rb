class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:student_id]
  
  validates_uniqueness_of :email, :id
  
  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:id)
        where(conditions.to_hash).where(["student_id = :value", { :value => login }]).first
      else
        where(conditions.to_hash).first
      end
    end
  
end
