import calendar
from datetime import date


class MonthOfYear:
    def __init__(self, month, year):
        self._month = month
        self._year = year

    def last_date(self):
        last_day = calendar.monthrange(self._year, self._month)[1]
        return date(self._year, self._month, last_day)

    def __repr__(self):
        return f"{self._month} of {self._year}"
