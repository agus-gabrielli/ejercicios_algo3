class Ticket:
    def __init__(self):
        self._items = {}
        self._total = 0

    def add_item(self, item, quantity, item_price):
        self._items[item] = quantity
        self._total += item_price * quantity

    def contains_item(self, item, quantity):
        return item in self._items and self._items[item] == quantity

    def total(self):
        return self._total

    def __repr__(self):
        return f"{self._items} Total: {self._total}"