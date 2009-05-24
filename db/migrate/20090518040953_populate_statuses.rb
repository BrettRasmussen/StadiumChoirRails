class PopulateStatuses < ActiveRecord::Migration
  def self.up
    statuses = %w[removed declined interested committed]
    statuses.each do |s|
      Status.create!(:name => s)
    end
  end

  def self.down
    Status.destroy_all
  end
end
