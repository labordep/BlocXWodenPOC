Class {
	#name : #BaselineOfBlocXWoden,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocXWoden
}

{ #category : #baselines }
BaselineOfBlocXWoden >> baseline: spec [
	<baseline>
	
	spec
		for: #common
		do: [ 
			"Dependencies"
			self dependencies: spec.
			
			"Packages"
			spec
				package: 'BlocXWoden'.
		]
]

{ #category : #baselines }
BaselineOfBlocXWoden >> dependencies: spec [

	spec baseline: 'WodenCoreExamples' with: [ spec repository: 'github://labordep/woden-core-examples' ].
	spec baseline: 'Bloc' with: [ spec repository: 'github://pharo-graphics/Bloc:dev-1.0/src' ].

]
