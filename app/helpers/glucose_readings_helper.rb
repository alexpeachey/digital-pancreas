module GlucoseReadingsHelper
  
  def nice_date(d)
    d.strftime("%Y-%m-%d %I:%M %p")
  end
end
