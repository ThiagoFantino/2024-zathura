Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
RepeatCard >> resolvesUsing: cardPlayResolver [

	cardPlayResolver resolveARepeatCardPlay: self
]
