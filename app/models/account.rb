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

  def active_for_authentication?
    super and self.can_login
  end

  def inactive_message
   'You may not log in.'
  end

  def can_login
    @SOHstart = Time.new(2016, 10, 2,23).in_time_zone('Hong Kong')
    @SOHend = Time.new(2016, 10, 3, 15).in_time_zone('Hong Kong')

    @SOSSstart = Time.new(2016, 10, 3, 23).in_time_zone('Hong Kong')
    @SOSSend = Time.new(2016, 10, 4, 15).in_time_zone('Hong Kong')

    @SOSEstart = Time.new(2016, 10, 2, 23).in_time_zone('Hong Kong')
    @SOSEend = Time.new(2016, 10, 5, 15).in_time_zone('Hong Kong')

    @SOMstart = Time.new(2016, 10, 5, 23).in_time_zone('Hong Kong')
    @SOMend = Time.new(2016, 10, 6, 15).in_time_zone('Hong Kong')

    case self.school
    when "SOH" 
      if Time.current.in_time_zone('Hong Kong').between?(@SOHstart, @SOHend)
        return true
      else
        return false
      end
    when "SOSS"
      if Time.current.in_time_zone('Hong Kong').between?(@SOSSstart, @SOSSend)
        return true
      else
        return false
      end
    when "SOSE"
      if Time.current.in_time_zone('Hong Kong').between?(@SOSEstart, @SOSEend)
        return true
      else
        return false
      end
    when "SOM"
      if Time.current.in_time_zone('Hong Kong').between?(@SOMstart, @SOMend)
        return true
      else
        return false
      end
    end
  end


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
