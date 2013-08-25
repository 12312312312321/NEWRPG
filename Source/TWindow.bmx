'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TWindow
	Field x, y, width, height, hidden
	Field winmoving, winresizing
	Field winmoveoldmx, winmoveoldmy
	Field title:String
	Field windowbordersize:Int
	Field z:Int
	Method New()
		x = 10
		y = 10
		z = 0
		Windows.AddFirst(Self)
		width = 200
		height = 400
		windowbordersize = 0
		hidden = 0
		title = "New window"
	End Method
	Method Move()
		If winmoving = 1 Then
			x = _mx - width / 2
			y = _my
			MouseState = MOUSE_MOVING
		End If
		If MouseUp() Then
			winmoving = 0
			MouseState = MOUSE_NOTHING
		End If
		If xMouseDown(xMOUSE_LEFT) And CheckMouse(x, y, width, elementheight) And z = 0 And MouseState = MOUSE_NOTHING Then
			winmoving = 1
			SetForegroundWindow()
		End If
	End Method
	Method Resize()
		If xMouseDown(xMOUSE_LEFT) And CheckMouse(x + width - 5, y + height - 5, 5, 5) And MouseState = MOUSE_NOTHING Then
			winresizing = 1
			SetForegroundWindow()
		End If
		If MouseUp() Then
			winresizing = 0
			MouseState = MOUSE_NOTHING
		End If
		If winresizing = 1 Then
			width = _mx - x
			height = _my - y
			If width < elementheight * 10 Then width = elementheight * 10
			If height < elementheight * 5 Then height = elementheight * 5
			If width + x > xGraphicsWidth() Then width = xGraphicsWidth() - x
			If height + y > xGraphicsHeight() Then height = xGraphicsHeight() - y
			MouseState = MOUSE_RESIZING
		End If
	End Method
	Method close()
		If xMouseDown(xMOUSE_LEFT) And CheckMouse(x, y + height - elementheight, elementheight, elementheight) and MouseState = MOUSE_NOTHING  Then
			SetForegroundWindow()
			winmoving = 0
			winresizing = 0
			hidden = 1
		End If
	End Method
	Method draw()
		'грань
		xColor (0, 0, 0)
		xRect(x - windowbordersize, y - windowbordersize, width + windowbordersize * 2, height + windowbordersize * 2, True)
		'Само окно
		xColor (155, 0, 0)
		xRect(x, y, width, height, True)
		'заголовок
		xColor (255, 0, 0)
		xRect(x, y, width, elementheight, True)
		xColor(255, 255, 255)
		xText(x, y, title)
		'кнопка ресайза
		If winresizing Then xColor(0, 255, 0) Else xColor(255, 0, 0)
		xRect(x + width - spacewidth, y + height - spacewidth, spacewidth, spacewidth, True)
		'кнопка закрытия
		xColor (255, 0, 0)
		xRect(x, y + height - elementheight, elementheight, elementheight, True)
		xColor (255, 255, 255)
		xText(x + elementheight * 3, y + height - elementheight, z)
	End Method
	Method DrawMouseHint()
		'=наведение на кнопку закрытия и ресайза
		If CheckMouse(x, y + height - elementheight, elementheight, elementheight) Then
			xColor(0, 255, 0)
			xRect(_mx + 10, _my, 50, 20, True)
			xColor(0, 0, 0)
			xText(_mx + 35, _my + 1, "Close", True)
		End If
		If CheckMouse(x + width - spacewidth, y + height - spacewidth, spacewidth, spacewidth) Then
			xColor(0, 255, 0)
			xRect(_mx - 50, _my, 50, 20, True)
			xColor(0, 0, 0)
			xText(_mx - 25, _my + 1, "Resize", True)
		End If
	End Method
	Method Update()
		If hidden = 0 Then
			checkClick()
			Move()
			Resize()
			draw()
			close()
		End If
	End Method
	Method checkclick()
		If CheckMouse(x, y, width, height) And z <> 0 And xMouseDown(xMOUSE_LEFT) And MouseState = MOUSE_NOTHING Then
			SetForegroundWindow()
		End If
	End Method
	Method SetForegroundWindow()
		Local w:TWindow
		Local k:Int = 1
		For w = EachIn Windows
			If w = Self Then
				z = 0
			Else
				w.z = k
				k = k + 1
			End If
		Next
		SortWindows()
	End Method
End Type