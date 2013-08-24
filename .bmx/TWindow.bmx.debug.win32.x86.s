	format	MS COFF
	extrn	___bb_blitz_blitz
	extrn	___bb_xors3d_xors3d
	extrn	_bbEmptyString
	extrn	_bbGCFree
	extrn	_bbNullObject
	extrn	_bbObjectClass
	extrn	_bbObjectCompare
	extrn	_bbObjectCtor
	extrn	_bbObjectFree
	extrn	_bbObjectRegisterType
	extrn	_bbObjectReserved
	extrn	_bbObjectSendMessage
	extrn	_bbObjectToString
	extrn	_bbOnDebugEnterScope
	extrn	_bbOnDebugEnterStm
	extrn	_bbOnDebugLeaveScope
	extrn	_brl_blitz_NullObjectError
	extrn	_xorsteam_xors3d_xColor
	extrn	_xorsteam_xors3d_xGraphicsHeight
	extrn	_xorsteam_xors3d_xGraphicsWidth
	extrn	_xorsteam_xors3d_xMouseDown
	extrn	_xorsteam_xors3d_xMouseX
	extrn	_xorsteam_xors3d_xMouseY
	extrn	_xorsteam_xors3d_xRect
	extrn	_xorsteam_xors3d_xText
	public	___bb_newrpg_twindow
	public	__bb_Window_Delete
	public	__bb_Window_Move
	public	__bb_Window_New
	public	__bb_Window_Resize
	public	__bb_Window_close
	public	__bb_Window_draw
	public	_bb_CheckMouse
	public	_bb_MouseNewButton
	public	_bb_MouseOldButton
	public	_bb_MouseUp
	public	_bb_Window
	public	_bb_borderheight
	public	_bb_borderwidth
	public	_bb_updatemouse
	section	"code" code
___bb_newrpg_twindow:
	push	ebp
	mov	ebp,esp
	push	ebx
	cmp	dword [_64],0
	je	_65
	mov	eax,0
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_65:
	mov	dword [_64],1
	push	ebp
	push	_58
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	call	___bb_blitz_blitz
	call	___bb_xors3d_xors3d
	push	_bb_Window
	call	_bbObjectRegisterType
	add	esp,4
	push	_53
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	_55
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	_56
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	_57
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,0
	jmp	_23
_23:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_updatemouse:
	push	ebp
	mov	ebp,esp
	push	ebx
	push	esi
	push	edi
	push	ebp
	push	_68
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_66
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [_bb_MouseNewButton]
	mov	dword [_bb_MouseOldButton],eax
	push	_67
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	call	dword [_xorsteam_xors3d_xMouseDown]
	mov	dword [_bb_MouseNewButton],eax
	mov	ebx,0
	jmp	_25
_25:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_MouseUp:
	push	ebp
	mov	ebp,esp
	push	ebx
	push	ebp
	push	_75
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_70
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [_bb_MouseOldButton]
	cmp	eax,1
	sete	al
	movzx	eax,al
	cmp	eax,0
	je	_71
	mov	eax,dword [_bb_MouseNewButton]
	cmp	eax,0
	sete	al
	movzx	eax,al
_71:
	cmp	eax,0
	je	_73
	push	_74
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,1
	jmp	_27
_73:
	mov	ebx,0
	jmp	_27
_27:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_CheckMouse:
	push	ebp
	mov	ebp,esp
	sub	esp,24
	push	ebx
	push	esi
	push	edi
	mov	eax,dword [ebp+8]
	mov	dword [ebp-4],eax
	mov	eax,dword [ebp+12]
	mov	dword [ebp-8],eax
	mov	eax,dword [ebp+16]
	mov	dword [ebp-12],eax
	mov	eax,dword [ebp+20]
	mov	dword [ebp-16],eax
	mov	dword [ebp-20],0
	mov	dword [ebp-24],0
	push	ebp
	push	_92
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_77
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	dword [_xorsteam_xors3d_xMouseX]
	mov	dword [ebp-20],eax
	push	_79
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	dword [_xorsteam_xors3d_xMouseY]
	mov	dword [ebp-24],eax
	push	_81
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-20]
	cmp	eax,dword [ebp-4]
	setge	al
	movzx	eax,al
	cmp	eax,0
	je	_82
	mov	edx,dword [ebp-20]
	mov	eax,dword [ebp-4]
	add	eax,dword [ebp-12]
	cmp	edx,eax
	setle	al
	movzx	eax,al
_82:
	cmp	eax,0
	je	_84
	mov	eax,dword [ebp-24]
	cmp	eax,dword [ebp-8]
	setge	al
	movzx	eax,al
_84:
	cmp	eax,0
	je	_86
	mov	edx,dword [ebp-24]
	mov	eax,dword [ebp-8]
	add	eax,dword [ebp-16]
	cmp	edx,eax
	setle	al
	movzx	eax,al
_86:
	cmp	eax,0
	je	_88
	push	_89
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,1
	jmp	_33
_88:
	push	_91
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,0
	jmp	_33
_33:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
__bb_Window_New:
	push	ebp
	mov	ebp,esp
	sub	esp,4
	push	ebx
	mov	eax,dword [ebp+8]
	mov	dword [ebp-4],eax
	push	ebp
	push	_118
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	dword [ebp-4]
	call	_bbObjectCtor
	add	esp,4
	mov	eax,dword [ebp-4]
	mov	dword [eax],_bb_Window
	mov	eax,dword [ebp-4]
	mov	dword [eax+8],0
	mov	eax,dword [ebp-4]
	mov	dword [eax+12],0
	mov	eax,dword [ebp-4]
	mov	dword [eax+16],0
	mov	eax,dword [ebp-4]
	mov	dword [eax+20],0
	mov	eax,dword [ebp-4]
	mov	dword [eax+24],0
	mov	eax,dword [ebp-4]
	mov	dword [eax+28],0
	mov	eax,dword [ebp-4]
	mov	dword [eax+32],0
	mov	edx,_bbEmptyString
	inc	dword [edx+4]
	mov	eax,dword [ebp-4]
	mov	dword [eax+36],edx
	push	_97
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_100
	call	_brl_blitz_NullObjectError
_100:
	mov	dword [ebx+8],10
	push	_102
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_104
	call	_brl_blitz_NullObjectError
_104:
	mov	dword [ebx+12],10
	push	_106
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_108
	call	_brl_blitz_NullObjectError
_108:
	mov	dword [ebx+16],200
	push	_110
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_112
	call	_brl_blitz_NullObjectError
_112:
	mov	dword [ebx+20],400
	push	_114
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_116
	call	_brl_blitz_NullObjectError
_116:
	mov	dword [ebx+24],0
	mov	ebx,0
	jmp	_36
_36:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
__bb_Window_Delete:
	push	ebp
	mov	ebp,esp
	mov	eax,dword [ebp+8]
_39:
	mov	eax,dword [eax+36]
	dec	dword [eax+4]
	jnz	_123
	push	eax
	call	_bbGCFree
	add	esp,4
_123:
	mov	eax,0
	jmp	_121
_121:
	mov	esp,ebp
	pop	ebp
	ret
__bb_Window_Move:
	push	ebp
	mov	ebp,esp
	sub	esp,12
	push	ebx
	push	esi
	push	edi
	mov	eax,dword [ebp+8]
	mov	dword [ebp-4],eax
	mov	dword [ebp-8],0
	mov	dword [ebp-12],0
	mov	eax,ebp
	push	eax
	push	_160
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_124
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	dword [_xorsteam_xors3d_xMouseX]
	mov	dword [ebp-8],eax
	push	_126
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	dword [_xorsteam_xors3d_xMouseY]
	mov	dword [ebp-12],eax
	push	_128
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_130
	call	_brl_blitz_NullObjectError
_130:
	cmp	dword [ebx+28],1
	jne	_131
	push	_132
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_134
	call	_brl_blitz_NullObjectError
_134:
	mov	eax,dword [ebp-8]
	mov	dword [ebx+8],eax
	push	_136
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_138
	call	_brl_blitz_NullObjectError
_138:
	mov	eax,dword [ebp-12]
	mov	dword [ebx+12],eax
_131:
	push	_140
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_bb_MouseUp
	cmp	eax,0
	je	_141
	push	_142
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_144
	call	_brl_blitz_NullObjectError
_144:
	mov	dword [ebx+28],0
_141:
	push	_146
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	call	dword [_xorsteam_xors3d_xMouseDown]
	cmp	eax,0
	je	_153
	mov	edi,dword [ebp-4]
	cmp	edi,_bbNullObject
	jne	_148
	call	_brl_blitz_NullObjectError
_148:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_150
	call	_brl_blitz_NullObjectError
_150:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_152
	call	_brl_blitz_NullObjectError
_152:
	push	dword [_bb_borderheight]
	push	dword [ebx+16]
	push	dword [esi+12]
	push	dword [edi+8]
	call	_bb_CheckMouse
	add	esp,16
_153:
	cmp	eax,0
	je	_155
	push	_156
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_158
	call	_brl_blitz_NullObjectError
_158:
	mov	dword [ebx+28],1
_155:
	mov	ebx,0
	jmp	_42
_42:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
__bb_Window_Resize:
	push	ebp
	mov	ebp,esp
	sub	esp,16
	push	ebx
	push	esi
	push	edi
	mov	eax,dword [ebp+8]
	mov	dword [ebp-4],eax
	mov	dword [ebp-8],0
	mov	dword [ebp-12],0
	mov	eax,ebp
	push	eax
	push	_243
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_161
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	call	dword [_xorsteam_xors3d_xMouseDown]
	cmp	eax,0
	je	_170
	mov	eax,dword [ebp-4]
	mov	dword [ebp-16],eax
	cmp	dword [ebp-16],_bbNullObject
	jne	_163
	call	_brl_blitz_NullObjectError
_163:
	mov	edi,dword [ebp-4]
	cmp	edi,_bbNullObject
	jne	_165
	call	_brl_blitz_NullObjectError
_165:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_167
	call	_brl_blitz_NullObjectError
_167:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_169
	call	_brl_blitz_NullObjectError
_169:
	push	5
	push	5
	mov	eax,dword [esi+12]
	add	eax,dword [ebx+20]
	sub	eax,5
	push	eax
	mov	eax,dword [ebp-16]
	mov	eax,dword [eax+8]
	add	eax,dword [edi+16]
	sub	eax,5
	push	eax
	call	_bb_CheckMouse
	add	esp,16
_170:
	cmp	eax,0
	je	_172
	push	_173
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_175
	call	_brl_blitz_NullObjectError
_175:
	mov	dword [ebx+32],1
_172:
	push	_177
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_bb_MouseUp
	cmp	eax,0
	je	_178
	push	_179
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_181
	call	_brl_blitz_NullObjectError
_181:
	mov	dword [ebx+32],0
_178:
	push	_183
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	dword [_xorsteam_xors3d_xMouseX]
	mov	dword [ebp-8],eax
	push	_185
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	dword [_xorsteam_xors3d_xMouseY]
	mov	dword [ebp-12],eax
	push	_187
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_189
	call	_brl_blitz_NullObjectError
_189:
	cmp	dword [ebx+32],1
	jne	_190
	push	_191
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_193
	call	_brl_blitz_NullObjectError
_193:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_196
	call	_brl_blitz_NullObjectError
_196:
	mov	eax,dword [ebp-8]
	sub	eax,dword [esi+8]
	mov	dword [ebx+16],eax
	push	_197
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_199
	call	_brl_blitz_NullObjectError
_199:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_202
	call	_brl_blitz_NullObjectError
_202:
	mov	eax,dword [ebp-12]
	sub	eax,dword [esi+12]
	mov	dword [ebx+20],eax
	push	_203
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_205
	call	_brl_blitz_NullObjectError
_205:
	mov	eax,dword [_bb_borderheight]
	imul	eax,10
	cmp	dword [ebx+16],eax
	jge	_206
	push	_207
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_209
	call	_brl_blitz_NullObjectError
_209:
	mov	eax,dword [_bb_borderheight]
	imul	eax,10
	mov	dword [ebx+16],eax
_206:
	push	_211
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_213
	call	_brl_blitz_NullObjectError
_213:
	mov	eax,dword [_bb_borderheight]
	imul	eax,5
	cmp	dword [ebx+20],eax
	jge	_214
	push	_215
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_217
	call	_brl_blitz_NullObjectError
_217:
	mov	eax,dword [_bb_borderheight]
	imul	eax,5
	mov	dword [ebx+20],eax
_214:
	push	_219
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_221
	call	_brl_blitz_NullObjectError
_221:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_223
	call	_brl_blitz_NullObjectError
_223:
	mov	ebx,dword [ebx+16]
	add	ebx,dword [esi+8]
	push	1
	call	_xorsteam_xors3d_xGraphicsWidth
	add	esp,4
	cmp	ebx,eax
	jle	_224
	push	_225
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_227
	call	_brl_blitz_NullObjectError
_227:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_230
	call	_brl_blitz_NullObjectError
_230:
	push	1
	call	_xorsteam_xors3d_xGraphicsWidth
	add	esp,4
	sub	eax,dword [ebx+8]
	mov	dword [esi+16],eax
_224:
	push	_231
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_233
	call	_brl_blitz_NullObjectError
_233:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_235
	call	_brl_blitz_NullObjectError
_235:
	mov	ebx,dword [ebx+20]
	add	ebx,dword [esi+12]
	push	1
	call	_xorsteam_xors3d_xGraphicsHeight
	add	esp,4
	cmp	ebx,eax
	jle	_236
	push	_237
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_239
	call	_brl_blitz_NullObjectError
_239:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_242
	call	_brl_blitz_NullObjectError
_242:
	push	1
	call	_xorsteam_xors3d_xGraphicsHeight
	add	esp,4
	sub	eax,dword [ebx+12]
	mov	dword [esi+20],eax
_236:
_190:
	mov	ebx,0
	jmp	_45
_45:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
__bb_Window_close:
	push	ebp
	mov	ebp,esp
	sub	esp,12
	push	ebx
	push	esi
	push	edi
	mov	eax,dword [ebp+8]
	mov	dword [ebp-4],eax
	mov	dword [ebp-8],0
	mov	dword [ebp-12],0
	mov	eax,ebp
	push	eax
	push	_270
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_244
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	dword [_xorsteam_xors3d_xMouseX]
	mov	dword [ebp-8],eax
	push	_246
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	dword [_xorsteam_xors3d_xMouseY]
	mov	dword [ebp-12],eax
	push	_248
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	call	dword [_xorsteam_xors3d_xMouseDown]
	cmp	eax,0
	je	_255
	mov	edi,dword [ebp-4]
	cmp	edi,_bbNullObject
	jne	_250
	call	_brl_blitz_NullObjectError
_250:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_252
	call	_brl_blitz_NullObjectError
_252:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_254
	call	_brl_blitz_NullObjectError
_254:
	push	dword [_bb_borderheight]
	push	dword [_bb_borderheight]
	mov	eax,dword [esi+12]
	add	eax,dword [ebx+20]
	sub	eax,dword [_bb_borderheight]
	push	eax
	push	dword [edi+8]
	call	_bb_CheckMouse
	add	esp,16
_255:
	cmp	eax,0
	je	_257
	push	_258
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_260
	call	_brl_blitz_NullObjectError
_260:
	mov	dword [ebx+28],0
	push	_262
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_264
	call	_brl_blitz_NullObjectError
_264:
	mov	dword [ebx+32],0
	push	_266
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_268
	call	_brl_blitz_NullObjectError
_268:
	mov	dword [ebx+24],1
_257:
	mov	ebx,0
	jmp	_48
_48:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
__bb_Window_draw:
	push	ebp
	mov	ebp,esp
	sub	esp,16
	push	ebx
	push	esi
	push	edi
	mov	eax,dword [ebp+8]
	mov	dword [ebp-4],eax
	mov	eax,ebp
	push	eax
	push	_321
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_271
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	255
	push	0
	push	0
	push	155
	call	_xorsteam_xors3d_xColor
	add	esp,16
	push	_272
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-4]
	mov	dword [ebp-8],eax
	cmp	dword [ebp-8],_bbNullObject
	jne	_274
	call	_brl_blitz_NullObjectError
_274:
	mov	edi,dword [ebp-4]
	cmp	edi,_bbNullObject
	jne	_276
	call	_brl_blitz_NullObjectError
_276:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_278
	call	_brl_blitz_NullObjectError
_278:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_280
	call	_brl_blitz_NullObjectError
_280:
	push	1
	push	dword [ebx+20]
	push	dword [esi+16]
	push	dword [edi+12]
	mov	eax,dword [ebp-8]
	push	dword [eax+8]
	call	_xorsteam_xors3d_xRect
	add	esp,20
	push	_281
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	255
	push	0
	push	0
	push	255
	call	_xorsteam_xors3d_xColor
	add	esp,16
	push	_282
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	edi,dword [ebp-4]
	cmp	edi,_bbNullObject
	jne	_284
	call	_brl_blitz_NullObjectError
_284:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_286
	call	_brl_blitz_NullObjectError
_286:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_288
	call	_brl_blitz_NullObjectError
_288:
	push	1
	push	dword [_bb_borderheight]
	push	dword [ebx+16]
	push	dword [esi+12]
	push	dword [edi+8]
	call	_xorsteam_xors3d_xRect
	add	esp,20
	push	_289
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_291
	call	_brl_blitz_NullObjectError
_291:
	cmp	dword [ebx+32],0
	je	_292
	push	_293
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	255
	push	0
	push	255
	push	0
	call	_xorsteam_xors3d_xColor
	add	esp,16
	jmp	_294
_292:
	push	_295
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	255
	push	0
	push	0
	push	255
	call	_xorsteam_xors3d_xColor
	add	esp,16
_294:
	push	_296
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-4]
	mov	dword [ebp-12],eax
	cmp	dword [ebp-12],_bbNullObject
	jne	_298
	call	_brl_blitz_NullObjectError
_298:
	mov	edi,dword [ebp-4]
	cmp	edi,_bbNullObject
	jne	_300
	call	_brl_blitz_NullObjectError
_300:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_302
	call	_brl_blitz_NullObjectError
_302:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_304
	call	_brl_blitz_NullObjectError
_304:
	push	1
	push	dword [_bb_borderwidth]
	push	dword [_bb_borderwidth]
	mov	eax,dword [esi+12]
	add	eax,dword [ebx+20]
	sub	eax,dword [_bb_borderwidth]
	push	eax
	mov	eax,dword [ebp-12]
	mov	eax,dword [eax+8]
	add	eax,dword [edi+16]
	sub	eax,dword [_bb_borderwidth]
	push	eax
	call	_xorsteam_xors3d_xRect
	add	esp,20
	push	_305
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	255
	push	0
	push	0
	push	255
	call	_xorsteam_xors3d_xColor
	add	esp,16
	push	_306
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	edi,dword [ebp-4]
	cmp	edi,_bbNullObject
	jne	_308
	call	_brl_blitz_NullObjectError
_308:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_310
	call	_brl_blitz_NullObjectError
_310:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_312
	call	_brl_blitz_NullObjectError
_312:
	push	1
	push	dword [_bb_borderheight]
	push	dword [_bb_borderheight]
	mov	eax,dword [esi+12]
	add	eax,dword [ebx+20]
	sub	eax,dword [_bb_borderheight]
	push	eax
	push	dword [edi+8]
	call	_xorsteam_xors3d_xRect
	add	esp,20
	push	_313
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	255
	push	255
	push	255
	push	255
	call	_xorsteam_xors3d_xColor
	add	esp,16
	push	_314
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	edi,dword [ebp-4]
	cmp	edi,_bbNullObject
	jne	_316
	call	_brl_blitz_NullObjectError
_316:
	mov	esi,dword [ebp-4]
	cmp	esi,_bbNullObject
	jne	_318
	call	_brl_blitz_NullObjectError
_318:
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_320
	call	_brl_blitz_NullObjectError
_320:
	push	0
	push	0
	push	dword [ebx+36]
	mov	eax,dword [esi+12]
	mov	dword [ebp+-16],eax
	fild	dword [ebp+-16]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [edi+8]
	mov	dword [ebp+-16],eax
	fild	dword [ebp+-16]
	sub	esp,4
	fstp	dword [esp]
	call	_xorsteam_xors3d_xText
	add	esp,20
	mov	ebx,0
	jmp	_51
_51:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
	section	"data" data writeable align 8
	align	4
_64:
	dd	0
_59:
	db	"TWindow",0
_60:
	db	"borderheight",0
_7:
	db	"i",0
	align	4
_bb_borderheight:
	dd	24
_61:
	db	"borderwidth",0
	align	4
_bb_borderwidth:
	dd	5
_62:
	db	"MouseOldButton",0
	align	4
_bb_MouseOldButton:
	dd	0
_63:
	db	"MouseNewButton",0
	align	4
_bb_MouseNewButton:
	dd	0
	align	4
_58:
	dd	1
	dd	_59
	dd	4
	dd	_60
	dd	_7
	dd	_bb_borderheight
	dd	4
	dd	_61
	dd	_7
	dd	_bb_borderwidth
	dd	4
	dd	_62
	dd	_7
	dd	_bb_MouseOldButton
	dd	4
	dd	_63
	dd	_7
	dd	_bb_MouseNewButton
	dd	0
_5:
	db	"Window",0
_6:
	db	"x",0
_8:
	db	"y",0
_9:
	db	"width",0
_10:
	db	"height",0
_11:
	db	"hidden",0
_12:
	db	"winmoving",0
_13:
	db	"winresizing",0
_14:
	db	"title",0
_15:
	db	"$",0
_16:
	db	"New",0
_17:
	db	"()i",0
_18:
	db	"Delete",0
_19:
	db	"Move",0
_20:
	db	"Resize",0
_21:
	db	"close",0
_22:
	db	"draw",0
	align	4
_4:
	dd	2
	dd	_5
	dd	3
	dd	_6
	dd	_7
	dd	8
	dd	3
	dd	_8
	dd	_7
	dd	12
	dd	3
	dd	_9
	dd	_7
	dd	16
	dd	3
	dd	_10
	dd	_7
	dd	20
	dd	3
	dd	_11
	dd	_7
	dd	24
	dd	3
	dd	_12
	dd	_7
	dd	28
	dd	3
	dd	_13
	dd	_7
	dd	32
	dd	3
	dd	_14
	dd	_15
	dd	36
	dd	6
	dd	_16
	dd	_17
	dd	16
	dd	6
	dd	_18
	dd	_17
	dd	20
	dd	6
	dd	_19
	dd	_17
	dd	48
	dd	6
	dd	_20
	dd	_17
	dd	52
	dd	6
	dd	_21
	dd	_17
	dd	56
	dd	6
	dd	_22
	dd	_17
	dd	60
	dd	0
	align	4
_bb_Window:
	dd	_bbObjectClass
	dd	_bbObjectFree
	dd	_4
	dd	40
	dd	__bb_Window_New
	dd	__bb_Window_Delete
	dd	_bbObjectToString
	dd	_bbObjectCompare
	dd	_bbObjectSendMessage
	dd	_bbObjectReserved
	dd	_bbObjectReserved
	dd	_bbObjectReserved
	dd	__bb_Window_Move
	dd	__bb_Window_Resize
	dd	__bb_Window_close
	dd	__bb_Window_draw
_54:
	db	"F:/Dropbox/bmax/NEWRPG/globals.bmx",0
	align	4
_53:
	dd	_54
	dd	1
	dd	1
	align	4
_55:
	dd	_54
	dd	2
	dd	1
	align	4
_56:
	dd	_54
	dd	4
	dd	1
	align	4
_57:
	dd	_54
	dd	5
	dd	1
_69:
	db	"updatemouse",0
	align	4
_68:
	dd	1
	dd	_69
	dd	0
	align	4
_66:
	dd	_54
	dd	7
	dd	2
	align	4
_67:
	dd	_54
	dd	8
	dd	2
_76:
	db	"MouseUp",0
	align	4
_75:
	dd	1
	dd	_76
	dd	0
	align	4
_70:
	dd	_54
	dd	11
	dd	2
	align	4
_74:
	dd	_54
	dd	11
	dd	47
_93:
	db	"CheckMouse",0
_94:
	db	"mx",0
_95:
	db	"my",0
	align	4
_92:
	dd	1
	dd	_93
	dd	2
	dd	_6
	dd	_7
	dd	-4
	dd	2
	dd	_8
	dd	_7
	dd	-8
	dd	2
	dd	_9
	dd	_7
	dd	-12
	dd	2
	dd	_10
	dd	_7
	dd	-16
	dd	2
	dd	_94
	dd	_7
	dd	-20
	dd	2
	dd	_95
	dd	_7
	dd	-24
	dd	0
	align	4
_77:
	dd	_54
	dd	15
	dd	2
	align	4
_79:
	dd	_54
	dd	16
	dd	2
	align	4
_81:
	dd	_54
	dd	17
	dd	2
	align	4
_89:
	dd	_54
	dd	18
	dd	3
	align	4
_91:
	dd	_54
	dd	20
	dd	3
_119:
	db	"Self",0
_120:
	db	":Window",0
	align	4
_118:
	dd	1
	dd	_16
	dd	2
	dd	_119
	dd	_120
	dd	-4
	dd	0
_98:
	db	"F:/Dropbox/bmax/NEWRPG/TWindow.bmx",0
	align	4
_97:
	dd	_98
	dd	8
	dd	3
	align	4
_102:
	dd	_98
	dd	9
	dd	3
	align	4
_106:
	dd	_98
	dd	10
	dd	3
	align	4
_110:
	dd	_98
	dd	11
	dd	3
	align	4
_114:
	dd	_98
	dd	12
	dd	3
	align	4
_160:
	dd	1
	dd	_19
	dd	2
	dd	_119
	dd	_120
	dd	-4
	dd	2
	dd	_94
	dd	_7
	dd	-8
	dd	2
	dd	_95
	dd	_7
	dd	-12
	dd	0
	align	4
_124:
	dd	_98
	dd	15
	dd	3
	align	4
_126:
	dd	_98
	dd	16
	dd	3
	align	4
_128:
	dd	_98
	dd	17
	dd	3
	align	4
_132:
	dd	_98
	dd	18
	dd	4
	align	4
_136:
	dd	_98
	dd	19
	dd	4
	align	4
_140:
	dd	_98
	dd	21
	dd	3
	align	4
_142:
	dd	_98
	dd	21
	dd	21
	align	4
_146:
	dd	_98
	dd	22
	dd	3
	align	4
_156:
	dd	_98
	dd	23
	dd	4
	align	4
_243:
	dd	1
	dd	_20
	dd	2
	dd	_119
	dd	_120
	dd	-4
	dd	2
	dd	_94
	dd	_7
	dd	-8
	dd	2
	dd	_95
	dd	_7
	dd	-12
	dd	0
	align	4
_161:
	dd	_98
	dd	27
	dd	3
	align	4
_173:
	dd	_98
	dd	27
	dd	87
	align	4
_177:
	dd	_98
	dd	28
	dd	3
	align	4
_179:
	dd	_98
	dd	28
	dd	21
	align	4
_183:
	dd	_98
	dd	29
	dd	3
	align	4
_185:
	dd	_98
	dd	30
	dd	3
	align	4
_187:
	dd	_98
	dd	31
	dd	3
	align	4
_191:
	dd	_98
	dd	32
	dd	4
	align	4
_197:
	dd	_98
	dd	33
	dd	4
	align	4
_203:
	dd	_98
	dd	34
	dd	4
	align	4
_207:
	dd	_98
	dd	34
	dd	38
	align	4
_211:
	dd	_98
	dd	35
	dd	4
	align	4
_215:
	dd	_98
	dd	35
	dd	38
	align	4
_219:
	dd	_98
	dd	36
	dd	4
	align	4
_225:
	dd	_98
	dd	36
	dd	41
	align	4
_231:
	dd	_98
	dd	37
	dd	4
	align	4
_237:
	dd	_98
	dd	37
	dd	43
	align	4
_270:
	dd	1
	dd	_21
	dd	2
	dd	_119
	dd	_120
	dd	-4
	dd	2
	dd	_94
	dd	_7
	dd	-8
	dd	2
	dd	_95
	dd	_7
	dd	-12
	dd	0
	align	4
_244:
	dd	_98
	dd	41
	dd	3
	align	4
_246:
	dd	_98
	dd	42
	dd	3
	align	4
_248:
	dd	_98
	dd	43
	dd	3
	align	4
_258:
	dd	_98
	dd	44
	dd	4
	align	4
_262:
	dd	_98
	dd	45
	dd	4
	align	4
_266:
	dd	_98
	dd	46
	dd	4
	align	4
_321:
	dd	1
	dd	_22
	dd	2
	dd	_119
	dd	_120
	dd	-4
	dd	0
	align	4
_271:
	dd	_98
	dd	50
	dd	3
	align	4
_272:
	dd	_98
	dd	51
	dd	3
	align	4
_281:
	dd	_98
	dd	52
	dd	3
	align	4
_282:
	dd	_98
	dd	53
	dd	3
	align	4
_289:
	dd	_98
	dd	54
	dd	3
	align	4
_293:
	dd	_98
	dd	54
	dd	23
	align	4
_295:
	dd	_98
	dd	54
	dd	46
	align	4
_296:
	dd	_98
	dd	55
	dd	3
	align	4
_305:
	dd	_98
	dd	56
	dd	3
	align	4
_306:
	dd	_98
	dd	57
	dd	3
	align	4
_313:
	dd	_98
	dd	58
	dd	3
	align	4
_314:
	dd	_98
	dd	59
	dd	3
