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
   Menu, Popup, Add, &���������� ������, ����������������

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
      RunWait, system\OneScript\bin\woscript.exe scripts\format.os align-equal-sign
   Return   

   ����������������:
      RunWait, system\OneScript\bin\woscript.exe scripts\auto\��������������.os
   Return   


}

