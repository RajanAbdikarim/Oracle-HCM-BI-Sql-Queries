select	 "PER_PERIODS_OF_SERVICE"."PERIOD_OF_SERVICE_ID" as "PERIOD_OF_SERVICE_ID",
	 "PER_PERIODS_OF_SERVICE"."PERSON_ID" as "PERSON_ID",
	 to_char("PER_PERIODS_OF_SERVICE"."ACTUAL_TERMINATION_DATE",'DD.MM.YYYY') as "ACTUAL_TERMINATION_DATE",

extract(year from "PER_PERIODS_OF_SERVICE"."ACTUAL_TERMINATION_DATE") actTerminYear,
extract(day from "PER_PERIODS_OF_SERVICE"."ACTUAL_TERMINATION_DATE") actTerminDay,
case extract(month from "PER_PERIODS_OF_SERVICE"."ACTUAL_TERMINATION_DATE")
 when 1 then 'Қантардан' 
 when 2 then 'Ақпаннан' 
 when 3 then 'Наурыздан' 
 when 4 then 'Сәуірден' 
 when 5 then 'Мамырдан' 
 when 6 then 'Маусымнан' 
 when 7 then 'Шілдеден' 
 when 8 then 'Тамыздан' 
 when 9 then 'Қыркүйектен' 
 when 10 then 'Қазаннан' 
 when 11 then 'Қарашадан' 
 when 12 then 'Желтоқсаннан' 
end actualTerminMonthShygysKz,

case extract(month from "PER_PERIODS_OF_SERVICE"."ACTUAL_TERMINATION_DATE")
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
end actualTerminMonthGenRu,



	 "PER_PERIODS_OF_SERVICE"."ATTRIBUTE2" as "ORDERNUMBER",
	 to_char("PER_PERIODS_OF_SERVICE"."ATTRIBUTE_DATE1",'DD.MM.YYYY') as "ORDERDATE",
	 "PER_PERIODS_OF_SERVICE"."ATTRIBUTE3" as "POSASSIGN",
	 "PER_PERIODS_OF_SERVICE"."ATTRIBUTE4" as "ASSIGNER",
	 "PER_PERIODS_OF_SERVICE"."ATTRIBUTE5" as "EXECUTER",

	 "PER_PERIODS_OF_SERVICE"."ATTRIBUTE8" as "REASON",
	 "PER_PERSON_NAMES_F"."LAST_NAME" as "LAST_NAME",
	 "PER_PERSON_NAMES_F"."FIRST_NAME" as "FIRST_NAME",
	 "PER_PERSON_NAMES_F"."MIDDLE_NAMES" as "MIDDLE_NAMES" ,
         substr("PER_PERSON_NAMES_F"."FIRST_NAME",1,1) as "I_FIRST_NAME",
	 substr("PER_PERSON_NAMES_F"."MIDDLE_NAMES",1,1) as "I_MIDDLE_NAMES" ,
 (case 
when lower(substr(trim("PER_PERSON_NAMES_F"."LAST_NAME"),-1,1)) in ('а','о','ұ', 'ы') then trim("PER_PERSON_NAMES_F"."LAST_NAME")||'ның'
when lower(substr(trim("PER_PERSON_NAMES_F"."LAST_NAME"),-1,1)) in ('ә','ө','ү', 'і','е', 'э') then trim("PER_PERSON_NAMES_F"."LAST_NAME")||'нің'
when lower(substr(trim("PER_PERSON_NAMES_F"."LAST_NAME"),-1,1)) in ('п','ф','қ','к','т','с','ш','щ','х','ц','ч','б','в','г','ғ','д','һ') then 
 case when lower(substr(trim("PER_PERSON_NAMES_F"."LAST_NAME"),-2,1)) in ('а','о','ұ', 'ы') then  trim("PER_PERSON_NAMES_F"."LAST_NAME")||'тың' else trim("PER_PERSON_NAMES_F"."LAST_NAME")||'тің' end
when lower(substr(trim("PER_PERSON_NAMES_F"."LAST_NAME"),-1,1)) in ('ж','з','л','р','й','и','у','ь') then 
 case when lower(substr(trim("PER_PERSON_NAMES_F"."LAST_NAME"),-2,1)) in ('а','о','ұ', 'ы') then  trim("PER_PERSON_NAMES_F"."LAST_NAME")||'дың' else trim("PER_PERSON_NAMES_F"."LAST_NAME")||'дің' end
when lower(substr(trim("PER_PERSON_NAMES_F"."LAST_NAME"),-1,1)) in ('м','н','ң') then 
 case when lower(substr(trim("PER_PERSON_NAMES_F"."LAST_NAME"),-2,1)) in ('а','о','ұ', 'ы') then  trim("PER_PERSON_NAMES_F"."LAST_NAME")||'ның' else trim("PER_PERSON_NAMES_F"."LAST_NAME")||'нің' end
end)
lastNameGenKz,

         (case 
when lower(substr(trim( "PER_PERSON_NAMES_F"."LAST_NAME"),-1,1)) in ('а','о','ұ', 'ы','ә','ө','ү', 'і','е', 'э','л','р','й','и','у','ь','м','н','ң') then trim("PER_PERSON_NAMES_F"."LAST_NAME")||'мен'
when lower(substr(trim( "PER_PERSON_NAMES_F"."LAST_NAME"),-1,1)) in ('п','ф','қ','к','т','с','ш','щ','х','ц','ч','б','в','г','ғ','д','һ') then trim("PER_PERSON_NAMES_F"."LAST_NAME")||'пен'
when lower(substr(trim( "PER_PERSON_NAMES_F"."LAST_NAME"),-1,1)) in ('ж','з') then trim("PER_PERSON_NAMES_F"."LAST_NAME")||'бен'

end)
lastNameTvorKz
 from	"FUSION"."PER_PERSON_NAMES_F" "PER_PERSON_NAMES_F",
	"FUSION"."PER_PERIODS_OF_SERVICE" "PER_PERIODS_OF_SERVICE" 
 where   "PER_PERIODS_OF_SERVICE"."PERSON_ID"="PER_PERSON_NAMES_F"."PERSON_ID"
  and 	 "PER_PERSON_NAMES_F"."NAME_TYPE" ='GLOBAL' and
"PER_PERSON_NAMES_F"."LAST_NAME"||' '||"PER_PERSON_NAMES_F"."FIRST_NAME"||' '||"PER_PERSON_NAMES_F"."MIDDLE_NAMES" = :fio
and  to_char("PER_PERIODS_OF_SERVICE"."ATTRIBUTE_DATE1", 'DD.MM.YYYY')||'/'||"PER_PERIODS_OF_SERVICE"."ATTRIBUTE2" = :orderDateNumber