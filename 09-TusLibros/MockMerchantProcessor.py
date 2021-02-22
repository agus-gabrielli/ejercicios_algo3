import PublisherTestObjectsFactory

class MockMerchantProcessor:
    def process_payment(self, total, credit_card):
        if credit_card._credit_card_number == PublisherTestObjectsFactory.PublisherTestObjectsFactory().a_stolen_credit_card_number():
            raise Exception(self.__class__.generic_rejected_payment_error_message())

    @classmethod
    def generic_rejected_payment_error_message(cls):
        return "The payment was rejected"
