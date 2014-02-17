class EventCalendar
  attr_reader :date

  def initialize(month=nil, year=nil)
    month = Date.today.month if month.blank?
    year = Date.today.year if year.blank?
    
    @date = Date.new(year.to_i, month.to_i, 1)
  end
  
  def month
    Date::MONTHNAMES[@date.month]
  end
  
  def year
    @date.year
  end
  
  def next_date
    @date + 1.month
  end
  
  def previous_date
    @date - 1.month
  end

  def weekdays
    Date::ABBR_DAYNAMES
  end
  
  def table
    table = []
    date = @date.beginning_of_month
    row = []
    
    while date <= @date.end_of_month do
      if row.size == 7
        table << row
        row = []
      end
      
      # Pad the front of the month
      if date.day == 1
        date.wday.times do
          row << EmptyCell.new
        end
      end
      
      row << Cell.new(date)
      
      date = date + 1.day
    end
    
    table << row
    
    # Pad the end of the month
    (7 - table.last.size).times do
      table.last << EmptyCell.new
    end
    
    table
  end
  
  
  class Cell
    def initialize(date)
      @date = date
    end
    
    def events
      Event.on_date(@date)
    end
    
    def date
      @date.day
    end
    
    def css_class
      if @date == Date.today
        "day current_day"
      elsif @date < Date.today
        "day past_day"
      else
        "day"
      end
    end
  end
  
  class EmptyCell
    def css_class
      ""
    end
    
    def events
      []
    end
    
    def date
      nil
    end
  end
  
end
