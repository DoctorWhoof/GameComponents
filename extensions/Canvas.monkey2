Namespace gui3d


Class Canvas Extension
	
	Method DrawGui3D( scene:Scene )
		For Local e := Eachin scene.GetRootEntities()
			Local guistack := gui3d.componentMap[ e ]
			If guistack
				For Local c := Eachin guistack
					c.OnDraw( Self )
				Next
			End
		Next
	End
	
	
End