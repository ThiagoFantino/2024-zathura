Class {
	#name : #AllyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
AllyCard >> cancelEffectUsing: cardPlayResolver [

	cardPlayResolver cancelAlly: self
]

{ #category : #delegating }
AllyCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAnAllyCardPlay: self
]
