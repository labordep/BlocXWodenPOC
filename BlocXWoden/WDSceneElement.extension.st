Extension { #name : #WDSceneElement }

{ #category : #'*BlocXWoden' }
WDSceneElement >> hasBlElement [
	"^ WDInteractiveSceneOSWindow new
		scene: self;
		camera: (WDCamera new asSceneNode position: (Vector3 x: 0 y: 0 z: 3));
		open"
		
	| blElement |
	blElement := BlWodenSceneElement2 new.
	blElement size: 1280@720.
	blElement scene: self.
	blElement camera: (WDCamera new asSceneNode position: (Vector3 x: 0 y: 0 z: 3)).
	^blElement
]
