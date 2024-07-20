Class {
	#name : #DistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DistributionTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
DistributionTest >> testEffectDistributionSumOfProbabilitiesMustBeEqualToOne [

	| effectDistribution |
	self
		should: [
			effectDistribution := Distribution with: {
					                      (ProbabilityElement
						                       with: Null new
						                       and: 0.30).
					                      (ProbabilityElement
						                       with: BlackHole new
						                       and: 0.20).
					                      (ProbabilityElement
						                       with: (HyperGravity needsToThrow: 3)
						                       and: 0.20).
					                      (ProbabilityElement
						                       with: (MoonWalk backwardDistance: 3)
						                       and: 0.10).
					                      (ProbabilityElement
						                       with: CardGiver new
						                       and: 0.10).
					                      (ProbabilityElement
						                       with: (HyperJump of: { 3. 2. 1 })
						                       and: 0.08).
					                      (ProbabilityElement
						                       with: AtomicBomb new
						                       and: 0.03) } ]
		raise: Error
		withMessage: 'The sum of the probabilities must be equal to 1!'
]

{ #category : #tests }
DistributionTest >> testProbabilityEffectProbabilityMustBeBetwenZeroAndOne [

	self
		should: [ ProbabilityElement with: Null new and: 2 ]
		raise: Error
		withMessage: 'Probability must be between 0 and 1!'
]

{ #category : #tests }
DistributionTest >> testThatAtomicBombEffectHasTwoPercentProbability [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityElement
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityElement
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityElement
				                       with: atomicBombEffect
				                       and: 0.02) }.

	self
		assert: (effectDistribution checkProbabilityOf: atomicBombEffect)
		equals: 2
]

{ #category : #tests }
DistributionTest >> testThatBlackHoleEffectHasTwentyPercentProbability [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityElement
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityElement
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityElement
				                       with: atomicBombEffect
				                       and: 0.02) }.

		self
		assert: (effectDistribution checkProbabilityOf: blackHoleEffect)
		equals: 20
]

{ #category : #tests }
DistributionTest >> testThatCardGiverHasTenPercentProbability [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityElement
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityElement
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityElement
				                       with: atomicBombEffect
				                       and: 0.02) }.

	self
		assert: (effectDistribution checkProbabilityOf: cardGiverEffect)
		equals: 10
]

{ #category : #tests }
DistributionTest >> testThatHyperGravityEffectHasTwentyPercentProbability [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityElement
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityElement
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityElement
				                       with: atomicBombEffect
				                       and: 0.02) }.

		self
		assert: (effectDistribution checkProbabilityOf: hyperGravityEffect)
		equals: 20
]

{ #category : #tests }
DistributionTest >> testThatHyperJumpEffectHasEightPercentProbability [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityElement
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityElement
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityElement
				                       with: atomicBombEffect
				                       and: 0.02) }.

		self
		assert: (effectDistribution checkProbabilityOf: hyperJumpEffect)
		equals: 8
]

{ #category : #tests }
DistributionTest >> testThatMoonWalkEffectHasTenPercentProbability [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityElement
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityElement
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityElement
				                       with: atomicBombEffect
				                       and: 0.02) }.

		self
		assert: (effectDistribution checkProbabilityOf: moonWalkEffect)
		equals: 10
]

{ #category : #tests }
DistributionTest >> testThatNullEffectHasThirtyPercentProbability [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityElement
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityElement
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityElement
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityElement
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityElement
				                       with: atomicBombEffect
				                       and: 0.02) }.

	self
		assert: (effectDistribution checkProbabilityOf: nullEffect)
		equals: 30
]
