#Использовать logging

Перем Обмен;
Перем _Лог;

////////////////////////////////////////////////////////////
// Вспомогательные методы

Функция ПолучитьТекст()
	Возврат Обмен.ПолучитьВыделенныйТекст();
КонецФункции // ПолучитьТекст()

Процедура УстановитьТекст(Результат)
	Обмен.УстановитьТекстВВыделение(Результат);
КонецПроцедуры

Функция УбратьПробелыСправа(Данные)
	Регулярка = новый РегулярноеВыражение("[ \t]+\r*\n");
	Возврат Регулярка.Заменить(Данные, Символы.ПС);
КонецФункции

Функция ВыравнитьПоЗначению(ЗначениеВыравнивания)
	
	Данные = "";
	ПозицияРавно = 0;	
	МассивСтрок = Новый Массив;
	
	Текст = ПолучитьТекст();
	СтрокиМодуля = СтрРазделить(Текст, Символы.ПС, Истина);
	
	// ЛогСтр = "";
	// Получаем макс.позицию равно
	Для Каждого Стр Из СтрокиМодуля Цикл
		
		Если Лев(СокрЛП(Стр), 2) = "//" Тогда
			МассивСтрок.Добавить(Стр);
		Иначе
			ТекПозицияРавно = Найти(Стр, ЗначениеВыравнивания);
			
			// Подстрока1 = (Лев(Стр, ТекПозицияРавно));
			// Подстрока2 = УбратьПробелыСправа(Подстрока1);
			// ТекПозицияРавно3 = СтрДлина(Подстрока2)+1;
			// _Лог.Добавить(Стр + " - " + ТекПозицияРавно3);

			ПозицияРавно = Макс(ПозицияРавно, ТекПозицияРавно);
			
			// ЛогСтр  = ЛогСтр  + "/"+ПозицияРавноДоОчистки+"/"+Подстрока2+"/"+ТекПозицияРавно+"/"+ПозицияРавно + Символы.ПС;
			
			
			МассивСтрок.Добавить(Стр);
		КонецЕсли
		
	КонецЦикла;
	// Обмен.ЗаписатьРезультатВФайл("tmp\log.txt", ЛогСтр);
	
	// выравниваем по равно
	Для Каждого стр из МассивСтрок Цикл
		
		Если СокрЛП(Стр) = "" Тогда
			Данные = Данные + ?(Данные = "", "", Символы.ПС);
			Продолжить;
		КонецЕсли;
		
		ТекПозицияРавно = Найти(Стр, ЗначениеВыравнивания);
		Если ТекПозицияРавно > 0 Тогда
			Разница = ПозицияРавно - ТекПозицияРавно;
			Пробелы = "";
			Для А = 0 по Разница Цикл
				Пробелы = Пробелы + " ";
			КонецЦикла;
			НоваяСтр = (Сред(Стр, 1, ТекПозицияРавно - 1)) + Пробелы + (Сред(Стр, ТекПозицияРавно));
			Данные = Данные + ?(Данные = "", "", Символы.ПС) + НоваяСтр;
		иначе
			Данные = Данные + ?(Данные = "", "", Символы.ПС) + Стр;
		КонецЕсли;
	КонецЦикла;
	// _Лог.Добавить(УбратьПробелыСправа(Данные));
	Возврат (УбратьПробелыСправа(Данные)); 
КонецФункции

// Вспомогательные методы
////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////
// Обработчики данных

Процедура УбратьЛишниеПробелыСправа() Экспорт
	Данные = ПолучитьТекст();
	УстановитьТекст(УбратьПробелыСправа(Данные));
КонецПроцедуры

Процедура ВыравнитьПоВведеномуСимволу() Экспорт
	Стр = Обмен.ВвестиЗначение("");
	Если СокрЛП(Стр) = "" Тогда
		Возврат;
	КонецЕсли;
	УстановитьТекст(ВыравнитьПоЗначению(Стр));
КонецПроцедуры

Процедура ВыравнитьПоЗапятой() Экспорт
	УстановитьТекст(ВыравнитьПоЗначению(","));
КонецПроцедуры

Процедура ВыравнитьПоРавно() Экспорт
	УстановитьТекст(ВыравнитьПоЗначению("="));
КонецПроцедуры

// Обработчики данных
////////////////////////////////////////////////////////////

Процедура ВыполнитьДействие(Параметры)
	
	Если Параметры.Количество() > 0 Тогда
		
		ВариантОбработки = Параметры[0];
		Если ВариантОбработки = "align-equal-sign" Тогда
			ВыравнитьПоРавно();
		ИначеЕсли ВариантОбработки = "align-first-comma" Тогда
			ВыравнитьПоЗапятой();
		ИначеЕсли ВариантОбработки = "align-user-symbol" Тогда
			ВыравнитьПоВведеномуСимволу();
		ИначеЕсли ВариантОбработки = "rtrim" Тогда
			УбратьЛишниеПробелыСправа();
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Обмен = ЗагрузитьСценарий("core/Обмен.os");
_Лог = Новый ЛогированиеВФайл("tmp/log.log");

ВыполнитьДействие(АргументыКоманднойСтроки);