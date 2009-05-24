class CreateVoiceparts < ActiveRecord::Migration
  def self.up
    create_table :voiceparts do |t|
      t.string :name
      t.string :nickname

      t.timestamps
    end
  end

  def self.down
    drop_table :voiceparts
  end
end
