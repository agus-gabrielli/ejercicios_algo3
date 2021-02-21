from TusLibrosExceptions import *
from datetime import datetime
from Ticket import Ticket


class Cashier:
    def __init__(self, ledger, price_list, merchant_processor):
        self._ledger = ledger
        self._price_list = price_list
        self._merchant_processor = merchant_processor

    def check_out(self, client_cart, credit_card):
        if client_cart.is_empty():
            raise CannotCheckoutEmptyCart

        ticket = self._process_items_of(client_cart)

        self._validate_credit_card(credit_card)
        self._check_for_transaction_amount_overflow(ticket.total())

        self._merchant_processor.process_payment(ticket.total(), credit_card)
        self._ledger.append(ticket)
        return ticket

    def _process_items_of(self, client_cart):
        ticket = Ticket()

        for book, book_quantity in client_cart.list_content().items():
            ticket.add_item(book, book_quantity, self._price_list[book])

        return ticket

    def _validate_credit_card(self, credit_card):
        self._check_valid_credit_card_number(credit_card)
        self._check_valid_owner_name(credit_card)
        self._check_expiration_date_of(credit_card)

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
