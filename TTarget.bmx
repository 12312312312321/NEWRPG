'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TTarget Extends TEntity
	Method New()
		obj = xCreateCube()
		xScaleEntity(obj, 0.1, 1.5, 0.1)
		xEntityColor(obj, 255, 150, 0)
		Position(0, 1, 0)
	End Method
	Method Location()
		If obj <> Null Then
			If cam <> Null Then
				xCameraPick(cam, _mx, _my)
				If xPickedEntity() = ground Then
					Local px:Float = xpickedx()
					Local py:Float = xpickedy()
					Local pz:Float = xpickedz()
					If px = 0 And py = 0 And pz = 0 Then
						xHideEntity(obj)
						X = 0
						Y = 1
						Z = 0
					Else
						xShowEntity(obj)
						X = px
						Y = 1
						Z = pz
					EndIf
					xPositionEntity (obj, X, 1, Z, 1)
				End If
			Else
				Notify ("Camera not found.")
				ENDGAME()
			EndIf
		Else
			Notify ("Target object not found.")
			ENDGAME()
		EndIf
	End Method
End Type