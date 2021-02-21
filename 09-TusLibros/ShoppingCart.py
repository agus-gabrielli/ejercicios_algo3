from TusLibrosExceptions import *


class ShoppingCart:

    def __init__(self, catalog):
        self._contained_books = {}
        self._books_sold_by_publisher = catalog

    def is_empty(self):
        return not self._contained_books

    def add_book(self, book_to_add, book_quantity):
        if book_to_add not in self._books_sold_by_publisher:
            raise UnknownBook("No se puede agregar al carro libros de otra editorial")
        if book_quantity < 1:
            raise InvalidBookQuantity("La cantidad de unidades del libro agregado debe ser mayor a 0")
    
        if book_to_add not in self._contained_books:
            self._contained_books[book_to_add] = book_quantity
        else: 
            self._contained_books[book_to_add] += book_quantity
    
    def contains(self, queried_book, book_quantity):
        return queried_book in self._contained_books and self._contained_books[queried_book] == book_quantity

    def list_content(self):
        return self._contained_books.copy()
