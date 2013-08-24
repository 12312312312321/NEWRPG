'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type NetSlot
	Field X:Int, Y:Int, Z:Int, HP:Int
	Field TypeEntity:Int
	Field anglex:Int, angley:Int, anglez:Int
	Field messageObjectId:Int, messageObjectHp:Int
	Field PlayerName:Int, MonsterUniqueName:Int
	Field PlayerAnimFrame
	Method New()
	'message 0-2,monster 0-8,player 0-8
		TypeEntity = 0
		X = 1
		messageObjectId = 1
		Y = 2
		messageObjectHp = 2
		Z = 3
		anglex = 4
		angley = 5
		anglez = 6
		HP = 7
		PlayerName = 8
		MonsterUniqueName = 8
		PlayerAnimFrame = 9
	End Method
End Type