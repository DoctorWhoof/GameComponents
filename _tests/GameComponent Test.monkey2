Namespace myapp

#Import "<std>"
#Import "<mojo>"
#Import "<mojo3d>"

#Import "../gamecomponents"

#Import "extensions/Model"
#Import "assets/"

Using std..
Using mojo..
Using mojo3d..

'---------------------------------------------- Main  ---------------------------------------------

Function Main()
	New AppInstance
	New MyWindow
	App.Run()
End

'------------------------------------ Test GameComponent class ------------------------------------

Class CollisionColor Extends GameComponent
	
	Method New( e:Entity )
		Super.New( e )
	End

	Method OnCollisionEnter( body:RigidBody ) Override
		Entity.Color = Color.Red
	End
	
	Method OnCollisionLeave( body:RigidBody ) Override
		Entity.Color = Color.White
	End
	
End

'------------------------------------------ Window class -------------------------------------------

Class MyWindow Extends Window
	
	Field _scene:Scene
	Field _camera:Camera
	Field _light:Light
	Field _ground:Model
	
	Field _res:Vec2i
	
	Method New()

		Super.New( "Banana banana",1440,810,WindowFlags.Resizable | WindowFlags.HighDPI )
		Layout="letterbox"
		_res = New Vec2i( Width, Height )
		
		'Scene
		_scene=Scene.GetCurrent()
		_scene.ClearColor = Color.Aluminum
		_scene.EnvColor = Color.Aluminum
		_scene.AmbientLight = New Color( 0.4, 0.25, 0.1 )
		_scene.CSMSplits = New Float[]( 1.0, 2.0, 4.0, 8.0 )
		
		_scene.FogColor = Color.Aluminum
		_scene.FogNear = 0.5
		_scene.FogFar = 20.0
		
		_scene.AddPostEffect( New FXAAEffect )
		
		'create camera
		_camera=New Camera
		_camera.Name="Camera"
		_camera.Near=.05
		_camera.Far=60
		_camera.FOV=60
		_camera.Move( 0,0.3,-1.2 )
		
		Local fly := New FlyBehaviour( _camera )
		fly.Speed = 0.02
		fly.RotSpeed = 0.5
		
		'create light
		_light=New Light
		_light.Color = New Color( 1.0, 0.9, 0.8 )
		_light.RotateX( 75,15 )
		_light.CastsShadow=true
		
		'create ground
		Local groundBox:=New Boxf( -100,-1,-100,100,0,100 )
		
		_ground=Model.CreateBox( groundBox,16,16,16,New PbrMaterial( Color.Aluminum * 1.25 ) )
		_ground.Name="Ground"
		
		Local groundCollider:=New BoxCollider( _ground )
		groundCollider.Box=groundBox
		
		Local groundBody:=New RigidBody( _ground )
		groundBody.Mass=0
		groundBody.CollisionGroup=64
		groundBody.CollisionMask=127

		'Models		
		Local banana:=Model.Load( "asset::banana.glb" )
		banana.AssignMaterialToHierarchy( PbrMaterial.Load( "asset::banana.pbr", TextureFlags.FilterMipmap ) )
		banana.Name="Banana"

		Local bananaCollider:=banana.AddComponent<CapsuleCollider>()
		bananaCollider.Axis = Axis.X
		bananaCollider.Radius = 0.02
		bananaCollider.Length = 0.2
		
		Local bananaBody:= banana.AddComponent<GameBody>()
		bananaBody.CollisionGroup=8
		bananaBody.CollisionMask=127
		bananaBody.Friction = 0.5
		bananaBody.RollingFriction = 0.02
		
		For Local n := 0 Until 500
			Local bananew := banana.Copy()
			bananew.Position = New Vec3f( Rnd(-2,2), Rnd(0.5,1.5), Rnd (-1, 1) )
			bananew.Rotation = New Vec3f( Rnd(-45,45), Rnd(-180,180), Rnd (-45,45) )
			bananew.AddComponent<CollisionColor>()
		Next
		
		_scene.World.Gravity = New Vec3f( 0, -4, 0 )
		banana.Visible = False
	End
	
	
	Method OnRender( canvas:Canvas ) Override
		RequestRender()
		_camera.View=Self
		_scene.Update()
		_scene.Render( canvas )
		canvas.Color = Color.Black
		canvas.DrawText( "Red bananas are in mid-collision", 20, 20 )
	End
	
	
	Method OnMeasure:Vec2i() Override
		Return _res
	End
	
End
