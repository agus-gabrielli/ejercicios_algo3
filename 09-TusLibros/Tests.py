from TusLibros import *
from TusLibrosExceptions import *
import unittest

#####################################################################
#                                                                   #
#                       CLASE TESTCASE                              #
#                                                                   #
#####################################################################
class ShoppingCartTests(unittest.TestCase):

    def setUp(self):
        self.book_to_add = "9788498387087"
        self.second_book_to_add = "9788498389722"
        self.third_book_to_add = "9789878000121"
        self.shopping_cart = ShoppingCart([self.book_to_add, self.second_book_to_add, self.third_book_to_add])
        
    def add_multiple_books_to_cart(self, shopping_cart, list_of_books_to_add):
        for book_to_add, quantity in list_of_books_to_add.items():
            shopping_cart.add_book(book_to_add, quantity)

    def test01_new_cart_is_empty(self):
        self.assertTrue(self.shopping_cart.is_empty())

    def test02_can_add_book_to_cart(self):
        self.shopping_cart.add_book(self.book_to_add, 1)

        self.assertFalse(self.shopping_cart.is_empty())
        self.assertTrue(self.shopping_cart.contains(self.book_to_add, 1))

    def test03_cart_doesnt_contain_not_added_book(self):
        self.shopping_cart.add_book(self.book_to_add, 1)

        self.assertFalse(self.shopping_cart.contains(self.second_book_to_add, 1))

    def test04_can_add_multiple_distinct_books_to_cart(self):
        list_of_books_to_add = {self.book_to_add: 1, self.second_book_to_add: 1, self.third_book_to_add: 1}

        self.add_multiple_books_to_cart(self.shopping_cart, list_of_books_to_add)

        self.assertFalse(self.shopping_cart.is_empty())
        self.assertTrue(self.shopping_cart.contains(self.book_to_add, 1))
        self.assertTrue(self.shopping_cart.contains(self.second_book_to_add, 1))
        self.assertTrue(self.shopping_cart.contains(self.third_book_to_add, 1))

    def test05_can_add_multiple_copies_of_same_book(self):
        self.shopping_cart.add_book(self.book_to_add, 3)

        self.assertTrue(self.shopping_cart.contains(self.book_to_add, 3))
        self.assertFalse(self.shopping_cart.contains(self.book_to_add, 6))

    def test06_list_of_empty_cart_is_empty(self):
        self.assertFalse(self.shopping_cart.list_content()) 

    def test07_cart_with_multiple_books_can_list_its_content(self):
        list_of_books_to_add = {self.book_to_add:1, self.second_book_to_add: 3}

        self.add_multiple_books_to_cart(self.shopping_cart, list_of_books_to_add)

        self.assertEqual(list_of_books_to_add, self.shopping_cart.list_content())

    def test08_cart_doesnt_accept_books_from_another_publisher(self):
        book_from_another_publisher = "9789505470662"

        with self.assertRaises(UnknownBook):
            self.shopping_cart.add_book(book_from_another_publisher, 3)
        self.assertFalse(self.shopping_cart.contains(book_from_another_publisher, 3))

    def test09_cart_only_accepts_a_book_quantity_greater_than_zero(self):
        with self.assertRaises(InvalidBookQuantity):
            self.shopping_cart.add_book(self.book_to_add, -2)
        self.assertFalse(self.shopping_cart.contains(self.book_to_add, -2))

class CashierTest(unittest.TestCase):
    def setUp(self):
        self.book_to_add = "9788498387087"
        self.second_book_to_add = "9788498389722"
        self.expensive_book_to_add = "9789878000121"
        self.shopping_cart = ShoppingCart([self.book_to_add, self.second_book_to_add, self.expensive_book_to_add])
        self.valid_credit_card = ["1234567890987654", self.create_valid_expiration_date(), "Sergio Fedi"]
        self.ledger = []
        self.price_list = {self.book_to_add: 50.0, self.second_book_to_add: 75.0, self.expensive_book_to_add: 300000000000000.0}
        self.cashier = Cashier(self.ledger, self.price_list)

    def create_valid_expiration_date(self):
        rundate = datetime.now()
        expiration_date = rundate.replace(year=rundate.year + 5, day=1)
        return expiration_date.strftime('%m/%Y')

    def test01_cannot_checkout_empty_cart(self):
        with self.assertRaises(CannotCheckoutEmptyCart):
            self.cashier.check_out_cart(self.shopping_cart, self.valid_credit_card)

    def test02_can_check_out_single_book(self):
        self.shopping_cart.add_book(self.book_to_add, 1)

        ticket = self.cashier.check_out_cart(self.shopping_cart, self.valid_credit_card)
        self.assertEqual(ticket, [(self.book_to_add, 1), ("Total:", 50.0)])

    def test03_can_check_out_multiple_book(self):
        self.shopping_cart.add_book(self.book_to_add, 5)
        self.shopping_cart.add_book(self.second_book_to_add, 3)

        ticket = self.cashier.check_out_cart(self.shopping_cart, self.valid_credit_card)
        self.assertEqual(ticket, [(self.book_to_add, 5), (self.second_book_to_add, 3), ("Total:", 475.0)])


    def test04_cannot_check_out_with_expired_credit_card(self):
        self.shopping_cart.add_book(self.book_to_add, 3)

        with self.assertRaises(ExpiredCreditCard):
            self.cashier.check_out_cart(self.shopping_cart, ["3734567890987654", "08/2003", "Enrique el antiguo"])

    def test05_cannot_check_out_with_invalid_credit_card_number(self):
        self.shopping_cart.add_book(self.book_to_add, 3)

        with self.assertRaises(InvalidCreditCardNumber):
            self.cashier.check_out_cart(self.shopping_cart, ["sadasdasas456", self.create_valid_expiration_date(), "Hackermann"])

    def test06_cannot_check_out_with_wrong_credit_card_owner_name(self):
        self.shopping_cart.add_book(self.book_to_add, 3)

        with self.assertRaises(InvalidCreditCardOwner):
            self.cashier.check_out_cart(self.shopping_cart, ["1234567890987654", self.create_valid_expiration_date(), "Jose Francisco de San Martín y Matorras"])

    def test07_cannot_check_out_excessivelly_expensive_purchase(self):
        self.shopping_cart.add_book(self.expensive_book_to_add, 4)

        with self.assertRaises(TransactionAmountOverflow):
            self.cashier.check_out_cart(self.shopping_cart, self.valid_credit_card)

    def test08_check_out_is_stopped_when_merchant_processor_rejects_payment(self):
        self.shopping_cart.add_book(self.book_to_add, 3)

        with self.assertRaises(MerchantProcessorException) as payment_exception:
            self.cashier.check_out_cart(self.shopping_cart,
                                        ["4380500008685118", self.create_valid_expiration_date(), "Mauro Rizzi"])
        self.assertEqual("1|SIN_DISPONIBLE", str(payment_exception))

"""
test4 --> expired credit levanta excepcion
test5 --> invalid cc not 16 digits l e
test6 --> cantidad de la transaccion
"""


#####################################################################
#                                                                   #
#                               MAIN                                #
#                                                                   #
#####################################################################
if __name__ == '__main__':
    unittest.main()
