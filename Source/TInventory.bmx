'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TInventory Extends TList
	Field IType:Int
	Function Create:TInventory(IType:Int)
		Local newi:TInventory = New TInventory
		newi.IType = IType
		Return newi
	End Function
End Type
