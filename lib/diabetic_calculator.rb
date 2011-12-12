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
    readings = self.glucose_readings
    if args[:begin_date].present? && args[:end_date].present?
      readings = readings.between(args[:begin_date],args[:end_date])
    elsif args[:begin_date].present?
      readings = readings.between(args[:begin_date],Time.now)
    elsif args[:n].present? 
      readings = readings.recent.limit(args[:n])
    elsif args[:meal_code].present?
      readings = readings.by_meal_code(args[:meal_code])
    end
    readings.map { |r| r.read_attribute(args[:measurement]) unless r.read_attribute(args[:measurement]) == 0 }.compact
  end
  
end