Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
Card >> resolvesUsing: cardPlayResolver [

	self subclassResponsibility
]
