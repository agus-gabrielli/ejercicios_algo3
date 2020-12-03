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

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/3/2020 00:00:56'!
test11RoverThatWasGivenAChainOfCommandsWithAnInvalidCommandStopsAtTheLastValidCommand
	
	self should: [marsRover processComands: 'fflblalffrff']
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

!CardinalDirections methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:36'!
cardinalDirectionAtMyLeft

	^self subclassResponsibility! !

!CardinalDirections methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:58'!
cardinalDirectionAtMyRight

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

!East methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:36'!
cardinalDirectionAtMyLeft

	^North new.! !

!East methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:58'!
cardinalDirectionAtMyRight

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

!North methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:36'!
cardinalDirectionAtMyLeft

	^West new.! !

!North methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:58'!
cardinalDirectionAtMyRight

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

!South methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:36'!
cardinalDirectionAtMyLeft

	^East new.! !

!South methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:58'!
cardinalDirectionAtMyRight

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

!West methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:36'!
cardinalDirectionAtMyLeft
	
	^South new.! !

!West methodsFor: 'direction changing' stamp: 'AG 12/2/2020 22:53:58'!
cardinalDirectionAtMyRight
	
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


!MarsRover methodsFor: 'command procesing' stamp: 'AG 12/2/2020 23:04:09'!
processComands: aChainOfCommands 
	
	aChainOfCommands do: [:aCommandIdentifier | self processComand: aCommandIdentifier ].! !


!MarsRover methodsFor: 'movement' stamp: 'MR 12/2/2020 23:48:19'!
moveBackwards

	currentCoordinates := currentCoordinates + currentCardinalDirection backwardMovementUnitVector! !

!MarsRover methodsFor: 'movement' stamp: 'MR 12/2/2020 23:48:11'!
moveForward

	currentCoordinates := currentCoordinates + currentCardinalDirection forwardMovementUnitVector! !

!MarsRover methodsFor: 'movement' stamp: 'AG 12/2/2020 22:53:36'!
rotateLeft

	currentCardinalDirection := currentCardinalDirection cardinalDirectionAtMyLeft! !

!MarsRover methodsFor: 'movement' stamp: 'AG 12/2/2020 22:53:58'!
rotateRight

	currentCardinalDirection := currentCardinalDirection cardinalDirectionAtMyRight! !


!MarsRover methodsFor: 'private' stamp: 'MR 12/2/2020 23:18:01'!
processComand: aCommandIdentifier
	
	| aCommand |
	aCommand := MarsRoverCommand newFor: aCommandIdentifier.
	aCommand ifNil: [^self error: aCommandIdentifier, ' is an Invalid command identifier.'].
	aCommand executeCommandFor: self.
	
	! !


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

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'MR 12/2/2020 23:22:26'!
newFor: aCommandIdentificator

	| subclassToInstantiate | 
	
	subclassToInstantiate := MarsRoverCommand allSubclasses detect: 
			[ :aCommand | aCommand isIdentifiedBy: aCommandIdentificator]
			ifNone: [^InvalidCommand new].
	
	^subclassToInstantiate new. ! !


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


!classDefinition: #MoveBackwards category: 'MarsRover'!
MarsRoverCommand subclass: #MoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwards methodsFor: 'execution' stamp: 'AG 12/2/2020 23:00:33'!
executeCommandFor: aMarsRover

	aMarsRover moveBackwards. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwards class' category: 'MarsRover'!
MoveBackwards class
	instanceVariableNames: ''!

!MoveBackwards class methodsFor: 'instance creation' stamp: 'AG 12/2/2020 22:47:43'!
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
