!classDefinition: #NumeroTest category: 'Numeros-Parte1-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:40'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:53'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:15:37'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Numero with: (Numero with: 7) over: (Numero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:16:19'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Numero with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:44:24'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: (Numero with: negativeOne over: two)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:29:45'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Numero with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:30:07'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Numero with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/8/2019 21:09:34'!
setUp

	zero := Numero with: 0.
	one := Numero with: 1.
	two := Numero with: 2.
	three:= Numero with: 3.
	four := Numero with: 4.
	five := Numero with: 5.
	eight := Numero with: 8.
	negativeOne := Numero with: -1.
	negativeTwo := Numero with: -2.
	
	oneHalf := Numero with: one over: two.
	oneFifth := Numero with: one over: five.
	twoFifth := Numero with: two over: five.
	twoTwentyfifth := Numero with: two over: (Numero with: 25).
	fiveHalfs := Numero with: five over: two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte1-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'AG 11/11/2020 19:53:30'!
* aMultiplier 

	self subclassResponsibility
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AG 11/11/2020 19:54:51'!
+ anAdder 
	
	self subclassResponsibility.
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AG 11/11/2020 19:56:02'!
negated
	
	self subclassResponsibility.! !


!Numero methodsFor: 'testing' stamp: 'AG 11/11/2020 20:01:07'!
isNegative
	
	self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'AG 11/11/2020 20:01:58'!
isOne

	self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'AG 11/11/2020 20:02:38'!
isZero

	self subclassResponsibility.! !


!Numero methodsFor: 'printing' stamp: 'AG 11/11/2020 20:04:47'!
printOn: aStream
	
	self subclassResponsibility.! !


!Numero methodsFor: 'comparing' stamp: 'AG 11/11/2020 20:19:00'!
= anObject

	self subclassResponsibility.
! !

!Numero methodsFor: 'comparing' stamp: 'AG 11/11/2020 20:19:07'!
hash

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte1-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !


!Numero class methodsFor: 'instance creation' stamp: 'AG 11/11/2020 19:57:10'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^Entero new initializeWith: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'AG 11/11/2020 19:57:23'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^Fraccion new initializeWith: numerator over: denominator! !


!classDefinition: #Entero category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Entero methodsFor: 'initialization' stamp: 'AG 11/11/2020 20:10:51'!
initializeWith: aValue
	
	value := aValue! !


!Entero methodsFor: 'arithmetic operations' stamp: 'AG 11/11/2020 19:52:30'!
* aMultiplier 

	^self class with: value * aMultiplier integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AG 11/11/2020 19:53:59'!
+ anAdder 

	^self class with: value + anAdder integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AG 11/11/2020 19:55:21'!
negated

	^self * (self class with: -1).! !


!Entero methodsFor: 'testing' stamp: 'AG 11/11/2020 19:59:52'!
isNegative
	
	^value < 0.
	! !

!Entero methodsFor: 'testing' stamp: 'AG 11/11/2020 20:01:35'!
isOne

	^value = 1.! !

!Entero methodsFor: 'testing' stamp: 'AG 11/11/2020 20:02:15'!
isZero

	^value = 0.! !


!Entero methodsFor: 'printing' stamp: 'AG 11/11/2020 20:04:17'!
printOn: aStream
	
	aStream print: value.! !


!Entero methodsFor: 'comparing' stamp: 'AG 11/11/2020 20:18:11'!
= anObject

	^value = anObject integerValue.! !

!Entero methodsFor: 'comparing' stamp: 'AG 11/11/2020 20:16:08'!
hash
	^value hash.! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/11/2020 20:13:10'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue.
		! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/11/2020 20:15:29'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue).
		! !


!Entero methodsFor: 'accessing' stamp: 'AG 11/11/2020 20:07:41'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!classDefinition: #Fraccion category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Fraccion methodsFor: 'testing' stamp: 'AG 11/11/2020 20:00:35'!
isNegative
	
	^denominator < 0.! !

!Fraccion methodsFor: 'testing' stamp: 'AG 11/11/2020 20:01:49'!
isOne

	^false.! !

!Fraccion methodsFor: 'testing' stamp: 'AG 11/11/2020 20:02:26'!
isZero

	^false.! !


!Fraccion methodsFor: 'printing' stamp: 'AG 11/11/2020 20:04:31'!
printOn: aStream
	
	aStream 
			print: numerator;
			nextPut: $/;
			print: denominator.! !


!Fraccion methodsFor: 'comparing' stamp: 'AG 11/11/2020 20:18:26'!
= anObject

	^(numerator * anObject denominator) = (denominator * anObject numerator).! !

!Fraccion methodsFor: 'comparing' stamp: 'AG 11/11/2020 20:16:20'!
hash
	^(numerator hash / denominator hash) hash.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'AG 11/11/2020 19:53:01'!
* aMultiplier 

	^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AG 11/11/2020 19:54:35'!
+ anAdder
	
	| newNumerator newDenominator |
		
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^ self class with: newNumerator over: newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AG 11/11/2020 19:55:48'!
negated
	
	^self class with: numerator * (self class with: -1) over: denominator.! !


!Fraccion methodsFor: 'initialization' stamp: 'AG 11/11/2020 20:11:13'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].

	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'accessing' stamp: 'AG 11/11/2020 20:06:55'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'AG 11/11/2020 20:07:22'!
numerator

	^numerator! !
