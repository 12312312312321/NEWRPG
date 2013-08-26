'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TNetworkPlayer Extends TNetworkEntity
	Field AllInventories:TManyInventories
	Field MP:Double
	Field Experience:Double
	Field CameraPivot:Int
	Field HP:Double
	Field Name:String
	Field LastAnimFrame:Int
	Field T:TTarget
	Method New()
		obj = xCopyEntity(PlayerMesh)
		CameraPivot = xCreatePivot()
		xEntityColor(obj, 0, 255, 0)
		xEntityType(obj, TYPE_PLAYER, True)
		'xEntityAddCapsuleShape(obj, 1)
		AllInventories = New TManyInventories
		T = New TTarget
		Position(0, 1, 0)
		HP = 100
		NetPlayersList.AddLast(Self)
	End Method
	
	Method UpdateXYZ()
		Super.UpdateXYZ()
		xPositionEntity(CameraPivot, xEntityX(obj, 1), xEntityY(obj, 1), xEntityZ(obj, 1), 1)
	End Method
		
	Function Create:TNetworkPlayer(isNet:Int = 0, NetObject:TGNetObject = Null)
		Local NP:TNetworkPlayer = New TNetworkPlayer
		NP.isNet = isNet
		If isNet = 0 Then
			NP.NetID = CreateGNetObject(host)
			NP.NetID.SetInt(NS.TypeEntity, TYPE_PLAYER)
			NP.NetID.SetString(NS.PlayerName, PlayerName)
			NP.Name = PlayerName
			'===Инвентарь
			TItemsWindow.Create(TYPE_MAIN_INVENTORY, NP)
		Else
			If NetObject = Null Then
				Notify("Net object (PLAYER) is NULL.")
				ENDGAME()
			End If
			NP.NetID = NetObject
			NP.Name = NP.NetID.GetString(NS.PlayerName)
		End If
		Return NP
	End Function
	Method Remove()
		If isNet = 0 Then
			CloseGNetObject(NetID)
			MYSQL_DELETE(PlayerName)
		End If
		CameraPivot = Null
		xFreeEntity(obj)
		NetPlayersList.Remove(Self)
	End Method
	
	Method UpdatePositionFromNET()
		Position(NetID.GetFloat(NS.X), NetID.GetFloat(NS.Y), NetID.GetFloat(NS.Z))
		xRotateEntity(obj, NetID.GetFloat(NS.anglex), NetID.GetFloat(NS.angley), NetID.GetFloat(NS.anglez) , 1)
		HP = NetID.GetFloat(NS.HP)
		LastAnimFrame = NetID.GetInt(NS.PlayerAnimFrame)
		xSetAnimFrame(obj, LastAnimFrame, 0)
	End Method
	Method UpdatePositionToNET()
		NetID.SetFloat(NS.X, X)
		NetID.SetFloat(NS.Y, Y)
		NetID.SetFloat(NS.Z, Z)
		NetID.SetFloat(NS.anglex, xEntityPitch(obj, 1))
		NetID.SetFloat(NS.angley, xEntityYaw(obj, 1))
		NetID.SetFloat(NS.anglez, xEntityRoll(obj, 1))
		NetID.SetFloat(NS.HP, HP)
		NetID.SetInt(NS.PlayerAnimFrame, LastAnimFrame)
	End Method
		
	Method MoveToTarget()
'		Local angle:Double = ATan2(y - t.y, x - t.x)
'		Local botspeed:Float = 0.01
'		Move(-Cos(angle) * botspeed, 0, Sin(angle) * botspeed)
		Local camanglex:Float, camangley:Float, camanglez:Float
		If Dist(T, Self) > 0.1 Then
			xShowEntity(T.obj)
			camanglex = xEntityPitch(cam, 1)
			camangley = xEntityYaw(cam, 1)
			camanglez = xEntityRoll(cam, 1)
			xPointEntity(obj, T.obj)
			xMoveEntity(obj, 0, 0, 0.1)
			xRotateEntity(obj, 0, xEntityYaw(obj, 1), 0, 1)
			LastAnimFrame = LastAnimFrame + 1
			LastAnimFrame = LastAnimFrame Mod 48
			xSetAnimFrame(obj, LastAnimFrame, 0)
			'If moving = False Then xAnimate(obj, 1)
		Else
			xPositionEntity(obj, T.X, 1, T.Z)
			LastAnimFrame = 0
			xAnimate(obj, 0)
			xSetAnimFrame(obj, 0, 0)
			xHideEntity(T.obj)
		EndIf
		UpdateXYZ()
	End Method
	
	Method Debug1()
		'xColor(255, 255, 255)
		'xText (0, 0, "HP " + HP + " MP " + MP + " EXP=" + Experience)
		'xText (0, 0, "Hp " + NetID.GetFloat(NS.HP))
		'xText (5, 20, "x" + X + " y" + Y + " z" + Z)
		'xText (5, 40, "netid " + PlayerName + " isnet=" + isNet)
	End Method
End Type