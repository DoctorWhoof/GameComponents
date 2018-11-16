
Namespace gui3d


Class GuiComponent Extends Component Abstract
	
	Const Type:=New ComponentType( "GuiComponent",0,Null )
	
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
