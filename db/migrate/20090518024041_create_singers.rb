class CreateSingers < ActiveRecord::Migration
  def self.up
    create_table :singers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :age
      t.string :phone
      t.integer :voicepart_id
      t.integer :status_id
      t.boolean :recording
      t.text :comments
      t.integer :mod_id

      t.timestamps
    end
  end

  def self.down
    drop_table :singers
  end
end
