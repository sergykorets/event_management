class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.datetime :time
      t.string :place
      t.string :purpose
      t.integer :owner_id, index: true
      t.timestamps
    end
  end
end
