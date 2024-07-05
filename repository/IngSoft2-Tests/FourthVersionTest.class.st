Class {
	#name : #FourthVersionTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
FourthVersionTest >> testBanana [

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
		          withUnitsOfMeasurement: (Parsecs with: 10).
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

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	
	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.

]
