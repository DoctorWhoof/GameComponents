
Namespace gui3d


Class GuiComponent Extends Component Abstract
	
	Const Type:=New ComponentType( "GuiComponent",0,Null )
	
	Private
	
	Global _mouse:Vec2f		'Allows a "local" mouse coordinate, that can be scaled if needed. Useful when rendering to a texture.
	Global _invertedMouse:Vec2f
	
	Public
	
	'**************************** Public Properties **************************** 
	
	Property InvertedYMouse:Vec2f()
		Return _invertedMouse
	End
	
	Property ScaledMouse:Vec2f()
		Return _mouse
	End
	
	'**************************** Public Functions *****************************
	
	Function SetScaledMouse( coords:Vec2f, cameraViewport:Recti )
		_mouse = coords
		_invertedMouse = New Vec2f( _mouse.X, cameraViewport.Height - _mouse.y )
	End
	
	'***************************** Public Methods ****************************** 
	
	Method New( entity:Entity )
		Super.New( entity,Type )
		Local componentStack := gui3d.componentMap[ entity ]
		
		If Not componentStack
			gui3d.componentMap.Add( entity, New Stack<GuiComponent> )
			componentStack = gui3d.componentMap[ entity ]
		End
		
		componentStack.Add(Self)
		
		entity.Destroyed += Lambda()
			Print "Destroying " + entity.Name
			gui3d.componentMap[ entity ].Clear()
			gui3d.componentMap.Remove( entity )
		End
	End
	
	
	Method OnMouseOver() Virtual
	End
	
	
	Method OnMouseEnter() Virtual
	End
	
	
	Method OnMouseLeave() Virtual
	End
	
	
	Method OnMouseClick( button:MouseButton ) Virtual
	End


	Method OnMouseHold( button:MouseButton ) Virtual
	End
	
	
	Method OnMouseRelease( button:MouseButton ) Virtual
	End
	
	
	Method OnDraw( canvas:Canvas ) Virtual
	End
	
	
End
