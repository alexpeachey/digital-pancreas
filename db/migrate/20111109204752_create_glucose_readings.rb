class CreateGlucoseReadings < ActiveRecord::Migration
  def change
    create_table :glucose_readings do |t|
      t.integer :user_id
      t.integer :glucose_value
      t.datetime :reading_at
      t.string :comment

      t.timestamps
    end
    add_index :glucose_readings, :user_id
    add_index :glucose_readings, :reading_at
  end
end