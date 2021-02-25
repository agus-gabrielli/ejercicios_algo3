class LoginSystemMock:
    def __init__(self, user_credentials):
        self._user_credentials = user_credentials
        
    def log_in_user(self, user_id, password):
        if user_id not in self._user_credentials or not self._user_credentials[user_id] == password:
            raise Exception(self.__class__.invalid_credentials_error_message())

    @classmethod
    def invalid_credentials_error_message(cls):
        return "No se puede realizar el login pues las credenciales son inválidas"
