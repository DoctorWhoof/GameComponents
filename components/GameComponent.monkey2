
Namespace gamecomponents


Class GameComponent Extends Component Abstract
	
	Const Type:=New ComponentType( "GameComponent",0,Null )
	
	Private
	
	Global gameComponentMap := New Map< Entity, Stack<GameComponent> >
	
	Public
	
	'**************************** Public Properties **************************** 
	
	
	'**************************** Public Functions *****************************
	
	Function GetStack:Stack<GameComponent>( entity:Entity )
		Return gameComponentMap[ entity ]
	End
	
	
	Function Clear()
		gameComponentMap.Clear()
	End
	
	'***************************** Public Methods ****************************** 
	
	Method New( entity:Entity )
		Super.New( entity,Type )
		Local componentStack := gameComponentMap[ entity ]
		
		If Not componentStack
			gameComponentMap.Add( entity, New Stack<GameComponent> )
			componentStack = gameComponentMap[ entity ]
		End
		
		componentStack.Add(Self)
		
		entity.Destroyed += Lambda()
			Print "Destroying " + entity.Name
			gameComponentMap[ entity ].Clear()
			gameComponentMap.Remove( entity )
		End
	End
	
	'************************************* Virtual methods *************************************
	
	#Rem
	Inherited methods from Component class:	
		OnCopy:Component( entity:Entity )
		OnShow()
		OnHide()
		OnStart()
		OnBeginUpdate()
		OnUpdate( elapsed:Float )
		OnDestroy()
		OnCollide( body:RigidBody )
	#End
	
	'Called when drawing the scene to a specific canvas.
	Method OnDraw( canvas:Canvas ) Virtual
	End
	
	'Called after all entities have been updated
	Method OnLateUpdate() Virtual
	End
	
	'Called on Scene.Reset()
	Method OnReset() Virtual
	End
	
	'Called a single frame when collision starts
	Method OnCollisionEnter( body:RigidBody ) Virtual
	End
	
	'Called for every frame while a collision lasts
	Method OnCollisionStay( body:RigidBody ) Virtual
	End
	
	'Called a single frame when collision ends
	Method OnCollisionLeave( body:RigidBody ) Virtual
	End
	
	
	
	
End
