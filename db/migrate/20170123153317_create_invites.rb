class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.string :email
      t.integer :sender_id, index: true
      t.integer :recipient_id, index: true
      t.integer :event_id
      t.timestamps
    end
  end
end
