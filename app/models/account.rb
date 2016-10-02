class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:student_id]
  belongs_to :timeslot
  belongs_to :groupshot
  # validates_uniqueness_of :email, :student_id
  
  def to_s
    "#{self.student_id}, #{self.name}, #{self.yr} - #{self.course}"
  end

  # def active_for_authentication?
  #   super and self.can_login
  # end

  # def inactive_message
  #  'You may not log in.'
  # end

  # def can_login
  #   @SOHstart = Time.new(2016, 10, 3, 7)
  #   @SOHend = Time.new(2016, 10, 3, 23)

  #   @SOSSstart = Time.new(2016, 10, 4, 7)
  #   @SOSSend = Time.new(2016, 10, 4, 23)

  #   @SOSEstart = Time.new(2016, 10, 5, 7)
  #   @SOSEend = Time.new(2016, 10, 5, 23)

  #   @SOMstart = Time.new(2016, 10, 6, 7)
  #   @SOMend = Time.new(2016, 10, 6, 23)

  #   case self.school
  #   when "SOH" 
  #     if Time.current.between?(@SOHstart, @SOHend)
  #       return true
  #     else
  #       return false
  #     end
  #   when "SOSS"
  #     if Time.current.between?(@SOSSstart, @SOSSend)
  #       return true
  #     else
  #       return false
  #     end
  #   when "SOSE"
  #     if Time.current.between?(@SOSEstart, @SOSEend)
  #       return true
  #     else
  #       return false
  #     end
  #   when "SOM"
  #     if Time.current.between?(@SOMstart, @SOMend)
  #       return true
  #     else
  #       return false
  #     end
  #   end
  # end


  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      #raise conditions.inspect
      if login = conditions.delete(:id)
        where(conditions.to_hash).where(["student_id = :value", { :value => login }]).first
      else
        where(conditions.to_hash).first
      end
    end
  def create_or_update
      raise ReadOnlyRecord, "#{self.class} is marked as readonly" if readonly?
      account = Account.where(student_id: self.student_id).first
      if account
        self.id = account.id
      end
      result = new_record? ? _create_record : _update_record
      result != false
    end

    # create_or_update comes from persistence.rb

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |account|
          csv << account.attributes.values_at(*column_names)
        end
      end
    end
end
