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

{ #category : #'as yet unclassified' }
SpaceShipPosition >> correctIfBeyond: maxLaps [

	lap >= maxLaps ifFalse: [ ^ self ].
	tileNumber := 1.
	lap := maxLaps
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> correctIfInNegativeLap [

	lap < 1 ifFalse: [ ^ self ].
	tileNumber := 1.
	lap := 1
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> costToMoveTo: anotherPostion withBoardSize: boardSize [

	^ ((self totalAmountOfSquaresMovedWith: boardSize)
	   - (anotherPostion totalAmountOfSquaresMovedWith: boardSize)) abs
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> initilizewith: aTileNumber and: aLap [

	tileNumber := aTileNumber.
	lap := aLap.
	self correctIfInNegativeLap
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> lap [

	^ lap
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> resetPosition [

	tileNumber := 1
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> tileNumber [

	^ tileNumber
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> totalAmountOfSquaresMovedWith: anAmountOfTilesPerLap [

	^ tileNumber + (lap - 1 * anAmountOfTilesPerLap)
]
