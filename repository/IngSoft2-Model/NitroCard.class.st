Class {
	#name : #NitroCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
NitroCard >> effect [

	^ 3
]

{ #category : #delegating }
NitroCard >> uses: cardPlayResolver [

	cardPlayResolver resolveANitroCardPlay:self
]
