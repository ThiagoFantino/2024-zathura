Class {
	#name : #EffectManager,
	#superclass : #Object,
	#instVars : [
		'game',
		'board',
		'spaceships',
		'lastEffectApplied'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
EffectManager class >> usedIn: aGame with: aBoard affecting: someShips [

	^ self new initializeIn: aGame using: aBoard affecting: someShips
]

{ #category : #playing }
EffectManager >> applyBlackHoleEffectTo: aSpaceShip [

	board move: aSpaceShip by: -4
]

{ #category : #initialization }
EffectManager >> applyEffectOn: aSpaceship [

	| effectToApply |
	effectToApply := board effectToApplyTo: aSpaceship.
	lastEffectApplied := effectToApply.
	effectToApply triggeredBy: aSpaceship on: self
]

{ #category : #playing }
EffectManager >> applyHyperGravityEffectOf: needsToThrow to: aSpaceship [

	aSpaceship changeRollingResultNeededToMove: needsToThrow
]

{ #category : #playing }
EffectManager >> applyMoonwalkMoving: anAmountOfTiles notAffecting: aShip [

	(self getAllButOneSpaceship: aShip) do: [ :spaceship |
		board move: spaceship by: anAmountOfTiles ]
]

{ #category : #playing }
EffectManager >> getAllButOneSpaceship: theSpaceShip [

	| filteredShips |
	filteredShips := spaceships select: [ :spaceship |
		                 spaceship ~= theSpaceShip ].

	^ filteredShips
]

{ #category : #playing }
EffectManager >> giveCardFromDeckTo: aSpaceship [

	game giveCardFromDeckTo: aSpaceship
]

{ #category : #initialization }
EffectManager >> initializeIn: aGame using: aBoard affecting: someShips [

	game := aGame.
	board := aBoard.
	spaceships := someShips.
	lastEffectApplied := Null create
]

{ #category : #playing }
EffectManager >> move: aSpaceShip by: anAmountOfTiles [

	board move: aSpaceShip by: anAmountOfTiles
]

{ #category : #playing }
EffectManager >> move: aSpaceship jumping: aQuantityOfParsec [

	board move: aSpaceship jumping: aQuantityOfParsec
]

{ #category : #playing }
EffectManager >> moveAllSpaceshipsToFirstPosition [

	board moveAllSpaceshipsToFirstPosition: spaceships
]

{ #category : #playing }
EffectManager >> repeatLastEffectAppliedOn: aSpaceship [

	lastEffectApplied triggeredBy: aSpaceship on: self
]

{ #category : #playing }
EffectManager >> teleport: aSpaceship to: tileToTeleport [

	board move: aSpaceship toTile: tileToTeleport.

]
