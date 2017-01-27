class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.integer :user_id, index: true
      t.integer :event_id, index: true
      t.timestamps
    end
  end
end
