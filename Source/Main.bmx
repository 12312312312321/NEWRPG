'blitzmax.com / Community / posts.php?topic = 81799
' blitzbasic.com / Community / posts.php?topic = 51171.
'=========================INITIALIZATION====================
LoadPlayerName()

xSetBlend(FI_ALPHABLEND)
font = xLoadFont("Book Antiqua", 12)
xSetFont(font)
'load mesh
PlayerMesh = xLoadAnimMesh(ModelsDir + "batman.b3d")
MonsterMesh = xLoadMesh(ModelsDir + "skelet2.b3d")
xHideEntity(PlayerMesh)
xHideEntity(MonsterMesh)
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
xEntityPickMode(ground, 1)
xEntityType(ground, TYPE_GROUND, True)
xEntityAddBoxShape(ground, 0)

'Стартовая точка
c = xCreateCone()

'Запоминание координат мыши в момент нажатия правой кнопки
Local mouseCameraX:Int, mouseCameraY:Int
'Скорость поворота камеры
Local cameraTurnSpeed:Double = 0

'===Инвентарь
Global ItemWindow:TItemsWindow = New TItemsWindow
ItemWindow.SetInventory(Player.Inventory)

Local LocalWindow:TWindow
'Главный цикл
Repeat
	'обновление управления
	updatemouse()
	If xKeyHit(xKEY_ESCAPE) Then
		Local sucess_q = Confirm("Хотите выйти?")
		If sucess_q Then Exit
	EndIf
	If xMouseHit(xMOUSE_MIDDLE) And isServer = True Then
		Local spt:TSpawnPoint = TSpawnPoint.Create(1, Rand(2, 5), Player.X, Player.Y + 1, Player.Z)
	EndIf
	If xMouseHit(xMOUSE_LEFT) Then
		If ItemWindow.CanClick() Then
			Player.T.Location()
			xAnimate(Player.obj, 1)
		End If
	End If
	If xMouseHit(xMOUSE_RIGHT) Then
		If ItemWindow.CanClick() Then
			mouseCameraX = xMouseX()
			mouseCameraY = xMouseY()
		End If
	End If
	cameraTurnSpeed = -xMouseXSpeed()
	If xMouseDown(xMOUSE_RIGHT) Then
		If ItemWindow.CanClick() Then
			xTurnEntity(Player.camerapivot, 0, cameraTurnSpeed, 0)
			xMoveMouse (mouseCameraX, mouseCameraY)
		End If
	End If
	If xKeyDown(xKEY_O) Then TItem.Create(ITEM_PACKET, Player.Inventory, 1, 1, Rand(0, 4))
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
	'sortwindows()
	For LocalWindow = EachIn Windows
		LocalWindow.Update()
	Next

	'вывод на экран
	xFlip()
Forever
If isServer Then Player.Remove()
ENDGAME()

Function sortwindows()
	Local win:TWindow
	Local list:TList = New TList
	Local count:Int = windows.Count()
	Local i:Int
	Local minwin:TWindow
	For i = 1 To count
		For win = EachIn Windows
			If minwin = Null Or minwin.z > win.z Then minwin = win
		Next
		list.AddLast(minwin)
		Windows.Remove(minwin)
	Next
	Windows = list
End Function

Function DrawGUI()
	Local p:TNetworkPlayer
	For p = EachIn NetPlayersList
		xCameraProject(cam, p.X, p.Y + 1, p.Z)
		xColor 255, 255, 255
		xText xProjectedX(), xProjectedY(), p.Name
	Next
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