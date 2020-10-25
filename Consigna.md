# Factorio

Hola soy el ingeniero de la planta Factorio donde extraemos hierro y carbón. Necesito un sistema que me ayude a planificar distintas formas de organizar nuestro circuito de producción. En la fábrica contamos con dos extractores, uno de carbón y otro de hierro, dos cintas transportadoras (dato de color…una es roja y la otra azul) y una caja donde almacenamos las menas de carbón y hierro producidas. El circuito que tenemos hoy en la fábrica es el siguiente:

![Circuito de Factorio](https://github.com/algoritmos-iii/ejercicios-2020-2c/blob/main/01-Factorio/Circuito.png)

Ahora necesito poder hacer funcionar este circuito. Pero pronto necesitaremos poder conectar los componentes de otra forma.

Ahh...me olvidé de contarles cómo funciona esto. El circuito tiene un ciclo de producción, hoy tenemos configurado para que ese ciclo sea el siguiente: funciona una vez el extractor de carbón, deposita la mena de carbón extraída en su cinta, luego funciona el extractor de hierro, dejando la mena de hierro en su cinta, luego funciona la cinta conectada al extractor de hierro, y luego la otra cinta, dejando las dos menas en la caja contenedora.

Tienen que modelar con nuestros queridos objetos el funcionamiento del circuito del ingeniero de Factorio. Les recomendamos descomponer la problemática en los siguientes escenarios:

**Escenario 1 Extractor-Caja**: simplifiquemos el circuito, quiero conectar el extractor de carbón a una caja contenedora. Hago andar el extractor y veo que en la caja hay una mena de carbón. Por ejemplo si hago andar el extractor dos veces entonces en el contenedor hay dos menas de carbón.

**Escenario 2 Extractor-Cinta-Caja**: un escenario más avanzado ahora sería conectar el extractor de carbón a la cinta y la cinta a la caja. Si hago andar al extractor, entonces veo que hay una mena de carbón en la cinta. Luego si hago andarla cinta, veo que el contenedor tiene la mena de carbón que estaba en la cinta.

**Escenario 3 Extractor-Extrator-Cinta-Cinta-Caja**: circuito completo de la fábrica.

## ¿Qué tenemos que hacer?
En el repositorio tienen el codigo realizado en clases FactorioEnClaseRevisado.st, deben hacer file-in en Cuis de este archivo, con esto les va a cargar una versión mas avanzada de los objetos (DenotativeObjects) que creamos en clase. Además pueden observar que hay un objeto que se llama FactorioTest que contiene 3 casos de tests que deben hacer pasar. Cada uno de los tests verifica los escenarios de la consigna. El primero pasa ya que se encuentra completa su implementación. Van a notar que algunos tests están incompletos, podrán encontrar comentarios describiendo cómo deben completarlos. La idea es que reemplacen estos comentarios con el codigo que lo hace andar.

Para que estos tests anden deben terminar el modelo de objetos (crear nuevos objetos y nuevos mensajes). Pista: seria razonable que su modelo tenga entre 3 y 8 objetos.

Para entregar deben hacer file-out de lo que representaron y subirlo al repo de su grupo dentro de una carpeta que llamarán 01-Factorio.

Sugerencia: simplifiquen el problema. Por ejemplo, no interesa cómo el extractor de hierro produce hierro y olvidense del paso del tiempo. 

## Tips de colecciones

**¿Cómo crear una colección ordenada?**

```smalltalk
unaColeccion := OrderedCollection new.
```

**¿Cómo agregarle un objeto a una colección?**

```smalltalk
unaColeccion add: 'Hola'
```

**¿Cómo agregar todos los elementos de una colección a otra colección?**

```smalltalk
otraColeccion := OrderedCollection new.
otraColeccion addAll: unaColeccion
```

**¿Cómo contar la cantidad de elementos que cumplen con cierta condición? Por ejemplo la cantidad de unos que tenemos.**

```smalltalk
unaColeccion count: [ :cadaElemento | cadaElemento = 1 ]
```
