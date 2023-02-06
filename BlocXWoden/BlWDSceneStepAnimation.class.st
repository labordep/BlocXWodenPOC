"
This animation is used to step Woden Scene Graph and invalidate the BlElement
"
Class {
	#name : #BlWDSceneStepAnimation,
	#superclass : #BlAnimation,
	#category : #BlocXWoden
}

{ #category : #pulse }
BlWDSceneStepAnimation >> applyValue: aBoolean [
	"Change this animation to be at the point indicated by the argument. The argument is an object already interpolated."

	"Step the scene graph"
	self target ifNotNil:[ :e |
		((e scene updateWithDeltaTime: ((self duration asMilliSeconds) * 0.001)) and:[aBoolean]) ifTrue:[ 
			"e hasParent ifTrue: [ e parent invalidate ]"
			"e requestLayout."
			"e invalidate."
		].
	].
]

{ #category : #pulse }
BlWDSceneStepAnimation >> valueForStep: aNumber [
	"Answer an Object that corresponds to aNumber, which belongs to the [0,1] closed interval that ALREADY HAS the easing function applied."
	
	"Tick once"
	^ aNumber >= 1
]
