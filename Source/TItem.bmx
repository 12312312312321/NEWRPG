'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TItem
	Field id:Int
	Field rare:Int
	Field effects:TList
	Field count:Int
	Field checkdelete:Int
	Field stacked:Int
	Function Create:TItem(ID:Int, Inventory:TInventory, stacked:Int = 0, count:Int = 1, rare:Int = 0)
		'проверка на аналогичные предметы
		Local items:TItem
		For items = EachIn Inventory
			If items.ID = ID And stacked = True And rare = items.rare Then
				items.count = items.count + count
				Return items
			End If
		Next
		'создание предмета
		Local Item:TItem = New TItem
		Item.effects = New TList
		Item.checkdelete = 0
		Item.stacked = stacked
		Item.rare = rare
		Local Luck:Int = Rand(0, 100)
		Local Chance:Int
		Local CountEffects:Int
		Local LuckMax:Int
		Select rare
			Case ITEM_RARE_NORMAL
				Chance = 20
			Case ITEM_RARE_MAGICAL
				Chance = 40
			Case ITEM_RARE_RARE
				Chance = 60
			Case ITEM_RARE_CRYSTALL
				Chance = 80
			Case ITEM_RARE_PERFECT
				Chance = 95
		End Select
		LuckMax = 100 - Chance
		CountEffects = Int((rare + 1) * Luck / LuckMax + 1)
		If CountEffects > 0 Then
			'=========создание эфектов для итема
			Local i:Int
			For i = 1 To CountEffects
				Item.AddEffect(Inventory)
			Next
		End If
		If count < 1 Then count = 1
		Item.ID = ID
		Item.count = count
		Inventory.AddLast(Item)
		Return Item
	End Function
	Method AddEffect(Inventory:TInventory)
		Local e:TItemEffect = New TItemEffect, e2:TItemEffect
 		e.ID = Rand(1, COUNT_ITEM_EFFECTS)
		e.value = TItemEffect.GetRandomValue(e.id)
		Local effectFinded:Int = False
		For e2 = EachIn effects
			If e2.id = e.id Then
				e2.value = e2.value + e.value
				effectFinded = True
			End If
		Next
		If effectFinded = False effects.AddLast(e)
	End Method
	Method RemoveFromInventory(Inventory:TInventory)
		Local eff:TItemEffect
		If effects Then
			For eff = EachIn effects
				effects.Remove(eff)
			Next
		EndIf
		Inventory.Remove(Self)
	End Method
	Method PacketExtract(Inventory:TInventory)
		Local Luck:Int = Rand(0, 100)
		Local Chance:Int
		Local CountItems:Int
		Local LuckMax:Int
		Local i:Int
		Select rare
			Case ITEM_RARE_NORMAL
				Chance = 10
			Case ITEM_RARE_MAGICAL
				Chance = 20
			Case ITEM_RARE_RARE
				Chance = 45
			Case ITEM_RARE_CRYSTALL
				Chance = 60
			Case ITEM_RARE_PERFECT
				Chance = 75
		End Select
		LuckMax = 100 - Chance
		CountItems = Int((rare + 1) * Luck / LuckMax + 1)
		For i = 1 To CountItems
			TItem.Create(ITEM_HOOD, Inventory, 0, 1, Rand(0, 4))
		Next
		If Chance = 75 And Rand(0, 100) = 50 Then TItem.Create(ITEM_FAV_INVENTORY, Inventory, 0, 1)
		If count > 1 Then count = count - 1 Else RemoveFromInventory(Inventory)
	End Method
	Method AddFavInventory(Inventory:TInventory)
		_AddFavInventory()
		Self.RemoveFromInventory(Inventory)
	End Method
End Type

Function _AddFavInventory()
	Local newWin:TItemsWindow = TItemsWindow.Create(TYPE_FAV_INVENTORY, Player)
End Function