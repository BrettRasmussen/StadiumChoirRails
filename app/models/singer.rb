class Singer < ActiveRecord::Base
  belongs_to :status
  belongs_to :voicepart

  validates_presence_of :first_name, :last_name, :voicepart_id
  validates_format_of :email, :with => /^.+@.+\.\w+$/
  validates_format_of :age, :with => /^\d{2,3}$/
  validates_format_of :phone, :with => /^[ext\s\d()-.]+$/i

  alias_method :orig_status, :status
  def status
    orig_status.name
  end

  def status=(new_status)
    stat = Status.find_by_name(new_status)
    raise "Invalid status: #{new_status}." if stat.nil?
    write_attribute(:status_id, stat.id)
  end

  alias_method :orig_voicepart, :voicepart
  def voicepart
    orig_voicepart.name
  end

  def voicepart=(new_voicepart)
    vp = Voicepart.find(:first, :conditions=>["name=? or nickname=?", new_voicepart, new_voicepart])
    raise "Invalid voicepart: #{new_voicepart}" if vp.nil?
    write_attribute(:voicepart_id, vp.id)
  end
end
