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

        self._check_valid_credit_card_number(credit_card)
        self._check_valid_owner_name(credit_card)
        self._check_expiration_date_of(credit_card)

        ticket = self._create_ticket(client_cart)

        self.mock_merchant_processor("https:")

        self.ledger.append(ticket)
        return ticket

    def _create_ticket(self, client_cart):
        ticket = []
        purchase_total = 0
        for book,book_quantity in client_cart.list_content().items():
            ticket.append((book, book_quantity))
            purchase_total += self.price_list[book] * book_quantity
        self._check_for_transaction_amount_overflow(purchase_total)
        ticket.append(("Total:", round(purchase_total, 2)))
        return ticket

    def _check_expiration_date_of(self, credit_card):
        expiry_date = datetime.strptime(credit_card[1], '%m/%Y')
        if expiry_date < datetime.now():
            raise ExpiredCreditCard("La tarjeta de credito estaba vencida")

    def _check_valid_credit_card_number(self, credit_card):
        if len(credit_card[0]) != 16 or not credit_card[0].isnumeric():
            raise InvalidCreditCardNumber("El numero de la tarjeta de credito es invalido")

    def _check_valid_owner_name(self, credit_card):
        if len(credit_card[2]) > 30:
            raise InvalidCreditCardOwner("El nombre del dueño de la tarjeta es demasiado largo")

    def _check_for_transaction_amount_overflow(self, total):
        if total > 999999999999999.99:
            raise TransactionAmountOverflow("El importe de la compra excede lo permitido")
        
    def _build_transaction_stream(self, credit_card, total):
# https://merchant.com/debit?creditCardNumber=5400000000000001&creditCardExpiration=072011&creditCardOwner=PEPE%20SANCHEZ&transactionAmount=123.50#
        string_total = str(total)
        if len(string_total) - string_total.index(".") == 2:
            string_total = string_total + "0"
        return "https://merchant.com/debit?creditCardNumber=" + credit_card[0] + "&creditCardExpiration=" + credit_card[1].replace("/","") + "&creditCardOwner=" + credit_card[2].upper().replace(" ", "%20") + "&transactionAmount=" + string_total

        
        



