'blitzmax.com / Community / posts.php?topic = 81799
' blitzbasic.com / Community / posts.php?topic = 51171.

' GNET simple dedicated server

' Create a new host. We call it listen because that's what it does

Local hosting = Proceed("Do you want to be host? (No = be client, Cancel = end)")
If hosting = -1 Then End
Local host:TGNetHost = CreateGNetHost()
Local port = 8086 ' users would normally choose one allowed through their firewall
Local address:String = "94.31.155.99"' loopback IP address for testing host & client on same machine
Local timeout_ms = 10000 ' client has 10 seconds to connect to host

Local success
If hosting Then
	success = GNetListen( host, port )
	If Not success Then RuntimeError "GNetListen failed"
Else
	success = GNetConnect( host, address$, port, timeout_ms )
	If Not success Then RuntimeError "GNetConnect failed"
EndIf

Print "Server started."
Local quit_server = False

	Local localObj:TGNetObject = CreateGNetObject:TGNetObject(host)
	Local remoteObj:TGNetObject
	Local objList:TList = New TList ' list of received, remote objects

	Local x = 0
	
xGraphics3D()
	
Local count
While Not quit_server
	xCls
	If xKeyHit(xKEY_P) Then x = x + 1
	If xKeyHit(xKEY_O) Then quit_server = True
	
	SetGNetInt (localObj, 0, x)
	
	GNetSync(host) ' Sync all created objects
	
	objList = GNetObjects(host, GNET_ALL)
	count = 0
	For remoteObj = EachIn objList
		xText(0, count * 12, String(GetGNetInt(remoteObj, 0)))
		count = count + 1
	Next
	
	xFlip
'	Local newpeer:TGNetPeer = GNetAccept( listen ) ' Is someone knocking on our port?
'	
'	If newpeer Then
'		' A new player wants to join us.
'		Print "New player"
'		Print "Players onnected at the moment:"
'		Local peerlist:TList = GNetPeers( listen )
'		
'		For Local p:TGNetPeer = EachIn peerlist
'			Print "  - "+DottedIP( SocketRemoteIP(GNetPeerTCPSocket( p )) )
'		Next
'		
'	EndIf
'	
'
'	' The stuff below isn't needed in this short tutorial. It just prints some debug information so we can see
'	' that the server is actually working. :)	
'
'	Local olist:TList = GNetObjects( listen ) ' Get all created objects in the game
'	
'	For Local o:TGnetObject = EachIn olist
'		
'		Local state = GNetObjectState( o ) ' Get the state of the object
'			
'		Select state
'			Case GNET_CREATED 'Object has been created
'				print "New object created"
'			Case GNET_SYNCED 'Object is in sync
'				' do something here if it is needed
'				' But the object is in sync and everything is just fine.
'			Case GNET_MODIFIED 'Object has been modified
'				' The object is modified! But no worries. It will be synced automagically.
'			Case GNET_CLOSED 'Object has been closed
'				Print "Connection closed to a peer"
'				' The object is no longer valid. The player left the game
'			Case GNET_MESSAGE 'Object is a message Object
'				' I haven't played around with this yet. So you need to read the manual
'				' yourself about this. ;)
'		
'		EndSelect
'		
'	Next

Wend
End