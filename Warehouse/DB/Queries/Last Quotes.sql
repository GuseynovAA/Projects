USE tempdb
GO

select
	S.ID,
	S.Name,
	SQ.[Date],
	SQ.Value
from
	Securities S
	cross apply (
		select top 1
			SQ.[Date],
			SQ.Value
		from Securities_Quotes SQ with (nolock)
		where SQ.Security_ID = S.ID
		order by SQ.[Date] desc
	) SQ
order by S.ID