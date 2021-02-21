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
        self._check_if_expired(credit_card)

        ticket = self._process_items_of(client_cart)

        self._check_for_transaction_amount_overflow(ticket.total())

        self._merchant_processor.process_payment(ticket.total(), credit_card)
        self._ledger.append(ticket)
        return ticket

    def _process_items_of(self, client_cart):
        ticket = Ticket()

        for book, book_quantity in client_cart.list_content().items():
            ticket.add_item(book, book_quantity, self._price_list[book])

        return ticket

    def _check_if_expired(self, credit_card):
        if credit_card.is_expired_on(datetime.now()):
            raise Exception(self.__class__.cannot_checkout_using_an_expired_card_error_message())


    def _check_for_transaction_amount_overflow(self, total):
        if total > 999999999999999.99:
            raise TransactionAmountOverflow("El importe de la compra excede lo permitido")

    @classmethod
    def cannot_checkout_an_empty_cart_error_message(cls):
        return "Cannot checkout an empty cart"

    @classmethod
    def cannot_checkout_using_an_expired_card_error_message(cls):
        return "Cannot checkout using an expired card"

    @classmethod
    def could_not_process_payment_error_message(cls):
        return "Cannot checkout using an expired card"
