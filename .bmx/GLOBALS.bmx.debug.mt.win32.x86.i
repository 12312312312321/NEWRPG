import brl.blitz
import brl.linkedlist
import brl.gnet
import pub.mysql
import xorsteam.fastimage
import brl.appstub
import brl.audio
import brl.bmploader
import brl.d3d7max2d
import brl.d3d9max2d
import brl.data
import brl.directsoundaudio
import brl.eventqueue
import brl.freeaudioaudio
import brl.freetypefont
import brl.jpgloader
import brl.map
import brl.maxlua
import brl.maxutil
import brl.oggloader
import brl.openalaudio
import brl.pngloader
import brl.tgaloader
import brl.threads
import brl.timer
import brl.wavloader
import pub.freejoy
import pub.freeprocess
import pub.glew
import pub.macos
TNetworkPlayer^TNetworkEntity{
.Inventory:TInventory&
.MP!&
.Experience!&
.CameraPivot%&
.HP!&
.Name$&
.LastAnimFrame%&
.T:TTarget&
-New%()="_bb_TNetworkPlayer_New"
-UpdateXYZ%()="_bb_TNetworkPlayer_UpdateXYZ"
+Create:TNetworkPlayer(isNet%=0,NetObject:brl.gnet.TGNetObject="bbNullObject")="_bb_TNetworkPlayer_Create"
-Remove%()="_bb_TNetworkPlayer_Remove"
-UpdatePositionFromNET%()="_bb_TNetworkPlayer_UpdatePositionFromNET"
-UpdatePositionToNET%()="_bb_TNetworkPlayer_UpdatePositionToNET"
-MoveToTarget%()="_bb_TNetworkPlayer_MoveToTarget"
-Debug1%()="_bb_TNetworkPlayer_Debug1"
}="bb_TNetworkPlayer"
TNetworkMonster^TNetworkEntity{
.MonsterID%&
.StartObj%&
.target:Tnetworkplayer&
.atkCountDown!&
.AgroRange!&
.atkRange!&
.UniqueName%&
-New%()="_bb_TNetworkMonster_New"
+Create:TNetworkMonster(isNet%=0,NetObject:brl.gnet.TGNetObject="bbNullObject")="_bb_TNetworkMonster_Create"
-Remove%()="_bb_TNetworkMonster_Remove"
-UpdatePositionFromNET%()="_bb_TNetworkMonster_UpdatePositionFromNET"
-UpdatePositionToNET%()="_bb_TNetworkMonster_UpdatePositionToNET"
-SetID%(id%)="_bb_TNetworkMonster_SetID"
-Atack%(p:TNetworkPlayer)="_bb_TNetworkMonster_Atack"
-UpdateAtack%()="_bb_TNetworkMonster_UpdateAtack"
-UpdateAgro%(p:TNetworkPlayer)="_bb_TNetworkMonster_UpdateAgro"
-UpdateMoveReturning%()="_bb_TNetworkMonster_UpdateMoveReturning"
}="bb_TNetworkMonster"
TEntity^brl.blitz.Object{
.obj%&
.X!&
.Y!&
.Z!&
-New%()="_bb_TEntity_New"
-Position%(newx#=0#,newy#=0#,newz#=0#)="_bb_TEntity_Position"
-Move%(dx#=0#,dy#=0#,dz#=0#)="_bb_TEntity_Move"
-UpdateXYZ%()="_bb_TEntity_UpdateXYZ"
}="bb_TEntity"
TNetworkEntity^TEntity{
.NetID:brl.gnet.TGNetObject&
.isNet%&
-New%()="_bb_TNetworkEntity_New"
}="bb_TNetworkEntity"
NetSlot^brl.blitz.Object{
.X%&
.Y%&
.Z%&
.HP%&
.TypeEntity%&
.anglex%&
.angley%&
.anglez%&
.messageObjectId%&
.messageObjectHp%&
.PlayerName%&
.MonsterUniqueName%&
.PlayerAnimFrame%&
-New%()="_bb_NetSlot_New"
}="bb_NetSlot"
TInventory^brl.linkedlist.TList{
.IType%&
-New%()="_bb_TInventory_New"
}="bb_TInventory"
TTarget^TEntity{
-New%()="_bb_TTarget_New"
-Location%()="_bb_TTarget_Location"
}="bb_TTarget"
ENDGAME%()="bb_ENDGAME"
LoadPlayerName%()="bb_LoadPlayerName"
WritePlayerName%(str$)="bb_WritePlayerName"
MYSQL_CLEARTABLE%()="bb_MYSQL_CLEARTABLE"
MYSQL_START%()="bb_MYSQL_START"
MYSQL_INSERT%(Name$)="bb_MYSQL_INSERT"
MYSQL_DELETE%(Name$)="bb_MYSQL_DELETE"
MYSQL_FINDPLAYER%(Name$)="bb_MYSQL_FINDPLAYER"
MYSQL_Check%(Result:pub.mysql.TMySQLResult)="bb_MYSQL_Check"
UpdateMouse%()="bb_UpdateMouse"
MouseUp%()="bb_MouseUp"
CheckMouse%(x%,y%,width%=0,height%=0)="bb_CheckMouse"
Dist!(p1:TEntity,p2:TEntity)="bb_Dist"
DistObj!(p1%,p2%)="bb_DistObj"
TSpawnPoint^TEntity{
.MonsterID%&
.MonsterCount%&
.SpawnRange!&
.c%&
-New%()="_bb_TSpawnPoint_New"
+Create:TSpawnPoint(MonID%,MonC%,x!,y!,z!)="_bb_TSpawnPoint_Create"
-SetSpawnRange%(range!)="_bb_TSpawnPoint_SetSpawnRange"
-Spawn%()="_bb_TSpawnPoint_Spawn"
-CheckMonstersInRange%()="_bb_TSpawnPoint_CheckMonstersInRange"
}="bb_TSpawnPoint"
TItem^brl.blitz.Object{
.id%&
.rare%&
.effects:brl.linkedlist.TList&
.count%&
.checkdelete%&
.stacked%&
-New%()="_bb_TItem_New"
+Create:TItem(ID%,Inventory:TInventory,stacked%=0,count%=1,rare%=0)="_bb_TItem_Create"
-AddEffect%(Inventory:TInventory)="_bb_TItem_AddEffect"
-RemoveFromInventory%(Inventory:TInventory)="_bb_TItem_RemoveFromInventory"
-PacketExtract%(Inventory:TInventory)="_bb_TItem_PacketExtract"
-AddFavInventory%(Inventory:TInventory)="_bb_TItem_AddFavInventory"
}="bb_TItem"
_AddFavInventory%()="bb__AddFavInventory"
TItemEffect^brl.blitz.Object{
.id%&
.value%&
-New%()="_bb_TItemEffect_New"
+GetRandomValue%(effectId%)="_bb_TItemEffect_GetRandomValue"
+GetNameEffect$(effectId%)="_bb_TItemEffect_GetNameEffect"
}="bb_TItemEffect"
TItemsWindow^TWindow{
.Inventory:TInventory&
.ScrollY%&
.CountItems%&
-New%()="_bb_TItemsWindow_New"
-SetInventory%(i:TInventory)="_bb_TItemsWindow_SetInventory"
-Draw%()="_bb_TItemsWindow_Draw"
-DrawItemHint%(itemdrawy%,k:TItem,text$)="_bb_TItemsWindow_DrawItemHint"
-Resize%()="_bb_TItemsWindow_Resize"
+CountCharsInString%(Str$)="_bb_TItemsWindow_CountCharsInString"
-CanClick%()="_bb_TItemsWindow_CanClick"
}="bb_TItemsWindow"
TWindow^brl.blitz.Object{
.x%&
.y%&
.width%&
.height%&
.hidden%&
.winmoving%&
.winresizing%&
.winmoveoldmx%&
.winmoveoldmy%&
.title$&
.windowbordersize%&
.z%&
-New%()="_bb_TWindow_New"
-Move%()="_bb_TWindow_Move"
-Resize%()="_bb_TWindow_Resize"
-close%()="_bb_TWindow_close"
-draw%()="_bb_TWindow_draw"
-DrawMouseHint%()="_bb_TWindow_DrawMouseHint"
-Update%()="_bb_TWindow_Update"
}="bb_TWindow"
TManyInventories^brl.linkedlist.TList{
-New%()="_bb_TManyInventories_New"
}="bb_TManyInventories"
TInventoriesWindow^TWindow{
-New%()="_bb_TInventoriesWindow_New"
-draw%()="_bb_TInventoriesWindow_draw"
-DrawInvHint%(inv:TItemsWindow)="_bb_TInventoriesWindow_DrawInvHint"
}="bb_TInventoriesWindow"
PlayerName$&=mem:p("bb_PlayerName")
font%&=mem("bb_font")
PlayerMesh%&=mem("bb_PlayerMesh")
MonsterMesh%&=mem("bb_MonsterMesh")
objList:brl.linkedlist.TList&=mem:p("bb_objList")
objListInit:brl.linkedlist.TList&=mem:p("bb_objListInit")
objListRemove:brl.linkedlist.TList&=mem:p("bb_objListRemove")
NetPlayersList:brl.linkedlist.TList&=mem:p("bb_NetPlayersList")
NetMonstersList:brl.linkedlist.TList&=mem:p("bb_NetMonstersList")
NetSpawnsList:brl.linkedlist.TList&=mem:p("bb_NetSpawnsList")
Windows:brl.linkedlist.TList&=mem:p("bb_Windows")
TYPE_PLAYER%&=mem("bb_TYPE_PLAYER")
TYPE_MONSTER%&=mem("bb_TYPE_MONSTER")
TYPE_GNETMESSAGE%&=mem("bb_TYPE_GNETMESSAGE")
TYPE_GROUND%&=mem("bb_TYPE_GROUND")
ITEM_PACKET%&=mem("bb_ITEM_PACKET")
ITEM_HOOD%&=mem("bb_ITEM_HOOD")
ITEM_FAV_INVENTORY%&=mem("bb_ITEM_FAV_INVENTORY")
ITEM_RARE_NORMAL%&=mem("bb_ITEM_RARE_NORMAL")
ITEM_RARE_MAGICAL%&=mem("bb_ITEM_RARE_MAGICAL")
ITEM_RARE_RARE%&=mem("bb_ITEM_RARE_RARE")
ITEM_RARE_CRYSTALL%&=mem("bb_ITEM_RARE_CRYSTALL")
ITEM_RARE_PERFECT%&=mem("bb_ITEM_RARE_PERFECT")
cam%&=mem("bb_cam")
light%&=mem("bb_light")
ground%&=mem("bb_ground")
Player:TNetworkPlayer&=mem:p("bb_Player")
Monsters:TNetworkMonster&=mem:p("bb_Monsters")
NS:NetSlot&=mem:p("bb_NS")
TYPE_MAIN_INVENTORY%&=mem("bb_TYPE_MAIN_INVENTORY")
TYPE_FAV_INVENTORY%&=mem("bb_TYPE_FAV_INVENTORY")
COUNT_ITEM_EFFECTS%&=mem("bb_COUNT_ITEM_EFFECTS")
host:brl.gnet.TGNetHost&=mem:p("bb_host")
port%&=mem("bb_port")
addressClient:brl.linkedlist.TList&=mem:p("bb_addressClient")
timeout_ms%&=mem("bb_timeout_ms")
isServer%&=mem("bb_isServer")
MySQL:pub.mysql.TMySQL&=mem:p("bb_MySQL")
MYSQL_HOST$&=mem:p("bb_MYSQL_HOST")
MYSQL_USER$&=mem:p("bb_MYSQL_USER")
MYSQL_PASSWORD$&=mem:p("bb_MYSQL_PASSWORD")
MYSQL_DATABASE$&=mem:p("bb_MYSQL_DATABASE")
MouseOldButton%&=mem("bb_MouseOldButton")
MouseNewButton%&=mem("bb_MouseNewButton")
_mx%&=mem("bb__mx")
_my%&=mem("bb__my")
MouseState%&=mem("bb_MouseState")
MOUSE_NOTHING%&=mem("bb_MOUSE_NOTHING")
MOUSE_MOVING%&=mem("bb_MOUSE_MOVING")
MOUSE_RESIZING%&=mem("bb_MOUSE_RESIZING")
elementheight%&=mem("bb_elementheight")
spacewidth%&=mem("bb_spacewidth")
ItemImg%&[]&=mem:p("bb_ItemImg")
AllInventories:TManyInventories&=mem:p("bb_AllInventories")
AllInventoriesWindow:TInventoriesWindow&=mem:p("bb_AllInventoriesWindow")
menu_btn%&=mem("bb_menu_btn")
menu_btn_active%&=mem("bb_menu_btn_active")
