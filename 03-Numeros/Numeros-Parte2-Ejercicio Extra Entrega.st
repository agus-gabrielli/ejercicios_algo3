!classDefinition: #NumeroTest category: 'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 5/7/2020 17:46:14'!
test27EnteroSubstractsEnteroCorrectly

	self assert: three - one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:29:05'!
addToEntero: anEnteroAugment

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:29:23'!
addToFraccion: aFraccionAugment

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:18:47'!
divideEntero: anEnteroDivider

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:25:15'!
divideFraccion: anFraccionDivider

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:28:33'!
multiplyEntero: anEnteroMultiplier

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:28:42'!
multiplyFraccion: aFraccionMultiplier

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:22:37'!
substractToEntero: anEnteroMinuend

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:24:26'!
substractToFraccion: aFraccionMinuend

	^self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'private' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:46:56'!
invalidNumberTypeErrorDescription
	^ 'Tipo de Número Inválido'! !


!classDefinition: #Entero category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'arithmetic operations' stamp: 'MR 11/15/2020 23:02:58'!
* aMultiplier
 
	^aMultiplier multiplyEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AG 11/15/2020 22:29:05'!
+ anAdder 
	
	^anAdder addToEntero: self
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AG 11/15/2020 22:22:37'!
- aSubtrahend 
	
	^aSubtrahend substractToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MR 11/15/2020 23:03:09'!
/ aDivisor
 
	^aDivisor divideEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MR 11/16/2020 01:24:11'!
fibonacci

	^self subclassResponsibility 
		! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:29:05'!
addToEntero: anEnteroAugment
		
	^self class with: anEnteroAugment integerValue + value
	! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:54:10'!
addToFraccion: aFraccionAugment
		
	^Fraccion with: self * aFraccionAugment denominator + aFraccionAugment numerator
			over: aFraccionAugment denominator! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:54:17'!
divideEntero: anEnteroDividend
		
	^Fraccion with: anEnteroDividend 
			over: self
	! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:54:23'!
divideFraccion: anFraccionDivider
		
	^Fraccion with: anFraccionDivider numerator 
			over: anFraccionDivider denominator * self
	! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:28:33'!
multiplyEntero: anEnteroMultiplicand
		
	^self class with: value * anEnteroMultiplicand integerValue
	! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:54:37'!
multiplyFraccion: aFraccionMultiplicand
		
	^Fraccion with: self * aFraccionMultiplicand numerator 
			over: aFraccionMultiplicand denominator
	! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:22:37'!
substractToEntero: anEnteroMinuend
		
	^self class with: anEnteroMinuend integerValue - value! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:54:45'!
substractToFraccion: aFraccionMinuend
		
	^Fraccion with: aFraccionMinuend numerator - (self * aFraccionMinuend denominator)
			over: aFraccionMinuend denominator! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'MR 11/16/2020 00:49:49'!
isNegative
	
	^self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'MR 11/16/2020 00:49:57'!
isOne
	
	^self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'MR 11/16/2020 00:50:07'!
isZero
	
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'MR 11/16/2020 01:21:14'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	aValue < 0 ifTrue: [^MenorACero new initializeWith: aValue].
	aValue = 0 ifTrue: [^IgualACero new].
	aValue = 1 ifTrue: [^IgualAUno new].
	^MayorAUno new initializeWith: aValue.
	! !


!classDefinition: #IgualACero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #IgualACero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!IgualACero methodsFor: 'testing' stamp: 'MR 11/16/2020 00:46:11'!
isNegative

	^false! !

!IgualACero methodsFor: 'testing' stamp: 'MR 11/16/2020 00:48:43'!
isOne
	^false! !

!IgualACero methodsFor: 'testing' stamp: 'MR 11/16/2020 00:48:52'!
isZero
	^true! !


!IgualACero methodsFor: 'arithmetic operations' stamp: 'MR 11/16/2020 00:52:13'!
fibonacci

	^IgualAUno new! !


!IgualACero methodsFor: 'initialization' stamp: 'MR 11/16/2020 00:37:40'!
initialize

	value := 0.! !


!classDefinition: #IgualAUno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #IgualAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!IgualAUno methodsFor: 'initialization' stamp: 'MR 11/16/2020 00:38:16'!
initialize

	value := 1.! !


!IgualAUno methodsFor: 'arithmetic operations' stamp: 'MR 11/16/2020 00:53:18'!
fibonacci
	
	^self! !


!IgualAUno methodsFor: 'testing' stamp: 'MR 11/16/2020 00:46:50'!
isNegative

	^false! !

!IgualAUno methodsFor: 'testing' stamp: 'MR 11/16/2020 00:47:03'!
isOne
	
	^true! !

!IgualAUno methodsFor: 'testing' stamp: 'MR 11/16/2020 00:46:58'!
isZero
	
	^false! !


!classDefinition: #MayorAUno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #MayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!MayorAUno methodsFor: 'initialization' stamp: 'MR 11/16/2020 00:39:55'!
initializeWith: aValue

	value := aValue! !


!MayorAUno methodsFor: 'testing' stamp: 'MR 11/16/2020 00:47:31'!
isNegative

	^false! !

!MayorAUno methodsFor: 'testing' stamp: 'MR 11/16/2020 00:48:25'!
isOne

	^false! !

!MayorAUno methodsFor: 'testing' stamp: 'MR 11/16/2020 00:47:39'!
isZero

	^false! !


!MayorAUno methodsFor: 'arithmetic operations' stamp: 'MR 11/16/2020 01:22:08'!
fibonacci

	| one two |
	
	one := IgualAUno new.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !


!classDefinition: #MenorACero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #MenorACero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!MenorACero methodsFor: 'initialization' stamp: 'MR 11/16/2020 00:40:31'!
initializeWith: aValue

	value := aValue! !


!MenorACero methodsFor: 'arithmetic operations' stamp: 'MR 11/16/2020 01:23:50'!
fibonacci

	^self error: Entero negativeFibonacciErrorDescription.
		! !


!MenorACero methodsFor: 'testing' stamp: 'MR 11/16/2020 00:49:15'!
isNegative

	^true! !

!MenorACero methodsFor: 'testing' stamp: 'MR 11/16/2020 00:49:31'!
isOne

	^false! !

!MenorACero methodsFor: 'testing' stamp: 'MR 11/16/2020 00:49:24'!
isZero

	^false! !


!classDefinition: #Fraccion category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'AG 11/15/2020 22:28:42'!
* aMultiplier 
	
	^aMultiplier multiplyFraccion: self
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MR 11/15/2020 23:02:44'!
+ anAdder 

	^anAdder addToFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AG 11/15/2020 22:24:26'!
- aSubtrahend 
	
	^aSubtrahend substractToFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MR 11/15/2020 23:03:29'!
/ aDivisor
 
	^aDivisor divideFraccion: self	! !


!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:49:46'!
addToEntero: anEnteroAugment
		
	^Fraccion with: anEnteroAugment * denominator + numerator 
			over: denominator
	! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:52:52'!
addToFraccion: aFraccionAugment
		
	| newNumerator newDenominator |
	
	newNumerator := (aFraccionAugment numerator *  denominator) + (aFraccionAugment denominator *  numerator).
	newDenominator := aFraccionAugment denominator *  denominator.
	
	^Fraccion with: newNumerator
			over: newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:51:33'!
divideEntero: anEnteroDividend
		
	^Fraccion with: anEnteroDividend * self denominator 
			over: self numerator
	! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:51:25'!
divideFraccion: aFraccionDividend
		
	^Fraccion with: aFraccionDividend numerator * denominator
			over: aFraccionDividend denominator * numerator
	! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:51:05'!
multiplyEntero: anEnteroMultiplicand
		
	^Fraccion with: numerator * anEnteroMultiplicand 
			over: denominator
	! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:50:48'!
multiplyFraccion: aFraccionMultiplicand
		
	^Fraccion with: numerator * aFraccionMultiplicand numerator
			over: denominator * aFraccionMultiplicand denominator
	! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:50:13'!
substractToEntero: anEnteroMinuend

	^Fraccion with: anEnteroMinuend * denominator - numerator 
			over: denominator! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AG 11/15/2020 22:53:51'!
substractToFraccion: aFraccionMinuend
		
	| newNumerator newDenominator |
		
	newNumerator := (aFraccionMinuend numerator * denominator) - (aFraccionMinuend denominator * numerator).
	newDenominator := aFraccionMinuend denominator * denominator.
	
	^Fraccion with: newNumerator
			over: newDenominator.
	! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
