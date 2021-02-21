class CreditCard:
    
    def __init__(self, owners_name, credit_card_number, expiration_month_of_year):
        
        self._check_owners_name_is_not_blank(owners_name)
        self._check_valid_credit_card_number(credit_card_number)

        self._owners_name = owners_name
        self._credit_card_number = credit_card_number
        self._expiration_month_of_year = expiration_month_of_year

    def _check_owners_name_is_not_blank(self, owners_name):
        if owners_name == '':
            raise Exception(cls.name_cannot_be_blank_error_message())
    
    def _check_valid_credit_card_number(self, credit_card_number):
        if len(credit_card_number) != 16 or not credit_card_number.isnumeric():
            raise Exception(cls.number_must_be_sixteen_digits_error_message())

    def is_expired_on(self, a_datetime):
        return a_datetime.date() > self._expiration_month_of_year.last_date()


    @classmethod
    def name_cannot_be_blank_error_message(cls):
        return "Name cannot be blank"
    
    @classmethod
    def number_must_be_sixteen_digits_error_message(cls):
        return "El numero de la tarjeta de credito es invalido"
    