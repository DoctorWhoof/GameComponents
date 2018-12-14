Namespace test

#Import "<std>"
Using std..

#Reflect std
#Reflect test

Function Main()
	'first object, Initial state
	Local s := New Test
	s.name = "Dave"
	s.health = 150.0
	s.axis = Axis.Z
	s.color= Color.Cyan
	s.speed = New Vec2f( 2.0, 2.0 )
	s.alive = True
	s.items = New String[] ( "Bag", "Lantern" )
	s.SaveState()
	s.PrintState()
	
	'second object, Initial state
	Local t := New Test
	t.name = "Bob"
	t.health = 100.0
	t.axis = Axis.X
	t.color= Color.Red
	t.speed = New Vec2f( 1.0, 0.0 )
	t.alive = True
	t.items = New String[] ( "Bag", "Hat", "Lantern" )
	t.sibling = s
	t.SaveState()
	t.PrintState()

	'New state	for second object
	t.name = "Larry"
	t.health = 250.0
	t.axis = Axis.Y
	t.color= Color.Green
	t.speed = New Vec2f( 0.0, 5.0 )
	t.alive = False
	t.items = New String[] ( "Flower" )
	t.sibling = Null
	t.PrintState()
	
	'Revert second object to initial state
	t.RestoreState()
	t.PrintState()
End


Class Test
	
	Field name :String
	Field health:Float
	Field axis:Axis
	Field color:Color
	Field speed:Vec2f
	Field alive:Bool
	Field items:String[]
	Field sibling :Test
	
	Private
	Field _state := New Map<String, Variant>

	Public
	Method SaveState()
		Local info := Self.DynamicType
		For Local d := Eachin info.GetDecls()
			If d.Gettable And d.Settable And Not d.Name.StartsWith( "_" )
				_state.Add( d.Name, d.Get( Self ) )
			End
		End
	End
	
	Method RestoreState()
		If Not _state.Empty
			Local info := Self.DynamicType
			For Local d := Eachin info.GetDecls()
				If d.Gettable And d.Settable And Not d.Name.StartsWith( "_" )
					d.Set( Self, _state[d.Name] )
				End
			End
		End
	End
	
	'This is ugly and not needed for save/restore functionality, just needed for this demo.
	Method PrintState()
		Local info := Self.DynamicType
		Print "~n" + info.Name
		For Local d := Eachin info.GetDecls()
			If d.Gettable And d.Settable And Not d.Name.StartsWith( "_" )
				Local value:= ""
				Select d.Type.Name
					Case "String" value =  String( d.Get( Self ) )
					Case "Float" value =  Float( d.Get( Self ) )
					Case "Bool" value = Bool( d.Get( Self ) )
					Case "std.geom.Vec2<monkey.types.Float>" value = Cast<Vec2f>( d.Get( Self ) )
					Case "std.graphics.Color" value = Cast<Color>( d.Get( Self ) )
					Case "std.geom.Axis" 
						Local a := Cast<Axis>( d.Get( Self ) )
						Select a
							Case Axis.X value = "Axis.X"
							Case Axis.Y value = "Axis.Y"
							Case Axis.Z value = "Axis.Z"
						End
					Case "String[]" 
						Local t := ""
						For Local i := Eachin Cast<String[]>( d.Get( Self ) )
							t += i + " "
						Next
						value = t
					Case "test.Test"
						Local v:= Cast<Test>( d.Get( Self ) )
						If v Then value = v.name Else value = "Null"
					Default value = d.Type.Name
				End
				Print "    " + d.Name + ": " + value
			End
		End
	End
	
End