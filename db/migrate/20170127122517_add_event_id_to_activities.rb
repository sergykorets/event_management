class AddEventIdToActivities < ActiveRecord::Migration[5.0]
  def change
  	add_column :activities, :event_id, :integer
  	add_index :activities, :event_id
  end
end
