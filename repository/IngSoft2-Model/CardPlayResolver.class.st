Class {
	#name : #CardPlayResolver,
	#superclass : #Object,
	#instVars : [
		'game',
		'lastCardPlayed',
		'cardUser',
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
CardPlayResolver >> cancelAcceleration: aCard [

	game cancelTheEffectOf: aCard
]

{ #category : #resolving }
CardPlayResolver >> cancelAlly: aCard [

	game setAllyToNil
]

{ #category : #resolving }
CardPlayResolver >> cancelLeak: aCard [

	game setLeakToFalse
]

{ #category : #resolving }
CardPlayResolver >> cancelNitro: spaceshipTurn [

	game cancel: nitroCardPlayed of: spaceshipTurn
]

{ #category : #resolving }
CardPlayResolver >> cancelOverload: aCard [

	game cancelTheEffectOf: aCard
]

{ #category : #initialization }
CardPlayResolver >> initializeWith: aGame [

	game := aGame
]

{ #category : #resolving }
CardPlayResolver >> resolve: aCardPlayed by: aSpaceship targetting: anotherSpaceship [

	cardUser := aSpaceship.
	cardTarget := anotherSpaceship.
	aCardPlayed uses: self
]

{ #category : #resolving }
CardPlayResolver >> resolveACancellationCardPlay: aCard [

	cardTarget cancelEffectUsing: self.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardUser.
	game addToDiscardDeck: aCard.
	game addToDiscardDeck: cardTarget
]

{ #category : #resolving }
CardPlayResolver >> resolveALeakCardPlay: aCard [

	game assertIsTurnOf: cardUser.
	game activateLeakCardPenaltyOf: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardUser
]

{ #category : #resolving }
CardPlayResolver >> resolveANitroCardPlay: aCard [

	game applyACardEffect: aCard to: cardTarget.
	game activateNitroTurnsOf: cardTarget.
	lastCardPlayed := aCard.
	nitroCardPlayed := aCard.
	game removeFromHand: aCard to: cardUser.
	game addToDiscardDeck: aCard
]

{ #category : #resolving }
CardPlayResolver >> resolveARedoCardPlay: aCard [

	game addNew: lastCardPlayed to: cardUser.
	game play: lastCardPlayed by: cardUser targetting: cardTarget.
	game removeFromHand: aCard to: cardUser
]

{ #category : #resolving }
CardPlayResolver >> resolveARepeatCardPlay: aCard [

	game repeatLastEffectAppliedOn: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardUser.
	game addToDiscardDeck: aCard
]

{ #category : #resolving }
CardPlayResolver >> resolveAnAccelerationCardPlay: aCard [

	game assertIsTurnOf: cardUser.
	game applyToAllSpaceShips: aCard.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardUser
]

{ #category : #resolving }
CardPlayResolver >> resolveAnAllyCardPlay: aCard [

	game assertIsTurnOf: cardUser.
	game setAnAllianceBewtween: cardUser and: cardTarget.
	game applyACardEffect: aCard to: cardUser.
	game applyACardEffect: aCard to: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardUser
]

{ #category : #resolving }
CardPlayResolver >> resolveAnOverloadCardPlay: aCard [

	game assertIsTurnOf: cardUser.
	game applyACardEffect: aCard to: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardUser
]
