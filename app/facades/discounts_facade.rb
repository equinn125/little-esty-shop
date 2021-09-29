class DiscountsFacade
  def holidays
    holiday_data = HolidayService.new.holiday
    upcoming = holiday_data[0..2]
    @holidays = upcoming.map do |holiday|
      Holiday.new(holiday)
    end
  end
end
