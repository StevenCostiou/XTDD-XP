"
I configure user ids and loggers for the XTDDXP first exploration.
"
Class {
	#name : 'XTDDXPConfigurator',
	#superclass : 'Object',
	#category : 'XTDDXP',
	#package : 'XTDDXP'
}

{ #category : 'configuration' }
XTDDXPConfigurator >> configureExperiment [

	EpMonitor disableDuring: [ 
		| concreteLogger |
		
		self flag: 'instantiate your logger'.
		concreteLogger := self newLogger.
		
		concreteLogger setExperiment: XTDDXPExperiment new.
		
		self flag: 'set the project name (will be the path on server)'.
		concreteLogger projectName: 'completion'.
		
		self flag: 'configure the logger'.
		concreteLogger participantUUID: 'xxx'.
		self spyClass logger: concreteLogger.
		
		self flag: 'configure the instrumentation'.
		"self instrumenterClass instrumentSystem."

		concreteLogger authorizeDataSending.
		 ]
]

{ #category : 'accessing' }
XTDDXPConfigurator >> instrumenterClass [
	^(self class environment at: #DSSpyInstrumenter)
]

{ #category : 'configuration' }
XTDDXPConfigurator >> newLogger [
	^(self class environment at: #DSEventRecorderLogger) new
]

{ #category : 'configuration' }
XTDDXPConfigurator >> removeERRecorderFromSettings [
	EREventRecorderSettings class compile:'urlSettingsOn: aBuilder 

	(aBuilder setting: #stringUrl)
		parent: #Tools;
		target: self;
		description: ''The default URL for the Event Recorder server.'';
		label: ''Event Recorder URL address''
'
	
]

{ #category : 'requests' }
XTDDXPConfigurator >> requestUserName [

	| input |
	input := UIManager default
		         request: 'Please provide your XTDD unique id:'
		         initialAnswer: ''.
	(#( nil '' ) includes: input) ifTrue: [ ^ self ].

	^ input
]

{ #category : 'accessing' }
XTDDXPConfigurator >> spyClass [
	^(self class environment at: #DSSpy)
]
