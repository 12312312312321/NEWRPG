'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TItemEffect
	Field id:Int
	Field value:Int
	Function GetRandomValue:Int(effectId:Int)
		Local Result:Int
		Select effectId
			Case 1
				Result = Rand(50, 150)
			Case 2
				Result = Rand(50, 150)
		End Select
		Return Result
	End Function
	Function GetNameEffect:String(effectId:Int)
		Local Result:String
		Select effectId
			Case 1
				Result = "Boost HP"
			Case 2
				Result = "Boost MP"
		End Select
		Return Result
	End Function
End Type