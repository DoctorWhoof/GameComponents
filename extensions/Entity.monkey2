Namespace gamecomponents

Class Entity Extension
	
	'------------------------- Recursive methods that propagate to children. Called by Scene -------------------------
	
	
	Method Draw( canvas:Canvas )
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnDraw( canvas )
			Next
		End
		For Local child := Eachin Children
			child.Draw( canvas )
		Next
	End
	
	
	Method LateUpdate()
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnLateUpdate()
			Next
		End
		For Local child := Eachin Children
			child.LateUpdate()
		Next
	End
	
	
	Method Reset()
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnReset()
			Next
		End
		For Local child := Eachin Children
			child.Reset()
		Next
	End
	
	
	'------------------------- Collision events -------------------------
		
	
	Method CollisionEnter( body:RigidBody )
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnCollisionEnter( body )
			Next
		End
	End
	
	
	Method CollisionStay( body:RigidBody )
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnCollisionStay( body )
			Next
		End
	End
	
	
	Method CollisionLeave( body:RigidBody )
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnCollisionLeave( body )
			Next
		End
	End
	
	
	'------------------------- Mouse events -------------------------

	
	Method MouseOverEvent()
		Local guiStack := GuiComponent.GetStack( Self )
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseOver()
			Next
		End
	End
	
	
	Method MouseEnterEvent()
		Local guiStack := GuiComponent.GetStack( Self )
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseEnter()
			Next
		End
	End
	
	
	Method MouseLeaveEvent()
		Local guiStack := GuiComponent.GetStack( Self )
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseLeave()
			Next
		End
	End
	
	
	Method MouseClickEvent( button:MouseButton )
		Local guiStack := GuiComponent.GetStack( Self )
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseClick( button )
			Next
		End
	End
	
	
	Method MouseHoldEvent( button:MouseButton )
		Local guiStack := GuiComponent.GetStack( Self )
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseHold( button )
			Next
		End
	End
	
	
	Method MouseReleaseEvent( button:MouseButton )
		Local guiStack := GuiComponent.GetStack( Self )
		If guiStack
			For Local c := Eachin guiStack
				c.OnMouseRelease( button )
			Next
		End
	End
	
End
