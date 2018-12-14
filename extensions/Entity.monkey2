Namespace gamecomponents

Class Entity Extension

	Property Enabled:Bool()
		Return True				'temporary hack! Only affects components for now.
	Setter( value:Bool )
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.enabled = value
			Next
		End
		For Local child := Eachin Children
			child.Enabled = value
		Next
	End
		
	
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
	
	
	Method LateDraw( canvas:Canvas )
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnLateDraw( canvas )
			Next
		End
		For Local child := Eachin Children
			child.LateDraw( canvas )
		Next
	End
	
	
	Method LateUpdate()
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				If c.enabled Then c.OnLateUpdate()
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
				c.Reset()
			Next
		End
		For Local child := Eachin Children
			child.Reset()
		Next
	End
	
	
	'------------------------- Collision events -------------------------
		
	
	Method CollisionEnter( other:Entity )
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnCollisionEnter( other, Self )
			Next
		End
	End
	
	
	Method CollisionStay( other:Entity  )
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnCollisionStay( other, Self )
			Next
		End
	End
	
	
	Method CollisionLeave( other:Entity  )
		Local gameStack := GameComponent.GetStack( Self )
		If gameStack
			For Local c := Eachin gameStack
				c.OnCollisionLeave( other, Self )
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
