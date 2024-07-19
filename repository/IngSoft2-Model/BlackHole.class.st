Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
BlackHole >> triggeredBy: aSpaceship on: anEffectManager [

	anEffectManager applyBlackHoleEffectTo: aSpaceship
]
