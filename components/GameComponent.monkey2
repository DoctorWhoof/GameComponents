
Namespace gamecomponents


Class GameComponent Extends Component Abstract
	
	Field enabled:= True
	
	Const Type:=New ComponentType( "GameComponent",0,Null )
	
	Private
	
	Field _state := New Map<String, Variant>
	
	Global _gameComponentMap := New Map< Entity, Stack<GameComponent> >
	
	Public
	
	'**************************** Public Properties **************************** 
	
	
	'**************************** Public Functions *****************************
	
	Function GetStack:Stack<GameComponent>( entity:Entity )
		Return _gameComponentMap[ entity ]
	End
	
	
	Function Clear()
		_gameComponentMap.Clear()
	End
	
	'***************************** Public Methods ****************************** 
	
	Method New( entity:Entity )
		Super.New( entity,Type )
		Local componentStack := _gameComponentMap[ entity ]
		
		If Not componentStack
			_gameComponentMap.Add( entity, New Stack<GameComponent> )
			componentStack = _gameComponentMap[ entity ]
		End
		
		componentStack.Add(Self)
		
		entity.Destroyed += Lambda()
			_gameComponentMap[ entity ]?.Clear()
			_gameComponentMap.Remove( entity )
		End
	End
	
	Method SaveState()
		_state = GetState()
	End
	
	Method RestoreState()
		CopyState( _state )
	End
	
	Method CopyState( state:Map<String,Variant> )
		If Not state.Empty
			Local info := Self.DynamicType
			Local decls := New Stack<DeclInfo>()
			decls.AddAll( info.GetDecls() )
			
			'Sort by [priority=n] metadata. Higher values are copied first.
			decls.Sort( Lambda:Int( a:DeclInfo, b:DeclInfo )
				Local aPriority := Int(a.GetMetaValue( "priority" ) )
				Local bPriority := Int( b.GetMetaValue( "priority" ) )
				Return bPriority <=> aPriority
			End )
			
			'Copies value, if key is present in map
'			Print "Copy: " + Entity.Name + "; " + info.Name
			For Local d := Eachin decls
				Local v := state[d.Name]
				If v
'					Print "    " + d.Name + ": " + d.Type.Name + " ; priority=" + Int(d.GetMetaValue( "priority" ))
					d.Set( Self, v )
				End
			End
		End
	End
	
	Method GetState:Map<String,Variant>()
		Local state:= New Map<String,Variant>
		Local info := Self.DynamicType
		For Local d := Eachin info.GetDecls()
			If d.Gettable And d.Settable And Not d.Name.StartsWith( "_" )
				state.Add( d.Name, d.Get( Self ) )
			End
		End
		Return state
	End
	
	
	Method GetSavedState:Map<String,Variant>()
		Return _state.Copy()
	End
	
	
	Method Reset()
		RestoreState()
		OnReset()
	End
	
	
	'************************************* Virtual methods *************************************
	
	#Rem
	Inherited methods from Component class:	
		OnCopy:Component( entity:Entity )
		OnShow()
		OnHide()
		OnStart()
		OnBeginUpdate()
		OnEndUpdate()
		OnUpdate( elapsed:Float )
		OnDestroy()
		OnCollide( body:RigidBody )
	#End
	
	'Called when drawing the scene to a specific canvas.
	Method OnDraw( canvas:Canvas ) Virtual
	End
	
	'Useful when drawing to two distinct canvases (for instance, one low res, one high res)
	Method OnLateDraw( canvas:Canvas ) Virtual
	End
	
	'Called after all entities have been updated
	Method OnLateUpdate() Virtual
	End
	
	'Called on Scene.Reset()
	Method OnReset() Virtual
	End
	
	'Called a single frame when collision starts
	Method OnCollisionEnter( other:Entity, this:Entity ) Virtual
	End
	
	'Called for every frame while a collision lasts
	Method OnCollisionStay( other:Entity, this:Entity ) Virtual
	End
	
	'Called a single frame when collision ends
	Method OnCollisionLeave( other:Entity, this:Entity ) Virtual
	End
	
End
