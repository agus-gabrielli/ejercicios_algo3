!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MR 11/30/2020 21:43:50'!
test01RoverThatHasntMovedIsInStartingLocation
	
	| Rover |
	Rover := MarsRover newInLocation: 1@1 pointing: #N.
	
	self assert: Rover currentPosition = (1@1) .! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MR 11/30/2020 21:52:58'!
test02RoverThatHasntRotatedIsPointingTheSameDirection
	
	| Rover |
	Rover := MarsRover newInLocation: 1@1 pointing: #N.
	
	self assert: Rover currentFacing = #N .! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentCoordinates currentCardinalDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'MR 11/30/2020 21:49:05'!
initializeNewInLocation: coordinates pointing: cardinalDirection
 
	currentCoordinates := coordinates.
	currentCardinalDirection := cardinalDirection.! !


!MarsRover methodsFor: 'positioning' stamp: 'MR 11/30/2020 21:54:12'!
currentFacing
	^#N! !

!MarsRover methodsFor: 'positioning' stamp: 'MR 11/30/2020 21:49:37'!
currentPosition
	
	^1@1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MR 11/30/2020 21:45:23'!
newInLocation: coordinates pointing: cardinalDirection 
	
	^self new initializeNewInLocation: coordinates pointing: cardinalDirection ! !
