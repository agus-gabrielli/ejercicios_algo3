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
        self.shopping_cart = ShoppingCart()
        self.book_to_add = "9788498387087"
        self.second_book_to_add = "9788498389722"
        self.third_book_to_add = "9789878000121"

    def add_multiple_books_to_cart(self, shopping_cart, list_of_books_to_add):
        for book_to_add, quantity in list_of_books_to_add:
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
        list_of_books_to_add = [(self.book_to_add, 1), (self.second_book_to_add, 1), (self.third_book_to_add, 1)]

        self.add_multiple_books_to_cart(self.shopping_cart, list_of_books_to_add)

        self.assertFalse(self.shopping_cart.is_empty())
        self.assertTrue(self.shopping_cart.contains(list_of_books_to_add[0][0], 1))
        self.assertTrue(self.shopping_cart.contains(list_of_books_to_add[1][0], 1))
        self.assertTrue(self.shopping_cart.contains(list_of_books_to_add[2][0], 1))

    def test05_can_add_multiple_copies_of_same_book(self):
        self.shopping_cart.add_book(self.book_to_add, 3)

        self.assertTrue(self.shopping_cart.contains(self.book_to_add, 3))
        self.assertFalse(self.shopping_cart.contains(self.book_to_add, 6))

    def test06_list_of_empty_cart_is_empty(self):
        self.assertEqual(self.shopping_cart.list_content(), "0") 

    def test07_cart_with_multiple_books_can_list_its_content(self):
        list_of_books_to_add = [(self.book_to_add, 1), (self.second_book_to_add, 3)]

        self.add_multiple_books_to_cart(self.shopping_cart, list_of_books_to_add)

        self.assertEqual(self.shopping_cart.list_content(), "0|" + self.book_to_add + "|1|" + self.second_book_to_add + "|3")

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

    def test01_cant_checkout_empty_cart(self):
        shopping_cart = ShoppingCart()
        sales_system = SalesSystem()
        credit_card = CreditCard()
        cashier = Cashier(sales_system)

        with self.assertRaises(CannotCheckoutEmptyCart):
            cashier.check_out_cart(shopping_cart, credit_card)

    def test02_can_check_out_single_item(self):
        shopping_cart = ShoppingCart()
        shopping_cart.add_book("9788498387087", 1)
        sales_system = SalesSystem()
        cashier = Cashier(sales_system)
        credit_card = CreditCard()

        cashier.check_out_cart(shopping_cart, credit_card)
        assert ledger_book.purchase_amount(shopping_cart) == 50


#####################################################################
#                                                                   #
#                               MAIN                                #
#                                                                   #
#####################################################################
if __name__ == '__main__':
    unittest.main()
