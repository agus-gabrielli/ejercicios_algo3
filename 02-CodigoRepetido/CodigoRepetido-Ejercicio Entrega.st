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

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/2/2020 21:34:01'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
	
	self testThatCollaborations: [customerBook addCustomerNamed: 'John Lennon'.] shouldNotTakeMoreMillisecondsThan: 50
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/2/2020 21:48:36'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.	
	customerBook := CustomerBook newWithFirstCustomer: paulMcCartney.

	self testThatCollaborations: [customerBook removeCustomerNamed: paulMcCartney.] shouldNotTakeMoreMillisecondsThan: 100
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/3/2020 15:05:28'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
		
		! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/3/2020 14:59:38'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon testAction firstCondition secondCondition |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook newWithFirstCustomer: johnLennon.
	testAction := [customerBook removeCustomerNamed: 'Paul McCartney'].
	firstCondition := [customerBook numberOfCustomers = 1].
	secondCondition := [customerBook includesCustomerNamed: johnLennon].
	
	
	self testFailureOf: testAction withError: NotFound withConditions: firstCondition and: secondCondition

! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/3/2020 15:39:49'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|

	paulMcCartney := 'Paul McCartney'.	
	customerBook := CustomerBook newWithFirstCustomer: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	self testThatBook: customerBook containsActiveCustomers: 0 andSuspendedCustomers: 1 forATotalOf: 1 andAlsoTestThat: [customerBook includesCustomerNamed: paulMcCartney].
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/3/2020 15:39:49'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|

	paulMcCartney := 'Paul McCartney'.	
	customerBook := CustomerBook newWithFirstCustomer: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
		self testThatBook: customerBook containsActiveCustomers: 0 andSuspendedCustomers: 0 forATotalOf: 0 andAlsoTestThat: [(customerBook includesCustomerNamed: paulMcCartney) not].


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/3/2020 15:07:19'!
test07CanNotSuspendAnInvalidCustomer
		
	| customerBook johnLennon testAction firstCondition secondCondition |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook newWithFirstCustomer: johnLennon.
	testAction := [customerBook suspendCustomerNamed: 'Ringo Starr'].
	firstCondition := [customerBook numberOfCustomers = 1].
	secondCondition := [customerBook includesCustomerNamed: johnLennon].
	
	
	self testFailureOf: testAction withError: CantSuspend withConditions: firstCondition and: secondCondition
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MR 11/3/2020 15:09:47'!
test08CanNotSuspendAnAlreadySuspendedCustomer
		
	| customerBook johnLennon testAction firstCondition secondCondition |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook newWithFirstCustomer: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	testAction := [customerBook suspendCustomerNamed: johnLennon].
	firstCondition := [customerBook numberOfCustomers = 1].
	secondCondition := [customerBook includesCustomerNamed: johnLennon].
	
	
	self testFailureOf: testAction withError: CantSuspend withConditions: firstCondition and: secondCondition
		
		
! !


!CustomerBookTest methodsFor: 'asserts' stamp: 'MR 11/3/2020 14:53:30'!
testFailureOf: collaborationsToTest withError: error withConditions: firstCondition and: secondCondition 
	
	[ collaborationsToTest value.
	self fail ]
		on: error 
		do: [ :anError | 
			self assert: firstCondition value.
			self assert: secondCondition value].! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'MR 11/3/2020 15:39:49'!
testThatBook: customerBook containsActiveCustomers: numberOfActiveCustomers andSuspendedCustomers: numberOfSuspendedCustomers forATotalOf: numberOfCustomers andAlsoTestThat: additionalTest

	self assert: numberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfCustomers equals: customerBook numberOfCustomers.
	self assert: additionalTest value.! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'MR 11/2/2020 21:31:07'!
testThatCollaborations: collaborationsToMeasure shouldNotTakeMoreMillisecondsThan: maxTimeInMilliseconds
	| millisecondsBeforeRunning millisecondsAfterRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	collaborationsToMeasure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (maxTimeInMilliseconds * millisecond)! !


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


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

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


!CustomerBook class methodsFor: 'initialization' stamp: 'MR 11/2/2020 21:51:29'!
newWithFirstCustomer: aCustomerName
	| customerBook |
	customerBook := self new.
	customerBook addCustomerNamed: aCustomerName.
	^customerBook! !
