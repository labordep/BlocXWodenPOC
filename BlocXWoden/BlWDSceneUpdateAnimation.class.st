Class {
	#name : #BlWDSceneUpdateAnimation,
	#superclass : #BlAnimation,
	#instVars : [
		'previousLoop'
	],
	#category : #BlocXWoden
}

{ #category : #pulse }
BlWDSceneUpdateAnimation >> applyValue: aBoolean [
	"Change this animation to be at the point indicated by the argument. The argument is an object already interpolated."
	
	"Step the scene graph"
	self target ifNotNil:[ :e |
		e scene updateWithDeltaTime: (16 * 0.001).
		aBoolean ifTrue:[e background: e buildWDSceneBackground].	
	].
]

{ #category : #pulse }
BlWDSceneUpdateAnimation >> valueForStep: aNumber [
	"Answer an Object that corresponds to aNumber, which belongs to the [0,1] closed interval that ALREADY HAS the easing function applied."
	
	"Tick once" 
	previousLoop ifNil:[previousLoop := 0].
	previousLoop <= self loopCount ifTrue:[previousLoop := self loopCount copy. ^true] ifFalse:[^false].
]
