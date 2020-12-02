'From Cuis 5.0 [latest update: #4384] on 2 December 2020 at 3:46:56 pm'!
!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MR 12/2/2020 15:06:59'!
test01RoverThatHasntMovedIsInStartingLocation
	
	| rover |
	rover := MarsRover newInCoordinates: 1@1 facing: #N.
	
	rover processComands: ''.
	
	self assert: (rover isInCoordinates: (1@1) facing: #N).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MR 12/2/2020 15:38:43'!
test02AskingRoverThatHasntMovedIfItIsInDifferentCoordinatesThanInitialCoordinatesReturnsFalse
	
	| rover |
	rover := MarsRover newInCoordinates: 1@1 facing: #N.
	
	rover processComands: ''.
	
	self deny: (rover isInCoordinates: (1@2) facing: #N).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MR 12/2/2020 15:42:57'!
test03RoverThatWasCommandedToMoveForwardMovedOnePositionForward
	
	| rover |
	rover := MarsRover newInCoordinates: 1@1 facing: #N.
	
	rover processComands: 'f'.
	
	self assert: (rover isInCoordinates: (1@2) facing: #N).! !
