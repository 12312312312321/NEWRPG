'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TSpawnPoint Extends TEntity
	Field MonsterID:Int
	Field MonsterCount:Int
	Field SpawnRange:Double
	Field c:Int
	Function Create:TSpawnPoint(MonID, MonC, x:Double, y:Double, z:Double)
		Local sp:TSpawnPoint = New TSpawnPoint
		sp.MonsterID = MonID
		sp.MonsterCount = MonC
		sp.obj = xCreateCone()
		sp.Position(x, y, z)
		NetSpawnsList.AddLast(sp)
		'рейдж-сфера
		sp.c = xCreateSphere()
		xEntityColor(sp.c, 0, 0, 255)
		xEntityAlpha(sp.c, 0.1)
		xPositionEntity(sp.c, x, y, z)
		sp.SetSpawnRange(10)
		Return sp
	End Function
	Method SetSpawnRange(range:Double)
		If range < 1 Then range = 1
		SpawnRange = range
		xScaleEntity(c, SpawnRange* 0.5, SpawnRange* 0.5, SpawnRange* 0.5)
	End Method
	Method Spawn()
		Local Mon:TNetworkMonster = TNetworkMonster.Create()
		Local StartX:Double = X + Rnd(-SpawnRange * 0.5, SpawnRange * 0.5)
		Local StartY:Double = y
		Local StartZ:Double = Z + Rnd(-SpawnRange * 0.5, SpawnRange * 0.5)
		Mon.Position(StartX, StartY, StartZ)
		xPositionEntity(Mon.StartObj, StartX, StartY, StartZ)
		Mon.SetID(MonsterID)
	End Method
	Method CheckMonstersInRange()
		Local mon:TNetworkMonster
		Local counterMonsters = 0
		For mon = EachIn NetMonstersList
			If Dist(mon, Self) <= SpawnRange Then
				counterMonsters = counterMonsters + 1
			End If
		Next
		Local i
		If counterMonsters < MonsterCount Then
			For i = counterMonsters To MonsterCount - 1
				Spawn()
			Next
		End If
	End Method
End Type