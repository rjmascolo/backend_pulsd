class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.text :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :event_price
      t.text :address
      t.timestamps
    end
  end
end
