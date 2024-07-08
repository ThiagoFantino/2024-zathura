Class {
	#name : #FourthVersionTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
FourthVersionTest >> testFV01DeckHasALimitedAmountOfCards [

	| aGame aBoard aDie1 someSpaceships aDeck anAccelerationCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null new.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anAccelerationCard := AccelerationCard new.

	aDeck := Deck of: {
			         anAccelerationCard.
			         anAccelerationCard.
			         anAccelerationCard.
			         anAccelerationCard.
			         anAccelerationCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
	self assert: (aGame cardsHandOf: 'Walter') cardsInHand size equals: 2.
	self assert: aGame deckLength equals: 1
]

{ #category : #tests }
FourthVersionTest >> testFV02WhenACardIsUsedItGoesToTheDiscardDeck [

	| aGame aBoard aDie1 someSpaceships aDeck anAccelerationCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null new.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anAccelerationCard:=AccelerationCard new.

	aDeck := Deck of: {
			         anAccelerationCard.
			         anAccelerationCard.
			         anAccelerationCard.
			         anAccelerationCard.
						anAccelerationCard.}.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame discardDecklength) equals:0.
	
	aGame play: anAccelerationCard  by:'Danny'  targetting: 'all'.
	
	aGame playNextTurn.
	
	aGame play: anAccelerationCard  by:'Walter'  targetting: 'all'.
	
	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.
	self assert: (aGame discardDecklength) equals:2.

]

{ #category : #tests }
FourthVersionTest >> testFV02WhenDeckIsEmptyDiscardDeckIsShuffledAndThatIsTheNewDeck [

	| aGame aBoard aDie1 someSpaceships aDeck anAccelerationCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          CardGiver new.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anAccelerationCard := AccelerationCard new.

	aDeck := Deck of: {
			         anAccelerationCard.
			         anAccelerationCard.
			         anAccelerationCard.
			         anAccelerationCard.
			         anAccelerationCard }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
	self assert: aGame deckLength equals: 1.
	self assert: aGame discardDecklength equals: 0.

	aGame play: anAccelerationCard by: 'Danny' targetting: 'all'.

	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 1.
	self assert: aGame deckLength equals: 1.
	self assert: aGame discardDecklength equals: 1.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
	self assert: aGame deckLength equals: 1.
	self assert: aGame discardDecklength equals: 0
]

{ #category : #tests }
FourthVersionTest >> testFV03WhenSpaceshipUsesNitroCardItAddsThreeToTheTotalRollOfIt [

	| aGame aBoard aDie1 someSpaceships aDeck aNitroCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null new.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	aNitroCard:=NitroCard new.

	aDeck := Deck of: {
			         aNitroCard.
			         aNitroCard.
			         aNitroCard.
			         aNitroCard.
						aNitroCard.}.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	
	aGame play: aNitroCard  by:'Danny'  targetting: 'Danny'.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.

]

{ #category : #tests }
FourthVersionTest >> testFV04WhenSpaceshipUsesNitroCardItAlsoLastsForThreeTurns [

	| aGame aBoard aDie1 someSpaceships aDeck aNitroCard |
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
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 1. 1. 1. 1. 1. 1. 1. 1. 20 }.

	aNitroCard := NitroCard new.

	aDeck := Deck of: {
			         aNitroCard.
			         aNitroCard.
			         aNitroCard.
			         aNitroCard.
			         aNitroCard }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame play: aNitroCard by: 'Walter' targetting: 'Walter'.
	self assert: (aGame spaceshipCalled: 'Walter') nitroTurns equals: 3.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') nitroTurns equals: 2.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Walter') position equals: 9.
	self assert: (aGame spaceshipCalled: 'Walter') nitroTurns equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Walter') position equals: 13.
	self assert: (aGame spaceshipCalled: 'Walter') nitroTurns equals: 0.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Walter') position equals: 14.
]

{ #category : #tests }
FourthVersionTest >> testFV05WhenSpaceshipUsesLeakCardItDuplicatesTheConsumptionOfFuel [

	| aGame aBoard aDie1 someSpaceships aDeck aLeakCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null new.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	aLeakCard:=LeakCard new.

	aDeck := Deck of: {
			         aLeakCard.
			         aLeakCard.
			         aLeakCard.
			         aLeakCard.
						aLeakCard.}.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel equals: 12.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel equals: 12.
	
	aGame play: aLeakCard  by:'Danny'  targetting: 'Walter'.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel equals: 10.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel equals: 8.

]

{ #category : #tests }
FourthVersionTest >> testFV06LeakCardIsCancelledWhenSpaceshipRunsOutOfFuel [

	| aGame aBoard aDie1 someSpaceships aDeck aLeakCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null new.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 1. 2. 1. 1. 1. 1. 3.}.

	aLeakCard:=LeakCard new.

	aDeck := Deck of: {
			         aLeakCard.
			         aLeakCard.
			         aLeakCard.
			         aLeakCard.
						aLeakCard.}.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel equals: 6.
	
	aGame play: aLeakCard  by:'Danny'  targetting: 'Walter'.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel equals: 2.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel equals: 6.
	
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel equals: 0.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel equals: 5.
	
	
]

{ #category : #tests }
FourthVersionTest >> testFV07LeakCardAlsoIsCancelledWhenSpaceshipUsesCancellationCard [

	| aGame aBoard aDie1 someSpaceships aDeck aLeakCard  aCancellationCard |
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
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	aLeakCard := LeakCard new.
	aCancellationCard := CancellationCard new.

	aDeck := LoadedDeck of: {
			         aLeakCard.
			         aCancellationCard.
			         aLeakCard.
			         aCancellationCard }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel equals: 12.

	aGame play: aLeakCard by: 'Danny' targetting: 'Walter'. 

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel equals: 8.

	aGame play: aCancellationCard by: 'Walter' targetting:aLeakCard. 
	
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel equals: 6.
]
