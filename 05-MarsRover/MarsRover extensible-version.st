!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover north south east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test01RoverThatWasntCommandedToMoveIsInStartingLocation
	
	marsRover processCommands: ''.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test02RoverThatWasntCommandedToMoveIsNotInIncorrectPosition
	
	marsRover processCommands: ''.
	
	self deny: (marsRover isInCoordinates: (1@2) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test03RoverThatWasntCommandedToRotateIsNotFacingAnotherDirection

	marsRover processCommands: ''.
	
	self deny: (marsRover isInCoordinates: (1@1) facing: south).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test04RoverThatWasCommandedToMoveForwardIsInExpectedPosition
	
	marsRover processCommands: 'f'.
	
	self assert: (marsRover isInCoordinates: (1@2) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test05RoverThatWasCommandedToMoveBackwardsIsInExpectedPosition
	
	marsRover processCommands: 'b'.
	
	self assert: (marsRover isInCoordinates: (1@0) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test06RoverThatWasCommandedToRotateLeftIsFacingTheExpectedDirection
	
	marsRover processCommands: 'l'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: west).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test07RoverThatWasCommandedToRotateRightIsFacingTheExpectedDirection
	
	marsRover processCommands: 'r'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: east).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test08RoverThatWasCommandedToMoveMultipleTimesIsInExpectedPosition
	
	marsRover processCommands: 'fffbbf'.
	
	self assert: (marsRover isInCoordinates: (1@3) facing: north).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test09RoverThatWasCommandedToRotateRightMultipleTimesIsFacingTheExpectedDirection
	
	marsRover processCommands: 'rrr'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: west).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test10RoverThatWasCommandedToRotateMultipleTimesIsFacingTheExpectedDirection
	
	marsRover processCommands: 'lllr'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: south).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test11RoverThatWasCommandedToMoveAndRotateMultipleTimesIsPositionedCorrectly
	
	marsRover processCommands: 'lfrbbllffr'.
	
	self assert: (marsRover isInCoordinates: (0@-3) facing: west).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AG 12/3/2020 17:38:56'!
test12RoverThatWasGivenAChainOfCommandsWithAnInvalidCommandStopsAtTheLastValidCommand
	
	self should: [marsRover processCommands: 'fflblalffrff']
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: 'Invalid Command'.
							self assert: (marsRover isInCoordinates: (2@3) facing: south)]	.! !


!MarsRoverTest methodsFor: 'setup' stamp: 'MR 12/3/2020 17:54:03'!
setUp
	
	north := North new.
	south := South new.
	east := East new.
	west := West new.
	marsRover := MarsRover newInCoordinates: (1@1) facing: north
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


!CardinalDirections methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:50:09'!
backwardMovementUnitVector

	^self subclassResponsibility ! !

!CardinalDirections methodsFor: 'movement unit vectors' stamp: 'MR 12/2/2020 23:50:13'!
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


!MarsRover methodsFor: 'command procesing' stamp: 'AG 12/3/2020 17:39:36'!
processCommands: aChainOfCommands 
	
	aChainOfCommands do: [:aCommandIdentifier | self processCommand: aCommandIdentifier ].! !


!MarsRover methodsFor: 'movement' stamp: 'MR 12/3/2020 17:55:30'!
moveBackward

	currentCoordinates := currentCoordinates + currentCardinalDirection backwardMovementUnitVector! !

!MarsRover methodsFor: 'movement' stamp: 'MR 12/2/2020 23:48:11'!
moveForward

	currentCoordinates := currentCoordinates + currentCardinalDirection forwardMovementUnitVector! !

!MarsRover methodsFor: 'movement' stamp: 'AG 12/3/2020 16:44:08'!
rotateLeft

	currentCardinalDirection := currentCardinalDirection cardinalDirectionOnYourLeft! !

!MarsRover methodsFor: 'movement' stamp: 'AG 12/3/2020 16:44:25'!
rotateRight

	currentCardinalDirection := currentCardinalDirection cardinalDirectionOnYourRight! !


!MarsRover methodsFor: 'private' stamp: 'MR 12/3/2020 17:57:06'!
processCommand: aCommandIdentifier
	
	| aCommand |
	aCommand := MarsRoverCommand newFor: aCommandIdentifier.
	aCommand executeCommandFor: self.
	
	! !


!MarsRover methodsFor: 'testing' stamp: 'AG 12/2/2020 22:22:00'!
isInCoordinates: aSetOfCoordinates facing: aCardinalDirection 

	^currentCoordinates = aSetOfCoordinates and: [currentCardinalDirection = aCardinalDirection]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MR 12/3/2020 17:53:13'!
newInCoordinates: aSetOfCoordinates facing: aCardinalDirection 
	
	aSetOfCoordinates isPoint ifFalse: [self error: 'Invalid Coordinates'].	
	(aCardinalDirection isKindOf: CardinalDirections) ifFalse: [self error: 'Invalid Cardinal Direction']. 
	^self new initializeNewInCoordinates: aSetOfCoordinates facing: aCardinalDirection! !


!classDefinition: #MarsRoverCommand category: 'MarsRover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommand methodsFor: 'execution' stamp: 'AG 12/2/2020 23:00:19'!
executeCommandFor: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'MarsRover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'AG 12/2/2020 22:48:42'!
isIdentifiedBy: aCommandIdentifier

	self subclassResponsibility ! !

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'AG 12/3/2020 17:04:41'!
newFor: aCommandIdentificator

	| aCommandToInstantiate | 
	
	aCommandToInstantiate := MarsRoverCommand allSubclasses detect: 
			[ :aCommand | aCommand isIdentifiedBy: aCommandIdentificator]
			ifNone: [aCommandToInstantiate := InvalidCommand].
	
	^aCommandToInstantiate new. ! !


!classDefinition: #InvalidCommand category: 'MarsRover'!
MarsRoverCommand subclass: #InvalidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!InvalidCommand methodsFor: 'execution' stamp: 'MR 12/3/2020 00:03:00'!
executeCommandFor: aMarsRover

	self error: 'Invalid Command'. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidCommand class' category: 'MarsRover'!
InvalidCommand class
	instanceVariableNames: ''!

!InvalidCommand class methodsFor: 'instance creation' stamp: 'MR 12/2/2020 23:23:22'!
isIdentifiedBy: aCommandIdentifier

	^false! !


!classDefinition: #MoveBackward category: 'MarsRover'!
MarsRoverCommand subclass: #MoveBackward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackward methodsFor: 'execution' stamp: 'MR 12/3/2020 17:55:30'!
executeCommandFor: aMarsRover

	aMarsRover moveBackward. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackward class' category: 'MarsRover'!
MoveBackward class
	instanceVariableNames: ''!

!MoveBackward class methodsFor: 'instance creation' stamp: 'AG 12/2/2020 22:47:43'!
isIdentifiedBy: aCommandIdentifier

	^aCommandIdentifier = $b! !


!classDefinition: #MoveForward category: 'MarsRover'!
MarsRoverCommand subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForward methodsFor: 'execution' stamp: 'AG 12/2/2020 23:00:39'!
executeCommandFor: aMarsRover

	aMarsRover moveForward. 

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForward class' category: 'MarsRover'!
MoveForward class
	instanceVariableNames: ''!

!MoveForward class methodsFor: 'instance creation' stamp: 'AG 12/2/2020 22:47:54'!
isIdentifiedBy: aCommandIdentifier

	^aCommandIdentifier = $f! !


!classDefinition: #RotateLeft category: 'MarsRover'!
MarsRoverCommand subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'execution' stamp: 'AG 12/2/2020 23:00:44'!
executeCommandFor: aMarsRover

	aMarsRover rotateLeft. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'MarsRover'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'instance creation' stamp: 'AG 12/2/2020 22:48:03'!
isIdentifiedBy: aCommandIdentifier

	^aCommandIdentifier = $l! !


!classDefinition: #RotateRight category: 'MarsRover'!
MarsRoverCommand subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'execution' stamp: 'AG 12/2/2020 23:00:50'!
executeCommandFor: aMarsRover

	aMarsRover rotateRight. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRight class' category: 'MarsRover'!
RotateRight class
	instanceVariableNames: ''!

!RotateRight class methodsFor: 'instance creation' stamp: 'AG 12/2/2020 22:48:11'!
isIdentifiedBy: aCommandIdentifier

	^aCommandIdentifier = $r! !
