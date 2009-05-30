class ChangeSingersAgeToInteger < ActiveRecord::Migration
  def self.up
    change_column :singers, :age, :integer
  end

  def self.down
    change_column :singers, :age, :string
  end
end
