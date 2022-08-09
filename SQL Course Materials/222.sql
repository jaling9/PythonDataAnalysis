select * from
(
select a.*,
b.start_code,b.start_name,b.destination_code,b.destination_name,
lead(a.control_mode,1, null) over (PARTITION BY a.robot_sn order by a.robot_sn,a.start_time),
lead(a.start_time,1,null) over (PARTITION BY  a.robot_sn order by a.robot_sn,a.start_time),
lead(a.task_mode,1,null) over (PARTITION BY  a.robot_sn order by a.robot_sn,a.start_time),
lead(a.task_state,1,null) over (PARTITION BY  a.robot_sn order by a.robot_sn,a.start_time),
lead(b.start_code,1,null) over (PARTITION BY  b.robot_sn order by b.robot_sn,b.start_time),
lead(b.start_name,1,null) over (PARTITION BY  b.robot_sn order by b.robot_sn,b.start_time),
lead(b.destination_code,1,null) over (PARTITION BY  b.robot_sn order by b.robot_sn,b.start_time),
lead(destination_name,1,null) over (PARTITION BY  b.robot_sn order by b.robot_sn,b.start_time)
from v_ods_business_food_delivery as a
left join v_dws_business_food_info_ft0 b
on a.id=b.bfd_id
where a.start_time>'2022-01-01'
) c
where c.control_mode='2'