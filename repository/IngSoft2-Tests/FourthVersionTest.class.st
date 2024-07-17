Class {
	#name : #FourthVersionTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
FourthVersionTest >> testFV01DeckHasALimitedAmountOfCards [

	| aGame aBoard aDie1 someSpaceships aDeck anAccelerationCard cardsDistribution cardsCollection |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anAccelerationCard := AccelerationCard new.

	cardsDistribution := Distribution with:
		                     { (ProbabilityAssigner
			                      with: anAccelerationCard
			                      and: 1) }.

	cardsCollection := cardsDistribution randomCollectionWith: 5.

	aDeck := Deck of: cardsCollection.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
	self assert: (aGame cardsHandOf: 'Walter') cardsInHand size equals: 2.
	self assert: aGame deckLength equals: 1
]

{ #category : #tests }
FourthVersionTest >> testFV02WhenAnInstantCardIsUsedItGoesToTheDiscardDeck [

	| aGame aBoard aDie1 someSpaceships aDeck aNitroCard cardsDistribution cardsCollection |
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
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	aNitroCard := NitroCard new.

	cardsDistribution := Distribution with:
		                     { (ProbabilityAssigner
			                      with: aNitroCard
			                      and: 1) }.

	cardsCollection := cardsDistribution randomCollectionWith: 5.

	aDeck := Deck of: cardsCollection.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.
	self assert: aGame discardDecklength equals: 0.

	aGame play: aNitroCard by: 'Danny' targetting: 'Danny'.

	aGame playNextTurn.

	aGame play: aNitroCard by: 'Walter' targetting: 'Walter'.

	aGame playNextTurn.

	self assert: 'Danny' isAt: 6 with: 1 in: aGame.
	self assert: 'Walter' isAt: 6 with: 1 in: aGame.
	self assert: aGame discardDecklength equals: 2
]

{ #category : #tests }
FourthVersionTest >> testFV03WhenDeckIsEmptyDiscardDeckIsShuffledAndThatIsTheNewDeck [

	| aGame aBoard aDie1 someSpaceships aDeck aNitroCard cardsDistribution cardsCollection |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          CardGiver new.
				          Null create }
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	aNitroCard := NitroCard new.

	cardsDistribution := Distribution with:
		                     { (ProbabilityAssigner with: aNitroCard and: 1) }.

	cardsCollection := cardsDistribution randomCollectionWith: 5.

	aDeck := Deck of: cardsCollection.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
	self assert: aGame deckLength equals: 1.
	self assert: aGame discardDecklength equals: 0.

	aGame play: aNitroCard by: 'Danny' targetting: 'Danny'.

	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 1.
	self assert: aGame deckLength equals: 1.
	self assert: aGame discardDecklength equals: 1.

	aGame playNextTurn.

	self assert: 'Danny' isAt: 6 with: 1 in: aGame.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
	self assert: aGame deckLength equals: 1.
	self assert: aGame discardDecklength equals: 0
]

{ #category : #tests }
FourthVersionTest >> testFV04DeckHasProbabilityOfOccurrence [

	| aGame aBoard aDie1 someSpaceships aDeck anAccelerationCard cardsDistribution cardsCollection anAllyCard anOverloadCard aCancellationCard aRedoCard aRepeatCard aNitroCard aLeakCard |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anAccelerationCard := AccelerationCard new.
	anAllyCard := AllyCard new.
	anOverloadCard := OverloadCard new.
	aCancellationCard := CancellationCard new.
	aRedoCard := RedoCard new.
	aRepeatCard := RepeatCard new.
	aNitroCard := NitroCard new.
	aLeakCard := LeakCard new.

	cardsDistribution := Distribution with: {
			                     (ProbabilityAssigner
				                      with: anAllyCard
				                      and: 0.20).
			                     (ProbabilityAssigner
				                      with: anOverloadCard
				                      and: 0.20).
			                     (ProbabilityAssigner
				                      with: aCancellationCard
				                      and: 0.20).
			                     (ProbabilityAssigner
				                      with: anAccelerationCard
				                      and: 0.20).
			                     (ProbabilityAssigner with: aRedoCard and: 0.10).
			                     (ProbabilityAssigner with: aRepeatCard and: 0).
			                     (ProbabilityAssigner
				                      with: aNitroCard
				                      and: 0.05).
			                     (ProbabilityAssigner with: aLeakCard and: 0.05) }.

	cardsCollection := cardsDistribution randomCollectionWith: 20.

	aDeck := Deck of: cardsCollection.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self
		assert: (cardsDistribution checkProbabilityOf: anAccelerationCard)
		equals: 20.
	self
		assert: (cardsDistribution checkProbabilityOf: anAllyCard)
		equals: 20.
	self
		assert: (cardsDistribution checkProbabilityOf: anOverloadCard)
		equals: 20.
	self
		assert: (cardsDistribution checkProbabilityOf: aCancellationCard)
		equals: 20.
	self
		assert: (cardsDistribution checkProbabilityOf: aRedoCard)
		equals: 10.
	self
		assert: (cardsDistribution checkProbabilityOf: aRepeatCard)
		equals: 0.
	self
		assert: (cardsDistribution checkProbabilityOf: aNitroCard)
		equals: 5.
	self
		assert: (cardsDistribution checkProbabilityOf: aLeakCard)
		equals: 5.

	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
	self assert: (aGame cardsHandOf: 'Walter') cardsInHand size equals: 2.
	self assert: aGame deckLength equals: 16
]

{ #category : #tests }
FourthVersionTest >> testFV05WhenSpaceshipUsesNitroCardItAddsThreeToTheTotalRollOfIt [

	| aGame aBoard aDie1 someSpaceships aDeck aNitroCard cardsDistribution cardsCollection |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	aNitroCard := NitroCard new.

	cardsDistribution := Distribution with:
		                     { (ProbabilityAssigner with: aNitroCard and: 1) }.

	cardsCollection := cardsDistribution randomCollectionWith: 5.

	aDeck := Deck of: cardsCollection.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.

	aGame play: aNitroCard by: 'Danny' targetting: 'Danny'.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Danny' isAt: 6 with: 1 in: aGame.
	self assert: 'Walter' isAt: 3 with: 1 in: aGame.
]

{ #category : #tests }
FourthVersionTest >> testFV06WhenSpaceshipUsesNitroCardItAlsoLastsForThreeTurns [

	| aGame aBoard aDie1 someSpaceships aDeck aNitroCard cardsDistribution cardsCollection |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 1. 1. 1. 1. 1. 1. 1. 1. 20 }.

	aNitroCard := NitroCard new.

	cardsDistribution := Distribution with:
		                     { (ProbabilityAssigner with: aNitroCard and: 1) }.

	cardsCollection := cardsDistribution randomCollectionWith: 5.

	aDeck := Deck of: cardsCollection.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.

	aGame play: aNitroCard by: 'Walter' targetting: 'Walter'.
	self assert: (aGame spaceshipCalled: 'Walter') nitroTurns equals: 3.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Walter' isAt: 5 with: 1 in: aGame.
	self assert: (aGame spaceshipCalled: 'Walter') nitroTurns equals: 2.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Walter' isAt: 9 with: 1 in: aGame.
	self assert: (aGame spaceshipCalled: 'Walter') nitroTurns equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Walter' isAt: 13 with: 1 in: aGame.
	self assert: (aGame spaceshipCalled: 'Walter') nitroTurns equals: 0.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Walter' isAt: 14 with: 1 in: aGame.
]

{ #category : #tests }
FourthVersionTest >> testFV07WhenSpaceshipUsesLeakCardItDuplicatesTheConsumptionOfFuel [

	| aGame aBoard aDie1 someSpaceships aDeck aLeakCard cardsDistribution cardsCollection |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	aLeakCard := LeakCard new.

	cardsDistribution := Distribution with:
		                     { (ProbabilityAssigner with: aLeakCard and: 1) }.

	cardsCollection := cardsDistribution randomCollectionWith: 5.

	aDeck := Deck of: cardsCollection.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 12.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 12.

	aGame play: aLeakCard by: 'Danny' targetting: 'Walter'.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Danny' isAt: 3 with: 1 in: aGame.
	self assert: 'Walter' isAt: 3 with: 1 in: aGame.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 10.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 8
]

{ #category : #tests }
FourthVersionTest >> testFV08LeakCardIsCancelledWhenSpaceshipRunsOutOfFuel [

	| aGame aBoard aDie1 someSpaceships aDeck aLeakCard cardsDistribution cardsCollection |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 1. 2. 1. 1. 1. 1. 3 }.

	aLeakCard := LeakCard new.

	cardsDistribution := Distribution with:
		                     { (ProbabilityAssigner with: aLeakCard and: 1) }.

	cardsCollection := cardsDistribution randomCollectionWith: 5.

	aDeck := Deck of: cardsCollection.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 6.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 6.

	aGame play: aLeakCard by: 'Danny' targetting: 'Walter'.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Danny' isAt: 3 with: 1 in: aGame.
	self assert: 'Walter' isAt: 3 with: 1 in: aGame.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 4.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 2.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Danny' isAt: 4 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 3.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Danny' isAt: 7 with: 1 in: aGame.
	self assert: 'Walter' isAt: 2 with: 1 in: aGame.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 0.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 5
]

{ #category : #tests }
FourthVersionTest >> testFV09LeakCardAlsoIsCancelledWhenSpaceshipUsesCancellationCard [

	| aGame aBoard aDie1 someSpaceships aDeck aLeakCard aCancellationCard |
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

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 12.

	aGame play: aLeakCard by: 'Danny' targetting: 'Walter'.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Danny' isAt: 3 with: 1 in: aGame.
	self assert: 'Walter' isAt: 3 with: 1 in: aGame.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 8.

	aGame play: aCancellationCard by: 'Walter' targetting: aLeakCard.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Danny' isAt: 5 with: 1 in: aGame.
	self assert: 'Walter' isAt: 5 with: 1 in: aGame.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 6
]

{ #category : #tests }
FourthVersionTest >> testFV10WhenDeckIsEmptyAndDiscardDeckIsEmptyNoCardsCanBeTaken [

	| aGame aBoard aDie1 someSpaceships aDeck anAllyCard cardsDistribution cardsCollection |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 3. 2. 2. 6 }.

	anAllyCard := AllyCard new.

	cardsDistribution := Distribution with:
		                     { (ProbabilityAssigner with: anAllyCard and: 1) }.

	cardsCollection := cardsDistribution randomCollectionWith: 4.

	aDeck := Deck of: cardsCollection.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
	self assert: aGame deckLength equals: 0.
	self assert: aGame discardDecklength equals: 0.


	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'It is not possible to pick a card because both decks are empty!'
]

{ #category : #tests }
FourthVersionTest >> testFV11WhenDiscardDeckIsEmptyAndACardFromDeckIsUsedBothEndUpEmpty [

	| aGame aBoard aDie1 someSpaceships aDeck aNitroCard cardsDistribution cardsCollection |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 3. 2. 2. 6 }.

	aNitroCard := NitroCard new.

	cardsDistribution := Distribution with:
		                     { (ProbabilityAssigner with: aNitroCard and: 1) }.

	cardsCollection := cardsDistribution randomCollectionWith: 4.

	aDeck := Deck of: cardsCollection.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
	self assert: aGame deckLength equals: 0.
	self assert: aGame discardDecklength equals: 0.

	aGame play: aNitroCard by: 'Danny' targetting: 'Walter'.

	self assert: aGame deckLength equals: 0.
	self assert: aGame discardDecklength equals: 1.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 1.

	aGame playNextTurn.
	self assert: aGame deckLength equals: 0.
	self assert: aGame discardDecklength equals: 0.
	self assert: (aGame cardsHandOf: 'Danny') cardsInHand size equals: 2.
]

{ #category : #tests }
FourthVersionTest >> testFV12OverloadCardGoesToDiscardDeckWhenItIsCancelled [

	| aGame aBoard aDie1 someSpaceships aDeck anOverloadCard aCancellationCard |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anOverloadCard := OverloadCard new.
	aCancellationCard := CancellationCard new.

	aDeck := LoadedDeck of: {
			         anOverloadCard.
			         aCancellationCard.
			         anOverloadCard.
			         aCancellationCard.
			         anOverloadCard }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame play: anOverloadCard by: 'Danny' targetting: 'Walter'.
	self assert: aGame discardDecklength equals: 0.

	aGame playNextTurn.
	aGame playNextTurn.

	aGame play: aCancellationCard by: 'Danny' targetting: anOverloadCard.
	self assert: aGame discardDecklength equals: 2
]

{ #category : #tests }
FourthVersionTest >> testFV13AllyCardGoesToDiscardDeckWhenItIsCancelled [

	| aGame aBoard aDie1 someSpaceships aDeck anAllyCard aCancellationCard |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anAllyCard := AllyCard new.
	aCancellationCard := CancellationCard new.

	aDeck := LoadedDeck of: {
			         anAllyCard.
			         aCancellationCard.
			         anAllyCard.
			         aCancellationCard.
			         anAllyCard.}.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame play: anAllyCard by: 'Danny' targetting: 'Walter'.
	self assert: aGame discardDecklength equals: 0.

	aGame playNextTurn.
	aGame playNextTurn.

	aGame play: aCancellationCard by: 'Danny' targetting: anAllyCard.
	self assert: aGame discardDecklength equals: 2
]

{ #category : #tests }
FourthVersionTest >> testFV14AccelerationCardGoesToDiscardDeckWhenItIsCancelled [

	| aGame aBoard aDie1 someSpaceships aDeck anAccelerationCard aCancellationCard |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anAccelerationCard := AccelerationCard new.
	aCancellationCard := CancellationCard new.

	aDeck := LoadedDeck of: {
			         anAccelerationCard.
			         aCancellationCard.
			         anAccelerationCard.
			         aCancellationCard.
			         anAccelerationCard.}.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame play: anAccelerationCard by: 'Danny' targetting: 'Walter'.
	self assert: aGame discardDecklength equals: 0.

	aGame playNextTurn.
	aGame playNextTurn.

	aGame play: aCancellationCard by: 'Danny' targetting: anAccelerationCard.
	self assert: aGame discardDecklength equals: 2
]

{ #category : #tests }
FourthVersionTest >> testFV15LeakCardGoesToDiscardDeckWhenItIsCancelled [

	| aGame aBoard aDie1 someSpaceships aDeck aLeakCard aCancellationCard |
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
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	aLeakCard := LeakCard new.
	aCancellationCard := CancellationCard new.

	aDeck := LoadedDeck of: {
			         aLeakCard.
			         aCancellationCard.
			         aLeakCard.
			         aCancellationCard.
			         aLeakCard.}.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame play: aLeakCard by: 'Danny' targetting: 'Walter'.
	self assert: aGame discardDecklength equals: 0.

	aGame playNextTurn.
	aGame playNextTurn.

	aGame play: aCancellationCard by: 'Danny' targetting: aLeakCard.
	self assert: aGame discardDecklength equals: 2
]

{ #category : #tests }
FourthVersionTest >> testFV16RepeatCardGoesToDiscardDeckAfterItIsUsed [

	| aGame aBoard aDie1 someSpaceships aDeck aRepeatCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new.
				          Null create }
		          withMeasures: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 6. 5. 3. 3. 20 }.

	aRepeatCard := RepeatCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.


	aGame playNextTurn.
	self assert: 'Danny' isAt: 7 with: 1 in: aGame.
	aGame playNextTurn.
	self assert: 'Danny' isAt: 7 with: 1 in: aGame.
	self assert: 'Walter' isAt: 2 with: 1 in: aGame.


	aGame play: aRepeatCard by: 'Walter' targetting: 'Danny'.
	self assert: aGame discardDecklength equals: 1.
	self assert: 'Danny' isAt: 3 with: 1 in: aGame.
	self assert: 'Walter' isAt: 2 with: 1 in: aGame.
]

{ #category : #tests }
FourthVersionTest >> testFV17RedoCardDiscardWhenItCopiesAPermanentCard [

	| aGame aBoard aDie1 someSpaceships aDeck anAccelerationCard aRedoCard aCancellationCard |
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
	aDie1 := LoadedDie of: { 3. 3. 3. 3. 6 }.

	anAccelerationCard := AccelerationCard new.
	aRedoCard := RedoCard new.
	aCancellationCard := CancellationCard new.

	aDeck := LoadedDeck of: {
			         anAccelerationCard.
			         aCancellationCard.
			         aRedoCard.
			         aCancellationCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.


	aGame play: anAccelerationCard by: 'Danny' targetting: 'all'.
	self assert: aGame discardDecklength equals: 0.

	aGame playNextTurn.

	aGame play: aRedoCard by: 'Walter' targetting: 'all'.
	self assert: aGame discardDecklength equals: 0.

	aGame
		play: aCancellationCard
		by: 'Danny'
		targetting: anAccelerationCard.
	self assert: aGame discardDecklength equals: 2
]

{ #category : #tests }
FourthVersionTest >> testFV18LeakCardCannotBePlayedWhenItIsNotSpaceshipTurnAsItIsAPermanentCard [

	| aGame aBoard aDie1 someSpaceships aDeck aLeakCard |
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
	aDie1 := LoadedDie of: { 3. 3. 3. 3. 6 }.

	aLeakCard := LeakCard new.

	aDeck := LoadedDeck of: {
			         aLeakCard.
			         aLeakCard.
			         aLeakCard.
			         aLeakCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: 'Danny' isAt: 1 with: 1 in: aGame.
	self assert: 'Walter' isAt: 1 with: 1 in: aGame.

	self
		should: [ aGame play: aLeakCard by: 'Walter' targetting: 'Danny' ]
		raise: Error
		withMessage: 'It is not your turn'
]
