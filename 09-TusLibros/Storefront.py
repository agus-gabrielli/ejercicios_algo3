from ShoppingCart import *
from Cashier import *

class Storefront:

    def __init__(self, publishers_catalog, login_auth_system, merchant_processor, system_clock, time_before_expiration):
        self._book_catalog = publishers_catalog
        self._time_before_cart_expiration = time_before_expiration
        self._system_clock = system_clock
        self._login_auth_system = login_auth_system
        self._cashier = Cashier([], publishers_catalog, merchant_processor)

        self._cartID_cart = {}
        self._cartID_ticket = {}

        self._clientID_cartsIDs = {} 
        self._cartID_clientID = {}
        self._cart_last_time_of_use = {}
        self._number_of_carts = 0
        self._number_of_tickets = 0

    def create_cart_for(self, client_id, client_password):
        self._login_auth_system.log_in_user(client_id, client_password)

        cart = ShoppingCart(self._book_catalog)
        cart_id = str(self._number_of_carts)
        self._cart_last_time_of_use[cart_id] = self._system_clock.now()
        self._number_of_carts += 1
        self._cartID_cart[cart_id] = cart

        if client_id not in self._clientID_cartsIDs:
            self._clientID_cartsIDs[client_id] = [cart_id]
        else:
            self._clientID_cartsIDs[client_id].append(cart_id)

        self._cartID_clientID[cart_id] = client_id
        
        return cart_id

    def list_cart_content(self, cart_id):
        self._check_cart_id_is_valid(cart_id)
        self._check_if_cart_expired(cart_id)

        self._cart_last_time_of_use[cart_id] = self._system_clock.now()
        return self._cartID_cart[cart_id].list_content()

    def add_to_cart(self, cart_id, book_isbn, book_quantity):
        self._check_if_cart_can_be_used(cart_id)

        self._cart_last_time_of_use[cart_id] = self._system_clock.now()
        self._cartID_cart[cart_id].add_book(book_isbn, book_quantity)

    def check_out_cart(self, cart_id, credit_card):
        self._check_if_cart_can_be_used(cart_id)

        self._cart_last_time_of_use[cart_id] = self._system_clock.now()

        cart_owner_id = self._cartID_clientID[cart_id]
        ticket = self._cashier.check_out(self._cartID_cart[cart_id], credit_card)

        transaction_id = str(self._number_of_tickets)
        self._number_of_tickets += 1
        self._cartID_ticket[cart_id] = ticket
        return transaction_id

    def list_purchases(self, client_id, password):
        self._login_auth_system.log_in_user(client_id, password)

        accumulated_tickets_for_client = Ticket()
        for cart_id in self._clientID_cartsIDs[client_id]:
            if cart_id in self._cartID_ticket:
                for book,quantity in self._cartID_ticket[cart_id].list_items().items():
                    accumulated_tickets_for_client.add_item(book, quantity, self._book_catalog[book])

        return accumulated_tickets_for_client

    def _check_if_cart_expired(self, cart_id):
        if self._system_clock.now() - self._cart_last_time_of_use[cart_id] > self._time_before_cart_expiration:
            raise Exception(self.__class__.cart_is_expired_error_message())

    def _check_if_cart_can_be_used(self, cart_id):
            self._check_cart_id_is_valid(cart_id)
            self._check_if_cart_is_already_checked_out(cart_id)
            self._check_if_cart_expired(cart_id)

    def _check_if_cart_is_already_checked_out(self, cart_id):
        if cart_id in self._cartID_ticket:
            raise Exception(self.__class__.cart_already_checked_out_error_message())

    def _check_cart_id_is_valid(self, cart_id):
        if cart_id not in self._cartID_cart:
            raise Exception(self.__class__.invalid_cart_error_message())

    @classmethod
    def cannot_add_book_to_cart_with_invalid_id_error_message(cls):
        return "No se puede agregar un libro a un carrito inválido"

    @classmethod
    def invalid_cart_error_message(cls):
        return "La id del carrito es inválida"

    @classmethod
    def cart_is_expired_error_message(cls):
        return "El carrito ha expirado, no puede usarlo"

    @classmethod
    def cart_already_checked_out_error_message(cls):
        return "Ya se había hecho checkout sobre este carrito"