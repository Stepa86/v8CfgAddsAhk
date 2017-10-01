Перем Обмен;

////////////////////////////////////////////////////////////
// Вспомогательные методы

Функция ПолучитьТекст()
	Возврат Обмен.ПолучитьВыделенныйТекст();
КонецФункции // ПолучитьТекст()

Процедура УстановитьТекст(НовыеДанные)
	Обмен.УстановитьТекстВВыделение(НовыеДанные);
КонецПроцедуры

// Вспомогательные методы
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// Обработчики данных

Процедура ВВерхнийРегистр() Экспорт
	УстановитьТекст(ВРег(ПолучитьТекст()));
КонецПроцедуры

Процедура ВНижнийРегистр() Экспорт
	УстановитьТекст(НРег(ПолучитьТекст()));
КонецПроцедуры

Процедура ВНормальныйРегистр() Экспорт
	
	Данные = ПолучитьТекст();
	
	ПервыйСимвол = ВРег(Сред(НРег(Данные), 0,1));
	Данные = ПервыйСимвол + Сред(НРег(Данные), 2); 
	
	УстановитьТекст(Данные);
	
КонецПроцедуры

// Обработчики данных
////////////////////////////////////////////////////////////


Процедура ВыполнитьДействие()
	Парамеры = АргументыКоманднойСтроки;
	
	Если Парамеры.Количество() = 1 Тогда
		ПараметрОбработки = АргументыКоманднойСтроки[0];
		
		Если НРег(ПараметрОбработки) = "up" Тогда
			ВВерхнийРегистр();
		ИначеЕсли НРег(ПараметрОбработки) = "down" Тогда
			ВНижнийРегистр();
		ИначеЕсли НРег(ПараметрОбработки) = "normal" Тогда
			ВНормальныйРегистр();
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры


Обмен = ЗагрузитьСценарий("core/Обмен.os");
ВыполнитьДействие();