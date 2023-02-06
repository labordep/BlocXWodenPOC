Class {
	#name : #WDBlExample,
	#superclass : #Object,
	#category : #BlocXWoden
}

{ #category : #examples }
WDBlExample class >> buildBlElement [

	| element |
	element := BlElement new
		geometry: (BlRoundedRectangleGeometry cornerRadius: 20);
		size: 300@300;
		background: (Color yellow alpha: 0.5);
		border: (BlBorder paint: Color red width: 7);
		yourself.	
	
	element addEventHandlerOn: BlClickEvent do: [ :e | element background: (Color random alpha: 0.5) ]. 
	"element addEventHandlerOn: BlMouseOutEvent do: [ :e | element background: (Color yellow alpha: 0.5) ]. "
		
	^element
]

{ #category : #private }
WDBlExample class >> buildWodenSceneExampleAnimatedCube [
	<script:'self buildWodenSceneExampleAnimatedCube inspect'>
	
	| cube animationTime scene |
	cube := (WDMeshBuilder new
		addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
		mesh) asSceneNode.
	animationTime := 0.0.
	scene := WDScene new
		add: cube;
		add: ((WDPointLightSource new
			color: (Vector3 x: 0.8 y: 0.8 z: 0.2);
			intensity: 5.0;
			influenceRadius: 4.0;
			asSceneNode)
				position: (Vector3 x: -1.5 y: 1.5 z: 1.6);
				yourself);
		updateBlock: [ :delta |
			animationTime := animationTime + delta.
			cube position: (Vector3 y: (animationTime * Float twoPi) sin * 1.5).
			true
	].
	
	^scene
]

{ #category : #private }
WDBlExample class >> convertWodenSceneToBlElementWithAlexandrie: aWDSceneElement [

	| blElement |
	blElement := aWDSceneElement hasBlElement.
	^ blElement
]

{ #category : #examples }
WDBlExample class >> openWodenSceneGraphInBlocSDL2Window [
	"This example open a SDL Bloc Window with a Woden scene graph for background"
	<script>
	| space scene blElement |
	
	"Create the Bloc Space and open it"
	space := BlSpace new.
	space host: BlOSWindowSDL2Host new.
	space title: 'Woden Scene Graph in Bloc SDL2 window'.
	space extent: 1280@720; position: 50@50.
	space show.
	
	"Create a woden scene graph and add it in the Bloc window"
	scene := self buildWodenSceneExampleAnimatedCube.
	
	"Convert the scene into a Bloc element with Alexandrie Backend display"
	blElement := self convertWodenSceneToBlElementWithAlexandrie: scene.
	space root addChild: blElement.
	
	blElement := self buildBlElement.
	blElement relocate: 300@50.
	space root addChild: blElement.
	
	^space
]

{ #category : #'see class side' }
WDBlExample >> seeClassSide [
]
