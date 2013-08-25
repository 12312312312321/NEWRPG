import brl.blitz
import xorsteam.xors3d
updatemouse%()="bb_updatemouse"
MouseUp%()="bb_MouseUp"
CheckMouse%(x%,y%,width%=0,height%=0)="bb_CheckMouse"
Window^brl.blitz.Object{
.x%&
.y%&
.width%&
.height%&
.hidden%&
.winmoving%&
.winresizing%&
.title$&
-New%()="_bb_Window_New"
-Delete%()="_bb_Window_Delete"
-Move%()="_bb_Window_Move"
-Resize%()="_bb_Window_Resize"
-close%()="_bb_Window_close"
-draw%()="_bb_Window_draw"
}="bb_Window"
borderheight%&=mem("bb_borderheight")
borderwidth%&=mem("bb_borderwidth")
MouseOldButton%&=mem("bb_MouseOldButton")
MouseNewButton%&=mem("bb_MouseNewButton")
