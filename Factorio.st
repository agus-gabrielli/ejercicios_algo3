!classDefinition: #Contenedor category: 'Factorio'!
DenotativeObject subclass: #Contenedor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Contenedor class' category: 'Factorio'!
Contenedor class
	instanceVariableNames: 'contenido'!

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:04'!
agregar: unaMena
	contenido add: unaMena.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:00'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:20'!
cantidadDeMenas
	^contenido size.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:58:36'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: #carbon; add: #hierro; yourself).! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:51'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #ExtractorDeCarbon category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'Factorio'!
ExtractorDeCarbon class
	instanceVariableNames: 'destino'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:23'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:50'!
extraer
	destino agregar: #carbon.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:58:36'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := PrimeraCinta.! !


!classDefinition: #ExtractorDeHierro category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'Factorio'!
ExtractorDeHierro class
	instanceVariableNames: 'destino'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:46:03'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:47:03'!
extraer
	destino agregar: #hierro.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:58:36'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := SegundaCinta.! !


!classDefinition: #FactorioTest category: 'Factorio'!
DenotativeObject subclass: #FactorioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FactorioTest class' category: 'Factorio'!
FactorioTest class
	instanceVariableNames: ''!

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 01:01:45'!
configurarCircuitoExtractorCaja.

	Contenedor vaciar.
	ExtractorDeCarbon conectarA: Contenedor.	
! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:55:32'!
hacerAndarCircuitoExtractorCaja

	ExtractorDeCarbon extraer.
	! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:53:55'!
test01ExtractorCaja
	self configurarCircuitoExtractorCaja.
	
	self hacerAndarCircuitoExtractorCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.! !


!FactorioTest class methodsFor: 'escenario 2' stamp: 'AG 10/25/2020 15:23:53'!
configurarCircuitoExtractorCintaCaja

	Contenedor vaciar.
	"No se olviden de vaciar la cinta tambien!!"
	PrimeraCinta vaciar.
	"Conectamos el extractor a la cinta, luego conectamos la cinta a la caja"
	ExtractorDeCarbon conectarA: PrimeraCinta. 
	PrimeraCinta conectarA: Contenedor.! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'AG 10/25/2020 15:26:21'!
hacerAndarCircuitoExtractorCintaCaja

	"Hacemos andar el extractor, asi deja un carbon en la cinta."
	ExtractorDeCarbon extraer.
	"Luego hacemos andar la cinta (con algun mensaje) y deberia dejar el carbon en la caja.	"
	PrimeraCinta transportarContenido ! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'AG 10/25/2020 15:27:50'!
test02ExtractorCintaCaja
	self configurarCircuitoExtractorCintaCaja.
	
	self hacerAndarCircuitoExtractorCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.
	"Tambien tenemos que chequear que en la cinta no haya nada. Cero carbon."
	Assert that: PrimeraCinta cantidadDeMenas isEqualTo: 0.! !


!FactorioTest class methodsFor: 'escenario 3' stamp: 'AG 10/25/2020 15:49:07'!
configurarCircuitoExtractorExtractorCintaCintaCaja

	Contenedor vaciar.
	"Además de vaciar el Contenedor (arriba) también vaciamos las dos cintas"
	PrimeraCinta vaciar.
	SegundaCinta vaciar.
	"Conectamos el extractor de carbon a una de las cintas"
	ExtractorDeCarbon conectarA: PrimeraCinta.
	"Conectamos el extractor de hierro a la otra cinta"
	ExtractorDeHierro conectarA: SegundaCinta.
	"Ahora conectamos la primer cinta al Contenedor"
	PrimeraCinta conectarA: Contenedor.
	"Y conectamos la segunda cinta a la primer cinta"
	SegundaCinta conectarA: PrimeraCinta.	
! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'AG 10/25/2020 15:51:20'!
hacerAndarCircuitoExtractorExtractorCintaCintaCaja
	
	"Hacemos andar el extractor, asi deja un carbon en la cinta.
	Lo mismo con el otro extractor, asi deja una mena de hierro en la otra cinta.
	Hacemos andar la cinta con la mena de hierro, asi la deposita en la cinta que tiene el carbon.
	Ahora podemos hacer andar la ultima cinta, la que recibió primero el carbon 
	y ahora tambien tiene el hierro y que deje todo en el Contenedor."
	ExtractorDeCarbon extraer.
	ExtractorDeHierro extraer.
	SegundaCinta transportarContenido.
	PrimeraCinta transportarContenido.! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'AG 10/25/2020 15:52:26'!
test03ExtractorExtractorCintaCintaCaja
	self configurarCircuitoExtractorExtractorCintaCintaCaja.
	
	self hacerAndarCircuitoExtractorExtractorCintaCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: (Contenedor cantidadDe: #hierro) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 2.
	"Tambien tenemos que chequear que no haya nada en las cintas"
	Assert that: PrimeraCinta cantidadDeMenas isEqualTo: 0.
	Assert that: SegundaCinta cantidadDeMenas isEqualTo: 0.! !


!classDefinition: #PrimeraCinta category: 'Factorio'!
DenotativeObject subclass: #PrimeraCinta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrimeraCinta class' category: 'Factorio'!
PrimeraCinta class
	instanceVariableNames: 'contenido destino'!

!PrimeraCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:12:17'!
agregar: unaMena
	contenido add: unaMena.! !

!PrimeraCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:21:21'!
cantidadDe: unaMenaDeMuestra
	"Hay que preguntar bien si se pueden agregar metodos para testear el correcto funcionamiento de la cinta..."
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!PrimeraCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:12:17'!
cantidadDeMenas
	^contenido size.! !

!PrimeraCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:13:00'!
conectarA: unDestino
	destino := unDestino.! !

!PrimeraCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:58:36'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new)).
	destino := Contenedor.! !

!PrimeraCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:29:37'!
transportarContenido
	contenido do: [ :mena | destino agregar: mena].
	self vaciar.! !

!PrimeraCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:12:17'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #SegundaCinta category: 'Factorio'!
DenotativeObject subclass: #SegundaCinta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SegundaCinta class' category: 'Factorio'!
SegundaCinta class
	instanceVariableNames: 'contenido destino'!

!SegundaCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
agregar: unaMena
	contenido add: unaMena.! !

!SegundaCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
cantidadDe: unaMenaDeMuestra
	"Hay que preguntar bien si se pueden agregar metodos para testear el correcto funcionamiento de la cinta..."
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!SegundaCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
cantidadDeMenas
	^contenido size.! !

!SegundaCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
conectarA: unDestino
	destino := unDestino.! !

!SegundaCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:58:36'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new)).
	destino := PrimeraCinta.! !

!SegundaCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
transportarContenido
	contenido do: [ :mena | destino agregar: mena].
	self vaciar.! !

!SegundaCinta class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
vaciar
	contenido := OrderedCollection new.! !

Contenedor initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!
PrimeraCinta initializeAfterFileIn!
SegundaCinta initializeAfterFileIn!