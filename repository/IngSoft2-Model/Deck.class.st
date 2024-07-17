Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Deck class >> assertIsNotEmpty: someCards [

	someCards ifEmpty: [
		Error signal: 'Deck must have at least one card' ]
]

{ #category : #'instance creation' }
Deck class >> of: someCards [

	self assertIsNotEmpty: someCards.
	^ self new initializeOf: someCards
]

{ #category : #initialization }
Deck >> initializeOf: someCards [

	cards := someCards asOrderedCollection shuffled
]

{ #category : #initialization }
Deck >> isEmpty [

	^ cards isEmpty
]

{ #category : #accessing }
Deck >> length [

	^ cards size
]

{ #category : #playing }
Deck >> pick [

	| cardToPick |
	cards isEmpty ifTrue: [ Error signal: 'No cards to pick' ].
	cardToPick := cards first.
	cards remove: cardToPick.
	^ cardToPick
]
