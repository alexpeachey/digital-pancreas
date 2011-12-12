class RenameGlucoseValueOnGlucoseReadings < ActiveRecord::Migration
  def change
    rename_column :glucose_readings, :glucose_value, :glucose
  end
end
