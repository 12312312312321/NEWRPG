'This BMX file was edited with BLIde ( http://www.blide.org )
'============================================================ MAIN MENU ================================================================
Function CheckServerList:TList()
	Local list:TList = New TList
	Local f:TStream = ReadFile("serverlist.txt")
	If Not f Then
		Notify("Servers List not found.")
		ENDGAME()
	End If
	While Not f.Eof()
		list.AddLast(trim(f.ReadLine()))
	Wend
	CloseFile(f)
	Return list
End Function
'MainMenu главный цикл
Function MainMenuCycle()
	Local success:Int, sucess_q:Int
	Local JoinActive:Int = 0
	Local joinString:String
	Local joinServersCounter:Int = 0
	Local InputActive:Int = 0
	'================== socket, определение IP
	Local sock:TSocket = CreateTCPSocket()
	BindSocket(sock, 8086)
	SocketListen(sock)
	Local addressHost:String = DottedIP(HostIp(HostName(SocketLocalIP(sock))))
	sock.Close()
	addressClient = CheckServerList()
	Repeat
		If xAnimating(PlayerMesh) = 0 Then xAnimate(PlayerMesh, 1)
		UpdateMouse()
		xCls
		'========================= playername =================
		If CheckMouse(xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 - 66, 256, 32) Or InputActive Then
			xColor(255, 0, 0)
			xDrawImage(menu_btn, xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 - 66)
			If xMouseHit(xMOUSE_LEFT) Then
				If inputactive Then WritePlayerName(PlayerName)
				InputActive = Not InputActive
			End If
		Else
			xColor(0, 0, 0)
			xDrawImage(menu_btn, xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 - 66)
		End If
		If InputActive Then
			xDrawImage(menu_btn_active, xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 - 66)
			Local char:Int = xGetKey()
			If (char >= 48 And char <= 57) Or(char >= 65 And char <= 90) Or (char >= 97 And char <= 122) Then
				PlayerName = PlayerName + Chr(char)
			ElseIf char = 8 Then
				PlayerName = Left(PlayerName, PlayerName.Length - 1)
			ElseIf char = 13 Then
				WritePlayerName(PlayerName)
				InputActive = 0
			End If
			xColor(255, 0, 0)
			xText(xGraphicsWidth() / 2, xGraphicsHeight() / 2 - 58, "Login: " + PlayerName, 1)
		Else
			If PlayerName.Length = 0 Then PlayerName = "Player"
			xText(xGraphicsWidth() / 2, xGraphicsHeight() / 2 - 58, "Login: " + PlayerName, 1)
		End If
		'================================== CREATE GAME ==========================
		If CheckMouse(xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 - 33, 256, 32) Then
			xColor(255, 0, 0)
			xDrawImage(menu_btn_active, xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 - 33)
			If xMouseHit(xMOUSE_LEFT) Then
				success = GNetListen(host, port)
				If Not success Then
					Repeat
						sucess_q = Confirm("Not avaliable. Rehost?")
						If sucess_q Then
							success = GNetListen(host, port)
						Else
							Exit
						End If
						If success Then
							isServer = True
							MYSQL_CLEARTABLE()
							Exit
						End If
					Forever
				Else
					isServer = True
					MYSQL_CLEARTABLE()
					Exit
				End If
			End If
		Else
			xColor(0, 0, 0)
			xDrawImage(menu_btn, xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 - 33)
		End If
		xText(xGraphicsWidth() / 2, xGraphicsHeight() / 2 - 25, "Host on " + addressHost, 1)
		'================================== JOIN GAME ==========================
		If CheckMouse(xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2, 256, 32) Then
			xColor(255, 0, 0)
			xDrawImage(menu_btn_active, xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2)
			If xMouseHit(xMOUSE_LEFT) Then JoinActive = Not JoinActive
		Else
			xColor(0, 0, 0)
			xDrawImage(menu_btn, xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2)
		End If
		xText(xGraphicsWidth() / 2, xGraphicsHeight() / 2 + 7, "Join to...", 1)
		'==================================Exit Button==========================
		If CheckMouse(xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 + 32, 256, 32) Then
			xColor(255, 0, 0)
			xDrawImage(menu_btn_active, xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 + 33)
			If xMouseHit(xMOUSE_LEFT) Then End
		Else
			xColor(0, 0, 0)
			xDrawImage(menu_btn, xGraphicsWidth() / 2 - 125, xGraphicsHeight() / 2 + 33)
		End If
		xText(xGraphicsWidth() / 2, xGraphicsHeight() / 2 + 40, "Exit", 1)
		If JoinActive Then
			joinServersCounter = 0
			For joinstring = EachIn addressClient
				If CheckMouse(xGraphicsWidth() / 2 + 132, xGraphicsHeight() / 2 + 33 * joinServersCounter, 256, 32) Then
					xColor(255, 0, 0)
					xDrawImage(menu_btn_active, xGraphicsWidth() / 2 + 132, xGraphicsHeight() / 2 + 33 * joinServersCounter)
					If xMouseHit(xMOUSE_LEFT) Then
						success = TryConnect(JoinString)
					End If
				Else
					xColor(0, 0, 0)
					xDrawImage(menu_btn, xGraphicsWidth() / 2 + 132, xGraphicsHeight() / 2 + 33 * joinServersCounter)
				End If
				xText(xGraphicsWidth() / 2 + 260, xGraphicsHeight() / 2 + 7 + 33 * joinServersCounter, joinstring, 1)
				joinServersCounter = joinServersCounter + 1
			Next
			If success Then
				isServer = False
				Exit
			End If
		End If
		
		xFlushMouse()
		xFlip
	Forever
	Return
End Function
'Попытка соединения с сервером
Function TryConnect:Int(s:String)
	Local success, sucess_q
	success = GNetConnect(host, s, port, timeout_ms)
	If Not success Then
		Repeat
			sucess_q = Confirm("Not avaliable. Reconnect?")
			If sucess_q Then
				success = GNetConnect(host, s, port, timeout_ms)
			Else
				Return False
			End If
			If success Then Return True
		Forever
	Else
		Return True
	End If
End Function
