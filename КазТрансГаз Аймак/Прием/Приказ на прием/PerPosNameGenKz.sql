select 

(case when a.position_id is null then  
(select 


case 
when lower(substr(trim(o.attribute2),-1,1)) in ('а','о','ұ', 'ы') then trim(o.attribute2)||'ның'
when lower(substr(trim(o.attribute2),-1,1)) in ('ә','ө','ү', 'і','е', 'э') then trim(o.attribute2)||'нің'
when lower(substr(trim(o.attribute2),-1,1)) in ('п','ф','қ','к','т','с','ш','щ','х','ц','ч','б','в','г','ғ','д','һ') then 
 case when lower(substr(trim(o.attribute2),-2,1)) in ('а','о','ұ', 'ы') then  trim(o.attribute2)||'тың' else trim(o.attribute2)||'тің' end
when lower(substr(trim(o.attribute2),-1,1)) in ('ж','з','л','р','й','и','у','ь') then 
 case when lower(substr(trim(o.attribute2),-2,1)) in ('а','о','ұ', 'ы') then  trim(o.attribute2)||'дың' else trim(o.attribute2)||'дің' end
when lower(substr(trim(o.attribute2),-1,1)) in ('м','н','ң') then 
 case when lower(substr(trim(o.attribute2),-2,1)) in ('а','о','ұ', 'ы') then  trim(o.attribute2)||'ның' else trim(o.attribute2)||'нің' end
end  

from hr_all_organization_units o where o.organization_id = a.organization_id)
||' '||

(select 
 
case when substr(trim(j.attribute16),-1,1) in ('і', 'ы') then j.attribute16 else case when substr(trim(j.attribute16),-2,1)  in ('а','о','ұ', 'ы') then trim(j.attribute16)||'ы' else trim(j.attribute16)||'і' end end
from PER_JOBS_F_VL  j where j.job_id = a.job_id)

 
else  
(select 
case when substr(f.attribute2,-1,1) in ('і', 'ы') then f.attribute2 else case when substr(f.attribute2,-2,1)  in ('а','о','ұ', 'ы') then f.attribute2||'ы' else f.attribute2||'і' end end
from hr_all_positions_f f where f.position_id = a.position_id) 
end) posNameGenKz


from per_all_assignments_m a
join per_person_names_f n on a.person_id = n.person_id and n.name_type='GLOBAL'
where n.last_name||' '||n.first_name||' '||n.middle_names = :fio 
and action_code in ('HIRE','REHIRE')
and to_char(a.ass_attribute_date1,'DD.MM.YYYY')||'/'||a.ass_attribute1 = :orderDateNumber