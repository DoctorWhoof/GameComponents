Namespace gui3d

Class Entity Extension
	
	Method MouseOverEvent()
		Local guiStack := gui3d.componentMap[ Self ]
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseOver()
			Next
		End
	End
	
	
	Method MouseEnterEvent()
		Local guiStack := gui3d.componentMap[ Self ]
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseEnter()
			Next
		End
	End
	
	
	Method MouseLeaveEvent()
		Local guiStack := gui3d.componentMap[ Self ]
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseLeave()
			Next
		End
	End
	
	
	Method MouseClickEvent( button:MouseButton )
		Local guiStack := gui3d.componentMap[ Self ]
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseClick( button )
			Next
		End
	End
	
	
	Method MouseHoldEvent( button:MouseButton )
		Local guiStack := gui3d.componentMap[ Self ]
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseHold( button )
			Next
		End
	End
	
	
	Method MouseReleaseEvent( button:MouseButton )
		Local guiStack := gui3d.componentMap[ Self ]
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseRelease( button )
			Next
		End
	End
	
End
