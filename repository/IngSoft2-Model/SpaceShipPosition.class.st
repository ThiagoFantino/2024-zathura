Class {
	#name : #SpaceShipPosition,
	#superclass : #Object,
	#instVars : [
		'lap',
		'tileNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
SpaceShipPosition class >> createAt: aTile and: aLap [

	^ self new initilizewith: aTile and: aLap
]

{ #category : #correcting }
SpaceShipPosition >> correctIfBeyond: maxLaps [

	lap >= maxLaps ifFalse: [ ^ self ].
	tileNumber := 1.
	lap := maxLaps
]

{ #category : #correcting }
SpaceShipPosition >> correctIfInNegativeLap [

	lap < 1 ifFalse: [ ^ self ].
	tileNumber := 1.
	lap := 1
]

{ #category : #calculating }
SpaceShipPosition >> costToMoveTo: anotherPostion withBoardSize: boardSize [

	^ ((self totalAmountOfSquaresMovedWith: boardSize)
	   - (anotherPostion totalAmountOfSquaresMovedWith: boardSize)) abs
]

{ #category : #initalize }
SpaceShipPosition >> initilizewith: aTileNumber and: aLap [

	tileNumber := aTileNumber.
	lap := aLap.
	self correctIfInNegativeLap
]

{ #category : #accessing }
SpaceShipPosition >> lap [

	^ lap
]

{ #category : #resetting }
SpaceShipPosition >> resetPosition [

	tileNumber := 1
]

{ #category : #accessing }
SpaceShipPosition >> tileNumber [

	^ tileNumber
]

{ #category : #calculating }
SpaceShipPosition >> totalAmountOfSquaresMovedWith: anAmountOfTilesPerLap [

	^ tileNumber + (lap - 1 * anAmountOfTilesPerLap)
]
