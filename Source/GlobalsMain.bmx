'This BMX file was edited with BLIde ( http://www.blide.org )
'имя локального игрока
Global PlayerName:String
'шрифт
Global font:Int
'модель игрока
Global PlayerMesh:Int
Global MonsterMesh:Int
'листы
Global objList:TList = New TList		'сетевые объекты
Global objListInit:TList = New TList		'сетевые объекты
Global objListRemove:TList = New TList		'сетевые объекты для удаления
Global NetPlayersList:TList = New TList	'игроки
Global NetMonstersList:TList = New TList 'монстры
Global NetSpawnsList:TList = New TList	'спаун-поинты
Global Windows:TList = New TList
'типы существ
Global TYPE_PLAYER = 1
Global TYPE_MONSTER = 2
Global TYPE_GNETMESSAGE = 3
Global TYPE_GROUND = 4
'типы предметов
Global ITEM_PACKET = 0
Global ITEM_HOOD = 1
Global ITEM_FAV_INVENTORY = 2
'редкость предметов
Global ITEM_RARE_NORMAL = 0
Global ITEM_RARE_MAGICAL = 1
Global ITEM_RARE_RARE = 2
Global ITEM_RARE_CRYSTALL = 3
Global ITEM_RARE_PERFECT = 4
'объекты
Global cam:Int
Global light:Int
Global ground:Int
Global Player:TNetworkPlayer
Global Monsters:TNetworkMonster
Global NS:NetSlot = New NetSlot
'Типы инвентарей
Global TYPE_MAIN_INVENTORY = 1
Global TYPE_FAV_INVENTORY = 2
'Эффекты предметов
Global COUNT_ITEM_EFFECTS = 2
'1 = HP
'2 = MP
'=================Host or Client===============
Global host:TGNetHost = CreateGNetHost()
Global port = 8086
Global portSocket = 8087
Global addressClient:TList
Global timeout_ms = 3000
Global isServer:Int
'mysql
Global MySQL:TMySQL
Global MYSQL_HOST:String = "127.0.0.1"
Global MYSQL_USER:String = "root"
Global MYSQL_PASSWORD:String = "858585z"
Global MYSQL_DATABASE:String = "newrpg"
'Mouse
Global MouseOldButton
Global MouseNewButton
Global _mx
Global _my
Global MouseState = 0
Global MOUSE_NOTHING = 0
Global MOUSE_MOVING = 1
Global MOUSE_RESIZING = 2
Global MOUSE_DRAGDROP = 3
Global MOUSE_ITEM_DRAG:TItem = Null
'размер элементов для окон
Global elementheight = 24
Global spacewidth = 5
'random
SeedRnd MilliSecs()
'Загрузка картинок  
xKey ("")
xAppWindowFrame (0)
xAppTitle ("New RPG 1.0")
xInitDraw()
xGraphics3D ()
Global ImageDir:String = "Data/image/"
Global ModelsDir:String = "Data/models/"
Global UserConfigDir:String = "User/config/"
Global ItemImg[] = [xLoadImage(ImageDir + "item_0.png"), xLoadImage(ImageDir + "item_1.png"), xLoadImage(ImageDir + "item_2.png")]
Global AllInventories:TManyInventories = New TManyInventories
Global AllInventoriesWindow:TInventoriesWindow = New TInventoriesWindow
'================== Images главное меню ========================
Global menu_btn = xloadimage(ImageDir + "mainmenu_bt_stand.png")
Global menu_btn_active = xloadimage(ImageDir + "mainmenu_bt_active.png")
Global Sock:TSocket

