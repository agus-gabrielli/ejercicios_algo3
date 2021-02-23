from ShoppingCart import *


class Storefront:

    def __init__(self, publishers_catalog):
        self._client_credentials = {"Mauro_Rizzi": "123457", "Agustin_Gabrielli": "pepito"}
        self._carts = {}
        self._book_catalog = publishers_catalog

    def create_cart_for(self, client_id, client_password):
        if client_id not in self._client_credentials or not self._client_credentials[client_id] == client_password:
            raise Exception(self.__class__.invalid_credentials_error_message())

        cart = ShoppingCart(self._book_catalog)
        cart_id = "asdasdas"
        self._carts[cart_id] = cart
        return cart_id

    def list_cart_content(self, client_id, carti_id):
        return self._carts[carti_id].list_content()

    def add_to_cart(self, cart_id, book_isbn, book_quantity):
        self._carts[cart_id].add_book(book_isbn, book_quantity)

    @classmethod
    def invalid_credentials_error_message(cls):
        return "No se puede realizar la acción pues las credenciales son inválidas"

    @classmethod
    def cannot_add_book_to_cart_with_invalid_id_error_message(cls):
        return "No se puede agregar un libro a un carrito inválido"