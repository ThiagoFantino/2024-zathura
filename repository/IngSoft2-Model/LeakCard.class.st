Class {
	#name : #LeakCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
LeakCard >> cancelEffectUsing: cardPlayResolver [

	cardPlayResolver cancelLeak: self
]

{ #category : #delegating }
LeakCard >> uses: cardPlayResolver [

	cardPlayResolver resolveALeakCardPlay:self
]
