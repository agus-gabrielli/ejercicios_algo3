from datetime import datetime
from MockMerchantProcessor import *
from ShoppingCart import *
from Cashier import *
from CreditCard import *
from MonthOfYear import *


class PublisherTestObjectsFactory:
    def a_cashier(self, price_list, a_ledger):
        return Cashier(a_ledger, price_list, MockMerchantProcessor())

    def a_valid_credit_card(self):
        june_next_year = MonthOfYear(6, self.now().year + 1)
        return CreditCard('Juan Perez', "1234567891234567", june_next_year)

    def a_stolen_credit_card_number(self):
        return "4380500008685118"

    def an_empty_cart(self):
        return ShoppingCart(self.the_editorial_catalog())

    def a_cart_with_a_book(self):
        cart = ShoppingCart(self.the_editorial_catalog())
        cart.add_book(self.a_book_from_the_editorial(), 1)
        return cart

    def an_empty_ledger(self):
        return []

    def an_expired_credit_card(self):
        june_last_year = MonthOfYear(6, self.now().year - 1)
        return CreditCard('Juan Perez', "1234567891234567", june_last_year)

    def the_editorial_catalog(self):
        return ["9788498387087", "9788498389722", "9789878000121"]

    def a_book_from_the_editorial(self):
        return self.the_editorial_catalog()[0]

    def now(self):
        return datetime.now()
