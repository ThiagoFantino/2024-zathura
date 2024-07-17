Class {
	#name : #FirstVersionTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
FirstVersionTest >> testFV01GameMustHaveAtLeastOneSpaceship [

	| aBoard aDie1 |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3}.


	self
		should: [
			Game
				playedBy: {  }
				on: aBoard
				finishingAfter: 2
				rolling: aDie1
				usingCardsFrom: { 'card1.'. 'card2.' } ]
		raise: Error
		withMessage: 'Game must have at least one spaceship'
]

{ #category : #tests }
FirstVersionTest >> testFV02SpaceshipsStartAtFirstTile [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := #( 'Danny' 'Walter' ).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2' }).


	self assert: (aGame spaceshipCalled: 'Danny') name equals: 'Danny'.
	self assert: (aGame spaceshipCalled: 'Walter') name equals: 'Walter'.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.
]

{ #category : #tests }
FirstVersionTest >> testFV03GameHasEndedAsOneSpaceshipReachTheEnd [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 9. 9. 9. 10 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2' }).

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Danny' isAt: 3 with: 2 in: aGame.
	self assert: 'Walter' isAt: 3 with: 2 in: aGame.

	aGame playNextTurn.

	self assert: 'Danny' isAt: 1 with: 3 in: aGame.
	self assert: 'Walter' isAt: 3 with: 2 in: aGame.



	self assert: aGame hasEnded
]

{ #category : #tests }
FirstVersionTest >> testFV04CantRollAfterGameEnded [

	| aGame aBoard aDie1 someSpaceships |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 9. 10 }.
	someSpaceships := { 'Danny'. 'Walter' }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 1
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2' }).

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.

	aGame playNextTurn.

	self assert: 'Danny' isAt: 1 with: 2 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'Game has already ended'
]

{ #category : #tests }
FirstVersionTest >> testFV05IsValidWhenTheWinnerIsAssignedCorrectly [

	| aGame aBoard aDie1 someSpacheships |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 8. 8. 8. 9 }.
	someSpacheships := { 'Danny'. 'Walter' }.

	aGame := Game
		         playedBy: someSpacheships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2' }).

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.


	self assert: aGame winner name equals: 'Danny'
]

{ #category : #tests }
FirstVersionTest >> testFV06GameIsPlayedWithTwoDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3}.
	aDie2 := LoadedDie of: {3}.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDiceRoller
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2' }).

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.

	aGame playNextTurn.
	self deny: aGame hasEnded.
	self assert: 'Danny' isAt: 7 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.
]

{ #category : #tests }
FirstVersionTest >> testFV07GameWithRandomDie [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := Die of: 3.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2' }).

	self deny: aGame hasEnded.
	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
FirstVersionTest >> testFV08GameWithTwoRandomDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).
	aDie1 := Die of: 3.
	aDie2 := Die of: 5.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2' }).

	self deny: aGame hasEnded.
	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
FirstVersionTest >> testFV09SpaceshipOneCanRollTheDiceAfterSpaceshipTwoTurn [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 3. 3. 3. 3. 4 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2' }).
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Danny' isAt: 4 with: 1 in: aGame.
	self assert: 'Walter' isAt: 4 with: 1 in: aGame.
	aGame playNextTurn.
	self assert: 'Danny' isAt: 7 with: 1 in: aGame.
]

{ #category : #tests }
FirstVersionTest >> testFV10TurnsWhenThreeSpaceshipsArePlaying [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.


	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2'. 'card1'. 'card2'. }).

	aGame playNextTurn.
	self assert: 'Danny' isAt: 4 with: 1 in: aGame.

	aGame playNextTurn.
	self assert: 'Walter' isAt: 4 with: 1 in: aGame.

	aGame playNextTurn.
	self assert: 'Joseph' isAt: 4 with: 1 in: aGame.
]

{ #category : #tests }
FirstVersionTest >> testFV11WormholeGoesBackwards [

	| aGame wormholeTile3 wormholeTile5 aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	wormholeTile3 := Wormhole betweenTiles: { 3. 5 }.
	wormholeTile5 := Wormhole betweenTiles: { 5. 3 }.

	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          wormholeTile3.
				          Null create.
				          wormholeTile5.
				          Null create.
				          Null create }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: {4}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2'. 'card1'. 'card2'. }).

	aGame playNextTurn.

	self assert: 'Danny' isAt: 3 with: 1 in: aGame.
]

{ #category : #tests }
FirstVersionTest >> testFV12WormholeGoesForward [

	| aGame wormholeTile8 wormholeTile12 aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	wormholeTile8 := Wormhole betweenTiles: { 8. 12 }.
	wormholeTile12 := Wormhole betweenTiles: { 12. 8 }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          wormholeTile8.
				          Null create.
				          Null create.
				          Null create.
				          wormholeTile12.
				          Null create }
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: {7}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2'. 'card1'. 'card2'. }).

	aGame playNextTurn.

	self assert: 'Danny' isAt: 12 with: 1 in: aGame.
]

{ #category : #tests }
FirstVersionTest >> testFV13WormholeIsNotOnANormalTile [

	| aGame wormholeTile3 wormholeTile7 aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	wormholeTile3 := Wormhole betweenTiles: { 3. 7 }.
	wormholeTile7 := Wormhole betweenTiles: { 7. 3 }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          wormholeTile3.
				          Null create.
				          Null create.
				          Null create.
				          wormholeTile7 }
		          withMeasures: (Parsecs with: 10).

	aDie1 := LoadedDie of: {4}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2'. 'card1'. 'card2'. 'card1'. 'card2'. }).

	aGame playNextTurn.

self assert: 'Danny' isAt: 5 with: 1 in: aGame.
]
