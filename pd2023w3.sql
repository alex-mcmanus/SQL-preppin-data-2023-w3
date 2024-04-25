
with trans as (
select case online_or_in_person
        when 1 then 'Online'
        when 2 then 'In-Person' end as online_or_in_person
        , date_part( quarter, to_date(transaction_date, 'dd/mm/yyyy hh24:mi:ss')) as Quarter
        , sum(value) as Value
from pd2023_wk01
where left(transaction_code, 3) = 'DSB'
group by all
)

select trans.online_or_in_person
    ,trans.quarter
    ,value
    ,targets
    ,value - targets as variance
from pd2023_wk03_targets
    unpivot(targets for quarter in (Q1, Q2, Q3, Q4)) AS U


INNER JOIN TRANS 
    ON TRANS.QUARTER=REPLACE(U.QUARTER, 'Q', '')::int
    and trans.online_or_in_person = u.online_or_in_person
