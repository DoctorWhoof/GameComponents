Namespace gui3d

Class Entity Extension
	
	Method MouseOverEvent()
		If gui3d.componentMap[ Self ]
			For Local c := Eachin gui3d.componentMap[ Self ]
				c.OnMouseOver()
			Next
		End
	End
	
	
	Method MouseEnterEvent()
		If gui3d.componentMap[ Self ]
			For Local c := Eachin gui3d.componentMap[ Self ]
				c.OnMouseEnter()
			Next
		End
	End
	
	
	Method MouseLeaveEvent()
		If gui3d.componentMap[ Self ]
			For Local c := Eachin gui3d.componentMap[ Self ]
				c.OnMouseLeave()
			Next
		End
	End
	
	
	Method MouseClickEvent( button:MouseButton )
		If gui3d.componentMap[ Self ]
			For Local c := Eachin gui3d.componentMap[ Self ]
				c.OnMouseClick( button )
			Next
		End
	End
	
	
	Method MouseHoldEvent( button:MouseButton )
		If gui3d.componentMap[ Self ]
			For Local c := Eachin gui3d.componentMap[ Self ]
				c.OnMouseHold( button )
			Next
		End
	End
	
	
	Method MouseReleaseEvent( button:MouseButton )
		If gui3d.componentMap[ Self ]
			For Local c := Eachin gui3d.componentMap[ Self ]
				c.OnMouseRelease( button )
			Next
		End
	End
	
End
