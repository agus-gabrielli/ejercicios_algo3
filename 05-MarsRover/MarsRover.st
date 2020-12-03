!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover north south east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test01RoverThatWasntCommandedToMoveIsInStartingLocation
	
	marsRover processCommands: ''.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test02RoverThatWasntCommandedToMoveIsNotInIncorrectPosition
	
	marsRover processCommands: ''.
	
	self deny: (marsRover isInCoordinates: (1@2) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test03RoverThatWasntCommandedToRotateIsNotFacingAnotherDirection

	marsRover processCommands: ''.
	
	self deny: (marsRover isInCoordinates: (1@1) facing: south).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test04RoverThatWasCommandedToMoveForwardIsInExpectedPosition
	
	marsRover processCommands: 'f'.
	
	self assert: (marsRover isInCoordinates: (1@2) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test05RoverThatWasCommandedToMoveBackwardsIsInExpectedPosition
	
	marsRover processCommands: 'b'.
	
	self assert: (marsRover isInCoordinates: (1@0) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test06RoverThatWasCommandedToRotateLeftIsFacingTheExpectedDirection
	
	marsRover processCommands: 'l'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: west).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test07RoverThatWasCommandedToRotateRightIsFacingTheExpectedDirection
	
	marsRover processCommands: 'r'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: east).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test08RoverThatWasCommandedToMoveMultipleTimesIsInExpectedPosition
	
	marsRover processCommands: 'fffbbf'.
	
	self assert: (marsRover isInCoordinates: (1@3) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test09RoverThatWasCommandedToRotateRightMultipleTimesIsFacingTheExpectedDirection
	
	marsRover processCommands: 'rrr'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: west).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test10RoverThatWasCommandedToRotateMultipleTimesIsFacingTheExpectedDirection
	
	marsRover processCommands: 'lllr'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: south).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test11RoverThatWasCommandedToMoveAndRotateMultipleTimesIsPositionedCorrectly
	
	marsRover processCommands: 'lfrbbllffr'.
	
	self assert: (marsRover isInCoordinates: (0@-3) facing: west).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:37:27'!
test12RoverThatWasGivenAChainOfCommandsWithAnInvalidCommandStopsAtTheLastValidCommand
	
	self should: [marsRover processCommands: 'fflblalffrff']
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: 'Invalid Command'.
							self assert: (marsRover isInCoordinates: (2@3) facing: south)]	.! !


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

!CardinalDirections methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:08'!
cardinalDirectionOnYourLeft

	^self subclassResponsibility! !

!CardinalDirections methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:25'!
cardinalDirectionOnYourRight

	^self subclassResponsibility! !


!CardinalDirections methodsFor: 'testing' stamp: 'AG 12/2/2020 22:18:56'!
= aCardinalDirection

	^self isKindOf: aCardinalDirection class! !


!CardinalDirections methodsFor: 'movement unit vectors' stamp: 'AG 12/3/2020 17:18:42'!
backwardMovementUnitVector

	^self subclassResponsibility ! !

!CardinalDirections methodsFor: 'movement unit vectors' stamp: 'AG 12/3/2020 17:18:48'!
forwardMovementUnitVector

	^self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
CardinalDirections subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:08'!
cardinalDirectionOnYourLeft

	^North new.! !

!East methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:25'!
cardinalDirectionOnYourRight

	^South new.! !


!East methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:50:38'!
backwardMovementUnitVector

	^(-1@0)! !

!East methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:51:37'!
forwardMovementUnitVector

	^(1@0)! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirections subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:08'!
cardinalDirectionOnYourLeft

	^West new.! !

!North methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:25'!
cardinalDirectionOnYourRight

	^East new.! !


!North methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:52:17'!
backwardMovementUnitVector
	
	^(0@-1)! !

!North methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:52:24'!
forwardMovementUnitVector
	
	^(0@1)! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirections subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:08'!
cardinalDirectionOnYourLeft

	^East new.! !

!South methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:25'!
cardinalDirectionOnYourRight

	^West new.! !


!South methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:53:55'!
backwardMovementUnitVector

	^(0@1)! !

!South methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:54:04'!
forwardMovementUnitVector

	^(0@-1)! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirections subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:08'!
cardinalDirectionOnYourLeft
	
	^South new.! !

!West methodsFor: 'direction changing' stamp: 'AG 12/3/2020 16:44:25'!
cardinalDirectionOnYourRight
	
	^North new.! !


!West methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:54:38'!
backwardMovementUnitVector
	
	^(1@0)! !

!West methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:54:48'!
forwardMovementUnitVector
	
	^(-1@0)! !


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


!MarsRover methodsFor: 'command procesing' stamp: 'AG 12/3/2020 17:42:52'!
processCommands: aChainOfCommands 

	aChainOfCommands do: [ :aCommandIdentifier | self processCommand: aCommandIdentifier ].! !


!MarsRover methodsFor: 'private' stamp: 'AG 12/3/2020 17:42:33'!
processCommand: aCommandIdentifier

	aCommandIdentifier = $f ifTrue: [^currentCoordinates := currentCoordinates + 
								currentCardinalDirection forwardMovementUnitVector ].
	aCommandIdentifier = $b ifTrue: [^currentCoordinates := currentCoordinates + 
								currentCardinalDirection backwardMovementUnitVector ].
	aCommandIdentifier = $r ifTrue: [^currentCardinalDirection := currentCardinalDirection cardinalDirectionOnYourRight ].
	aCommandIdentifier = $l ifTrue: [^currentCardinalDirection := currentCardinalDirection cardinalDirectionOnYourLeft ].
	
	self error: 'Invalid Command'.! !


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
