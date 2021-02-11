from CartExceptions import *


class ShoppingCart():

    def __init__(self):
        self.contained_books = {}
        self.books_sold_by_publisher = {"9788498387087", "9788498389722", "9789878000121"}

    def is_empty(self):
        return not self.contained_books

    def add_book(self, book_to_add, book_quantity):
        if book_to_add not in self.books_sold_by_publisher:
            raise UnknownBook("No se puede agregar al carro libros de otra editorial")
        if book_quantity < 1:
            raise InvalidBookQuantity("La cantidad de unidades del libro agregado debe ser mayor a 0")
    
        if book_to_add not in self.contained_books:
            self.contained_books[book_to_add] = book_quantity
        else: 
            self.contained_books[book_to_add] += book_quantity
    
    def contains(self, queried_book, book_quantity):
        if queried_book not in self.contained_books: 
            return False
        return self.contained_books[queried_book] == book_quantity

    def list_content(self):
        content_list = "0"
        for book, book_quantity in self.contained_books.items():
            content_list = content_list + "|" + book + "|" + str(book_quantity)
        return content_list
