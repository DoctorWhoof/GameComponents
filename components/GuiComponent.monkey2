
Namespace gamecomponents

Class GuiComponent Extends Component Abstract
	
	Const Type:=New ComponentType( "GuiComponent",0,Null )
	
	Private
	
	Global _mouse:Vec2f		'Allows a "local" mouse coordinate, that can be scaled if needed. Useful when rendering to a texture.
	Global _invertedMouse:Vec2f
	
	Global guiComponentMap := New Map< Entity, Stack<GuiComponent> >
	
	Public
	
	'**************************** Public Properties **************************** 
	
	Property InvertedYMouse:Vec2f()
		Return _invertedMouse
	End
	
	Property ScaledMouse:Vec2f()
		Return _mouse
	End
	
	'**************************** Public Functions *****************************
	
	Function GetStack:Stack<GuiComponent>( entity:Entity )
		Return guiComponentMap[ entity ]
	End
	
	
	Function Clear()
		guiComponentMap.Clear()
	End
	
	
	Function SetScaledMouse( coords:Vec2f, cameraViewport:Recti )
		_mouse = coords
		_invertedMouse = New Vec2f( _mouse.X, cameraViewport.Height - _mouse.y )
	End
	
	'***************************** Public Methods ****************************** 
	
	Method New( entity:Entity )
		Super.New( entity,Type )
		Local componentStack := guiComponentMap[ entity ]
		
		If Not componentStack
			guiComponentMap.Add( entity, New Stack<GuiComponent> )
			componentStack = guiComponentMap[ entity ]
		End
		
		componentStack.Add(Self)
		
		entity.Destroyed += Lambda()
			Print "Destroying " + entity.Name
			guiComponentMap[ entity ].Clear()
			guiComponentMap.Remove( entity )
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
