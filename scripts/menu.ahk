createMenuItems() {

    ; �����, ����� ��������� ������� ����������� ����
    Menu, Popup, Add, 
    Menu, Popup, DeleteAll 

   Menu, Popup, Add, �����&����, ���������
   Menu, Popup, Add, �����&�����, ����������
   Menu, Popup, Add, �����&���������, ��������������
   Menu, Popup, Add, �����&�������, ������������
   Menu, Popup, Add, 
   Menu, Popup, Add, ��������� �� &�����, ����������������

   ��������:
   Return

   ���������:
      SendRaw, ���������;
   Return

   ����������:
      SendRaw, ����������;
   Return

   ��������������:
      SendRaw, ��������������;
   Return

   ������������:
      SendRaw, ������������;
   Return

   ����������������:
      putSelectionInFile()
      RunWait, system\OneScript\bin\oscript.exe scripts\format.os align-equal-sign,,Hide
      pasteTextFromFile()
   Return   

}

