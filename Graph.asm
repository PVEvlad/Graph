format PE GUI 5.0
entry start
include 'C:\Assembler\fasm\INCLUDE\win32a.inc'
IDM_EXIT  = 901
IDM_INFO1 = 102
IDM_INFO2 = 103
IDM_FUNC1 = 105
IDM_FUNC2 = 106
IDM_FUNC3 = 107
IDM_CLEAR = 108
IDM_UPDAT = 109
section '.code' code readable writeable executable

start:
push 0
call [GetModuleHandle]
push eax
WinMain:
mov [style], 0
mov [lpfnWndProc], WndProc
mov [cbClsExtra], 0
mov [cbWndExtra], 0
mov [hInstance], eax
mov [hIcon], 0
mov [hCursor], 0
mov [hbrBackground], COLOR_BTNFACE
mov [lpszMenuName], 30h
mov [lpszClassName], _ClassName
push wcex
call [RegisterClass]
mov [Wtx], 100
mov [Wty], 100
;wind
PUSH 0                                   ; /lParam = NULL
PUSH [hInstance]               ; |hInst = NULL
PUSH 0                                   ; |hMenu = NULL
PUSH 0                                   ; |hParent = NULL
PUSH 400                                  ; |Height = 64 (100.)
PUSH 400                                  ; |Width = 96 (150.)
PUSH [Wty]                                  ; |Y = 0
PUSH [Wtx]                                   ; |X = 0
PUSH WS_OVERLAPPED+WS_MINIMIZEBOX+WS_MAXIMIZEBOX+WS_SYSMENU+WS_THICKFRAME+WS_CAPTION+WS_VISIBLE
PUSH _WindowName                          ; |WindowName = "New Window"
PUSH _ClassName                           ; |Class = "ClassName"
PUSH 0 ; |ExtStyle = 0
call [CreateWindow]
mov [hWnd1], eax

StartLoop:
push 0
push 0
push 0
push msg
call [GetMessage]
cmp eax, 1
jb ExitProgramm
jne StartLoop
push msg
call [TranslateMessage]
push msg
call [DispatchMessage]
jmp StartLoop

shwAB:
mov [left2],0
push 1
push [Aedit]
call [ShowWindow]

push 1
push [Bedit]
call [ShowWindow]
jmp noosi  
;;;;;;;;;;;;;;;;;
osi:
push 1
push 0
push dword [ebp+hwnd2]
call [InvalidateRect]
push ps
push dword [ebp+hwnd2]
call [BeginPaint]
mov [dc], EAX

call DrowOsi;, dc, 0, 0, ADDR TextOfWin, 15h

  push 0x000000FF
  push 2
  push PS_SOLID
  call [CreatePen];CreatePen(PS_SOLID, 2, 0);
  mov [hPen], eax
  push [hPen]
  push [hdc]
  call [SelectObject];SelectObject(hdc, hpen);
        fld [parA]
        fimul [stepy]
        fstp [parA]
        fld [parB]
        fimul [stepy]
        fstp [parB]
call Razn
  push [hPen]
  call [DeleteObject];DeleteObject(hpen)

push ps


push dword [ebp+hwnd2]
call [EndPaint];, hwin, ADDR ps
ret
;;;;;;;;;;;;;;;;;;;
Razn:
cmp [q],1
jne no1

push 7
push _func1
push 0
push 0
push [hdc]
call [TextOut]

 push 0
        mov eax,[centy] ;eax - центр                
                fld dword[parA]
                mov [x1],-7
                fimul [x1]
                ;fimul [stepy]
                fist  dword[x1]
                sub eax,[x1]
                mov [y1],eax
                
                fld dword[parB]
                ;fimul [stepy]
        fistp [x1]
        mov eax, [y1]
        sub eax, [x1]
 push eax
 push [left]
 push [hdc]
 call [MoveToEx];MoveToEx(hdc, x, Y, 0)

        mov eax,[centy] ;eax - центр            
                fld dword[parA]
                mov [x1],7
                fimul [x1]
                fist  dword[x1]
                sub eax,[x1]
                mov [y1],eax
                
                fld dword[parB]
                ;fimul [stepy]
        fistp [x1]
        mov eax, [y1]
        sub eax, [x1]
 push eax
 push [right]
 push [hdc]
 call [LineTo];LineTo(hdc, x, Y)
 
no1:
cmp [q],2
jne no2
fld [parB]
fidiv [stepy]
fstp [parB]
push 0
        mov [x1],-7
                fild dword[x1]
                                fmul[parB]
                fsin
                fmul [parA]
                fist dword[NUM]
                mov eax,[centy]
                sub eax,[NUM]
        fild dword[x1]
push eax
push [left]
push [hdc]
call [MoveToEx];MoveToEx(hdc, x, Y, 0)

loop_sin:
fadd [step]
fst  st1
        fimul [stepx]
        mov eax,[centx]
        fist dword[x1]
        add eax,[x1]
        
        fcomp;  dword[x1]
        fst st1
        fmul [parB]
        fsin
        fmul [parA]
        mov ebx,[centy]
        fist dword[x1]
        sub ebx,[x1]
 push ebx 
 push eax
 push [hdc]
 call [LineTo]
fcomp  ;[x1]
fst st1
fist dword[x1]
cmp [x1],8
jne loop_sin

push 14
push _func2
push 0
push 0
push [hdc]
call [TextOut]

no2:
cmp [q],3
jne no3

push 0
        mov [x1],-7
                fild dword[x1]
                                fimul dword[x1]
                                fmul  dword[parA]
                                fadd  dword[parB]
                fist dword[NUM]
                mov eax,[centy]
                sub eax,[NUM]
        fild dword[x1]
push eax
push [left]
push [hdc]
call [MoveToEx];MoveToEx(hdc, x, Y, 0)

loop_tr:
fadd [step]
fst  st1
        fimul [stepx]
                fist [x1]
        mov eax,[centx]
        add eax,[x1]
        
        fcomp; dword[x1]
        fst st1
                fst [x1]
                
                                fmul dword[x1]
                                fmul  dword[parA]
                                fadd  dword[parB]
        mov ebx,[centy]
        fist dword[x1]
        sub ebx,[x1]
 push ebx 
 push eax
 push [hdc]
 call [LineTo]
fcomp  ;[x1]
fst st1
fist dword[x1]
cmp [x1],8
jne loop_tr

push 11
push _func3
push 0
push 0
push [hdc]
call [TextOut]
no3:
ret
;;;;;;;;;;;;;;;;;;
DrowOsi: 
 mov eax, [right]
 sub eax, [left]
 mov edx, 0
 mov ebx,2
 div ebx
 mov [centx],eax
 mov ebx,7
 mov edx,0
 div ebx
 mov [stepx],eax
 mov eax, [bottom]
 sub eax, [top]
 mov edx, 0
 mov ebx,2
 div ebx
 mov [centy],eax
 mov ebx,7
 mov edx,0
 div ebx
 mov [stepy],eax
 mov eax, dword[stepy]
 mov eax,[centx]
 mov [tekx],eax
 mov eax,[centy]
 mov [teky],eax
push 0x00FF0000
push [hdc]
call [SetTextColor];(hdc, 0x00FF0000); //устанавливаем цвет текста синий

push 1
push _y
push  0
add [tekx],5
push [tekx];10;eax
push [hdc]
call [TextOut];(hdc, OffsetX + 10, 0, L"Y", 1);
sub [tekx],5

push 2
push _A
push  30
push  0
push [hdc]
call [TextOut];(hdc, OffsetX + 10, 0, L"Y", 1);

push 2
push _B
push  60
push  0
push [hdc]
call [TextOut];(hdc, OffsetX + 10, 0, L"Y", 1);

push 1
push _x
push [teky]
push [right]
push [hdc]
call [TextOut];(hdc, x, y, str, 1);

mov [tekchisl],30h
push 1
push tekchisl
push [centy]
push [centx]
push [hdc]
call [TextOut];(hdc, x, y, str, 1);

sub [centx],8
mov eax,0
mov ebx,0
mov ecx,0
mov edx,0
mov [stringsize], 1;количество выводимых символов
mov cl, 7; модуль числа
mov [tekx], 0
mov [teky], 0
looposi:

mov [tekchisl], ecx
add [tekchisl],30h

push [stringsize]
push tekchisl
push [teky]
push [centx]
push [hdc]
call [TextOut];(hdc, x, y, str, 1);

sub [centy],8
push 1
push lin
push [centy]
push [tekx]
push [hdc]
call [TextOut]
add [centy],8
add [stringsize],1
push [stringsize]
push minus
push [centy]
push [tekx]
push [hdc]
call [TextOut];(hdc, x, y, str, 1);
sub [stringsize],1
mov eax, [stepy]
add [teky], eax

mov eax, [stepx]
add [tekx], eax

mov ecx, [tekchisl]
sub cl, 30h
sub cl, 1

cmp cl, 0
jne looposi

mov cl, 7; модуль числа
mov eax, [right]
mov [tekx], eax
mov eax, [bottom]
mov [teky], eax
mov [stringsize],3
looposi2:

mov [tekchisl], ecx
add [tekchisl],30h

sub [centx],4
push [stringsize]
push minus
push [teky]
push [centx]
push [hdc]
call [TextOut];(hdc, x, y, str, 1);
add [centx],4

sub [centy],8
push 1
push lin
push [centy]
push [tekx]
push [hdc]
call [TextOut]
add [centy],8

sub [stringsize],2
push [stringsize]
push tekchisl
push [centy]
push [tekx]
push [hdc]
call [TextOut];(hdc, x, y, str, 1);
add [stringsize],2

mov eax, [stepy]
sub [teky], eax

mov eax, [stepx]
sub [tekx], eax

mov ecx, [tekchisl]
sub cl, 30h
sub cl, 1

cmp cl, 0
jne looposi2

 push 0
 push 1
 push PS_SOLID
 call [CreatePen];CreatePen(PS_SOLID, 2, 0);
 mov [hPen], eax
 push [hPen]
 push [hdc]
 call [SelectObject];SelectObject(hdc, hpen);
 push 0
 push 0
 push [centx]
 push [hdc]
 call [MoveToEx];MoveToEx(hdc, x, Y, 0)
 push [bottom]
 push [centx]
 push [hdc]
 call [LineTo];LineTo(hdc, x, Y)
 push 0
 push [centy]
 push 0
 push [hdc]
 call [MoveToEx];MoveToEx(hdc, x, Y, 0)
 push [centy]
 push [right]
 push [hdc]
 call [LineTo];LineTo(hdc, x, Y)
 push [hPen]
 call [DeleteObject];DeleteObject(hpen)


ret
;;;;;;;;;;;;;;;;;
obr_vvod:
strok   = 08h
chisl = 0ch
push ebp
mov ebp,esp

fistp dword[loop_num]
fistp dword[loop_num]
fistp dword[loop_num]
fistp dword[loop_num]
fistp dword[loop_num]
fistp dword[loop_num]
fistp dword[loop_num]
fldz
mov [loop_num],1
mov [NUM],0
mov ebx,[ebp+strok]
mov eax,0
mov dh,byte[ebx]
cmp dh,'-'
jne loopchisl
add ebx,1
mov dh,byte[ebx]
mov [NUM],1
loopchisl:
cmp dh,0
je endchisl
cmp dh,','
je drobloop
cmp dh,'.'
je drobloop
sub dh, 30h
imul eax,0ah
mov ecx,0
mov cl,dh
mov [vvod], ecx
add eax,[vvod]
add ebx, 1
mov dh,byte[ebx]
jmp loopchisl

drobloop:
add ebx,1
mov dh,byte[ebx]
cmp dh,0
je endchisl
sub dh,30h
xor ecx,ecx
mov cl,dh
mov [vvod],ecx
fild dword[vvod]
localloop:
mov [vvod],0ah
fidiv [vvod]
inc [tek_loop]
mov ecx,[tek_loop]
cmp [loop_num],ecx
jne localloop
fadd st0,st1
mov [tek_loop],0
inc [loop_num]
jmp drobloop

endchisl:
mov ecx,[ebp+chisl]
mov [ecx],eax
fiadd dword[ecx]
fst dword[ecx]

cmp [NUM],1
jne nomin
mov [NUM],-1
fimul [NUM]
nomin:

fst dword[ecx]
pop ebp
ret 08h 
;;;;;;;;;;;;;;;;;
ExitProgramm:
push [wParam]
call [ExitProcess]

WndProc: ;HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam
hwnd2   = 08h
uMsg2   = 0ch
wParam2 = 10h
lParam2 = 14h
push ebp
mov ebp, esp
cmp dword [ebp+uMsg2], 10h
jz msgCloseWindow
cmp dword [ebp+uMsg2], 02h
jz msgDestroyWindow

cmp dword [ebp+uMsg2],WM_CREATE
jnz nocreat
;;;;;;;;;;;;;;;;;;
fild dword[parA]
fst  dword[parA]
fild dword[parB]
fst  dword[parB]
mov [step],1
fild dword[step]
mov [x1],10
fidiv [x1]
fidiv [x1]
fst dword[step]
PUSH 0                                   ; 
PUSH 0                                   ; 
PUSH 0                                   ; 
PUSH dword [ebp+hwnd2]                   ;
PUSH 20                                  ; 
PUSH 60                                  ; 
PUSH 30                                  ; 
PUSH 20                                  ; 
PUSH WS_CHILD+WS_BORDER                  ;
PUSH _nachA                              ; 
PUSH _Edit                               ; 
PUSH 0                                   ;
call [CreateWindow]
mov [Aedit], EAX

PUSH 0                                   ; 
PUSH 0                                   ; 
PUSH 0                                   ; 
PUSH dword [ebp+hwnd2]                   ;
PUSH 20                                  ; 
PUSH 60                                  ; 
PUSH 60                                  ; 
PUSH 20                                  ; 
PUSH WS_CHILD+WS_BORDER       ;
PUSH _nachB                              ; 
PUSH _Edit                               ; 
PUSH 0                                   ;
call [CreateWindow]
mov [Bedit], EAX
;;;;;;;;;;;;;;;;;;
nocreat:

cmp [q], 0
je prop
push rect1
push [hWnd1]
call [GetWindowRect]

mov eax, [right1]
sub eax, [left1]
mov [Wtx], eax
mov eax, [right2]
sub eax, [left2]
cmp eax,[Wtx]
je nox
push rect2
push [hWnd1]
call [GetWindowRect]
jmp update
call osi
nox:

mov eax, [bottom1]
sub eax, [top1]
mov [Wty], eax
mov eax, [bottom2]
sub eax, [top2]
cmp eax,[Wty]
je noy
push rect2
push [hWnd1]
call [GetWindowRect]
jmp update
call osi
noy:

prop:
cmp dword [ebp+uMsg2],WM_COMMAND
jnz nocom

cmp word [ebp+wParam2], IDM_UPDAT
jne no_update
update:
push 12h
push _nachA
push [Aedit]
call [GetWindowText]
push 12h
push _nachB
push [Bedit]
call [GetWindowText]
push parA
push _nachA
call obr_vvod
push parB
push _nachB
call obr_vvod
push 0
push 0
push dword [hWnd1]
call [InvalidateRect]
call osi
no_update:

cmp word [ebp+wParam2], IDM_CLEAR
jne noclear
mov [q],0
push 0
push [Aedit]
call [ShowWindow]

push 0
push [Bedit]
call [ShowWindow]

push 1
push 0
push dword [hWnd1]
call [InvalidateRect]
noclear:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp word [ebp+wParam2], IDM_INFO2
jne noInfProg
push 0
push _zag
push _InfProg
push 0
call [MessageBox]
noInfProg:

cmp word [ebp+wParam2], IDM_INFO1
jne noInfAut
push 0
push _zag
push _InfAut
push 0
call [MessageBox]
noInfAut:

cmp word [ebp+wParam2], IDM_FUNC1
jne no_func1
mov [q], 1
jmp shwAB
no_func1:

cmp word [ebp+wParam2], IDM_FUNC2
jne no_func2
mov [q], 2
jmp shwAB
no_func2:

cmp word [ebp+wParam2], IDM_FUNC3
jne no_func3
mov [q], 3
jmp shwAB
no_func3:
noosi:

cmp word [ebp+wParam2], IDM_EXIT
jne noexit
push dword [ebp+hwnd2]
call [DestroyWindow]
noexit:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nocom:


jmp ExitWndProc
msgCloseWindow:
push dword [ebp+hwnd2]
call [DestroyWindow]
jmp ExitWndProc
msgDestroyWindow:
push 0
call [PostQuitMessage]
ExitWndProc:
push dword [ebp+lParam2]
push dword [ebp+wParam2]
push dword [ebp+uMsg2]
push dword [ebp+hwnd2]
call [DefWindowProc]
mov esp,ebp
pop ebp
;leave
ret 10h

section '.data' data readable writable
ClassName db 'PerFas',0
tekx dd ?
teky dd ?
stepx dd ?
stepy dd ?
;char
lin db '|'
minus db '-'
tekchisl dd ?
cherta db '--'
;bool
q db 0
dc dd 0
;double 
parA  dd  1 
parB  dd  1
;int
stringsize dd ?
NUM     dd ?
defoult dd 0
Wtx     dd ?
Wty     dd ?
;char*
buf db 0,0,0,0,0,0,0,0,0,0
step dd ?
;double**
;x dd 0
;y dd 0
vvod dd ?
x1 dd  ?
y1 dd  ?
;HWND
Aedit dd 0
Bedit dd 0
hWnd1 dd ?
;HDC
;hdc   dd 0
;hpen
hPen  dd 0
;wndclassex
wcex:
style           dd ?
lpfnWndProc     dd ?
cbClsExtra      dd ?
cbWndExtra      dd ?
hInstance       dd ?
hIcon           dd ?
hCursor         dd ?
hbrBackground   dd ?
lpszMenuName    dd ?
lpszClassName   dd ?
msg:
  hWnd    dd ?
  message dd ?
  wParam  dd ?
  lParam  dd ?
  time    dd ?
  pt:
    x dd ?
    y dd ?
;RECT
rect1:
left1   dd ?;
top1    dd ?;
right1  dd ?;
bottom1 dd ?;
rect2:
left2   dd ?;
top2    dd ?;
right2  dd ?;
bottom2 dd ?;
;;;;;;;;;;;;;;
schetchik db 0
centx dd ?
centy dd ?
loop_num dd 1
tek_loop dd 0
;PAINTSTRUCT
ps:
  hdc         dd ?
  fErase      dd ?
  rcPaint:     ;RECT
        left     dd ?
        top      dd ?
        right    dd ?
        bottom   dd ?
  fRestore    dd ?
  fIncUpdate  dd ?
  rgbReserved db 32 dup (?)

_ClassName     : db 'ClassName', 0
_WindowName    : db 'New Window', 0
_FailtRegister : db 'Не удалось зарегистрировать класс', 0
_FailtCreate   : db 'Не удалось создать окно', 0
_FailtLoad     : db 'Не удалось Загрузить меню', 0
_FailtSet      : db 'Не удалось Привязать меню', 0
_ItemMenu      : db 'Пункт меню', 0
_main_menu     : db 'main_menu', 0
_InfProg       : db 'Выбирайте нужный график в <функции> Вводите нужные параметры. Жмите <обновить> в <параметры>', 0
_InfAut        : db 'Группа ЭВМ 3-1.Пухаев В.Э.', 0
_Edit          : db 'Edit', 0
_nachA         : db '1', 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
_nachB         : db '1', 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
_zag           : db 'Заголовок для сообщений', 0
_y             : db 'Y',0
_x             : db 'X',0
_A             : db 'A=',0
_B             : db 'B=',0
_func1         : db 'Y=A*X+B',0
_func2         : db 'Y=A*sinus(B*X)',0
_func3         : db 'Y=A*(x^2)+B',0
section '.bss' data readable writeable
hMenu dd ?
section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,     RVA kernel_table
  dd 0,0,0,RVA user_name,       RVA user_table
  dd 0,0,0,RVA gdi32_name,      RVA GDI32_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess            dd RVA _ExitProcess
    GetModuleHandle        dd RVA _GetModuleHandle
    GetCommandLine         dd RVA _GetCommandLine

    dd 0
  user_table:
    GetWindowText          dd RVA _GetWindowText
    MessageBox             dd RVA _MessageBox
    CreateWindow           dd RVA _CreateWindow
    RegisterClass          dd RVA _RegisterClassA
    TranslateMessage       dd RVA _TranslateMessage
    GetMessage             dd RVA _GetMessage
    DispatchMessage        dd RVA _DispatchMessage
    DefWindowProc          dd RVA _DefWindowProcA
    PostQuitMessage        dd RVA _PostQuitMessage
    DestroyWindow          dd RVA _DestroyWindow
    InvalidateRect         dd RVA _InvalidateRect
    ShowWindow             dd RVA _ShowWindow
    BeginPaint             dd RVA _BeginPaint
    EndPaint               dd RVA _EndPaint
    GetWindowRect          dd RVA _GetWindowRect
    dd 0
   
   GDI32_table:
    SetTextColor           dd RVA _SetTextColor
        TextOut                dd RVA _TextOut
        CreatePen              dd RVA _CreatePen
        SelectObject           dd RVA _SelectObject
        MoveToEx               dd RVA _MoveToEx
        LineTo                 dd RVA _LineTo
        DeleteObject           dd RVA _DeleteObject
        dd 0

  kernel_name db 'KERNEL32.DLL',0
  user_name   db 'USER32.DLL'  ,0
  gdi32_name  db 'GDI32.dll'   ,0

_GetWindowRect     dw      0
   db 'GetWindowRect',     0
_GetWindowText     dw      0
   db 'GetWindowTextA',     0
_GetSystemMetrics  dw      0
   db 'GetSystemMetrics',  0
_GetCommandLine    dw      0
   db 'GetCommandLineA',   0
_DeleteObject      dw      0
   db 'DeleteObject',      0
_LineTo            dw      0
   db 'LineTo',            0
_MoveToEx          dw      0
   db 'MoveToEx',          0
_CreatePen         dw      0
   db 'CreatePen',         0
_SelectObject      dw      0
   db  'SelectObject',     0
_MessageBox        dw      0
   db 'MessageBoxA',       0
_GetModuleHandle   dw      0
   db 'GetModuleHandleA',  0
_ExitProcess       dw      0
   db 'ExitProcess',       0
_CreateWindow      dw      0
   db 'CreateWindowExA',   0
_GetMessage        dw      0
   db 'GetMessageA',       0
_TranslateMessage  dw      0
   db 'TranslateMessage',  0
_DispatchMessage   dw      0
   db 'DispatchMessageA',  0
_RegisterClassA    dw      0
   db 'RegisterClassA',    0
_DefWindowProcA    dw      0
   db 'DefWindowProcA',    0
_PostQuitMessage   dw      0 
   db 'PostQuitMessage',   0
_DestroyWindow     dw      0
   db 'DestroyWindow',     0
_InvalidateRect    dw      0
   db 'InvalidateRect',    0
_ShowWindow        dw      0
   db 'ShowWindow',        0
_BeginPaint        dw      0
   db 'BeginPaint',        0
_EndPaint          dw      0
   db 'EndPaint',          0
_SetTextColor      dw      0
   db 'SetTextColor',      0
_TextOut           dw      0
   db 'TextOutA',          0

section '.rsrc' resource data readable
directory RT_MENU , menus
resource menus,30h,LANG_ENGLISH+SUBLANG_DEFAULT,main_menu
menu main_menu
menuitem 'Exit',         IDM_EXIT
menuitem 'Update',       IDM_UPDAT
menuitem 'Clear',        IDM_CLEAR
menuitem 'Info', 0,      MFR_POPUP
menuitem 'Aouthor',      IDM_INFO1
menuitem 'Program',      IDM_INFO2, MFR_END
menuitem 'Functions',0,  MFR_POPUP + MFR_END
menuitem 'Lin',          IDM_FUNC1
menuitem 'Sinus',        IDM_FUNC2
menuitem 'Parabola',     IDM_FUNC3, MFR_END