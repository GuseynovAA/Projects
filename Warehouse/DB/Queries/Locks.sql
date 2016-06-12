select 
    req.session_id, 
       su.name UserName,
       db.name, 
    sqltext.text, 
       req.wait_type, 
       req.user_id,
       req.status, 
       req.command, 
       req.cpu_time, 
       req.total_elapsed_time,
       req.total_elapsed_time / 1000 / 60.0           total_elapsed_time_min,
       req.total_elapsed_time / 1000 / 60.0 / 60      total_elapsed_time_hour,
       lock_timeout, 
       blocking_session_id
from 
       sys.dm_exec_requests req
left join
       sys.sysusers su ON
       (
             su.uid = req.user_id
       )
inner join 
       sys.databases as db on 
       (
             req.database_id = db.database_id 
       )
cross apply 
       sys.dm_exec_sql_text(sql_handle) as sqltext 
--where 
       --req.session_id = 136
order by 
       req.total_elapsed_time desc
