Class {
	#name : #BlWodenSceneElement,
	#superclass : #BlElement,
	#instVars : [
		'scene',
		'camera',
		'formFrameBuffer',
		'formColorBuffer',
		'tickAnimation',
		'sceneRenderer'
	],
	#category : #BlocXWoden
}

{ #category : #drawing }
BlWodenSceneElement >> aeDrawOn: aeCanvas [

	self aeDrawOn: aeCanvas with: [

		"My position is applied before my transformation matrix,
		which may have an additional translation."
		aeCanvas pathTranslate: self position.
		self transformation aeApplyTo: aeCanvas.

		"self aeDrawEffectBelowGeometryOn: aeCanvas." "no effects"
		self aeDrawWodenSceneElementOn: aeCanvas.
		"self aeDrawEffectAboveGeometryOn: aeCanvas." "no effects"

		"self aeDrawChildrenOn: aeCanvas." "no children"
		
		]
]

{ #category : #drawing }
BlWodenSceneElement >> aeDrawOn: aeCanvas with: aBlockClosure [
	"No opacity management"
	
	aeCanvas restoreContextAfter: aBlockClosure
]

{ #category : #drawing }
BlWodenSceneElement >> aeDrawWodenSceneElementOn: aeCanvas [
	"Draw the woden scene as an image (texture)"

	| renderingSceneState form |
	renderingSceneState := self renderingSceneState.
	self renderRenderingSceneStateIntoFormFramebuffer: renderingSceneState.
	
	"self geometry aeApplyTo: aeCanvas element: self."
	form := formColorBuffer data.
	
	"Code inspired by AeCanvasTest>>renderForm"
	"aeCanvas pathScale: (aeCanvas extent / form extent) asFloatPoint."
	"aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangleTo: form extent ]."
	
	aeCanvas setBackgroundWithForm: form alpha: 1.0.
	"self border aeApplyTo: aeCanvas element: self."
	
	aeCanvas drawFigureAndPrepareToClip: (self hasChildren and: [ self clipChildren ]).
]

{ #category : #accessing }
BlWodenSceneElement >> camera [

	^ camera
]

{ #category : #accessing }
BlWodenSceneElement >> camera: aCameraNode [

	camera := aCameraNode ifNotNil: [ aCameraNode asSceneNode ]
]

{ #category : #drawing }
BlWodenSceneElement >> drawingSurfaceExtent [

	^ self extent ceiling
]

{ #category : #drawing }
BlWodenSceneElement >> initialize [ 

	super initialize.
	self camera: WDCamera new.
]

{ #category : #drawing }
BlWodenSceneElement >> renderRenderingSceneStateIntoFormFramebuffer: renderingSceneState [
	| drawingExtent |
	drawingExtent := self drawingSurfaceExtent.
	
	(formFrameBuffer isNil or: [ formFrameBuffer extent ~= drawingExtent ]) ifTrue: [
		formColorBuffer := WDTexture forReadedColorBufferWithExtent: drawingExtent.
		formFrameBuffer := WDFramebuffer forColorAttachment: formColorBuffer. 
	].

	self sceneRenderer renderSceneState: renderingSceneState intoFramebuffer: formFrameBuffer.

	
]

{ #category : #drawing }
BlWodenSceneElement >> renderingSceneState [
	| extent aspectRatio |
	scene ifNil: [ ^ nil ].
	camera ifNil: [ ^ nil ].
	extent := self extent.
	aspectRatio := extent x asFloat / extent y.
	^ (camera asCameraStateWithAspectRatio: aspectRatio) ifNotNil: [ :cameraState | scene asRenderingSceneWithCameraState: cameraState ]
]

{ #category : #accessing }
BlWodenSceneElement >> scene [

	^ scene
]

{ #category : #accessing }
BlWodenSceneElement >> scene: aWDScene [

	scene := aWDScene.
	scene ifNil:[
		tickAnimation ifNotNil: [ :e | e stop ].	
		^ self
	].
	
	"using an animation to have a framerate tick"
	tickAnimation ifNil:[ 
		tickAnimation := BlWDSceneStepAnimation new. 
		self addAnimation: tickAnimation.
		tickAnimation duration: (17 milliSeconds). "update has maximum of 60ips : 1000/60 => (50/3) ~ 16.6"
		tickAnimation beInfinite.
	].

	tickAnimation start.
]

{ #category : #drawing }
BlWodenSceneElement >> sceneRenderer [

	^ sceneRenderer ifNil: [ sceneRenderer := WDSceneRenderer current ]
]
