!classDefinition: #CintaAzul category: 'Factorio'!
DenotativeObject subclass: #CintaAzul
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaAzul class' category: 'Factorio'!
CintaAzul class
	instanceVariableNames: 'contenido destino'!

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
agregar: unaMena
	contenido add: unaMena.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
cantidadDe: unaMenaDeMuestra
	"Hay que preguntar bien si se pueden agregar metodos para testear el correcto funcionamiento de la cinta..."
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
cantidadDeMenas
	^contenido size.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
conectarA: unDestino
	destino := unDestino.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'MR 10/28/2020 19:49:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new)).
	destino := CintaRoja.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
transportarContenido
	contenido do: [ :mena | destino agregar: mena].
	self vaciar.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AG 10/25/2020 15:44:42'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaRoja category: 'Factorio'!
CintaAzul subclass: #CintaRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaRoja class' category: 'Factorio'!
CintaRoja class
	instanceVariableNames: ''!

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'MR 10/28/2020 19:49:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new)).
	destino := Contenedor.! !


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

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'MR 10/28/2020 19:49:53'!
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
	instanceVariableNames: 'destino tipoDeMena'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:23'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'MR 10/28/2020 14:22:56'!
extraer
	destino agregar: tipoDeMena.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'MR 10/28/2020 19:49:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaRoja.
	tipoDeMena := #carbon.! !


!classDefinition: #ExtractorDeHierro category: 'Factorio'!
ExtractorDeCarbon subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'Factorio'!
ExtractorDeHierro class
	instanceVariableNames: ''!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MR 10/28/2020 19:49:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaAzul.
	tipoDeMena := #hierro.! !


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


!FactorioTest class methodsFor: 'escenario 2' stamp: 'MR 10/25/2020 18:38:25'!
configurarCircuitoExtractorCintaCaja

	Contenedor vaciar.
	CintaRoja vaciar.
	ExtractorDeCarbon conectarA: CintaRoja. 
	CintaRoja conectarA: Contenedor.! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'MR 10/25/2020 18:38:25'!
hacerAndarCircuitoExtractorCintaCaja

	ExtractorDeCarbon extraer.
	CintaRoja transportarContenido ! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'MR 10/25/2020 18:38:25'!
test02ExtractorCintaCaja
	self configurarCircuitoExtractorCintaCaja.
	
	self hacerAndarCircuitoExtractorCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.
	Assert that: CintaRoja cantidadDeMenas isEqualTo: 0.! !


!FactorioTest class methodsFor: 'escenario 3' stamp: 'MR 10/25/2020 18:38:45'!
configurarCircuitoExtractorExtractorCintaCintaCaja

	Contenedor vaciar.
	CintaRoja vaciar.
	CintaAzul vaciar.
	ExtractorDeCarbon conectarA: CintaRoja.
	ExtractorDeHierro conectarA: CintaAzul.
	CintaRoja conectarA: Contenedor.
	CintaAzul conectarA: CintaRoja.	
! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'MR 10/25/2020 18:38:45'!
hacerAndarCircuitoExtractorExtractorCintaCintaCaja
	
	ExtractorDeCarbon extraer.
	ExtractorDeHierro extraer.
	CintaAzul transportarContenido.
	CintaRoja transportarContenido.! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'MR 10/25/2020 18:38:45'!
test03ExtractorExtractorCintaCintaCaja
	self configurarCircuitoExtractorExtractorCintaCintaCaja.
	
	self hacerAndarCircuitoExtractorExtractorCintaCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: (Contenedor cantidadDe: #hierro) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 2.
	Assert that: CintaRoja cantidadDeMenas isEqualTo: 0.
	Assert that: CintaAzul cantidadDeMenas isEqualTo: 0.! !

CintaAzul initializeAfterFileIn!
CintaRoja initializeAfterFileIn!
Contenedor initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!