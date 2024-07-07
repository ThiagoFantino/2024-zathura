Class {
	#name : #FourthVersionTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
FourthVersionTest >> testFV01WhenACardIsUsedItGoesToTheDiscardDeck [

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
	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self assert: (aGame discardDecklength) equals:1.

]

{ #category : #tests }
FourthVersionTest >> testFV02WhenDeckIsEmptyDiscardDeckIsShuffledAndThatIsTheNewDeck [

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
	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self assert: (aGame discardDecklength) equals:1.

]
