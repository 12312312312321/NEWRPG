'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem

Type TNetworkMonster Extends TNetworkEntity
	Field MonsterID:Int
	Field StartObj:Int
	Field target:Tnetworkplayer
	Field atkCountDown:Double
	Field AgroRange:Double
	Field atkRange:Double
	Field UniqueName:Int
	Method New()
		obj = xCopyMesh(MonsterMesh)
		xEntityColor(obj, 255, 0, 255)
		xEntityType(obj, TYPE_MONSTER, True)
		xEntityAddBoxShape(obj, 1)
		'xEntityAddCapsuleShape(obj, 1,)
		StartObj = xCreatePivot()
		AgroRange = 5.0
		atkRange = 1.0
		UniqueName = NetMonstersList.Count()
		NetMonstersList.AddLast(Self)
	End Method
	
	Function Create:TNetworkMonster(isNet = 0, NetObject:TGNetObject = Null)
		Local NM:TNetworkMonster = New TNetworkMonster
		NM.isNet = isNet
		If isNet = 0 Then
			NM.NetID = CreateGNetObject(host)
			NM.NetID.SetInt(NS.TypeEntity, TYPE_MONSTER)
			NM.NetID.SetInt(NS.MonsterUniqueName, NM.UniqueName)
		Else
			If NetObject = Null Then
				Notify("Net object(MONSTER) is NULL")
				ENDGAME()
			End If
			NM.NetID = NetObject
		End If
		Return NM
	End Function
	
	Method Remove()
		If isNet = 0 Then CloseGNetObject(NetID)
		xFreeEntity(obj)
		xFreeEntity(StartObj)
		NetMonstersList.Remove(Self)
	End Method
	
	Method UpdatePositionFromNET()
		Local newy:Double
		If NetID.GetFloat(NS.Y) < 1 Then newy = 1 Else newy = NetID.GetFloat(NS.Y)
		Position(NetID.GetFloat(NS.X), newy, NetID.GetFloat(NS.Z))
		xRotateEntity(obj, NetID.GetFloat(NS.anglex), NetID.GetFloat(NS.angley), NetID.GetFloat(NS.anglez) , 1)
	End Method
		
	Method UpdatePositionToNET()
		Local newy:Double
		If Y < 1 Then
			newy = 1
		Else
			newy = Y
		End If
		Position(X, newy, Z)
		NetID.SetFloat(NS.X, X)
		NetID.SetFloat(NS.Y, newy)
		NetID.SetFloat(NS.Z, Z)
		NetID.SetFloat(NS.anglex, xEntityPitch(obj, 1))
		NetID.SetFloat(NS.angley, xEntityYaw(obj, 1))
		NetID.SetFloat(NS.anglez, xEntityRoll(obj, 1))
	End Method
	
	Method SetID(id:Int)
		MonsterID = id
	End Method
	
	Method Atack(p:TNetworkPlayer)
		If atkCountDown <= 0 Then
			Local messaga:TGNetObject = CreateGNetObject(host)
			messaga.SetInt(NS.TypeEntity, TYPE_GNETMESSAGE)
			messaga.SetString(NS.messageObjectId, p.NetID.GetString(NS.PlayerName))
			messaga.SetFloat(NS.messageObjectHp, p.HP - 1.0)
			atkCountDown = 1
		End If
	End Method
	Method UpdateAtack()
		If atkCountDown <= 0 Then
			atkCountDown = 0
		Else
			atkCountDown = atkCountDown - 0.01
		End If
	End Method
	
	Method UpdateAgro(p:TNetworkPlayer)
		Target = p
		If DistObj(obj, Target.obj) > atkRange Then
			xPointEntity(obj, Target.obj)
			xMoveEntity(obj, 0, 0, 0.1)
		ElseIf DistObj(obj, Target.obj) <= atkRange Then
			Atack(Target)
		End If
		UpdateXYZ()
	End Method
	
	Method UpdateMoveReturning()
		Target = Null
		If DistObj(StartObj, obj) > 1 Then
			xPointEntity(obj, StartObj)
			xMoveEntity(obj, 0, 0, 0.1)
		Else
			Position(xEntityX(StartObj), xEntityY(StartObj), xEntityZ(StartObj))
		End If
		
		UpdateXYZ()
	End Method
	
End Type