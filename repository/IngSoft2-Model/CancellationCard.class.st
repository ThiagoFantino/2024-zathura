Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
CancellationCard >> resolvesUsing: cardPlayResolver [

	cardPlayResolver resolveACancellationCardPlay: self
]
