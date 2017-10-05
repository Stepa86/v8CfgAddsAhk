#include core\KeyCodes.ahk
#include core\WorkWithModule.ahk
#include core\WorkWithWindows.ahk
#include scripts\actions.ahk
#include scripts\menu.ahk


Ctrl_A = ^{SC01E}
Ctrl_L = ^{SC026}
Ctrl_Shift_Z = ^+{SC02C}

; ----------------------------------
; Ctrl + 1 ����� ������ ��������
^1:: actionShowMethodsList()

; Ctrl + 2 - ����� ������ ������
^2:: actionShowRegionsList()

; Ctrl + 3 - �������� ������� ������
^3:: actionShowExtFilesList()

; Ctrl + Shift + m - ������ �������
^+sc32:: actionShowScriptManager()

; Ctrl + w ����� ����� ���������� �����
^sc11:: actionShowPrevWords()

; ----------------------------------
; ������: ��������� ������ ������

; Ctrl + b - � ������ ������
^sc30:: actionGotoMethodBegin()

; Ctrl + e - � ����� ������
^sc12:: actionGotoMethodEnd()
; �����: ��������� ������ ������
; ----------------------------------

;-----------------------------------------------
; --- ����� � ����������� ����������� ---
; Alt + f - ����� � ���.�����������
!sc21:: actionShowRegExSearch()
;-----------------------------------------------
; Alt + r - ���������� ���������� ������
!sc13:: actionShowRegExSearchLastResult()

; shift + alt + r
+!sc13:: actionShowLastSelect()

; --- ������ ---
; ctrl + / (ctrl + .) - ��������������� ������:
^/:: Send, {home}//

; Ctrl + i - ���������� ������: 
^sc17:: SendInput, ^+{NumpadAdd}

; Ctrl-\ ������ '|'
$^\:: SendInput |

; Alt - [ - ������ '['
$!SC01A::Send [ 

; Alt + ] - ������ ']'
$!SC01B::Send ] 

; Alt - & - ������ '&'
$!SC008::Send &

; Ctrl + D - ����������� ������� ������/ ����������� ����� � ������� ����
^sc20:: SendInput, {CTRLDOWN}{INS}{CTRLUP}{Right}{HOME}{HOME}{SHIFTDOWN}{INS}{SHIFTUP}

; ----------------------------------------
; ��������� �����������
; ----------------------------------------
!sc1E:: actionRunAuthorComments("add") ; alt+a - ���� ��������
!sc12:: actionRunAuthorComments("edit") ; alt+e - ���� �������
!sc20:: actionRunAuthorComments("del") ; alt+d - ���� ������
; ����� ��������� �����������
; ----------------------------------------

;-----------------------------------
; �������� �� ���������� � ����� OpenConf
;
; Ctrl + Enter - ������� � ��������� (��� � OpenConf)
^Enter::
	SendInput, {F12}
return

; Alt + - ������� �� ���������� ������� (��� � OpenConf)
!left::
	SendInput, ^-
return
;------------------------------------

; Ctrl+7 - ������������ �������
^SC008:: actionShowPreprocMethod()

;------------------------------------
; ��������� �� ����������

; Alt + J - ����� �� ����������
$!sc24:: actionShowSimpleMetaSearch()

; Ctrl +j - ������� � ������� ���������� �� ���� �������� ���������
$^sc24:: actionShowIncomingObjectTypes()

; Ctrl + shift + j - ������� � ������� ����������
$^+sc24:: actionShowMetadataNavigator()
;------------------------------------

;------------------------------------
; ���������� ���������� ++, +=, --, -=
::++:: 
	clipboard =
 	SendInput, ^+{left}^+{left}^{ins}{Right}{space}{scD}{Space}+{ins}{sc4E}{Space}1;
Return

::--:: 
 	SendInput, ^+{left}^+{left}^{ins}{Right}{space}{scD}{Space}+{ins}{sc4A}{Space}1;
Return

::+=:: 
 	SendInput, ^+{left}^+{left}^{ins}{Right}{space}{scD}{Space}+{ins}{sc4E}{Space}
Return

::-=:: 
 	SendInput, ^+{left}^+{left}^{ins}{Right}{space}{scD}{Space}+{ins}{sc4A}{Space}
Return

::.=:: 
 	SendInput, ^+{left}^+{left}^{ins}{Right}{space}{scD}{Space}+{ins}{sc4E}{Space}
Return

;------------------------------------

; Win + X - �������� ����
#sc02D:: 
	showMenu()
Return

; Alt + Ctrl + ������ - ������� ����� ��������� �����
!^Space:: 
   actionShowPrevWords()
Return

; ----------------------------------
; Ctrl + 0 ������ 1script
^0:: actionRun1Script()

; -----------------------------------
; ������� � ������ ����� � ��������� ������
; Shift + Alt + Left
!+left::
	actionGoToPrevContainedWord()
return

; ������� � ����� ����� � ��������� ������
; Shift + Alt + Right
!+Right::
	actionGoToNextContainedWord()
return

; Win + N - �������� ��� ������
#sc31::
	actionShowMethodName()
return

; Alt + Up - ����������� ������ �����
!up::
	SendInput, {HOME}{SHIFTDOWN}{END}{SHIFTUP}{SHIFTDOWN}{DEL}{SHIFTUP}^{sc26}{HOME}{UP}{HOME}{ENTER}{UP}{SHIFTDOWN}{INS}{SHIFTUP}
return

; Alt + down - ����������� ������ �����
!down::
	SendInput, {HOME}{SHIFTDOWN}{END}{SHIFTUP}{SHIFTDOWN}{DEL}{SHIFTUP}^{sc26}{END}{ENTER}{SHIFTDOWN}{INS}{SHIFTUP}
return

; Ctrl + Alt + F - ��������� ��������������
^!sc21::
	actionOneStyleSelection()
return

; Win + C - ����� � ����� ����� ��� ��������
#sc2E::
	SendInput, {CTRLDOWN}{left}{SHIFTDOWN}{Right}{SHIFTUP}{ins}{CTRLUP}{Right}
return

; Win + W - �������� ����
#sc11::
	actionWindowsManager()
return

; Win + S - ���������� ����������� ������
#sc1F::
	actionResultSearchFilter()
return

$+$SC01C:: ; Shift+Enter
$+$SC11C:: ; Shift+Enter �� "��������" ����������
	actionContinueRow()
Return