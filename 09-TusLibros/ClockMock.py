class ClockMock:
    def __init__(self):
        self._current_time = 0
    
    def now(self):
        return self._current_time

    def forward_time(self, minutes):
        self._current_time += minutes

    def __sub__(self, another_time):
        return self._current_time - another_time
