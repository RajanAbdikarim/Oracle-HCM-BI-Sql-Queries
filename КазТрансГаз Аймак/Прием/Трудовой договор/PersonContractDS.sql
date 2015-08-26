SELECT a.PERSON_ID, a.ass_attribute5 CONTRACTNUMBER, 
TO_CHAR(a.ass_attribute_date2,'DD.MM.YYYY') CONTRACTDATE
FROM per_all_assignments_m a
join per_person_names_f n on a.person_id = n.person_id and n.name_type='GLOBAL'
where n.last_name||' '||n.first_name||' '||n.middle_names = :fio 
and action_code in ('HIRE','REHIRE')
and to_char(a.ass_attribute_date2,'DD.MM.YYYY')||'/'||a.ass_attribute5 = :termDateNumber