Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
OverloadCard >> cancelEffectUsing: cardPlayResolver [

	cardPlayResolver cancelOverload: self
]

{ #category : #initialization }
OverloadCard >> effect [

	^ -2
]

{ #category : #delegating }
OverloadCard >> resolvesUsing: cardPlayResolver [

	cardPlayResolver resolveAnOverloadCardPlay: self
]
