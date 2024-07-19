Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
RedoCard >> resolvesUsing: cardPlayResolver [

	cardPlayResolver resolveARedoCardPlay: self
]
