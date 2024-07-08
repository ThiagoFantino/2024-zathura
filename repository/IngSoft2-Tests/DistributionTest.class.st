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
					                      (ProbabilityAssigner
						                       with: Null new
						                       and: 0.30).
					                      (ProbabilityAssigner
						                       with: BlackHole new
						                       and: 0.20).
					                      (ProbabilityAssigner
						                       with: (HyperGravity needsToThrow: 3)
						                       and: 0.20).
					                      (ProbabilityAssigner
						                       with: (MoonWalk backwardDistance: 3)
						                       and: 0.10).
					                      (ProbabilityAssigner
						                       with: CardGiver new
						                       and: 0.10).
					                      (ProbabilityAssigner
						                       with: (HyperJump of: { 3. 2. 1 })
						                       and: 0.08).
					                      (ProbabilityAssigner
						                       with: AtomicBomb new
						                       and: 0.03) } ]
		raise: Error
		withMessage: 'The sum of the probabilities must be equal to 1!'
]

{ #category : #tests }
DistributionTest >> testProbabilityEffectProbabilityMustBeBetwenZeroAndOne [

	self
		should: [ ProbabilityAssigner with: Null new and: 2 ]
		raise: Error
		withMessage: 'Probability must be between 0 and 1!'
]

{ #category : #tests }
DistributionTest >> testThatIfAtomicBombEffectHasTwoPercentProbabilityItHasBetweenZeroAndTwelveTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityAssigner
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityAssigner
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityAssigner
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = atomicBombEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
DistributionTest >> testThatIfBlackHoleEffectHasTwentyPercentProbabilityItHasBetweenTenAndFortyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityAssigner
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityAssigner
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityAssigner
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = blackHoleEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
DistributionTest >> testThatIfHyperGravityEffectHasTwentyPercentProbabilityItHasBetweenTenAndFortyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityAssigner
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityAssigner
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityAssigner
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = hyperGravityEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
DistributionTest >> testThatIfHyperJumpEffectHasEightPercentProbabilityItHasBetweenZeroAndEighteenTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityAssigner
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityAssigner
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityAssigner
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = hyperJumpEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
DistributionTest >> testThatIfMoonWalkEffectHasTenPercentProbabilityItHasBetweenZeroAndTwentyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityAssigner
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityAssigner
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityAssigner
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = moonWalkEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
DistributionTest >> testThatIfNullEffectHasFortyPercentProbabilityItHasBetweenThirtyAndSixtyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := Distribution with: {
			                      (ProbabilityAssigner
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityAssigner
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityAssigner
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityAssigner
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityAssigner
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = nullEffect ].

	self assert: (effectCount between: 0 and: 100)
]
