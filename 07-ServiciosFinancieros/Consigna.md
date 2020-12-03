# Servicios financieros

## Primera parte: Transferencias

Un banco quiere empezar a ofrecer nuevos servicios a sus clientes, por lo que nos contrató para extender su actual sistema.

Actualmente se cuenta con un modelo bancario simple, formado por transacciones de depósito y retiro, así como cuentas bancarias y una implementación inicial de portfolios. El mismo se puede cargar haciendo file-in de ServiciosFinancieros-Ejercicio.st.

Dentro de los nuevos servicios está la posibilidad de realizar transferencias entre los clientes. Para ello decidió agregar un nuevo tipo de transacción: la transferencia entre cuentas.

Una **transferencia** es una transacción entre cuentas, que tiene ”dos patas”. La pata de la extracción, de donde se saca la plata, y la pata del depósito a donde se deposita la plata.

Una transferencia se realiza entonces entre dos cuentas y por un valor.

Además de poder registrar una transferencia entre cuentas, deseamos poder saber el valor de la misma. Del mismo modo, queremos poder preguntarle a cada una de las patas de la transferencia cual es su contraparte: a la pata de extracción cual es el depósito por transferencia relacionado, y viceversa.

Antes de comenzar, notar que uno de los tests está fallando.. ¿qué sucede? Corregir este problema antes de comenzar con el modelado de las transferencias.

Una vez corregido el test, implementar el modelo mediante TDD.

## Segunda parte: Portfolios

Ahora que el banco posee la funcionalidad de transferencias entre cuentas, quiere empezar a ofrecer más servicios financieros a sus clientes más avanzados. Dentro de los nuevos servicios está la posibilidad de poder administrar agrupaciones de cuentas. Esas agrupaciones de cuentas se denominan portfolios.

Actualmente un portfolio permite únicamente agregarle cuentas y otros portfolios, pero se espera poder hacer con ellos lo mismo que con una cuenta convencional, excepto registrar transacciones. Por ejemplo, debemos podemos obtener el balance de un portfolio: Si un portfolio es la agrupación de Cuenta 1 (con balance de $100) y Cuenta 2 (con balance de $200), se espera que el balance del mismo sea $300. También se espera poder preguntarle a un portfolio si alguna de sus cuentas registró una transacción.

Por el momento, no se desea poder quitar cuentas o portfolios de un portfolio.

Implementar la solución utilizando TDD, extendiendo PortfolioTest.
