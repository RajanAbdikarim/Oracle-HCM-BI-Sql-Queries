select 

lower(case when a.position_id is null then (select j.name from PER_JOBS_F_VL  j where j.job_id = a.job_id)||' '||(select name  from hr_all_organization_units o where o.organization_id = a.organization_id) 
else  (select f.name  from hr_all_positions_f_tl f where f.position_id = a.position_id and f.language = 'RU') 
end) posNameGenRu


from per_all_assignments_m a
join per_person_names_f n on a.person_id = n.person_id and n.name_type='GLOBAL'
where n.last_name||' '||n.first_name||' '||n.middle_names = :fio 
and a.action_code in ('HIRE','REHIRE') and a.assignment_type = 'E'
and to_char(a.ass_attribute_date1,'DD.MM.YYYY')||'/'||a.ass_attribute1 = :orderDateNumber