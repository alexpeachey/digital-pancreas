module DiabeticCalculator
  
  def average_level(*args)
    levels = valid_levels_for_args(args)
    return 0 unless levels.any?
    levels.inject { |sum, r| sum + r }.to_f / levels.size
  end
  
  def max_level(*args)
    levels = valid_levels_for_args(args)
    return 0 unless levels.any?
    levels.max
  end
  
  def min_level(*args)
    levels = valid_levels_for_args(args)
    return 0 unless levels.any?
    levels.min
  end
  
  private
  def valid_levels_for_args(*args)
    args = Hash[*args.flatten]
    measurement = args[:measurement]
    if args[:begin_date].present? && args[:end_date].present?
      levels = self.glucose_readings.between(args[:begin_date],args[:end_date]).map { |r| r.read_attribute(measurement) }
    elsif args[:begin_date].present?
      levels ||= self.glucose_readings.between(args[:begin_date],Time.now).map { |r| r.read_attribute(measurement) }
    elsif args[:n].present? 
      levels = self.glucose_readings.recent.limit(args[:n]).map { |r| r.read_attribute(measurement) }
    elsif args[:meal_code].present?
      levels = self.glucose_readings.by_meal_code(args[:meal_code]).map { |r| r.read_attribute(measurement) }
    else
      levels = self.glucose_readings.map { |r| r.read_attribute(measurement) }
    end
    
    levels
  end
  
end