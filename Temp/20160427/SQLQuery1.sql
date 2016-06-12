use Store
go


select
	Account.Id,
	MoneyTransaction.DateTime,
	Account.Name,
	MoneyTransaction.GUID
	
From
	dbo.Accounts AS Account

	INNER JOIN (SELECT TOP 10 * FROM dbo.MoneyTransactions) AS MoneyTransaction ON
		MoneyTransaction.AccountId = Account.Id

FOR XML AUTO






