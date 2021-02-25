from datetime import *
from MockMerchantProcessor import *
from ClockMock import *
from ShoppingCart import *
from Cashier import *
from CreditCard import *
from MonthOfYear import *
from Storefront import *
from LoginSystemMock import *

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

    def a_book_from_the_editorial(self):
        return "9788498387087"

    def the_editorial_catalog(self):
        return {self.a_book_from_the_editorial(): 50.0, "9788498389722": 75.0, "9789878000121": 300000000000000.0}

    def now(self):
        return datetime.now()
    
    def user_credentials(self):
        return {"Mauro_Rizzi": "123457", "Agustin_Gabrielli": "pepito"}

    def a_storefront(self, clock_mock):
        return Storefront(self.the_editorial_catalog(), LoginSystemMock(self.user_credentials()), MockMerchantProcessor(), clock_mock, self.minutes_before_cart_expires())

    def a_valid_client_id_and_password(self):
        return "Mauro_Rizzi", "123457"

    def another_valid_client_id_and_password(self):
        return "Agustin_Gabrielli", "pepito"

    def an_invalid_client_id_and_password(self):
        return "Pepito", "123"
    
    def an_invalid_cart_id(self):
        return "Juancito"

    def an_id_of_an_empty_cart(self, storefront):
        client_id, password = self.a_valid_client_id_and_password()

        return storefront.create_cart_for(client_id, password)

    def minutes_before_cart_expires(self):
        return 30