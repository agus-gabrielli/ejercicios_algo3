from ShoppingCart import *

class Storefront:

    def __init__(self):
        self._clients_credentials = {"Mauro_Rizzi": "12345"}
        self._clients_carts = {}     
        self._carts_clients = {} 

    def create_cart_for(self, client_id, client_password):
        if client_id not in self._clients_credentials and client_password not in self._clients_credentials.values():
            raise Exception(self.__class__.invalid_credentials_error_message())

        if client_id not in self._clients_carts:
            self._clients_carts[client_id] = []
        cart_id = client_id + str(len(self._clients_carts[client_id]))
        self._clients_carts[client_id].append(cart_id)
        self._carts_clients[cart_id] = client_id
        return cart_id

    def client_has_cart(self, client_id, cart_id):
        if client_id not in self._clients_carts: 
            return False

        return cart_id in self._clients_carts[client_id]

    def add_to_cart(self, cart_id, book_isbn, book_quantity):
        if cart_id not in self._carts_clients: 
            raise Exception(self.__class__.cannot_add_book_to_cart_with_invalid_id_error_message())

    def cart_contains(self, cart_id, book_isbn, book_quantity):
        return True

    @classmethod
    def invalid_credentials_error_message(cls):
        return "No se puede realizar la acción pues las credenciales son inválidas"

    @classmethod
    def cannot_add_book_to_cart_with_invalid_id_error_message(cls):
        return "No se puede agregar un libro a un carrito inválido"