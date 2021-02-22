from ShoppingCart import *
from Ticket import *
from CreditCard import *
from Cashier import *
from Storefront import *
from MonthOfYear import *
from datetime import datetime
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
        self.book_to_add = self._test_objects_factory.a_book_from_the_editorial()
        self.second_book_to_add = self._test_objects_factory.the_editorial_catalog()[1]
        self.third_book_to_add = self._test_objects_factory.the_editorial_catalog()[2]
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
        self.book_to_add = self._test_objects_factory.a_book_from_the_editorial()
        self.second_book_to_add = self._test_objects_factory.the_editorial_catalog()[1]
        self.expensive_book_to_add = self._test_objects_factory.the_editorial_catalog()[2]
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

    # def test05_cannot_check_out_with_invalid_credit_card_number(self):
    #     with self.assertRaises(InvalidCreditCardNumber):
    #         self.cashier.check_out(self.shopping_cart_with_a_book, ["sadasdasas456", self._create_valid_expiration_date(), "Hackermann"])
    #     self.assertFalse(self.ledger)

    # def test06_cannot_check_out_with_wrong_credit_card_owner_name(self):
    #     with self.assertRaises(InvalidCreditCardOwner):
    #         self.cashier.check_out(self.shopping_cart_with_a_book, ["1234567890987654", self._create_valid_expiration_date(), "Jose Francisco de San Martín y Matorras"])
    #     self.assertFalse(self.ledger)

    def test07_cannot_check_out_excessivelly_expensive_purchase(self):
        self.shopping_cart.add_book(self.expensive_book_to_add, 4)

        try:
            self.cashier.check_out(self.shopping_cart, self.valid_credit_card)
            self.fail()
        except Exception as thrown_exception:
            self.assertEqual(str(thrown_exception), Cashier.cannot_checkout_purchase_total_too_large_error_message())
            self.assertFalse(self.ledger)

    def test08_check_out_is_stopped_when_merchant_processor_rejects_payment(self):
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
    def test01_cannot_create_cart_with_invalid_credentials(self):
        storefront = Storefront()
        try: 
            storefront.create_cart_for("Enrique_El_Antiguo", "contraseña")
            self.fail()
        except Exception as thrown_exception:
            self.assertEqual(str(thrown_exception), Storefront.invalid_credentials_error_message())

    def test02_can_create_cart_with_valid_credentials(self):
        storefront = Storefront()
        client_id = "Mauro_Rizzi"
        cart_id = storefront.create_cart_for(client_id, "12345")
        self.assertTrue(storefront.client_has_cart(client_id, cart_id))

    def test03_new_client_does_not_have_a_cart(self):
        storefront = Storefront()
        client_id = "Raúl"
        self.assertFalse(storefront.client_has_cart(client_id, "id_invalido"))

    def test04_client_that_created_one_cart_does_not_have_another_cart(self):
        storefront = Storefront()
        client_id = "Mauro_Rizzi"
        cart_id = storefront.create_cart_for(client_id, "12345")
        self.assertFalse(storefront.client_has_cart(client_id, cart_id + "invalid"))

    def test05_two_different_carts_have_different_ids(self):
        storefront = Storefront()
        client_id = "Mauro_Rizzi"
        first_cart_id = storefront.create_cart_for(client_id, "12345")
        second_cart_id = storefront.create_cart_for(client_id, "12345")
        self.assertNotEqual(first_cart_id, second_cart_id)

    def test06_same_client_can_have_multiple_carts(self):
        storefront = Storefront()
        client_id = "Mauro_Rizzi"
        first_cart_id = storefront.create_cart_for(client_id, "12345")
        second_cart_id = storefront.create_cart_for(client_id, "12345")
        self.assertTrue(storefront.client_has_cart(client_id, first_cart_id))
        self.assertTrue(storefront.client_has_cart(client_id, second_cart_id))

    def test07_cannot_add_book_to_cart_with_invalid_id(self):
        storefront = Storefront()
        try:
            storefront.add_to_cart("juancito", "3434324324321234", 2)
            self.fail()
        except Exception as thrown_exception:
            self.assertEqual(str(thrown_exception), Storefront.cannot_add_book_to_cart_with_invalid_id_error_message())

    def test08_client_can_add_book_to_cart(self):
        storefront = Storefront()
        client_id = "Mauro_Rizzi"
        cart_id = storefront.create_cart_for(client_id, "12345")
        storefront.add_to_cart(cart_id, "3434324324321234", 2)
        self.assertTrue(storefront.cart_contains(cart_id, "3434324324321234", 2))




#####################################################################
#                                                                   #
#                               MAIN                                #
#                                                                   #
#####################################################################
if __name__ == '__main__':
    unittest.main()