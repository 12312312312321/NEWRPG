'blitzmax.com / Community / posts.php?topic = 81799
' blitzbasic.com / Community / posts.php?topic = 51171.
'=========================INITIALIZATION====================
LoadPlayerName()

'xExtractAnimSeq(PlayerMesh, 1, 1, 1)
'xExtractAnimSeq(PlayerMesh, 2, 13, 2)

'координаты мыши
_mx = xMouseX()
_my = xMouseY()
'=============== MySQL =============================
MYSQL_START()
'цикл главного меню
MainMenuCycle()

Local mysql_finded:Int = MYSQL_FINDPLAYER(PlayerName)
If mysql_finded > 0 Then
	Notify("Reconnect another playername. This player is Online.")
	ENDGAME()
End If
MYSQL_INSERT(PlayerName)
'===================Создание объектов


'игрок и моснтры
Player:TNetworkPlayer = TNetworkPlayer.Create()

'камера и свет
cam = xCreateCamera()
xEntityParent(cam, Player.CameraPivot)
xPositionEntity (cam, 0, 5, -20)
xPointEntity(cam, Player.CameraPivot)
light = xCreateLight()
xEntityParent(light, cam)
xAmbientLight(20, 20, 20)

'временная переменная
Local c:Int

'Площадка земли
ground = xCreateCube()
xScaleEntity (ground, 1000, 1, 1000)
xPositionEntity (ground, 0, 0, 0)
xEntityPickMode(ground, PICK_BOX)
xEntityType(ground, TYPE_GROUND, True)
xEntityAddBoxShape(ground, 0)

'Стартовая точка
c = xCreateCone()

If isServer Then
	Sock = CreateTCPSocket()
	BindSocket(sock, portSocket)
	SocketListen(sock)
End If
'Главный цикл
Repeat
	'обновление управления
	updatemouse()
	If xKeyHit(xKEY_ESCAPE) Then
		Local sucess_q = Confirm("Хотите выйти?")
		If sucess_q Then Exit
	EndIf
	CheckMouseControl()
	If xKeyDown(xKEY_O) Then
		Local inv:TInventory = FindMainInventory()
		TItem.Create(ITEM_PACKET, inv, 1, 1, Rand(0, 4))
	End If
	If xKeyHit(xKEY_I) Then AllInventoriesWindow.hidden = Not AllInventoriesWindow.hidden
	If xKeyHit(xKEY_P) Then _AddFavInventory()
	If xKeyHit(xKEY_F1) Then DebugStop()
		
	'Движение игрока к цели
	Player.MoveToTarget()
	
	'обновление спаунпоинтов
	Local SpawnPoint:TSpawnPoint
	For SpawnPoint = EachIn NetSpawnsList
		SpawnPoint.CheckMonstersInRange()
	Next
	
	'обновление сетевых объектов
	UpdateToGnet()
	'сихнронизируем локальные объекты
	GNetSync(host)
	'получаем данные о новых (создаем) и старых (перемещаем) объектах
	UpdateFromGnet()

	xUpdateWorld()
	xRenderWorld()

	'рисование инвентаря
	DrawGUI()

	'вывод на экран
	xFlip()
Forever
If isServer Then Player.Remove()
ENDGAME()

Function DrawGUI()
	Local p:TNetworkPlayer
	Local LocalWindow:TWindow
	For p = EachIn NetPlayersList
		xCameraProject(cam, p.X, p.Y + 1, p.Z)
		xColor 255, 255, 255
		xText xProjectedX(), xProjectedY(), p.Name
	Next
	For LocalWindow = EachIn Windows
		LocalWindow.Update()
	Next
	If MOUSE_ITEM_DRAG Then
		DrawItemPic(MOUSE_ITEM_DRAG, _mx, _my)
	End If
End Function

Function UpdateToGnet()
	Local mindist1:Double, mindist2:Double
	Local NetPlayer:TNetworkPlayer
	Local NetPlayer2:TNetworkPlayer
	Player.UpdatePositionToNET()
	For monsters:TNetworkMonster = EachIn NetMonstersList
		If monsters.isNet = 0 Then
			monsters.UpdateAtack()
			For NetPlayer = EachIn NetPlayersList
				For NetPlayer2 = EachIn NetPlayersList
					mindist1 = Dist(NetPlayer, monsters)
					mindist2 = Dist(NetPlayer2, monsters)
					If mindist1 > monsters.AgroRange And mindist2 > monsters.AgroRange Or DistObj(monsters.obj, monsters.StartObj) > monsters.AgroRange Then
						monsters.UpdateMoveReturning()
					Else
						If mindist2 < mindist1 Then
							monsters.UpdateAgro(NetPlayer2)
						Else
							monsters.UpdateAgro(NetPlayer)
						End If
					End If
				Next
			Next
			monsters.UpdatePositionToNET()
		EndIf
	Next
End Function

Function UpdateFromGnet()
	Local remoteObj:TGNetObject
	Local NetPlayer:TNetworkPlayer
	Local NetMonster:TNetworkMonster
	Local PlayerFinded = False
	Local MonsterFinded = False
	objList = GNetObjects(host, GNET_ALL)
	For remoteObj = EachIn objList
		If remoteObj.GetInt(NS.TypeEntity) = TYPE_PLAYER Then
			'=============Поиск игрока================
			PlayerFinded = False
			For NetPlayer = EachIn NetPlayersList
				If NetPlayer.NetID.GetString(NS.PlayerName) = remoteObj.GetString(NS.PlayerName) Then
					PlayerFinded = True
				End If
			Next
			If PlayerFinded = False Then
				NetPlayer = TNetworkPlayer.Create(1, remoteObj)
			End If
			'==================Позиционирование удаленных игроков===========
			If NetPlayer.isNet Then NetPlayer.UpdatePositionFromNET()
		ElseIf remoteObj.GetInt(NS.TypeEntity) = TYPE_MONSTER Then
			MonsterFinded = False
			For NetMonster = EachIn NetMonstersList
				If NetMonster.NetID.GetInt(NS.MonsterUniqueName) = remoteObj.GetInt(NS.MonsterUniqueName) Then
					MonsterFinded = True
					Exit
				End If
			Next
			If MonsterFinded = False Then
				NetMonster = TNetworkMonster.Create(1, remoteObj)
			End If
			If DistObj(NetMonster.obj, Player.obj) < 20 Then
				NetMonster.UpdatePositionFromNET()
			End If
		ElseIf remoteObj.GetInt(NS.TypeEntity) = TYPE_GNETMESSAGE Then
			If Player.NetID.GetString(NS.PlayerName) = remoteObj.GetString(NS.messageObjectId) Then
				Player.HP = remoteObj.GetFloat(NS.messageObjectHp)
				remoteObj.Close()
			End If
		Else
			Notify("Unknown Packet.")
			ENDGAME()
		End If
	Next
	'получаем данные об удаленных объектах
	objListRemove = GNetObjects(host, GNET_CLOSED)
	For remoteObj = EachIn objListRemove
		If remoteObj.GetInt(NS.TypeEntity) = TYPE_PLAYER Then
			For NetPlayer = EachIn NetPlayersList
				If NetPlayer.NetID.GetString(NS.PlayerName) = remoteObj.GetString(NS.PlayerName) Then
					NetPlayer.Remove()
					If isServer Then
						MYSQL_DELETE(remoteObj.GetString(NS.PlayerName))
					End If
				End If
			Next
		ElseIf remoteObj.GetInt(NS.TypeEntity) = TYPE_MONSTER Then
			For NetMonster = EachIn NetMonstersList
				If NetMonster.NetID.GetInt(NS.MonsterUniqueName) = remoteObj.GetInt(NS.MonsterUniqueName) Then
					NetMonster.Remove()
				End If
			Next
		End If
	Next
End Function