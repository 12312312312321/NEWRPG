'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TItemsWindow Extends TWindow
	Field Inventory:TInventory
	Field ScrollY:Int
	Field CountItems:Int
	Method New()
		hidden = 1
		title = "Inventory"
		width = elementheight * 10 + spacewidth * 2
		height = elementheight * 15 + spacewidth * 2 + elementheight
		windowbordersize = 2
	End Method
	Function Create:TItemsWindow(itype:Int, P:TNetworkPlayer)
		Local newi:TItemsWindow = New TItemsWindow
		newi.Inventory = TInventory.Create(itype)
		If itype = TYPE_MAIN_INVENTORY Then
			newi.title = "Main Inventory"
		ElseIf itype = TYPE_FAV_INVENTORY Then
			newi.title = "Additional Inventory"
		End If
		P.AllInventories.AddLast(newi)
		Return newi
	End Function
	Method Draw()
		Super.draw()
		'прямоугольник внутри окна где предметы отображаются
		xColor (255, 0, 0)
		xRect(x + spacewidth, y + elementheight + spacewidth, width - spacewidth * 2, height - elementheight * 2 - spacewidth * 2, True)
		'количество предметов
		xColor (255, 0, 0)
		xRect x + elementheight + spacewidth, y + height - elementheight, elementheight * 3, elementheight
		xColor 255, 255, 255
		xText x + elementheight + spacewidth + 2, y + height - elementheight + 1, Inventory.Count()
		
		Local k:TItem
		Local i:Int = 0
		Local ite_mymin = xGraphicsHeight()
		Local ite_mymax = 0
		Local scroll = (ScrollY * elementheight)
		Local sizeOfTitle = elementheight
		Local countOfItemsX = (width - spacewidth * 2) / elementheight
		Local ite_my:Int, ite_mx:Int
		'=========Нарисовать итемы
		For k = EachIn Inventory
			ite_mx = x + (i Mod countOfItemsX) * elementheight + spacewidth
			ite_my = y + sizeOfTitle + i / countOfItemsX * elementheight + spacewidth - scroll
			If ite_mymin > ite_my Then ite_mymin = ite_my
			If ite_mymax < ite_my Then ite_mymax = ite_my
			If ite_my > y + elementheight And ite_my < y + height - elementheight * 2 Then
				DrawItemPic(k, ite_mx, ite_my)
			EndIf
			i = i + 1
		Next
		
		'============= Скроллинг инвентаря =============
		If xKeyDown(xKEY_U) Then If ite_mymax > y + height - 2 * elementheight Then ScrollY = ScrollY + 1
		If xKeyDown(xKEY_Y) Then If ite_mymin < y + elementheight Then ScrollY = ScrollY - 1
		Local countOfItemsY = (height - 2 * elementheight) / elementheight
		Local ScrollYMax%
		If i Mod countOfItemsX = 0 Then
			ScrollYMax = i / countOfItemsX - countOfItemsY
		Else
			ScrollYMax = i / countOfItemsX - countOfItemsY + 1
		End If
		'============ Обрисовка скролинга =============
		Local scrolldisplay_width = 5
		Local scrolldisplay_height = 5
		Local scrolldisplay_minx = x + width - spacewidth
		Local scrolldisplay_miny = y + sizeOfTitle + spacewidth
		Local scrolldisplay_100 = (height - sizeOfTitle - spacewidth * 2 - elementheight - scrolldisplay_height)
		Local scrolldisplay_Y
		If ScrollYMax > 0 Then
			scrolldisplay_Y = scrolldisplay_miny + Float(Float(ScrollY) / Float(ScrollYMax)) * scrolldisplay_100
		Else
			scrolldisplay_Y = scrolldisplay_miny
		End If
		xColor (125, 125, 125)
		xRect (scrolldisplay_minx, scrolldisplay_miny, scrolldisplay_width, countOfItemsY * elementheight - 1, True)
		xColor (255, 255, 255)
		xRect(scrolldisplay_minx, scrolldisplay_Y, scrolldisplay_width, scrolldisplay_height, True)
		'==== debug
'		xColor 255, 255, 255
'		xText 0, 0, "ite_mymax: " + ite_mymax
'		xText 0, 20, " ite_mymin:" + ite_mymin
'		xText 0, 40, " ite_my:" + ite_my
'		xText 0, 60, "ite_mx: " + ite_mx
'		xText 0, 80, "countOfItemsX: " + countOfItemsX
'		xText 0, 100, "i: " + i
'		xText 0, 120, "ScrollY: " + ScrollY
'		xText 0, 140, "countOfItemsY: " + countOfItemsY
'		xText 0, 160, "maxscroll: " + ScrollYMax
		
		'================нарисовать информацию по наведению мышкой 
		i = 0
		Local itemdrawy:Int = 0
		For k = EachIn Inventory
			Local ite_mx = x + (i Mod countOfItemsX) * elementheight + spacewidth
			Local ite_my = y + sizeoftitle + i / countOfItemsX * elementheight + spacewidth - scroll
			If CheckMouse(ite_mx, ite_my, elementheight, elementheight) And ite_my > y + elementheight And ite_my < y + height - elementheight * 2 Then
				itemdrawy = DrawItemHint(itemdrawy, k, "ID: " + String(k.id))
				itemdrawy = DrawItemHint(itemdrawy, k, "Count: " + String(k.count))
				itemdrawy = DrawItemHint(itemdrawy, k, "Rare: " + String(k.rare))
				Local eff:TItemEffect
				If k.effects Then
					If k.effects.Count() Then
						For eff = EachIn k.effects
							itemdrawy = DrawItemHint(itemdrawy, k, eff.GetNameEffect(eff.id) + String(eff.value))
						Next
					End If
				End If
				If xMouseDown(xMOUSE_LEFT) And xKeyDown(xKEY_LSHIFT) Then
					k.checkdelete = 1
				ElseIf xMouseDown(xMOUSE_LEFT) And Not xKeyDown(xKEY_LSHIFT) And k.checkdelete = 1 Then
					k.checkdelete = 0
				ElseIf xMouseDown(xMOUSE_LEFT) And Not xKeyDown(xKEY_LSHIFT) And k.checkdelete = 0 And MOUSE_ITEM_DRAG = Null And MouseState = MOUSE_NOTHING Then
					MOUSE_ITEM_DRAG = k
					Inventory.Remove(k)
				End If
				
				If xMouseDown(xMOUSE_RIGHT) And k.checkdelete = 0 Then
					If k.id = ITEM_PACKET Then
						k.PacketExtract(Inventory)
					ElseIf k.id = ITEM_FAV_INVENTORY Then
						k.AddFavInventory(Inventory)
					End If
				End If
			EndIf
			If xKeyDown(xKEY_P) And k.checkdelete = 1 Then
				k.RemoveFromInventory(Inventory)
			End If
			i = i + 1
		Next
		'========Показать подсказки для кнопок по  наведению мыши
		DrawMouseHint()
	End Method
	Method DrawItemHint:Int(itemdrawy:Int, k:TItem, text:String)
		xColor (0, 255, 0)
		xRect(_mx, _my + itemdrawy * 17, elementheight * 5, 17, True)
		xColor (0, 0, 0)
		xText(_mx + 5, _my + itemdrawy * 17, text)
		Return itemdrawy + 1
	End Method
	Method Resize()
		Super.Resize()
		Local minXsize = elementheight * 10 + spacewidth * 2
		Local minYsize = elementheight * 5 + elementheight * 2 + spacewidth * 2
		If winresizing = 1 Then
			ScrollY = 0
			width = _mx - x
			width = width - (width - spacewidth * 2) Mod elementheight
			height = _my - y
			height = height - (height - spacewidth * 2 - elementheight * 2) Mod elementheight
			If width < minXsize Then width = minXsize
			If height < minYsize Then height = minYsize
		End If
	End Method
	Function CountCharsInString:Int(Str:String)
		Local StrTmp:String[] = Str.Split(Chr(10))
	 	Return StrTmp.Length
	End Function
End Type