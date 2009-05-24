class PopulateVoiceparts < ActiveRecord::Migration
  def self.up
    voiceparts = ["Soprano I", "Soprano II", "Alto I", "Alto II",
                  "Tenor I", "Tenor II", "Bass I", "Bass II"]
    voiceparts.each do |vp|
      nick = vp[0,1].downcase + vp[/\s\w+/].strip.length.to_s
      Voicepart.create!(:name => vp, :nickname => nick)
    end
  end

  def self.down
    Voicepart.destroy_all
  end
end
