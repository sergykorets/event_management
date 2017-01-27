class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :user_id, index: true
      t.string :action
      t.integer :trackable_id, index: true
      t.string :trackable_type

      t.timestamps
    end
  end
end
