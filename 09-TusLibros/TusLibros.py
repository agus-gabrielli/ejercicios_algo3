from TusLibrosExceptions import *
from datetime import datetime

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
        if queried_book not in self._contained_books: 
            return False
        return self._contained_books[queried_book] == book_quantity

    def list_content(self):
        return self._contained_books.copy()


class Cashier:
    def __init__(self, ledger, price_list):
        self.ledger = ledger
        self.price_list = price_list


    def check_out_cart(self, client_cart, credit_card):
        if client_cart.is_empty():
            raise CannotCheckoutEmptyCart

        ticket = self._create_ticket(client_cart)
        self.ledger.append(ticket)
        return ticket

    def _create_ticket(self, client_cart):
        ticket = []
        total = 0
        for book,book_quantity in client_cart.list_content().items():
            ticket.append((book, book_quantity))
            total += self.price_list[book] * book_quantity
        
        ticket.append(("Total:", total))
        return ticket

    def _check_expiration_date_of(self, credit_card):
        
        date = datetime.strptime(credit_card[1], '%m/%y')
        date < datetime.now()


        


        
        



