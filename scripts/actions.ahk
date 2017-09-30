actionShowMethodsList() {
	Global

	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os �������������
	if (ErrorLevel = 0) {
		return
	}

	nStr := ErrorLevel
	SendInput ^%KeyG%
	WinWait, ������� �� ������ ������
	SendInput, %nStr%{ENTER}

	SendInput, {home}
	SendInput, ^{NumpadAdd}
}

actionShowRegionsList() {
	Global

	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os ��������������,,Hide
	if (ErrorLevel = 0) {
		return
	}

	nStr := ErrorLevel
	SendInput, ^%KeyG%
	WinWait, ������� �� ������ ������
	SendInput, %nStr%{ENTER}

	SendInput, {home}
	SendInput, ^{NumpadAdd}
}

actionShowExtFilesList() {
	Global

	; RunWait, wscript scripts\ExtFiles.js
	RunWait, system\OneScript\bin\woscript.exe scripts\ExtFiles.os,,

	NewText := getTextFromFile()
	If (NewText <> "") {
		ClipWait
		Sleep 1
		set_locale_ru()
		SendInput, !%KeyA%
		SendInput, {DOWN}{DOWN}{Enter}
		WinWait, ��������
		SendInput, ^%KeyV%{Enter}
	}
}

actionShowScriptManager() {
	RunWait, system\OneScript\bin\woscript.exe scripts\����������������.os,,
}

actionShowPrevWords() {
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os allwords,,
	pasteTextFromFile()
}

actionGotoMethodBegin() {
	Global

	getTextUp()
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os ������������,,Hide
	if (ErrorLevel > 0) {
		nStr := ErrorLevel
		SendInput, {CtrlDown}%KeyG%{CtrlUp}
		WinWait, ������� �� ������ ������
		SendInput,%nStr%{ENTER}
	}   
	SendInput, {home}
}

actionGotoMethodEnd() {
	Global

	getTextUp()
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os ������������,,Hide
	if (ErrorLevel > 0) {
		nStr := ErrorLevel
		SendInput ^%KeyG%
		WinWait, ������� �� ������ ������
		SendInput %nStr%{ENTER}
		SendInput ^{SC01A}
	}   
	SendInput, {home}
}

actionShowRegExSearch() {
	Global

	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os RegExSearch,,Hide
	if (ErrorLevel > 0) {
		nStr := ErrorLevel
		Sleep 1
		SendInput ^%KeyG%
		WinWait, ������� �� ������ ������
		SendInput %nStr%{ENTER}
	}   
	SendInput, {home}
}

actionShowRegExSearchLastResult() {
	Global

	SendInput, {home}
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os �������������������������,,Hide
	if (ErrorLevel > 0) {
		nStr := ErrorLevel
		SendInput ^%KeyG%
		WinWait, ������� �� ������ ������
		SendInput %nStr%{ENTER}
	}   
	SendInput, {home}
}

actionShowLastSelect() {
	Global

	SendInput, {home}
	; RunWait, wscript scripts.js null last
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os �����������������������������,,Hide
	if (ErrorLevel > 0) {
		nStr := ErrorLevel
		SendInput ^%KeyG%
		WinWait, ������� �� ������ ������
		SendInput %nStr%{ENTER}
	}   
	SendInput, {home}
	SendInput, ^{NumpadAdd}
}


actionRunAuthorComments(data) {
	RunWait, system\OneScript\bin\oscript.exe scripts\��������������������.os %data%,,hide
}

actionRunLinksToItems() {
	putSelectionInFile()
	RunWait, wscript scripts\generator.js null simple-managment
	pasteTextFromFile()
}

actionShowCodeGenerator() {
	RunWait, wscript scripts\generator.js null generator
	pasteTextFromFile()	
}

actionShowPreprocMethod() {
	RunWait, system\OneScript\bin\woscript.exe scripts\��������������.os �������� �������������������,,
}

actionShowSimpleMetaSearch() {
	Global

	SendInput, ^+%KeyC%
	Sleep 10
	SendInput ^%KeyF%
}

actionShowIncomingObjectTypes() {
	Global
try {
	SendInput, %KeyContextMenu%
	SendInput, {UP}{UP}{UP}{ENTER}
	Sleep 100
	SendInput, {Enter}
	; Sleep 1
	SendInput, ^!%KeyO%
	ActivateWindowByTitle("��������� ���������")
	SendInput, ^%KeyA%
	; ClipWait
	Sleep 1
	putTextFromResultWindowInFile(0)
	module = tmp\module.txt
	
	RunWait, wscript scripts\scripts.js %module% gototype
	;RunWait, system\OneScript\bin\oscript.exe scripts\���������\���������������������.os ����������������������
		; MsgBox %ErrorLevel%
		Sleep 1
	if (ErrorLevel > 0) {
		SendInput, ^{END}
		UpCount := ErrorLevel
		Loop %UpCount%
		{
			SendInput, {UP}
		}	
		SendInput, {ENTER}	
	}
	SendInput, {HOME}

	}  Catch, er {
		MsgBox, er
    Reload
}
}

actionShowMetadataNavigator() {
	Global

	module = tmp\module.txt

	; clear old data
	FileDelete %module%
	FileAppend,, %module%
	RunWait, system\inputbox.exe %module%

	NewText := getTextFromFile()
	If (NewText <> "") {
		; go to service msgs
		SendInput, ^!%KeyO%
		SendInput, ^+%KeyC%
		ActivateWindowByTitle("���������� ������")
		Sleep 1
		; �������� ������� ����
		ControlGetFocus, WinType
		
		If (WinType <> "V8Grid1") {
			; ���� ��� ���� ������ - ����� �������� � ������, ������ ���.
			SendInput, {Tab}
		}

		; show search dlg
		SendInput, ^%KeyF%
		WinWait, ����� �������� ����������
		pasteTextFromFile()
		SendInput, {Enter}
		
		Sleep 2000
		
		ActivateWindowByTitle("���������� ������")

		SendInput, ^%KeyA%
		ClipWait
		SendInput, {Left}{Enter}
		putTextFromResultWindowInFile(0)
		NewText := getTextFromFile()
		If (NewText <> "") {
			SendInput, ^{END}
			RunWait, wscript scripts\scripts.js %module% gotoobject
			NewText := getTextFromFile()
			If (NewText <> "") {
				SendInput, {Home}
				SendInput, ^%KeyF%
				SendInput +{ins}
			
				SendInput, !{Insert}
				ClipWait
				SendInput, {Enter}
				SendInput, {Enter}
			}
		}
	}
}

showMenu() {
	createMenuItems()
	Menu, Popup, Show
}

actionRun1Script() {
	module = tmp\module.os
	
	SendInput ^{SC01E}^{ins}{Left}
	ClipWait
	
	FileDelete %module%

	FileAppend, %Clipboard%, %module%, UTF-8
	RunWait, cmd "/K system\OneScript\bin\oscript.exe tmp/module.os"

}

actionGoToPrevContainedWord() {

	clipboard =

	SendInput ^+{left}^{ins}{right}
	RunWait, system\OneScript\bin\woscript.exe scripts\���������������.os �������� �����������,,
}

actionGoToNextContainedWord() {

	clipboard =

	SendInput ^+{right}^{ins}{left}
	RunWait, system\OneScript\bin\woscript.exe scripts\���������������.os �������� ����������,,
}

actionShowMethodName() {
	Global

	getTextUp()
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os ���������,,

}

actionGenerateServerMethodFromCurMethod() {
	Global

	getTextUp()
	RunWait, system\OneScript\bin\oscript.exe scripts\���������\�����������������.os ���������������������,,Hide

}

actionOneStyleSelection() {
    ; ������������� ��������� ���������� 1�, �.�. � ������ ����������� ����� ������������ ���������� �� ��������
    global
    SendInput, !+%KeyF%
	fileName:="scripts\OneStyle\module.txt"
    putSelectionInFile( fileName )
    RunWait, system\OneScript\bin\oscript.exe scripts\OneStyle\Main.os %fileName%,,Hide
    pasteTextFromFile( fileName, 2 )
	FileDelete %fileName%
}

actionWindowsManager() {
	detect_hidden = 0
	WinGet controls, ControlListHwnd
	static WINDOW_TEXT_SIZE := 32767 ; Defined in AutoHotkey source.
	VarSetCapacity(buf, WINDOW_TEXT_SIZE * (A_IsUnicode ? 2 : 1))
	text := ""
	Loop Parse, controls, `n
	{
		if !detect_hidden && !DllCall("IsWindowVisible", "ptr", A_LoopField)
			continue
		if !DllCall("GetWindowText", "ptr", A_LoopField, "str", buf, "int", WINDOW_TEXT_SIZE)
			continue
		if (buf = "������������") {
			continue
		} 
		text .= buf "`r`n"
	}

	module = tmp\module.txt
	FileDelete %module%
	FileAppend, %text%, %module%, UTF-8

	RunWait, system\SelectValueSharp.exe %module%
	FileRead, text, tmp\module.txt
	Loop Parse, controls, `n
	{
		if !DllCall("GetWindowText", "ptr", A_LoopField, "str", buf, "int", WINDOW_TEXT_SIZE)
			continue
		 if (buf = text) {
		 	WinActivate, ahk_id %A_LoopField%
		 }
	}
}

actionResultSearchFilter() {

	; ������������ ��������� ������
	ActivateWindowByTitle("���������� ������")

	clipboard =
	; �������� � ����������� ������
	SendInput, ^%KeyA%^{ins}
	;SendInput, ^{ins}
	ClipWait
	SendInput, {home}

	module = tmp\module.txt
	FileDelete %module%
	FileAppend, %Clipboard%, %module%, UTF-8

	SendInput, {home}
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\���������������������.os �����������������������,,Hide
	if (ErrorLevel > 0) {
		UpCount := ErrorLevel
		ActivateWindowByTitle("���������� ������")
		Loop %UpCount%
		{
			SendInput, {down}
		}	
		SendInput, {ENTER}	
	}


}


actionTextWinExt() {
	; MsgBox go
	RunWait, system\OneScript\bin\woscript.exe scripts\WinExtTest.os,,
}

actionManager2() {
	RunWait, system\OneScript\bin\woscript.exe scripts\����������������2.os,,	
}