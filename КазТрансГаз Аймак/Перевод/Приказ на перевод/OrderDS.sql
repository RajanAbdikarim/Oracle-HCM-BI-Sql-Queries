select 
n.last_name||' '||n.first_name||' '||n.middle_names fioKz, 
(case 
when lower(substr(trim(n.last_name),-1,1)) in ('а','о','ұ', 'ы') then trim(n.last_name)||'ның'
when lower(substr(trim(n.last_name),-1,1)) in ('ә','ө','ү', 'і','е', 'э') then trim(n.last_name)||'нің'
when lower(substr(trim(n.last_name),-1,1)) in ('п','ф','қ','к','т','с','ш','щ','х','ц','ч','б','в','г','ғ','д','һ') then 
 case when lower(substr(trim(n.last_name),-2,1)) in ('а','о','ұ', 'ы') then  trim(n.last_name)||'тың' else trim(n.last_name)||'тің' end
when lower(substr(trim(n.last_name),-1,1)) in ('ж','з','л','р','й','и','у','ь') then 
 case when lower(substr(trim(n.last_name),-2,1)) in ('а','о','ұ', 'ы') then  trim(n.last_name)||'дың' else trim(n.last_name)||'дің' end
when lower(substr(trim(n.last_name),-1,1)) in ('м','н','ң') then 
 case when lower(substr(trim(n.last_name),-2,1)) in ('а','о','ұ', 'ы') then  trim(n.last_name)||'ның' else trim(n.last_name)||'нің' end
end)
lastNameGenKz, 
to_char(a.effective_start_date,'DD.MM.YYYY') start_date,


a.ass_attribute1 orderNumber, 
to_char(a.ass_attribute_date1,'DD.MM.YYYY') orderDate, 
a.ass_attribute2 orderAssigner, 
a.ass_attribute3 orderAssignerPos,

to_char(a.ass_attribute_date2,'DD.MM.YYYY') as contractDate,
a.ass_attribute5 as contractNumber,

substr(n.first_name,1,1)||'.' i_fn,
(case when n.middle_names is not null then substr(n.middle_names,1,1)||'.' else '' end) i_mn,
a.ass_attribute4 execOrder






from per_all_assignments_m a
join per_person_names_f n on a.person_id = n.person_id and n.name_type='GLOBAL'
where n.last_name||' '||n.first_name||' '||n.middle_names = :fio 
and action_code in ('TRANSFER')
and to_char(a.ass_attribute_date1,'DD.MM.YYYY')||'/'||a.ass_attribute1 = :orderDateNumber