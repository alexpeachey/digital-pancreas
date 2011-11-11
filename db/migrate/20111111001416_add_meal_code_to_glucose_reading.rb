class AddMealCodeToGlucoseReading < ActiveRecord::Migration
  def change
    add_column :glucose_readings, :meal_code, :integer
    add_index :glucose_readings, :meal_code
  end
end