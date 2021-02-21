class ShoppingCart:

    def __init__(self, catalog):
        self._contained_books = {}
        self._books_sold_by_publisher = catalog

    def is_empty(self):
        return not self._contained_books

    def add_book(self, book_to_add, book_quantity):
        if book_to_add not in self._books_sold_by_publisher:
            raise Exception(self.__class__.cannot_add_unkown_book_to_cart_error_message())
        if book_quantity < 1:
            raise Exception(self.__class__.cannot_add_zero_or_negative_amount_of_books_to_cart_error_message())
    
        if book_to_add not in self._contained_books:
            self._contained_books[book_to_add] = book_quantity
        else: 
            self._contained_books[book_to_add] += book_quantity
    
    def contains(self, queried_book, book_quantity):
        return queried_book in self._contained_books and self._contained_books[queried_book] == book_quantity

    def list_content(self):
        return self._contained_books.copy()

    @classmethod
    def cannot_add_unkown_book_to_cart_error_message(cls):
        return "Cannot add a book from another editorial to the cart"

    @classmethod
    def cannot_add_zero_or_negative_amount_of_books_to_cart_error_message(cls):
        return "Cannot add a book with zero or negative quantity to the cart"
