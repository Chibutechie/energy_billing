--- Monthly Revenue Trend 

select 
    year,
    month,
    sum(amount_billed_ngn) as total_billed,
    sum(amount_paid_ngn) as total_collected,
    sum(arrears_ngn) as total_arrears,
    round (CAST(SUM(amount_paid_ngn) / nullif(SUM(amount_billed_ngn), 0) as NUMERIC), 2) as collection_rate
from energy_billing
group by 1, 2
order by year, month;

--- Payment behaviour by tariff

select 
    tariff_band,
    count (*) as total_customers,
    count (case when paid_on_time then 1 end) as on_time_payments,
    round (count(case when paid_on_time then 1 end)::numeric / count(*) * 100, 2) as on_time_payment_rate,
    round (avg(amount_billed_ngn):: numeric, 2) as avg_bill_amount,
   round (avg(arrears_ngn)::numeric, 2) as avg_arrears
from energy_billing
group by 1
order by on_time_payment_rate desc;

--- top customers by arrears

select 
	customer_id,
	disco,
	sum(arrears_ngn) as total_arrears,
	count(*) as billing_periods,
	avg(amount_billed_ngn) as avg_monthly_bill
from energy_billing
group by 1, 2
order by total_arrears desc
limit 10;