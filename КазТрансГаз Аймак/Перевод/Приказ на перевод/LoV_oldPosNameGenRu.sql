select
lower(case when a.position_id is not null then
(select p1.name from hr_ALL_POSITIONS_F_tl p1 where p1.language = 'RU' and p1.position_id =
        (select a2.position_id from per_all_assignments_m a2 where a2.effective_start_date= 
            (select max(a1.EFFECTIVE_START_DATE) from per_all_assignments_m a1 where a1.assignment_id = a.assignment_id and a1.EFFECTIVE_START_DATE<a.effective_start_date) and                                a2.assignment_id = a.assignment_id))
else (
select j.name from PER_JOBS_F_VL  j where j.job_id=
    (select a2.job_id from per_all_assignments_m a2 where a2.effective_start_date= 
         (select max(a1.EFFECTIVE_START_DATE) from per_all_assignments_m a1 where a1.assignment_id = a.assignment_id and a1.EFFECTIVE_START_DATE<a.effective_start_date) and a2.assignment_id = a.assignment_id)
)||' '||
(select o.name  from hr_all_organization_units o where o.organization_id =
(select a2.organization_id from per_all_assignments_m a2 where a2.effective_start_date= (select max(a1.EFFECTIVE_START_DATE) from per_all_assignments_m a1 where a1.assignment_id = a.assignment_id and a1.EFFECTIVE_START_DATE<a.effective_start_date) and a2.assignment_id = a.assignment_id)
)
end)
 oldPosNameGenRu

 from per_all_assignments_m a
join per_person_names_f n on a.person_id = n.person_id and n.name_type='GLOBAL'
where n.last_name||' '||n.first_name||' '||n.middle_names = :fio 
and action_code in ('TRANSFER')
and to_char(a.ass_attribute_date1,'DD.MM.YYYY')||'/'||a.ass_attribute1 = :orderDateNumber