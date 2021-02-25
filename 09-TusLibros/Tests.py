from Ticket import *
from CreditCard import *
from Storefront import *
from MonthOfYear import *
from PublisherTestObjectsFactory import *
import unittest


#####################################################################
#                                                                   #
#                       CLASE TESTCASE                              #
#                                                                   #
#####################################################################
class ShoppingCartTests(unittest.TestCase):

    def setUp(self):
        self._test_objects_factory = PublisherTestObjectsFactory()
        self.book_to_add, self.second_book_to_add, self.third_book_to_add = self._test_objects_factory.the_editorial_catalog().keys()
        self.shopping_cart = self._test_objects_factory.an_empty_cart()
        
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

        try:
            self.shopping_cart.add_book(book_from_another_publisher, 3)
            self.fail()
        except Exception as thrown_exception:
            self.assertEqual(str(thrown_exception), ShoppingCart.cannot_add_unkown_book_to_cart_error_message())
            self.assertFalse(self.shopping_cart.contains(book_from_another_publisher, 3))

    def test09_cart_only_accepts_a_book_quantity_greater_than_zero(self):
        try:
            self.shopping_cart.add_book(self.book_to_add, -2)
            self.fail()
        except Exception as thrown_exception:
            self.assertEqual(str(thrown_exception), ShoppingCart.cannot_add_zero_or_negative_amount_of_books_to_cart_error_message())
            self.assertFalse(self.shopping_cart.contains(self.book_to_add, -2))


class CashierTest(unittest.TestCase):
    def setUp(self):
        self._test_objects_factory = PublisherTestObjectsFactory()
        self.book_to_add, self.second_book_to_add, self.expensive_book_to_add = self._test_objects_factory.the_editorial_catalog().keys()
        self.catalog = self._test_objects_factory.the_editorial_catalog()
        self.shopping_cart = self._test_objects_factory.an_empty_cart()
        self.shopping_cart_with_a_book = self._test_objects_factory.a_cart_with_a_book()

        self.valid_credit_card = self._test_objects_factory.a_valid_credit_card()
        self.ledger = self._test_objects_factory.an_empty_ledger()
        # Me parece que deberiamos convertir el catalog en un price list y tenerloen el carrito, como cuando ibas al almacen y el producto tenia el sticker con el precio
        self.price_list = {self.book_to_add: 50.0, self.second_book_to_add: 75.0, self.expensive_book_to_add: 300000000000000.0}
        self.cashier = self._test_objects_factory.a_cashier(self.price_list, self.ledger)

    def test01_cannot_checkout_empty_cart(self):
        try:
            self.cashier.check_out(self.shopping_cart, self.valid_credit_card)
            self.fail()
        except Exception as thrown_exception:
            self.assertEqual(str(thrown_exception), Cashier.cannot_checkout_an_empty_cart_error_message())
            self.assertFalse(self.ledger)

    def test02_can_check_out_single_book(self):
        self.shopping_cart.add_book(self.book_to_add, 1)

        ticket = self.cashier.check_out(self.shopping_cart, self.valid_credit_card)

        self.assertTrue(ticket.contains_item(self.book_to_add, 1))
        self.assertEqual(ticket.total(), 50.0)
        self.assertTrue(ticket in self.ledger)

    def test03_can_check_out_multiple_books(self):
        self.shopping_cart.add_book(self.book_to_add, 5)
        self.shopping_cart.add_book(self.second_book_to_add, 3)

        ticket = self.cashier.check_out(self.shopping_cart, self.valid_credit_card)

        self.assertTrue(ticket.contains_item(self.book_to_add, 5) and ticket.contains_item(self.second_book_to_add, 3))
        self.assertEqual(ticket.total(), 475.0)
        self.assertTrue(ticket in self.ledger)

    def test04_cannot_check_out_with_expired_credit_card(self):
        try: 
            self.cashier.check_out(self.shopping_cart_with_a_book, self._test_objects_factory.an_expired_credit_card())
            self.fail()
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), Cashier.cannot_checkout_using_an_expired_card_error_message())
            self.assertFalse(self.ledger)

    def test05_cannot_check_out_excessivelly_expensive_purchase(self):
        self.shopping_cart.add_book(self.expensive_book_to_add, 4)

        try:
            self.cashier.check_out(self.shopping_cart, self.valid_credit_card)
            self.fail()
        except Exception as thrown_exception:
            self.assertEqual(str(thrown_exception), Cashier.cannot_checkout_purchase_total_too_large_error_message())
            self.assertFalse(self.ledger)

    def test06_check_out_is_stopped_when_merchant_processor_rejects_payment(self):
        try:
            self.cashier.check_out(self.shopping_cart_with_a_book, CreditCard("hola", self._test_objects_factory.a_stolen_credit_card_number(), MonthOfYear(6, datetime.now().year + 1)))
            self.fail()
        except Exception as thrown_exception:
            self.assertEqual(str(thrown_exception), MockMerchantProcessor.generic_rejected_payment_error_message())
            self.assertFalse(self.ledger)


class TicketTest(unittest.TestCase):
    def setUp(self):
        self.ticket = Ticket()
        self.purchased_item = "4380500008685118"

    def test01_total_of_newly_created_ticket_is_zero(self):
        self.assertEqual(self.ticket.total(), 0.0)

    def test02_newly_created_ticket_does_not_contain_items(self):
        self.assertFalse(self.ticket.contains_item(self.purchased_item, 1))

    def test03_can_add_item_to_ticket(self):
        self.ticket.add_item(self.purchased_item, 1, 50)

        self.assertTrue(self.ticket.contains_item(self.purchased_item, 1))
        self.assertEqual(self.ticket.total(), 50)

    def test04_can_add_multiple_items_to_ticket(self):
        another_purchased_item = "7680500008685529"

        self.ticket.add_item(self.purchased_item, 1, 50)
        self.ticket.add_item(another_purchased_item, 3, 10)

        self.assertTrue(self.ticket.contains_item(self.purchased_item, 1))
        self.assertTrue(self.ticket.contains_item(another_purchased_item, 3))
        self.assertEqual(self.ticket.total(), 80)

    def test05_item_that_was_not_purchased_is_not_in_ticket_with_other_items(self):
        not_purchased_item = "4380500008685118"

        self.ticket.add_item(not_purchased_item, 1, 50)

        self.assertFalse(self.ticket.contains_item(not_purchased_item, 3))

class StorefrontTests(unittest.TestCase):

        ###########################         SETUP        ###########################

    def setUp(self):
        self._object_factory = PublisherTestObjectsFactory()
        self._clock_mock = ClockMock()
        self._storefront = self._object_factory.a_storefront(self._clock_mock)

        ###########################         TESTS        ###########################
        
    def test01_client_cannot_create_cart_with_invalid_credentials(self):
        invalid_client_id, invalid_client_password = self._object_factory.an_invalid_client_id_and_password()

        collaboration_to_assert = lambda: self._storefront.create_cart_for(invalid_client_id, invalid_client_password)
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, LoginSystemMock.invalid_credentials_error_message())   

    def test02_client_can_create_cart_with_valid_credentials(self):
        client_id, client_password = self._object_factory.a_valid_client_id_and_password()
        cart_id = self._storefront.create_cart_for(client_id, client_password)

        self._assert_cart_with_this_id_is_empty(cart_id)

    def test03_client_can_add_books_to_cart(self):
        a_book = self._object_factory.a_book_from_the_editorial()
        cart_id = self._object_factory.an_id_of_an_empty_cart(self._storefront)

        self._storefront.add_to_cart(cart_id, a_book, 1)

        self._assert_cart_with_this_id_only_contains(cart_id, a_book)

    def test04_multiple_clients_can_add_books_to_cart(self):
        first_client_id, first_client_password = self._object_factory.a_valid_client_id_and_password()
        second_client_id, second_client_password = self._object_factory.another_valid_client_id_and_password()
        a_book = self._object_factory.a_book_from_the_editorial()

        first_client_cart_id = self._storefront.create_cart_for(first_client_id, first_client_password)
        second_client_cart_id = self._storefront.create_cart_for(second_client_id, second_client_password)
        self._storefront.add_to_cart(second_client_cart_id, a_book, 1)

        self._assert_cart_with_this_id_is_empty(first_client_cart_id)
        self._assert_cart_with_this_id_only_contains(second_client_cart_id, a_book)
        
    def test05_client_cannot_add_book_to_invalid_cart(self):
        collaboration_to_assert = lambda: self._storefront.add_to_cart(self._object_factory.an_invalid_cart_id(), self._object_factory.a_book_from_the_editorial(), 1)
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, Storefront.invalid_cart_error_message())

    def test06_client_cannot_list_cart_content_of_invalid_cart(self):
        collaboration_to_assert = lambda: self._storefront.list_cart_content(self._object_factory.an_invalid_cart_id())
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, Storefront.invalid_cart_error_message())

    def test07_client_cannot_checkout_cart_with_invalid_id(self):
        collaboration_to_assert = lambda: self._storefront.check_out_cart(self._object_factory.an_invalid_cart_id(), self._object_factory.a_valid_credit_card())
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, Storefront.invalid_cart_error_message())

    def test08_client_can_make_a_purchase(self):
        client_id, password = self._object_factory.a_valid_client_id_and_password()
        cart_id = self._storefront.create_cart_for(client_id, password)
        a_book = self._object_factory.a_book_from_the_editorial()
        self._storefront.add_to_cart(cart_id, a_book, 1)
        
        transaction_id = self._storefront.check_out_cart(cart_id, self._object_factory.a_valid_credit_card())
        self.assertFalse(len(transaction_id) == 0)
        self._assert_client_has_only_purchased(client_id, password, a_book, 1)

    def test09_client_can_make_multiple_purchases(self):
        client_id, password = self._object_factory.a_valid_client_id_and_password()
        a_book = self._object_factory.a_book_from_the_editorial()

        first_cart_id = self._storefront.create_cart_for(client_id, password)
        self._storefront.add_to_cart(first_cart_id, a_book, 1)
        first_transaction_id = self._storefront.check_out_cart(first_cart_id, self._object_factory.a_valid_credit_card())

        second_cart_id = self._storefront.create_cart_for(client_id, password)
        self._storefront.add_to_cart(second_cart_id, a_book, 3)
        second_transaction_id = self._storefront.check_out_cart(second_cart_id, self._object_factory.a_valid_credit_card())

        self.assertNotEqual(first_transaction_id, second_transaction_id)
        self._assert_client_has_only_purchased(client_id, password, a_book, 4)

    def test10_client_cannot_list_purchases_with_invalid_credentials(self):
        invalid_client_id, invalid_client_password = self._object_factory.an_invalid_client_id_and_password()

        collaboration_to_assert = lambda: self._storefront.list_purchases(invalid_client_id, invalid_client_password)
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, LoginSystemMock.invalid_credentials_error_message())

    def test11_client_cannot_add_books_to_an_expired_cart(self): 
        cart_id = self._object_factory.an_id_of_an_empty_cart(self._storefront)
    
        self._clock_mock.forward_time(35)

        collaboration_to_assert = lambda: self._storefront.add_to_cart(cart_id, self._object_factory.a_book_from_the_editorial(), 1)
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, Storefront.cart_is_expired_error_message())
        
    def test12_client_cannot_list_content_of_an_expired_cart(self): 
        cart_id = self._object_factory.an_id_of_an_empty_cart(self._storefront)
    
        self._clock_mock.forward_time(self._object_factory.minutes_before_cart_expires() + 5)

        collaboration_to_assert = lambda: self._storefront.list_cart_content(cart_id)
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, Storefront.cart_is_expired_error_message())

    def test13_client_cannot_checkout_an_expired_cart(self): 
        cart_id = self._object_factory.an_id_of_an_empty_cart(self._storefront)

        self._storefront.add_to_cart(cart_id, self._object_factory.a_book_from_the_editorial(), 1)
        self._clock_mock.forward_time(self._object_factory.minutes_before_cart_expires() + 5)

        collaboration_to_assert = lambda: self._storefront.check_out_cart(cart_id, self._object_factory.a_valid_credit_card())
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, Storefront.cart_is_expired_error_message())
       
    def test14_client_cart_expiration_time_is_reset_after_using_it(self):
        client_id, password = self._object_factory.a_valid_client_id_and_password()
        a_book = self._object_factory.a_book_from_the_editorial()
        minutes_to_forward = int(self._object_factory.minutes_before_cart_expires() - self._object_factory.minutes_before_cart_expires() * 0.5)

        cart_id = self._storefront.create_cart_for(client_id, password)
        self._clock_mock.forward_time(minutes_to_forward)
        self._storefront.list_cart_content(cart_id)
        self._clock_mock.forward_time(minutes_to_forward)
        self._storefront.add_to_cart(cart_id, a_book, 1)
        self._clock_mock.forward_time(minutes_to_forward)
        self._storefront.check_out_cart(cart_id, self._object_factory.a_valid_credit_card())
        self._clock_mock.forward_time(minutes_to_forward)
        
        self._assert_cart_with_this_id_only_contains(cart_id, a_book)
        self._assert_client_has_only_purchased(client_id, password, a_book, 1)

    def test15_client_cannot_checkout_an_already_checked_out_cart(self):
        cart_id = self._object_factory.an_id_of_an_empty_cart(self._storefront)
        self._storefront.add_to_cart(cart_id, self._object_factory.a_book_from_the_editorial(), 1)
        
        self._storefront.check_out_cart(cart_id, self._object_factory.a_valid_credit_card())

        collaboration_to_assert = lambda: self._storefront.check_out_cart(cart_id, self._object_factory.a_valid_credit_card())
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, Storefront.cart_already_checked_out_error_message())
        
    def test16_client_cannot_add_book_to_an_already_checked_out_cart(self):
        cart_id = self._object_factory.an_id_of_an_empty_cart(self._storefront)
        self._storefront.add_to_cart(cart_id, self._object_factory.a_book_from_the_editorial(), 1)
        
        self._storefront.check_out_cart(cart_id, self._object_factory.a_valid_credit_card())

        collaboration_to_assert = lambda: self._storefront.add_to_cart(cart_id, self._object_factory.a_book_from_the_editorial(), 1)
        self._assert_collaboration_raises_error_with_message(collaboration_to_assert, Storefront.cart_already_checked_out_error_message())

        ###########################         METODOS PRIVADOS        ###########################

    def _assert_client_has_only_purchased(self, client_id, password, a_book, book_quantity):
        total_price = self._object_factory.the_editorial_catalog()[a_book] * book_quantity

        self.assertTrue(self._storefront.list_purchases(client_id, password).contains_item(a_book, book_quantity))
        self.assertEqual(self._storefront.list_purchases(client_id, password).total(), total_price)

    def _assert_cart_with_this_id_is_empty(self, cart_id):
        self.assertEqual(len(self._storefront.list_cart_content(cart_id)), 0)

    def _assert_cart_with_this_id_only_contains(self, cart_id, a_book):
        cart_content = self._storefront.list_cart_content(cart_id)
        self.assertTrue(a_book in cart_content)
        self.assertEqual(len(cart_content), 1)

    def _assert_collaboration_raises_error_with_message(self, collaboration_to_run, error_message):
        try: 
            collaboration_to_run()
            self.fail()
        except Exception as thrown_exception:
            self.assertEqual(str(thrown_exception), error_message)


#####################################################################
#                                                                   #
#                               MAIN                                #
#                                                                   #
#####################################################################
if __name__ == '__main__':
    unittest.main()
