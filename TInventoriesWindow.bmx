'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TInventoriesWindow Extends TWindow
	Method New()
		hidden = 1
		title = "Inventories"
		width = elementheight * 10 + spacewidth * 2
		height = elementheight * 15 + spacewidth * 2 + elementheight
		windowbordersize = 2
	End Method
	Method draw()
		Super.draw()
		Local inv:TItemsWindow
		Local j:Int = 0
		For inv = EachIn AllInventories
			xColor(255, 255, 0)
			xResizeImage(ItemImg[ITEM_FAV_INVENTORY], elementheight, elementheight)
			Local i:Int = x + j Mod ((width - spacewidth * 2) / elementheight)* elementheight + spacewidth
			Local coef:Int
			If j > 0 Then coef = j / ((width - spacewidth * 2) / elementheight) * elementheight
			Local u:Int = (y + elementheight) + coef + spacewidth
			xDrawImage(ItemImg[ITEM_FAV_INVENTORY], i, u)
			If CheckMouse(i, u, elementheight, elementheight) Then
				If xMouseDown(xMOUSE_LEFT) Then inv.hidden = 0
				DrawInvHint(inv)
			End If
			j = j + 1
		Next
		'========Показать подсказки для кнопок по  наведению мыши
		DrawMouseHint()
	End Method
	Method DrawInvHint(inv:TItemsWindow)
		Local text:String
		If inv.Inventory.IType = TYPE_MAIN_INVENTORY Then
			text = "Main Inventory"
		ElseIf inv.Inventory.IType = TYPE_FAV_INVENTORY Then
			text = "Additional Inventory"
		End If
		xColor (0, 255, 0)
		xRect(_mx, _my, elementheight * 5, 17, True)
		xColor (0, 0, 0)
		xText(_mx + 5, _my, text)
	End Method
End Type
