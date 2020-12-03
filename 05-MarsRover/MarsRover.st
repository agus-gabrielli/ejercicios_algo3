!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover north south east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:09:49'!
test01RoverThatWasntCommandedToMoveIsInStartingLocation
	
	marsRover processComands: ''.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:10:03'!
test02RoverThatWasntCommandedToMoveIsNotInIncorrectPosition
	
	marsRover processComands: ''.
	
	self deny: (marsRover isInCoordinates: (1@2) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:10:09'!
test03RoverThatWasntCommandedToRotateIsNotFacingAnotherDirection

	marsRover processComands: ''.
	
	self deny: (marsRover isInCoordinates: (1@1) facing: south).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:10:15'!
test04RoverThatWasCommandedToMoveForwardIsInExpectedPosition
	
	marsRover processComands: 'f'.
	
	self assert: (marsRover isInCoordinates: (1@2) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:10:25'!
test05RoverThatWasCommandedToMoveBackwardsIsInExpectedPosition
	
	marsRover processComands: 'b'.
	
	self assert: (marsRover isInCoordinates: (1@0) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:10:32'!
test06RoverThatWasCommandedToRotateLeftIsFacingTheExpectedDirection
	
	marsRover processComands: 'l'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: west).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:10:38'!
test07RoverThatWasCommandedToRotateRightIsFacingTheExpectedDirection
	
	marsRover processComands: 'r'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: east).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:10:43'!
test08RoverThatWasCommandedToMoveMultipleTimesIsInExpectedPosition
	
	marsRover processComands: 'fffbbf'.
	
	self assert: (marsRover isInCoordinates: (1@3) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:10:50'!
test09RoverThatWasCommandedToRotateRightMultipleTimesIsFacingTheExpectedDirection
	
	marsRover processComands: 'rrr'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: west).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/2/2020 22:10:56'!
test10RoverThatWasCommandedToRotateMultipleTimesIsFacingTheExpectedDirection
	
	marsRover processComands: 'lllr'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: south).! !


!MarsRoverTest methodsFor: 'setup' stamp: 'AG 12/2/2020 22:09:23'!
setUp
	
	north := North new.
	south := South new.
	east := East new.
	west := West new.
	marsRover := MarsRover newInCoordinates: (1@1) facing: north.
	! !


!classDefinition: #CardinalDirections category: 'MarsRover'!
Object subclass: #CardinalDirections
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirections methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:19:34'!
left

	^self subclassResponsibility! !

!CardinalDirections methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:19:39'!
right

	^self subclassResponsibility! !


!CardinalDirections methodsFor: 'testing' stamp: 'AG 12/2/2020 22:18:56'!
= aCardinalDirection

	^self isKindOf: aCardinalDirection class! !


!classDefinition: #East category: 'MarsRover'!
CardinalDirections subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:13:12'!
left

	^North new.! !

!East methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:13:17'!
right

	^South new.! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirections subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:12:41'!
left

	^West new.! !

!North methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:12:31'!
right

	^East new.! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirections subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:14:15'!
left

	^East new.! !

!South methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:14:08'!
right

	^West new.! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirections subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:14:36'!
left
	
	^South new.! !

!West methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:14:30'!
right
	
	^North new.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentCoordinates currentCardinalDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'MR 12/2/2020 15:12:34'!
initializeNewInCoordinates: aSetOfCoordinates facing: aCardinalDirection
 
	currentCoordinates := aSetOfCoordinates.
	currentCardinalDirection := aCardinalDirection.! !


!MarsRover methodsFor: 'command procesing' stamp: 'AG 12/2/2020 22:16:02'!
processComands: aChainOfCommands 

	aChainOfCommands do: [:command | command = $f ifTrue: [currentCoordinates := currentCoordinates + (0@1)].
								command = $b ifTrue: [currentCoordinates := currentCoordinates + (0@-1)].
								command = $r ifTrue: [ currentCardinalDirection := currentCardinalDirection right ].
								command = $l ifTrue: [ currentCardinalDirection := currentCardinalDirection left ] ].! !


!MarsRover methodsFor: 'testing' stamp: 'AG 12/2/2020 22:22:00'!
isInCoordinates: aSetOfCoordinates facing: aCardinalDirection 

	^currentCoordinates = aSetOfCoordinates and: [currentCardinalDirection = aCardinalDirection]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MR 12/2/2020 15:11:21'!
newInCoordinates: aSetOfCoordinates facing: aCardinalDirection 
	
	^self new initializeNewInCoordinates: aSetOfCoordinates facing: aCardinalDirection! !
