Namespace gamecomponents


Class Canvas Extension
	
	Method DrawGameComponents( scene:Scene )
		For Local e := Eachin scene.GetRootEntities()
			
			Local guistack := GuiComponent.GetStack( e )
			If guistack
				For Local c := Eachin guistack
					c.OnDraw( Self )
				Next
			End
			
			Local gameStack := GameComponent.GetStack( e )
			If gameStack
				For Local c := Eachin gameStack
					c.OnDraw( Self )
				Next
			End
		Next
	End
	
End