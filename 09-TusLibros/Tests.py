from TusLibros import Cart

def test01newCartIsEmpty():
    cart = Cart(123123, 'hola')
    assert cart.size == 0, "El carro no estaba vacío"


def main():
    test01newCartIsEmpty()

if __name__ == '__main__':
    main()