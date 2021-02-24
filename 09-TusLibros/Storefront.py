from ShoppingCart import *
from Cashier import *
#from Ticket import *

class Storefront:

    def __init__(self, publishers_catalog, login_system, price_list, merchant_processor):
        self._book_catalog = publishers_catalog
        self._login_system = login_system
        self._price_list = price_list
        self._cashier = Cashier([], price_list, merchant_processor)
        self._client_carts = {} #purch
        self._cart_client = {}
        self._clients_tickets = {}
        self._carts = {}
        self._number_of_carts = 0
        self._number_of_tickets = 0

    def create_cart_for(self, client_id, client_password):
        self._login_system.log_in_user(client_id, client_password)

        cart = ShoppingCart(self._book_catalog)
        cart_id = str(self._number_of_carts)
        self._number_of_carts += 1
        self._carts[cart_id] = cart

        if client_id not in self._client_carts:
            self._client_carts[client_id] = [cart_id]
        else:
            self._client_carts[client_id].append(cart_id)

        self._cart_client[cart_id] = client_id

        return cart_id

    def list_cart_content(self, cart_id):
        self._check_cart_id_is_valid(cart_id)
        return self._carts[cart_id].list_content()

    def add_to_cart(self, cart_id, book_isbn, book_quantity):
        self._check_cart_id_is_valid(cart_id)
        self._carts[cart_id].add_book(book_isbn, book_quantity)

    def check_out_cart(self, cart_id, credit_card):
        self._check_cart_id_is_valid(cart_id)
        cart_owner_id = self._cart_client[cart_id]
        ticket = self._cashier.check_out(self._carts[cart_id], credit_card)

        if cart_owner_id not in self._clients_tickets:
            self._clients_tickets[cart_owner_id] = [ticket]
        else:
            self._clients_tickets[cart_owner_id].append(ticket)

        transaction_id = str(self._number_of_tickets)
        self._number_of_tickets += 1
        return transaction_id

    def list_purchases(self, client_id, password):
        accumulated_tickets_for_client = Ticket()
        for ticket in self._clients_tickets[client_id]:
            for book,quantity in ticket.list_items().items():
                accumulated_tickets_for_client.add_item(book, quantity, self._price_list[book])

        return accumulated_tickets_for_client


    def _check_cart_id_is_valid(self, cart_id):
        if cart_id not in self._carts:
            raise Exception(self.__class__.invalid_cart_error_message())

    @classmethod
    def cannot_add_book_to_cart_with_invalid_id_error_message(cls):
        return "No se puede agregar un libro a un carrito inválido"

    @classmethod
    def invalid_cart_error_message(cls):
        return "La id del carrito es inválida"