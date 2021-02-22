from datetime import datetime
from MockMerchantProcessor import *
from ShoppingCart import *
from Cashier import *
from CreditCard import *
from MonthOfYear import *


class PublisherTestObjectsFactory:
    def a_cashier(self, price_list):
        return Cashier(self.an_empty_ledger(), price_list, MockMerchantProcessor())

    def a_valid_credit_card(self):
        june_next_year = MonthOfYear(6, self.now().year + 1)
        return CreditCard('Juan Perez', "1234567891234567", june_next_year)

    def an_empty_cart(self, a_catalog):
        return ShoppingCart(a_catalog)

    def an_empty_ledger(self):
        return []

    def an_expired_credit_card(self):
        june_last_year = MonthOfYear(6, self.now().year - 1)
        return CreditCard('Juan Perez', "1234567891234567", june_last_year)

    def now(self):
        return datetime.now()
