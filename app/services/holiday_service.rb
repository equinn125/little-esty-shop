class HolidayService < Service
  def holiday
    get_data("https://date.nager.at/api/v3/NextPublicHolidays/US")
  end
end
