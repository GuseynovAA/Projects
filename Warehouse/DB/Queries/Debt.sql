USE Warehouse
GO

/*
SELECT
	T.ВидКредита,
	COUNT(DISTINCT T.Клиент) [Клиент],
	COUNT(DISTINCT T.НомерДоговора) [НомерДоговора],
	SUM(T.ТекущийДолг) [ТекущийДолг],
	SUM(T.ОсновнойДолг) [ОсновнойДолг]
FROM
	(
		SELECT
			EPL.Клиент,
			EPL.НомерДоговора,
			EPL.ВидКредита,
			EPL.КоличествоДнейПросрочки,
			CALC.ТекущийДолг,
			EPL.ОсновнойДолг
		FROM
			CFT.ЕПЛ_ПросроченныеКредиты AS EPL

			OUTER APPLY ( SELECT EPL.ПросроченныйКредит + EPL.ПросроченныеПроценты + EPL.ПеняКредит + EPL.ПеняПроценты AS [ТекущийДолг] ) AS CALC

		WHERE
			CALC.ТекущийДолг > 0
	) AS T
GROUP BY
	T.ВидКредита
*/

SELECT
	CRED_KIND_NAME,
	SUM(CRED_SUMMA_DOG) [CRED_SUMMA_DOG]
FROM
	CFT.DWH_КредитыДляОтделаРисковИМетодологии AS CFT
WHERE
	CFT.ДатаОтчета = '2014-09-01'
GROUP BY
	CRED_KIND_NAME