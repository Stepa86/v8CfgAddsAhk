Перем Обмен;
Перем ВыборИзСписка;

Процедура ВыбратьПрепроцессор() Экспорт
	
	Данные = Новый Соответствие;
	Данные.Вставить("&НаСервере", "&НаСервере");
	Данные.Вставить("&НаСервереБезКонтекста", "&НаСервереБезКонтекста");
	Данные.Вставить("&НаКлиенте", "&НаКлиенте");
	
	Результат = ВыборИзСписка.ВыбратьИзСписка(Данные);
	Обмен.УстановитьТекстВВыделение(Результат);
	
КонецПроцедуры

Процедура ПриСозданииОбъекта()
	
	Обмен = ЗагрузитьСценарий("core/Обмен.os");
	ВыборИзСписка = ЗагрузитьСценарий("core/SelectValue.os");
	
	Если АргументыКоманднойСтроки.Количество() > 0 Тогда
		Параметры = Обмен.РазобратьПараметры(АргументыКоманднойСтроки);
		Если Параметры.Действие = "ВыбратьПрепроцессор" Тогда
			ВыбратьПрепроцессор();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры