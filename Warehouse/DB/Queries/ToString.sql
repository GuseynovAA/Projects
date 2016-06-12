USE Warehouse
GO

SELECT
	(SELECT T.SubjectId + ';' FROM CRM.Prime_datSubjects T FOR XML PATH('') ) PhoneNumber
	
FROM CRM.Prime_datSubjects PN
GROUP BY CtaId



