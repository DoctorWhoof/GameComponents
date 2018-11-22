Namespace myapp3d

#Import "../gamecomponents"
Using gamecomponents..


Class MyWindow Extends Window
	
	Field _scene:Scene
	Field _camera:Camera
	Field _light:Light
	
	Field _ground:Model
	Field _donut:Model
	Field _box:Model
	Field _ball:Model
	
	Method New( title:String="Simple mojo3d app",width:Int=1280,height:Int=720,flags:WindowFlags=WindowFlags.Resizable | WindowFlags.HighDPI )
		Super.New( title,width,height,flags )
	End
	
	Method OnCreateWindow() Override
		'************ create scene ************ 
		
		_scene=New Scene
		_scene.ClearColor = New Color( 0.2, 0.6, 1.0 )
		_scene.AmbientLight = _scene.ClearColor * 0.25
		_scene.FogColor = _scene.ClearColor
		_scene.FogNear = 1.0
		_scene.FogFar = 200.0
		
		'************ create camera ************ 
		
		_camera=New Camera( Self )
		_camera.AddComponent<FlyBehaviour>()
		_camera.Move( 0,2.5,-15 )
		_camera.FOV = 50
		
		'************ create light ************ 
		
		_light=New Light
		_light.CastsShadow=True
		_light.Rotate( 45, 45, 0 )
		
		'************ create ground ************ 
		
		Local groundBox:=New Boxf( -100,-1,-100,100,0,100 )
		Local groundMaterial:=New PbrMaterial( Color.Lime )
		_ground=Model.CreateBox( groundBox,1,1,1,groundMaterial )
		_ground.CastsShadow=False
		
		Local mat:=New PbrMaterial( Color.Red, 0.05, 0.2 )
		
		'************ create donut ************
		
		_donut=Model.CreateTorus( 2, 0.5, 48, 24, mat )
		_donut.Move( 0, 2.5, 0 )
		_donut.Name = "Donut"
		
		Local mouseTest1 := _donut.AddComponent<MouseTest>()
		mouseTest1.CreateCollider()
		
		'************ create box ************
		
		_box=Model.CreateBox( New Boxf(-1.5,-1.5,-1.5,1.5,1.5,1.5), 1, 1, 1, mat )
		_box.Move( -7.5, 2.5, 0 )
		_box.Name = "Box"
		
		Local mouseTest2 := _box.AddComponent<MouseTest>()
		mouseTest2.CreateCollider()
		
		'************ create ball ************
		
		_ball=Model.CreateSphere( 2.5, 32, 32, mat )
		_ball.Move( 7.5, 2.5, 0 )
		_ball.Name = "Ball"
		
		Local mouseTest3 := _ball.AddComponent<MouseTest>()
		mouseTest3.CreateCollider()
		
		'************ setup MouseTest class ************
		
		MouseTest.camera = _camera
		
	End
	
	
	Method OnRender( canvas:Canvas ) Override
		RequestRender()
		
		_donut.Rotate( .2,.4,.6 )
		_box.Rotate( .4,.2,.3 )
		_ball.Rotate( .6,.1,.9 )
		
		_scene.Update()
		_scene.UpdateGui3D( _camera, Mouse.Location )
		
		_camera.View = Self
		_camera.Render( canvas )
		
		canvas.DrawGameComponents( _scene )
		canvas.DrawText( "Mouse over objects to change color. Click to see output message.",0 ,0 )
	End
End


Function Main()
	New AppInstance
	New MyWindow
	App.Run()
End


'****************************************** Test Component ******************************************

Class MouseTest Extends GuiComponent
	
	Global camera:Camera

	Method New( e:Entity )
		Super.New( e )
	End
	
	Method CreateCollider( mask:Int = -1 )
		Local m := Cast<Model>( Entity )
		If m
			Local body := m.AddComponent<RigidBody>()
			body.Mass = 0
			body.Kinematic = True
			body.CollisionMask = mask
			
			Local collider := m.AddComponent<BoxCollider>()
			collider.Box = m.Mesh.Bounds
		End
	End
	
	Method OnMouseEnter() Override
		Entity.Color = Color.Black
	End
	
	Method OnMouseLeave() Override
		Entity.Color = Color.White
	End
	
	Method OnMouseClick( button:MouseButton ) Override
		Select button
			Case MouseButton.Left Print "Left button clicked on " + Entity.Name
			Case MouseButton.Middle Print "Middle button clicked on " + Entity.Name
			Case MouseButton.Right Print "Right button clicked on " + Entity.Name
		End
	End
	
	Method OnMouseRelease( button:MouseButton ) Override
		Select button
			Case MouseButton.Left Print "Left button released on " + Entity.Name
			Case MouseButton.Middle Print "Middle button released on " + Entity.Name
			Case MouseButton.Right Print "Right button released on " + Entity.Name
		End
	End
	
	Method OnDraw( canvas:Canvas ) Override
		Local pos := camera.ProjectToViewport( Entity.Position )
		canvas.DrawText( Entity.Name, pos.X, pos.Y )
	End
	
End
