!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:14:49'!
test01RoverThatWasntCommandedToMoveIsInStartingLocation
	
	marsRover processComands: ''.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:14:59'!
test02RoverThatWasntCommandedToMoveIsNotInIncorrectPosition
	
	marsRover processComands: ''.
	
	self deny: (marsRover isInCoordinates: (1@2) facing: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:15:10'!
test03RoverThatWasntCommandedToRotateIsNotFacingAnotherDirection

	marsRover processComands: ''.
	
	self deny: (marsRover isInCoordinates: (1@1) facing: #S).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:15:18'!
test04RoverThatWasCommandedToMoveForwardIsInExpectedPosition
	
	marsRover processComands: 'f'.
	
	self assert: (marsRover isInCoordinates: (1@2) facing: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:15:34'!
test05RoverThatWasCommandedToMoveBackwardsIsInExpectedPosition
	
	marsRover processComands: 'b'.
	
	self assert: (marsRover isInCoordinates: (1@0) facing: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:16:02'!
test06RoverThatWasCommandedToRotateLeftIsFacingTheExpectedDirection
	
	marsRover processComands: 'l'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: #W).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:16:08'!
test07RoverThatWasCommandedToRotateRightIsFacingTheExpectedDirection
	
	marsRover processComands: 'r'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: #E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:16:29'!
test08RoverThatWasCommandedToMoveMultipleTimesIsInExpectedPosition
	
	marsRover processComands: 'fffbbf'.
	
	self assert: (marsRover isInCoordinates: (1@3) facing: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:16:36'!
test09RoverThatWasCommandedToRotateRightMultipleTimesIsFacingTheExpectedDirection
	
	marsRover processComands: 'rrr'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: #W).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MR 12/2/2020 17:16:43'!
test10RoverThatWasCommandedToRotateMultipleTimesIsFacingTheExpectedDirection
	
	marsRover processComands: 'lllr'.
	
	self assert: (marsRover isInCoordinates: (1@1) facing: #S).! !


!MarsRoverTest methodsFor: 'setup' stamp: 'MR 12/2/2020 17:14:22'!
setUp

	marsRover := MarsRover newInCoordinates: (1@1) facing: #N ! !


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


!MarsRover methodsFor: 'command procesing' stamp: 'MR 12/2/2020 17:01:52'!
processComands: aChainOfCommands 

	aChainOfCommands do: [:command | command = $f ifTrue: [currentCoordinates := currentCoordinates + (0@1)].
								command = $b ifTrue: [currentCoordinates := currentCoordinates + (0@-1)].
								command = $r ifTrue: [ currentCardinalDirection = #N ifTrue: [currentCardinalDirection := #E]	 ifFalse: [
													currentCardinalDirection = #E ifTrue: [currentCardinalDirection := #S] ifFalse: [
													currentCardinalDirection = #S ifTrue: [currentCardinalDirection := #W] ifFalse: [
													currentCardinalDirection := #N]]]].
								command = $l ifTrue: [ currentCardinalDirection = #N ifTrue: [currentCardinalDirection := #W]	 ifFalse: [
													currentCardinalDirection = #W ifTrue: [currentCardinalDirection := #S] ifFalse: [
													currentCardinalDirection = #S ifTrue: [currentCardinalDirection := #E] ifFalse: [
													currentCardinalDirection := #N]]]]].! !


!MarsRover methodsFor: 'testing' stamp: 'MR 12/2/2020 15:57:46'!
isInCoordinates: aSetOfCoordinates facing: aCardinalDirection 

	^currentCoordinates = aSetOfCoordinates and: [currentCardinalDirection = aCardinalDirection]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MR 12/2/2020 15:11:21'!
newInCoordinates: aSetOfCoordinates facing: aCardinalDirection 
	
	^self new initializeNewInCoordinates: aSetOfCoordinates facing: aCardinalDirection! !
