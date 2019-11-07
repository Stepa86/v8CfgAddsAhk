Перем Обмен;
Перем Настройки;

Функция ПолучитьСигантуру(Стр)
	
	Если Настройки.Автор = "%ПользовательОС%" Тогда
		СтрПользователь = ПеременныеСреды()["USERNAME"];
	Иначе
		СтрПользователь = Настройки.Автор;
	КонецЕсли;
	
	Если Настройки.Компания = "%ДоменОС%" Тогда
		СтрКомпания = ПеременныеСреды()["USERDNSDOMAIN"];
	Иначе
		СтрКомпания = Настройки.Компания;
	КонецЕсли;
	
	СтрДата = Формат(ТекущаяДата(), Настройки.ФорматДаты);
	
	Стр = СтрЗаменить(Стр,"%Author%", СтрПользователь);
	Стр = СтрЗаменить(Стр,"%Company%", СтрКомпания);
	Стр = СтрЗаменить(Стр,"%Date%", СтрДата);
	
	Возврат Стр;

КонецФункции

Функция ЗакоментироватьБлок(Данные)

	Код = СокрП(Данные);
	РегВыражение = Новый РегулярноеВыражение("^");
	РегВыражение.Многострочный  = Истина;
	Код = РегВыражение.Заменить(Код,"// ");
	
	Возврат Код;
	
КонецФункции // ЗакоментироватьБлок()

Процедура ОбработкаТекста(Данные, Действие)
	
	НовыеДанные = "";
	Если Действие = "add" Тогда
		НовыеДанные = "//" + Настройки["МеткаДобавлено"] + " " + ПолучитьСигантуру(Настройки.СигнатураНачало)
		+ Символы.ПС
		+ (Данные)
		+ Символы.ПС
		+ "//" + ПолучитьСигантуру(Настройки.СигнатураКонец);
	ИначеЕсли Действие = "edit" Тогда
		НовыеДанные = "//" + Настройки["МеткаИзменено"] + " " + ПолучитьСигантуру(Настройки.СигнатураНачало)
		+ Символы.ПС;
		Если Настройки.СохранятьКодПриИзменении Тогда
			НовыеДанные = НовыеДанные
			+ ЗакоментироватьБлок(Данные)
			+ Символы.ПС;
		КонецЕсли;
		НовыеДанные = НовыеДанные
		+ (Данные)
		+ Символы.ПС
		+ "//" + ПолучитьСигантуру(Настройки.СигнатураКонец);
	ИначеЕсли Действие = "del" Тогда
		НовыеДанные = "//" + Настройки["МеткаУдалено"] + " " + ПолучитьСигантуру(Настройки.СигнатураНачало)
		+ Символы.ПС
		+ ЗакоментироватьБлок(Данные)
		+ Символы.ПС
		+ "//" + ПолучитьСигантуру(Настройки.СигнатураКонец);
	КонецЕсли;	
	
	НовыеДанные = НовыеДанные  + Символы.ПС;
	
	Обмен.УстановитьТекстВВыделение(НовыеДанные);
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// Экспортируемые методы для менеджера скриптов
//
Процедура БлокДобавлен() Экспорт
	ВыделенныйТекст = Обмен.ПолучитьВыделенныйТекст();	
	ОбработкаТекста(ВыделенныйТекст, "add");
КонецПроцедуры

Процедура БлокИзменен() Экспорт
	ВыделенныйТекст = Обмен.ПолучитьВыделенныйТекст();	
	ОбработкаТекста(ВыделенныйТекст, "edit");
КонецПроцедуры

Процедура БлокУдален() Экспорт
	ВыделенныйТекст = Обмен.ПолучитьВыделенныйТекст();	
	ОбработкаТекста(ВыделенныйТекст, "del");
КонецПроцедуры
//
// Экспортируемые методы для менеджера скриптов
///////////////////////////////////////////////////////////////////////////////

Процедура ПриСозданииОбъекта()

	Обмен = ЗагрузитьСценарий("core/Обмен.os");
	Настройки = ЗагрузитьСценарий("settings/ПараметрыАвторскиеКомментарии.os").Настройки;

	Параметры = АргументыКоманднойСтроки;
	Если Параметры.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Действие = СокрЛП(Параметры[0]);
	
	ВыделенныйТекст = Обмен.ПолучитьВыделенныйТекст();	
	ОбработкаТекста(ВыделенныйТекст, Действие);

КонецПроцедуры