Class {
	#name : #BlWodenSceneElement2,
	#superclass : #BlElement,
	#instVars : [
		'camera',
		'scene',
		'animation',
		'formFrameBuffer',
		'formColorBuffer'
	],
	#category : #BlocXWoden
}

{ #category : #initialization }
BlWodenSceneElement2 >> buildWDSceneBackground [

	| form b renderingSceneState |
	
	renderingSceneState := self renderingSceneState.
	renderingSceneState ifNil:[^ BlBackground transparent].
	self renderRenderingSceneStateIntoFormFramebuffer: renderingSceneState.
	form := formColorBuffer data.

	b := BlBackground image: (form copy).  
	^ b
]

{ #category : #initialization }
BlWodenSceneElement2 >> camera [

	^ camera
]

{ #category : #initialization }
BlWodenSceneElement2 >> camera: aCameraNode [

	camera := aCameraNode ifNotNil: [ aCameraNode asSceneNode ]
]

{ #category : #initialization }
BlWodenSceneElement2 >> drawingSurfaceExtent [

	^ self extent ceiling
]

{ #category : #initialization }
BlWodenSceneElement2 >> initialize [ 

	super initialize.
	self camera: WDCamera new.
]

{ #category : #initialization }
BlWodenSceneElement2 >> renderRenderingSceneStateIntoFormFramebuffer: renderingSceneState [
	| drawingExtent |
	drawingExtent := self drawingSurfaceExtent.
	
	(formFrameBuffer isNil or: [ formFrameBuffer extent ~= drawingExtent ]) ifTrue: [
		formColorBuffer := WDTexture forReadedColorBufferWithExtent: drawingExtent.
		formFrameBuffer := WDFramebuffer forColorAttachment: formColorBuffer. 
	].

	self sceneRenderer renderSceneState: renderingSceneState intoFramebuffer: formFrameBuffer.
]

{ #category : #initialization }
BlWodenSceneElement2 >> renderingSceneState [
	| extent aspectRatio |
	scene ifNil: [ ^ nil ].
	camera ifNil: [ ^ nil ].
	extent := self extent.
	extent y = 0 ifTrue:[ ^ nil ].
	aspectRatio := extent x asFloat / extent y.
	^ (camera asCameraStateWithAspectRatio: aspectRatio) ifNotNil: [ :cameraState | scene asRenderingSceneWithCameraState: cameraState ]
]

{ #category : #initialization }
BlWodenSceneElement2 >> scene [

	^ scene
]

{ #category : #initialization }
BlWodenSceneElement2 >> scene: aWDScene [

	scene := aWDScene.
	scene ifNil:[
		animation ifNotNil: [ :e | e stop ].	
		^ self
	].
	
	"using an animation to have a framerate tick"
	animation ifNil:[ 
		animation := BlWDSceneUpdateAnimation new. 
		self addAnimation: animation. 
		animation duration: (16 milliSeconds). "update has maximum of 60ips : 1000/60 => (50/3) ~ 17"
		animation beInfinite.
	].

	animation start.
]

{ #category : #initialization }
BlWodenSceneElement2 >> sceneRenderer [

	^ WDSceneRenderer current
]
