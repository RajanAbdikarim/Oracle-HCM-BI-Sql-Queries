SELECT T1.PERSON_ID, T2.ADDRESS_LINE_1, T2.TOWN_OR_CITY
FROM PER_PERSON_ADDR_USAGES_F T1, PER_ADDRESSES_F T2
WHERE T1.ADDRESS_ID = T2.ADDRESS_ID AND
SYSDATE BETWEEN T1.EFFECTIVE_START_DATE AND T1.EFFECTIVE_END_DATE