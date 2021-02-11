from TusLibros import ShoppingCart


#####################################################################
#                                                                   #
#                    FUNCIONES AUXILIARES                           #
#                                                                   #
#####################################################################
def add_multiple_books_to_cart(shopping_cart, list_of_books_to_add):
    for book_to_add, quantity in list_of_books_to_add:
        shopping_cart.add_book(book_to_add, quantity)


def assert_that_cart_includes(shopping_cart, list_of_books):
    for book_to_add, quantity in list_of_books:
        if not shopping_cart.contains(book_to_add, quantity): 
            return False
    return True


#####################################################################
#                                                                   #
#                       FUNCIONES TESTS                             #
#                                                                   #
#####################################################################
def test01_new_cart_is_empty():
    shopping_cart = ShoppingCart()

    assert shopping_cart.is_empty(), "El carro no estaba vacío"
    print("    Test01 OK")


def test02_can_add_book_to_cart():
    shopping_cart = ShoppingCart()
    book_to_add = "9788498387087"

    shopping_cart.add_book(book_to_add, 1)

    assert not shopping_cart.is_empty(), "El carro estaba vacío"
    assert shopping_cart.contains(book_to_add, 1), "El carro no contenía el libro que agregamos"
    print("    Test02 OK")


def test03_cart_doesnt_contain_not_added_book():
    shopping_cart = ShoppingCart()
    first_book_to_add = "9788498387087"
    second_book_to_add = "9788498389722"

    shopping_cart.add_book(first_book_to_add, 1)

    assert not shopping_cart.contains(second_book_to_add, 1), "El carro contenía el libro que no habíamos agregado"
    print("    Test03 OK")


def test04_can_add_multiple_distinct_books_to_cart():
    shopping_cart = ShoppingCart()
    list_of_books_to_add = [("9788498387087", 1), ("9788498389722", 1), ("9789878000121", 1)]

    add_multiple_books_to_cart(shopping_cart, list_of_books_to_add)

    assert not shopping_cart.is_empty(), "El carro estaba vacío"
    assert assert_that_cart_includes(shopping_cart, list_of_books_to_add)
    print("    Test04 OK")


def test05_can_add_multiple_copies_of_same_book():
    shopping_cart = ShoppingCart()
    book_to_add = "9788498387087"

    shopping_cart.add_book(book_to_add, 3)

    assert shopping_cart.contains(book_to_add, 3), "El carro no contenía la cantidad correcta del libro"
    assert not shopping_cart.contains(book_to_add, 6), "El carro contenía una cantidad incorrecta del libro"
    print("    Test05 OK")


def test06_list_of_empty_cart_is_empty():
    shopping_cart = ShoppingCart()

    assert shopping_cart.list_content() == "0", "La lista no estaba vacía"
    print("    Test06 OK")


def test07_cart_with_multiple_books_can_list_its_content():
    shopping_cart = ShoppingCart()
    list_of_books_to_add = [("9788498387087", 1), ("9788498389722", 3)]

    add_multiple_books_to_cart(shopping_cart, list_of_books_to_add)

    assert shopping_cart.list_content() == "0|9788498387087|1|9788498389722|3", "El contenido de la lista es incorrecto"
    print("    Test07 OK")


def test08_cart_doesnt_accept_books_from_another_publisher():
    shopping_cart = ShoppingCart()
    book_from_another_publisher = "9789505470662"

    try:
        shopping_cart.add_book(book_from_another_publisher, 3)
    except:
        assert not shopping_cart.contains(book_from_another_publisher, 3), "El carro contenía un libro de otra editorial"
    else:
        assert False, "El carro permitió agregar un libro de otra editorial"
    print("    Test08 OK")


def test09_cart_only_accepts_a_book_quantity_greater_than_zero():
    shopping_cart = ShoppingCart()
    book_to_add = "9788498387087"

    try:
        shopping_cart.add_book(book_to_add, -2)
    except:
        assert not shopping_cart.contains(book_to_add, -2), "El carrito contiene un libro agregado con cantidad menor a 1"
    else:
        assert False, "El carro permitió agregar una cantidad de libros menor a 1"
    print("    Test09 OK")


def run_cart_tests():
    print("Starting Cart Tests")
    test01_new_cart_is_empty()
    test02_can_add_book_to_cart()
    test03_cart_doesnt_contain_not_added_book()
    test04_can_add_multiple_distinct_books_to_cart()
    test05_can_add_multiple_copies_of_same_book()
    test06_list_of_empty_cart_is_empty()
    test07_cart_with_multiple_books_can_list_its_content()
    test08_cart_doesnt_accept_books_from_another_publisher()
    test09_cart_only_accepts_a_book_quantity_greater_than_zero()
    print("All Cart Tests OK")


#####################################################################
#                                                                   #
#                               MAIN                                #
#                                                                   #
#####################################################################
def main():
    run_cart_tests()


if __name__ == '__main__':
    main()
