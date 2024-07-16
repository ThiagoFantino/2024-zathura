Class {
	#name : #CardPlayResolver,
	#superclass : #Object,
	#instVars : [
		'game',
		'lastCardPlayed',
		'cardPlayer',
		'cardTarget',
		'nitroCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlayResolver class >> with: aGame [

	^ self new initializeWith: aGame
]

{ #category : #resolving }
CardPlayResolver >> cancelALeakCard: aCard [

	game setLeakToFalse.
]

{ #category : #resolving }
CardPlayResolver >> cancelANitroCard: spaceshipTurn [

	(game spaceshipCalled: spaceshipTurn name) nitroTurns == 0 ifTrue: [
		(game cardsHandOf: spaceshipTurn name) removeEffectOf:
			nitroCardPlayed ]
]

{ #category : #resolving }
CardPlayResolver >> cancelAnAccelerationCard: aCard [

	game cancelTheEffectOf: aCard
]

{ #category : #resolving }
CardPlayResolver >> cancelAnAllyCard: aCard [

	game setAllyToNil.
]

{ #category : #resolving }
CardPlayResolver >> cancelAnOverloadCard: aCard [

	game cancelTheEffectOf: aCard
]

{ #category : #initialization }
CardPlayResolver >> initializeWith: aGame [

	game := aGame
]

{ #category : #resolving }
CardPlayResolver >> resolve: aCardPlayed by: aPlayer targetting: anotherPalyer [

	cardPlayer := aPlayer.
	cardTarget := anotherPalyer.
	aCardPlayed uses: self
]

{ #category : #resolving }
CardPlayResolver >> resolveACancellationCardPlay: aCard [

	cardTarget cancelEffectUsing: self.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer.
	game addToDiscardDeck: aCard.
	game addToDiscardDeck: cardTarget
]

{ #category : #resolving }
CardPlayResolver >> resolveALeakCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	game activateLeakCardPenaltyOf: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayResolver >> resolveANitroCardPlay: aCard [

	game applyACardEffect: aCard to: cardTarget.
	game activateNitroTurnsOf: cardTarget.
	lastCardPlayed := aCard.
	nitroCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer.
	game addToDiscardDeck: aCard
]

{ #category : #resolving }
CardPlayResolver >> resolveARedoCardPlay: aCard [

	game addNewCard: lastCardPlayed to: cardPlayer.
	game play: lastCardPlayed by: cardPlayer targetting: cardTarget.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayResolver >> resolveARepeatCardPlay: aCard [

	game repeatLastEffectAppliedOn: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer.
	game addToDiscardDeck: aCard
]

{ #category : #resolving }
CardPlayResolver >> resolveAnAccelerationCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	game applyToAllSpaceShips: aCard.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayResolver >> resolveAnAllyCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	game setAnAllianceBewtween: cardPlayer and: cardTarget.
	game applyACardEffect: aCard to: cardPlayer.
	game applyACardEffect: aCard to: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayResolver >> resolveAnOverloadCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	game applyACardEffect: aCard to: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]
