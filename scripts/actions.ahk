actionShowMethodsList() {
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os �������������
}

actionShowRegionsList() {
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os ��������������
}

actionShowExtFilesList() {
	RunWait, system\OneScript\bin\woscript.exe scripts\ExtFiles.os,,
}

actionShowScriptManager() {
	RunWait, system\OneScript\bin\woscript.exe scripts\����������������.os,,
}

actionShowPrevWords() {
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os allwords,,
	pasteTextFromFile()
}

actionGotoMethodBegin() {
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os ������������
}

actionGotoMethodEnd() {
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os �����������
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
		SendInput, {home}
	}   
	
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
		SendInput, {home}
	}   
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
		SendInput, {home}
		SendInput, ^{NumpadAdd}
	}   
}


actionRunAuthorComments(data) {
	RunWait, system\OneScript\bin\oscript.exe scripts\��������������������.os %data%,,hide
}

actionShowPreprocMethod() {
	RunWait, system\OneScript\bin\woscript.exe scripts\��������������.os �������������������,,
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
	RunWait, system\OneScript\bin\woscript.exe scripts\���������������.os prev,,
}

actionGoToNextContainedWord() {

	clipboard =

	SendInput ^+{right}^{ins}{left}
	RunWait, system\OneScript\bin\woscript.exe scripts\���������������.os next,,
}

actionShowMethodName() {
	; Global

	; getTextUp()
	RunWait, system\OneScript\bin\woscript.exe scripts\���������\�����������������.os ���������,,

}

actionOneStyleSelection() {
    ; ������������� ��������� ���������� 1�, �.�. � ������ ����������� ����� ������������ ���������� �� ��������
    global
    SendInput, !+%KeyF%
	RunWait, system\OneScript\bin\woscript.exe scripts\OneStyle\Main.os,,Hide
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

actionContinueRow() {
	SendInput, {SHIFTDOWN}{up}{up}{up}{SHIFTUP}^{Insert}
	ClipWait
	SendInput, {Right}
	RunWait, system\OneScript\bin\woscript.exe scripts\��������������.os ���������������������������
}

actionIncrements(kind) {
	; SendInput, ^{ins}
	; ClipWait
	RunWait, system\OneScript\bin\woscript.exe scripts\��������������.os ��������� %kind%
}

actionChoiceTemplate() {
	RunWait, system\OneScript\bin\woscript.exe scripts\��������������.os �������������
}

actionOpenObjectModuleExternal() {
	Global
	SendInput, {CtrlUp}
	SendInput, {CtrlDown}%KeyT%{CtrlUp}
	SendInput, {Tab}{Enter}{down}{Enter}
}
