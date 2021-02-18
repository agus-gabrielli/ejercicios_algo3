
class UnknownBook(Exception):
    pass

class InvalidBookQuantity(Exception):
    pass

class CannotCheckoutEmptyCart(Exception):
    pass

class ExpiredCreditCard(Exception):
    pass

class InvalidCreditCardNumber(Exception):
    pass

class InvalidCreditCardOwner(Exception):
    pass

class TransactionAmountOverflow(Exception):
    pass

class PaymentRejected(Exception):
    pass