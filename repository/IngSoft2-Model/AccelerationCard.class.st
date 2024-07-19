Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
AccelerationCard >> cancelEffectUsing: cardPlayResolver [

	cardPlayResolver cancelAcceleration: self
]

{ #category : #initialization }
AccelerationCard >> effect [

	^ 1
]

{ #category : #delegating }
AccelerationCard >> resolvesUsing: cardPlayResolver [

	cardPlayResolver resolveAnAccelerationCardPlay: self
]
