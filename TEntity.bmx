'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TEntity
	Field obj:Int
	Field X:Double
	Field Y:Double
	Field Z:Double
	Method New()
		X = 0
		Y = 0
		Z = 0
		obj = Null
	End Method
	Method Position(newx:Float = 0, newy:Float = 0, newz:Float = 0)
		xPositionEntity(obj, newX, newY, newZ)
		UpdateXYZ()
	End Method
	Method Move(dx:Float = 0, dy:Float = 0, dz:Float = 0)
		xMoveEntity(obj, dx, dy, dz)
		UpdateXYZ()
	End Method
	Method UpdateXYZ()
		X = xEntityX:Float(obj, 1)
		Y = xEntityY:Float(obj, 1)
		Z = xEntityZ:Float(obj, 1)
	End Method
End Type