﻿
Процедура ВыполнитьДействие()

	Обмен = ЗагрузитьСценарий("scripts\Обмен.os");

	ИмяФайла = "tmp\module.txt";

	СтарыйТекст = Обмен.ПолучитьТекстИзФайла(ИмяФайла);

	Текст = Новый ЗаписьТекста(ИмяФайла, КодировкаТекста.UTF8); 
	Текст.Записать(СтарыйТекст); 
	Текст.Закрыть();		
	ОсвободитьОбъект(Текст);

	ЗапуститьПриложение("cmd /K system\OneScript\bin\oscript.exe " + ИмяФайла);

КонецПроцедуры

ВыполнитьДействие();