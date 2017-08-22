Перем Обмен;
Перем Скрипты;

Процедура НайтиАвтоСкрипты(Знач РабочийКаталог, Скрипты)
	
	МассивДопустимыхРасширений = Новый Массив;
	МассивДопустимыхРасширений.Добавить(".os");
	МассивДопустимыхРасширений.Добавить(".js");
	
	Каталоги = НайтиФайлы(РабочийКаталог, "*.*", Истина);
	Сообщить("Всего файлов:" + Каталоги.Количество());
	Для Каждого НайденныйФайл Из Каталоги Цикл
		Если МассивДопустимыхРасширений.Найти(НайденныйФайл.Расширение) <> Неопределено  Тогда
			Если НайденныйФайл.Расширение = ".os" Тогда
				Приложение = "system\OneScript\bin\woscript.exe";
			ИначеЕсли НайденныйФайл.Расширение = ".js" Тогда
				Приложение = "wscript";
			КонецЕсли;
			ВставитьСкрипт(НайденныйФайл.ИмяБезРасширения, Приложение + " " + """" + НайденныйФайл.ПолноеИмя + """");
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ВставитьСкрипт(Значение, Ключ)
	Скрипты.Вставить(Ключ, Значение);
КонецПроцедуры

Процедура ВыполнитьДействие()
	
	Скрипты = Новый Соответствие();
	
	ВставитьСкрипт("Выделение в верхний регистр", "system\OneScript\bin\woscript.exe scripts\РаботаСРегистромТекста.os up");
	ВставитьСкрипт("Выделение в нижний регистр", "system\OneScript\bin\woscript.exe scripts\РаботаСРегистромТекста.os down");
	ВставитьСкрипт("Выделение в нормальный регистр", "system\OneScript\bin\woscript.exe scripts\РаботаСРегистромТекста.os normal");
	ВставитьСкрипт("----------------------------------------", "");
	ВставитьСкрипт("Выравнять по равно", "system\OneScript\bin\woscript.exe scripts\format.os align-equal-sign");
	ВставитьСкрипт("Выравнять по первой запятой", "system\OneScript\bin\woscript.exe scripts\format.os align-first-comma");
	ВставитьСкрипт("Выравнять по выбранному значению", "system\OneScript\bin\woscript.exe scripts\format.os align-user-symbol");
	ВставитьСкрипт("---------------------------------------", "");
	ВставитьСкрипт("Убрать пробелы в конце строк", "system\OneScript\bin\woscript.exe scripts\format.os rtrim");
	ВставитьСкрипт("Добавление ссылки на реквизит в модуле", "wscript scripts\generator.js null simple-managment");
	ВставитьСкрипт("Генератор кода", "wscript scripts\generator.js null generator");
	ВставитьСкрипт("============ Автоматически добавленные ============", "");
	
	ТекПуть = ТекущийКаталог() + "\scripts\auto\";
	НайтиАвтоСкрипты(ТекПуть, Скрипты);
	
	ВыборИзСписка = ЗагрузитьСценарий("scripts\SelectValue.os");
	Результат = ВыборИзСписка.ВыбратьИзСписка(Скрипты, Истина);
	
	Если Результат <> "" Тогда
		КодВозврата = 0;
		ЗапуститьПриложение(Результат, , Истина, КодВозврата);
		ЗавершитьРаботу(1);
	КонецЕсли;

	ЗавершитьРаботу(0);
	
КонецПроцедуры

Обмен = ЗагрузитьСценарий("scripts\Обмен.os");

ВыполнитьДействие();