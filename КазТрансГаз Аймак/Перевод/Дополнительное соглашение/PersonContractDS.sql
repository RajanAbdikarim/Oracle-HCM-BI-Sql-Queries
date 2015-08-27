SELECT 
a.PERSON_ID, 
a.ass_attribute5 CONTRACTNUMBER, 
TO_CHAR(a.ass_attribute_date2,'DD.MM.YYYY') CONTRACTDATE,
(select a1.ass_attribute5 from per_all_assignments_m a1 where a1.assignment_id = a.assignment_id and assignment_type = 'E' and action_code in ('HIRE','REHIRE')) OLDCONTRACTNUMBER,
(select TO_CHAR(a1.ass_attribute_date2,'DD.MM.YYYY') from per_all_assignments_m a1 where a1.assignment_id = a.assignment_id and assignment_type = 'E' and action_code in ('HIRE','REHIRE')) OLDCONTRACTDATE,

extract(year from a.ass_attribute_date2) contractYear, 
extract(day from a.ass_attribute_date2) contractDay,
(case extract(month from a.ass_attribute_date2)
when 1 then 'қаңтарынан'
when 2 then 'ақпанынан'
when 3 then 'наурызынан'
when 4 then 'сәуірінен'
when 5 then 'мамырынан'
when 6 then 'маусымынан'
when 7 then 'шілдесінен'
when 8 then 'тамызынан'
when 9 then 'қыркүйегінен'
when 10 then 'қазанынан'
when 11 then 'қарашасынан'
when 12 then 'желтоқсанынан'
end
) contractMonthKz, 
(case extract(month from a.ass_attribute_date2)
when 1 then 'января'
when 2 then 'февраля'
when 3 then 'марта'
when 4 then 'апреля'
when 5 then 'мая'
when 6 then 'июня'
when 7 then 'июля'
when 8 then 'августа'
when 9 then 'сентября'
when 10 then 'октября'
when 11 then 'ноября'
when 12 then 'декабря'
end
) contractMonthRu, 


extract(year from (select a1.ass_attribute_date2 from per_all_assignments_m a1 where a1.assignment_id = a.assignment_id and assignment_type = 'E' and action_code in ('HIRE','REHIRE'))) oldContractYear, 
extract(day from  (select a1.ass_attribute_date2 from per_all_assignments_m a1 where a1.assignment_id = a.assignment_id and assignment_type = 'E' and action_code in ('HIRE','REHIRE'))) oldContractDay,
(case extract(month from  (select a1.ass_attribute_date2 from per_all_assignments_m a1 where a1.assignment_id = a.assignment_id and assignment_type = 'E' and action_code in ('HIRE','REHIRE')))
when 1 then 'қаңтарынан'
when 2 then 'ақпанынан'
when 3 then 'наурызынан'
when 4 then 'сәуірінен'
when 5 then 'мамырынан'
when 6 then 'маусымынан'
when 7 then 'шілдесінен'
when 8 then 'тамызынан'
when 9 then 'қыркүйегінен'
when 10 then 'қазанынан'
when 11 then 'қарашасынан'
when 12 then 'желтоқсанынан'
end
) oldContractMonthKz, 
(case extract(month from  (select a1.ass_attribute_date2 from per_all_assignments_m a1 where a1.assignment_id = a.assignment_id and assignment_type = 'E' and action_code in ('HIRE','REHIRE')))
when 1 then 'января'
when 2 then 'февраля'
when 3 then 'марта'
when 4 then 'апреля'
when 5 then 'мая'
when 6 then 'июня'
when 7 then 'июля'
when 8 then 'августа'
when 9 then 'сентября'
when 10 then 'октября'
when 11 then 'ноября'
when 12 then 'декабря'
end
) oldContractMonthRu




FROM per_all_assignments_m a
join per_person_names_f n on a.person_id = n.person_id and n.name_type='GLOBAL'
where n.last_name||' '||n.first_name||' '||n.middle_names = :fio 
and action_code in ('TRANSFER')
and to_char(a.ass_attribute_date2,'DD.MM.YYYY')||'/'||a.ass_attribute5 = :termDateNumber