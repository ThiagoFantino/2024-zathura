Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'laps',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValidQuantityOf: parsecs [

	parsecs < 0 ifTrue: [
		Error signal: 'Parsecs cannot be a negative measure' ]
]

{ #category : #asserting }
Board class >> isValid: tiles [

	tiles size < 2 ifTrue: [ Error signal: 'Tiles should be 2 or more' ]
]

{ #category : #'instance creation' }
Board class >> of: tiles withMeasures: units [

	self isValid: tiles.
	self assertValidQuantityOf: units valueAsParsecs.
	^ self new
		  initializeOf: tiles
		  withDistance: units
]

{ #category : #initialization }
Board >> amountOfTiles [

	^ tiles size
]

{ #category : #accessing }
Board >> calculateNewLapWhen: aSpaceship advances: anAmountOfTilesToMove [

	| tilesSinceBeginning |
	tilesSinceBeginning := (aSpaceship tileNumber)
	                       + anAmountOfTilesToMove
	                       + (aSpaceship lap - 1 * self amountOfTiles).
	^ tilesSinceBeginning - 1 // self amountOfTiles + 1
]

{ #category : #accessing }
Board >> calculateTilesToMoveWhen: aSpaceship moves: anAmountOfTilesToMove [

	| newTileNumber tilesSinceBeginning lapAfterMovement |
	lapAfterMovement := self
		                    calculateNewLapWhen: aSpaceship
		                    advances: anAmountOfTilesToMove.
	tilesSinceBeginning := aSpaceship tileNumber + anAmountOfTilesToMove
	                       + (aSpaceship lap - 1 * self amountOfTiles).
	newTileNumber := tilesSinceBeginning % self amountOfTiles.
	(lapAfterMovement < 1 or: lapAfterMovement > self laps) ifTrue: [
		^ 1 - aSpaceship tileNumber ].
	newTileNumber = 0 ifTrue: [
		^ self amountOfTiles - aSpaceship tileNumber ].
	^ newTileNumber - aSpaceship tileNumber
]

{ #category : #initialization }
Board >> effectToApplyTo: aSpaceship [

	^ tiles at: aSpaceship tileNumber
]

{ #category : #playing }
Board >> finishesAfter: amountOfLaps [

	laps := amountOfLaps
]

{ #category : #initialization }
Board >> initializeOf: aTileCollection withDistance: aUnitOfDistance [

	tiles := aTileCollection.
	parsecs := aUnitOfDistance valueAsParsecs
]

{ #category : #accessing }
Board >> laps [

	^ laps
]

{ #category : #accessing }
Board >> move: aSpaceship by: anAmountOfTilesToMove [

	| tilesToMove lapsToMove costToMove newLap |
	newLap := self
		          calculateNewLapWhen: aSpaceship
		          advances: anAmountOfTilesToMove.
	lapsToMove := (newLap min: laps + 1 max: 1) - aSpaceship lap.
	tilesToMove := self
		                  calculateTilesToMoveWhen: aSpaceship
		                  moves: anAmountOfTilesToMove.

	costToMove := (lapsToMove * self amountOfTiles + tilesToMove) abs.
	aSpaceship
		movePositionBy: tilesToMove
		lapBy: lapsToMove
		neededFuel: costToMove
]

{ #category : #initialization }
Board >> move: aSpaceship jumping: aQuantityOfParsec [

	| tilesToMove |
	tilesToMove := (aQuantityOfParsec // (parsecs / self amountOfTiles))
		               truncated.

	self move: aSpaceship by: tilesToMove
]

{ #category : #initialization }
Board >> moveAllSpaceshipsToFirstPosition: allSpaceShips [

	allSpaceShips do: [ :spaceship |
		spaceship
			movePositionBy: 1 - spaceship tileNumber
			lapBy: 0
			neededFuel: 0 ]
]
