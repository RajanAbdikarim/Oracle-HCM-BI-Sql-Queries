select 
period_of_service_id,
to_char(a.ass_attribute_date2,'DD.MM.YYYY') as emplContDate,
extract(year from a.ass_attribute_date2)  termYear,
extract(day from a.ass_attribute_date2) termDay,
case extract(month from a.ass_attribute_date2)
 when 1 then 'қантардағы' 
 when 2 then 'ақпандағы' 
 when 3 then 'наурыздағы' 
 when 4 then 'сәуірдегі' 
 when 5 then 'мамырдағы' 
 when 6 then 'маусымдағы' 
 when 7 then 'шілдедегі' 
 when 8 then 'тамыздағы' 
 when 9 then 'қыркүйектегі' 
 when 10 then 'қазандағы' 
 when 11 then 'қарашадағы' 
 when 12 then 'желтоқсандағы' 
end termMonthKz,
case extract(month from a.ass_attribute_date2)
 when 1 then 'Января' 
when 2 then 'Февраля' 
when 3 then 'Марта' 
when 4 then 'Апреля' 
when 5 then 'Мая' 
when 6 then 'Июня' 
when 7 then 'Июля' 
when 8 then 'Августа' 
when 9 then 'Сентября' 
when 10 then 'Октября' 
when 11 then 'Ноября' 
when 12 then 'Декабря' 
end termMonthRu,

a.ass_attribute5 as emplContNumber
from per_all_assignments_m a
where action_code in ('HIRE','REHIRE') and a.assignment_type='E'