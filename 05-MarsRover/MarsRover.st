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


!MarsRover methodsFor: 'command procesing' stamp: 'MR 12/2/2020 15:13:31'!
processComands: aChainOfCommands 
	! !


!MarsRover methodsFor: 'testing' stamp: 'MR 12/2/2020 15:10:08'!
isInCoordinates: aSetOfCoordinates facing: aCardinalDirection 
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MR 12/2/2020 15:11:21'!
newInCoordinates: aSetOfCoordinates facing: aCardinalDirection 
	
	^self new initializeNewInCoordinates: aSetOfCoordinates facing: aCardinalDirection! !
