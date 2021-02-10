from TusLibros import Cart

def test01_new_cart_is_empty():
    cart = Cart(123123, 'hola')
    assert cart.is_empty(), "El carro no estaba vacío"
    print("Test01 OK")

def test02_cart_contains_added_book():
    cart = Cart(123123, 'hola')
    libro = "librito1"
    cart.add_book(libro, 1)
    assert not cart.is_empty(), "El carro estaba vacío"
    assert cart.contains(libro, 1), "El carro no contenía el libro que agregamos"
    print("Test02 OK")

def test03_cart_doesnt_contain_not_added_book():
    cart = Cart(123123, 'hola')
    libro1 = "librito1"
    libro2 = "librito2"
    cart.add_book(libro1, 1)
    assert not cart.contains(libro2, 1), "El carro contenía el libro que no habíamos agregado"
    print("Test03 OK")

def test04_cart_contains_multiple_added_books():
    cart = Cart(123123, 'hola')
    libro1 = "librito1"
    libro2 = "librito2"
    libro3 = "librito3"
    cart.add_book(libro1, 1)
    cart.add_book(libro2, 1)
    cart.add_book(libro3, 1)
    assert not cart.is_empty(), "El carro estaba vacío"
    assert cart.contains(libro1, 1), "El carro no contenía el libro1"
    assert cart.contains(libro2, 1), "El carro no contenía el libro2"
    assert cart.contains(libro3, 1), "El carro no contenía el libro3"
    print("Test04 OK")

def test05_cart_can_contain_same_book_multiple_times():
    cart = Cart(123123, 'hola')
    libro1 = "librito1"
    cart.add_book(libro1, 3)
    assert cart.contains(libro1, 3), "El carro no contenía la cantidad correcta de libro1"
    assert not cart.contains(libro1, 6), "El carro contenía una cantidad incorrecta de libro1"
    print("Test05 OK")

def test06_list_of_empty_cart_is_empty():
    cart = Cart(123123, 'hola')
    assert cart.list_content() == "0", "La lista no estaba vacía"
    print("Test06 OK")

def test07_cart_with_multiple_books_can_list_its_content():
    cart = Cart(123123, 'hola')
    libro1 = "librito1"
    libro2 = "librito2"
    cart.add_book(libro1, 1)
    cart.add_book(libro2, 3)
    assert cart.list_content() == "0|librito1|1|librito2|3", "La lista es incorrecta"
    print("Test07 OK")

def test08_cart_doesnt_accept_books_from_external_publisher():
    cart = Cart(123123, 'hola')
    libro_de_la_editorial = "librito1"
    libro_de_otra_editorial = "librito_de_otra_editorial"
    cart.add_book(libro_de_la_editorial, 1)
    assert not cart.add_book(libro_de_otra_editorial, 3), "Se agregó un libro que no es de la editorial"
    assert not cart.contains(libro_de_otra_editorial, 3), "El carrito tiene un libro que no es de la editorial"
    print("Test08 OK")

def test09_cart_only_accepts_a_book_quantity_greater_than_zero():
    cart = Cart(123123, 'hola')
    assert not cart.add_book("librito1", -2), "Se agregó un libro cuya cantidad es menor a 1"
    assert not cart.contains("librito1", -2), "El carrito contiene un libro agregado con cantidad menor a 1"
    print("Test09 OK")

def main():
    test01_new_cart_is_empty()
    test02_cart_contains_added_book()
    test03_cart_doesnt_contain_not_added_book()
    test04_cart_contains_multiple_added_books()
    test05_cart_can_contain_same_book_multiple_times()
    test06_list_of_empty_cart_is_empty()
    test07_cart_with_multiple_books_can_list_its_content()
    test08_cart_doesnt_accept_books_from_external_publisher()
    test09_cart_only_accepts_a_book_quantity_greater_than_zero()

if __name__ == '__main__':
    main()