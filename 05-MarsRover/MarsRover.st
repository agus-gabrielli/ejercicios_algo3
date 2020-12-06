!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north east south west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'MR 12/6/2020 18:30:52'!
setUp
	
	north := PointingNorth new.
	east := PointingEast new.
	south := PointingSouth new.
	west := PointingWest new.! !


!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:58'!
test01RoverNotCommandedToMoveIsInStartingPosition
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: north.
	
	rover processCommands: ''.
	
	self assert: (rover isInCoordinates: (1@1) facing: north) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:58'!
test02RoverNotCommandedToMoveIsNotInAnIncorrectPosition
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: north.
	
	rover processCommands: ''.
	
	self deny: (rover isInCoordinates: (4@3) facing: north) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:58'!
test03RoverNotCommandedToRotateIsNotFacingAnotherDirection
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: north.
	
	rover processCommands: ''.
	
	self deny: (rover isInCoordinates: (1@1) facing: south) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:58'!
test04RoverCommandedToMoveForwardHeadingNorthIsInCorrectPosition
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: north.
	
	rover processCommands: 'f'.
	
	self assert: (rover isInCoordinates: (1@2) facing: north) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test05RoverCommandedToMoveForwardHeadingEastIsInCorrectPosition
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: east.
	
	rover processCommands: 'f'.
	
	self assert: (rover isInCoordinates: (2@1) facing: east) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test06RoverCommandedToMoveForwardHeadingWestIsInCorrectPosition
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: west.
	
	rover processCommands: 'f'.
	
	self assert: (rover isInCoordinates: (0@1) facing: west) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test07RoverCommandedToMoveForwardHeadingSouthIsInCorrectPosition
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: south.
	
	rover processCommands: 'f'.
	
	self assert: (rover isInCoordinates: (1@0) facing: south) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test08RoverCommandedToMoveBackwardIsInCorrectPosition
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: south.
	
	rover processCommands: 'b'.
	
	self assert: (rover isInCoordinates: (1@2) facing: south) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test09RoverCommandedToRotateRightFacingNorthIsFacingEast
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: north.
	
	rover processCommands: 'r'.
	
	self assert: (rover isInCoordinates: (1@1) facing: east) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:58'!
test10RoverCommandedToRotateRightFacingEastIsFacingSouth
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: east.
	
	rover processCommands: 'r'.
	
	self assert: (rover isInCoordinates: (1@1) facing: south) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:58'!
test11RoverCommandedToRotateRightFacingSouthIsFacingWest
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: south.
	
	rover processCommands: 'r'.
	
	self assert: (rover isInCoordinates: (1@1) facing: west) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:58'!
test12RoverCommandedToRotateRightFacingWestIsFacingNorth
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: west.
	
	rover processCommands: 'r'.
	
	self assert: (rover isInCoordinates: (1@1) facing: north) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:58'!
test13RoverCommandedToRotateLeftFacingNorthIsFacingWest
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: north.
	
	rover processCommands: 'l'.
	
	self assert: (rover isInCoordinates: (1@1) facing: west) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test14RoverCommandedToRotateLeftFacingEastIsFacingNorth
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: east.
	
	rover processCommands: 'l'.
	
	self assert: (rover isInCoordinates: (1@1) facing: north) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test15RoverCommandedToRotateLeftFacingSouthIsFacingEast
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: south.
	
	rover processCommands: 'l'.
	
	self assert: (rover isInCoordinates: (1@1) facing: east) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test16RoverCommandedToRotateLeftFacingWestIsFacingSouth
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: west.
	
	rover processCommands: 'l'.
	
	self assert: (rover isInCoordinates: (1@1) facing: south) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test17RoverGivenMultipleCommandsIsInTheRightPositionAndHeadingTheRightWay
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: north.
	
	rover processCommands: 'fffllbbr'.
	
	self assert: (rover isInCoordinates: (1@6) facing: west) ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/6/2020 19:54:57'!
test18RoverGivenAnInvalidCommandStopsAtTheLastValidCommand
	
	| rover |
	rover _ MarsRover newIn: (1@1) heading: north.
	self should: [	rover processCommands: 'fflffbrxdffrlbbrf']
		raise: Error
		withExceptionDo: [ 	:anError | 
						self assert: anError messageText equals: 'Invalid Command'.
						self assert: (rover isInCoordinates: (0@3) facing: north)]! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentCoordinates currentHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'MR 12/6/2020 19:55:50'!
initializeNewIn: aSetOfCoordinates heading: aHeading 

	currentCoordinates _ aSetOfCoordinates.
	currentHeading _ aHeading.! !


!MarsRover methodsFor: 'movement' stamp: 'MR 12/6/2020 20:03:52'!
moveBackward

	currentCoordinates _ currentCoordinates + currentHeading backwardMovementVector ! !

!MarsRover methodsFor: 'movement' stamp: 'MR 12/6/2020 20:03:58'!
moveForward

	currentCoordinates _ currentCoordinates + currentHeading forwardMovementVector. ! !

!MarsRover methodsFor: 'movement' stamp: 'MR 12/6/2020 19:41:17'!
rotateLeft

	currentHeading _ currentHeading onYourLeft.! !

!MarsRover methodsFor: 'movement' stamp: 'MR 12/6/2020 19:41:17'!
rotateRight

	currentHeading _ currentHeading onYourRight.! !


!MarsRover methodsFor: 'command processing' stamp: 'MR 12/6/2020 18:35:12'!
processCommand: aCommand 

	aCommand = $f ifTrue: [^self moveForward].
	aCommand = $b ifTrue: [^self moveBackward].
	aCommand = $r ifTrue: [^self rotateRight].
	aCommand = $l ifTrue: [^self rotateLeft].
	
	self error: 'Invalid Command'
	! !

!MarsRover methodsFor: 'command processing' stamp: 'MR 12/6/2020 17:34:25'!
processCommands: aChainOfCommands 
	
	aChainOfCommands do: [:aCommand | self processCommand: aCommand]
	! !


!MarsRover methodsFor: 'testing' stamp: 'MR 12/6/2020 19:56:21'!
isInCoordinates: aSetOfCoordinates facing: aHeading 

	^currentCoordinates = aSetOfCoordinates and: [currentHeading = aHeading]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MR 12/6/2020 19:55:43'!
newIn: aSetOfCoordinates heading: aHeading 

	aSetOfCoordinates isPoint ifFalse: [self error: 'Invalid Starting Position'].
	(aHeading isKindOf: MarsRoverHeading) ifFalse: [self error: 'Invalid Starting Direction']. 
	
	^self new initializeNewIn: aSetOfCoordinates heading: aHeading ! !


!classDefinition: #MarsRoverHeading category: 'MarsRover'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeading methodsFor: 'testing' stamp: 'MR 12/6/2020 17:02:24'!
= aPossibleHeading

	^aPossibleHeading isKindOf: self class! !


!MarsRoverHeading methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:02'!
onYourLeft

	^self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:55'!
onYourRight

	^self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'movement vectors' stamp: 'MR 12/6/2020 19:54:05'!
backwardMovementVector

	^self forwardMovementVector negated! !

!MarsRoverHeading methodsFor: 'movement vectors' stamp: 'MR 12/6/2020 19:52:32'!
forwardMovementVector

	^self subclassResponsibility ! !


!classDefinition: #PointingEast category: 'MarsRover'!
MarsRoverHeading subclass: #PointingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingEast methodsFor: 'movement vectors' stamp: 'MR 12/6/2020 19:52:32'!
forwardMovementVector

	^(1@0)! !


!PointingEast methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:02'!
onYourLeft
	 
	^PointingNorth new! !

!PointingEast methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:55'!
onYourRight
	
	^PointingSouth new! !


!classDefinition: #PointingNorth category: 'MarsRover'!
MarsRoverHeading subclass: #PointingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingNorth methodsFor: 'movement vectors' stamp: 'MR 12/6/2020 19:52:32'!
forwardMovementVector

	^0@1! !


!PointingNorth methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:02'!
onYourLeft
	
	^PointingWest new! !

!PointingNorth methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:55'!
onYourRight

	^PointingEast new! !


!classDefinition: #PointingSouth category: 'MarsRover'!
MarsRoverHeading subclass: #PointingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingSouth methodsFor: 'movement vectors' stamp: 'MR 12/6/2020 19:52:32'!
forwardMovementVector

	^0@-1! !


!PointingSouth methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:02'!
onYourLeft
	
	^PointingEast new! !

!PointingSouth methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:55'!
onYourRight
	 
	^PointingWest new! !


!classDefinition: #PointingWest category: 'MarsRover'!
MarsRoverHeading subclass: #PointingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingWest methodsFor: 'movement vectors' stamp: 'MR 12/6/2020 19:52:32'!
forwardMovementVector

	^-1@0! !


!PointingWest methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:02'!
onYourLeft
	
	^PointingSouth new! !

!PointingWest methodsFor: 'direction changing' stamp: 'MR 12/6/2020 19:20:55'!
onYourRight
	
	^PointingNorth new! !
