'This BMX file was edited with BLIde ( http://www.blide.org )
Function ENDGAME()
	CloseGNetHost(host)
	If isServer Then
		Sock.Close()
	End If
	MySQL.Close()
	xDeinitDraw()
	End
End Function

Function CheckServerList:TList()
	Local list:TList = New TList
	Local f:TStream = ReadFile(UserConfigDir + "serverlist.txt")
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

Function LoadPlayerName()
	Local f:TStream = ReadFile(UserConfigDir + "playername.txt")
	If Not f Then
		WritePlayerName("Player")
		Return
	End If
		PlayerName = ReadLine(f)
		CloseFile(f)
	Return
End Function
Function WritePlayerName(str:String)
	Local f:TStream = WriteFile(UserConfigDir + "playername.txt")
	WriteLine(f, str)
	CloseFile(f)
	PlayerName = str
End Function

Function MYSQL_CLEARTABLE()
	Local Query:String
	Local Result:TMySQLResult
	Query = "DELETE FROM `playersonline`;"
	Result = MySQL.Query(Query)
	MYSQL_Check(Result)
End Function
Function MYSQL_START()
	Local Query:String
	Local Result:TMySQLResult
	'connect
	MySQL = TMySQL.Create(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE)
	If Not MySQL Then
		DebugLog ("Error: Can't connect.")
		Notify "Connection to server was failed."
		End
	EndIf
End Function
Function MYSQL_INSERT(Name:String)
	Local Query:String
	Local Result:TMySQLResult
	Query = "INSERT INTO `playersonline` VALUES('" + Name + "')"
	Result = MySQL.Query(Query)
	MYSQL_Check(Result)
End Function
Function MYSQL_DELETE(Name:String)
	Local Query:String
	Local Result:TMySQLResult
	Query = "DELETE FROM `playersonline` WHERE `Name`='" + Name + "';"
	Result = MySQL.Query(Query)
	MYSQL_Check(Result)
End Function
Function MYSQL_FINDPLAYER:Int(Name:String)
	Local Query:String
	Local Result:TMySQLResult
	Local Row:TMySQLRow
	'find player
	Query = "SELECT `Name` FROM `playersonline` WHERE `Name`='" + Name + "';"
	Result = MySQL.Query(Query)
	MYSQL_Check(Result)
	Return Result.Rows
End Function
Function MYSQL_Check(Result:TMySQLResult)
	If Not Result Then
		Notify("Error: Query failed. " + MySQL.GetError())
		ENDGAME()
		End
	EndIf
End Function

Function UpdateMouse()
	_mx = xMouseX()
	_my = xMouseY()
	MouseOldButton = MouseNewButton
	MouseNewButton = xMouseDown(1)
End Function
Function MouseUp()
	If MouseOldButton = 1 And MouseNewButton = 0 Return 1
End Function

Function CheckMouse(x:Int, y:Int, width:Int = 0, height:Int = 0)
	If _mx >= x And _mx <= (x + width) And _my >= y And _my <= y + height Then
		Return True
	Else
		Return False
	EndIf
End Function

Function Dist:Double(p1:TEntity, p2:TEntity)
	Return Sqr((p2.x - p1.x) ^ 2 + (p2.y - p1.y) ^ 2 + (p2.z - p1.Z) ^ 2)
End Function

Function DistObj:Double(p1:Int, p2:Int)
	Return Sqr((xEntityX(p2) - xEntityX(p1)) ^ 2 + (xEntityY(p2) - xEntityY(p1)) ^ 2 + (xEntityZ(p2) - xEntityZ(p1)) ^ 2)
End Function

Function SortWindows()
	Local list:TList = New TList
	Local w:TWindow
	Local count = windows.count()
	Local k:Int = count - 1
	Local i
	For i = 1 To count
		For w = EachIn Windows
			If w.z = k Then
				list.AddLast(w)
				k = k - 1
			End If
		Next
	Next
	Windows = list
End Function
