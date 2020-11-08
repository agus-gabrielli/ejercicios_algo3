!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/8/2020 17:24:52'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
	
	self testThatCollaborations: [customerBook addCustomerNamed: 'John Lennon'.] shouldNotTakeLongerThan: 50 * millisecond
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/8/2020 17:24:59'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: paulMcCartney.

	self testThatCollaborations: [customerBook removeCustomerNamed: paulMcCartney.] shouldNotTakeLongerThan: 100 * millisecond
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/8/2020 19:10:23'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook collaborationsToTest collaborationsToRunOnError |
			
	customerBook := CustomerBook new.
	
	collaborationsToTest := [customerBook addCustomerNamed: ''].
	collaborationsToRunOnError := [:anError | self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
							self assert: customerBook isEmpty].
		
	self testThatCollaborations: collaborationsToTest failWithError: Error ifSoDo: collaborationsToRunOnError
		
		! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/8/2020 19:10:13'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon collaborationsToTest collaborationsToRunOnError |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: johnLennon.
	
	collaborationsToTest := [customerBook removeCustomerNamed: 'Paul McCartney'].
	collaborationsToRunOnError := [self assert: customerBook numberOfCustomers = 1.
							self assert: (customerBook includesCustomerNamed: johnLennon)].
	
	
	self testThatCollaborations: collaborationsToTest failWithError: NotFound ifSoDo: collaborationsToRunOnError

! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/8/2020 18:37:50'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|

	paulMcCartney := 'Paul McCartney'.	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self testThatBook: customerBook containsActiveCustomers: 0 SuspendedCustomers: 1 forATotalOf: 1. 	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/8/2020 19:09:03'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|

	paulMcCartney := 'Paul McCartney'.	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self testThatBook: customerBook containsActiveCustomers: 0 SuspendedCustomers: 0 forATotalOf: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/8/2020 19:08:44'!
test07CanNotSuspendAnInvalidCustomer
		
	| customerBook johnLennon collaborationsToTest collaborationsToRunOnError |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: johnLennon.
	
	collaborationsToTest := [customerBook suspendCustomerNamed: 'Ringo Starr'].
	collaborationsToRunOnError := [self assert: customerBook numberOfCustomers = 1.
							self assert: (customerBook includesCustomerNamed: johnLennon)].
	
	self testThatCollaborations: collaborationsToTest failWithError: CantSuspend ifSoDo: collaborationsToRunOnError
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/8/2020 19:08:52'!
test08CanNotSuspendAnAlreadySuspendedCustomer
		
	| customerBook johnLennon collaborationsToTest collaborationsToRunOnError |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	collaborationsToTest := [customerBook suspendCustomerNamed: johnLennon].
	collaborationsToRunOnError := [self assert: customerBook numberOfCustomers = 1.
							self assert: (customerBook includesCustomerNamed: johnLennon)].
	
	self testThatCollaborations: collaborationsToTest failWithError: CantSuspend ifSoDo: collaborationsToRunOnError
		
		
! !


!CustomerBookTest methodsFor: 'asserts' stamp: 'MR 11/8/2020 18:36:07'!
testThatBook: customerBook containsActiveCustomers: numberOfActiveCustomers SuspendedCustomers: numberOfSuspendedCustomers forATotalOf: numberOfCustomers

	self assert: numberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'MR 11/8/2020 18:27:28'!
testThatCollaborations: collaborationsToTest failWithError: error ifSoDo: collaborationsToRunOnError
	[ collaborationsToTest value.
	self fail ]
		on: error 
		do: [  :anError |
			collaborationsToRunOnError valueWithPossibleArgs: {anError} ].! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'MR 11/8/2020 18:43:09'!
testThatCollaborations: collaborationsToMeasure shouldNotTakeLongerThan: maxTime
	| timeTaken |
	timeTaken := 	collaborationsToMeasure timeToRun.
	
	self assert: timeTaken < maxTime! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MR 11/5/2020 19:49:27'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'AG 11/3/2020 17:09:20'!
removeCustomerNamed: aName 
	
	active remove: aName ifAbsent: [ suspended remove: aName ifAbsent: [ ^NotFound signal ] ].
	^aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'MR 11/8/2020 17:17:50'!
suspendCustomerNamed: aName 
	
	(self includesActiveCustomerNamed: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'MR 11/8/2020 17:11:01'!
numberOfCustomers
	
	^self numberOfActiveCustomers  + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'MR 11/8/2020 17:14:09'!
includesActiveCustomerNamed: aName

	^active includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'MR 11/8/2020 17:15:52'!
includesCustomerNamed: aName

	^(self includesActiveCustomerNamed: aName) or: [self includesSuspendedCustomerNamed: aName]! !

!CustomerBook methodsFor: 'testing' stamp: 'MR 11/8/2020 17:14:18'!
includesSuspendedCustomerNamed: aName

	^suspended includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !

