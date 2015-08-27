select 

lower(case when a.position_id is null then (select j.name from PER_JOBS_F_VL  j where j.job_id = a.job_id)||' '||(select name  from hr_all_organization_units o where o.organization_id = a.organization_id) 
else  (select f.name  from hr_all_positions_f_tl f where f.position_id = a.position_id and f.language = 'RU') 
end) posNameGenRu
 from	"FUSION"."PER_PERSON_NAMES_F" "PER_PERSON_NAMES_F",
	"FUSION"."PER_PERIODS_OF_SERVICE" "PER_PERIODS_OF_SERVICE",
       per_all_assignments_m a 
 where   "PER_PERIODS_OF_SERVICE"."PERSON_ID"="PER_PERSON_NAMES_F"."PERSON_ID"
  and 	 "PER_PERSON_NAMES_F"."NAME_TYPE" ='GLOBAL' 
  and  "PER_PERIODS_OF_SERVICE"."PERIOD_OF_SERVICE_ID" = a.period_of_service_id
  and a.assignment_type = 'E'
  and a.action_code = 'TERMINATION'
  and "PER_PERSON_NAMES_F"."LAST_NAME"||' '||"PER_PERSON_NAMES_F"."FIRST_NAME"||' '||"PER_PERSON_NAMES_F"."MIDDLE_NAMES" = :fio
  and  to_char("PER_PERIODS_OF_SERVICE"."ATTRIBUTE_DATE1", 'DD.MM.YYYY')||'/'||"PER_PERIODS_OF_SERVICE"."ATTRIBUTE2" = :orderDateNumber