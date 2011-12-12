class AddInsulinToGlucoseReading < ActiveRecord::Migration
  def change
    add_column :glucose_readings, :bolus, :integer, default: 0
    add_column :glucose_readings, :basal, :integer, default: 0
    add_column :glucose_readings, :exercise, :integer, default: 0
    add_column :glucose_readings, :carbs, :integer, default: 0
  end
end
