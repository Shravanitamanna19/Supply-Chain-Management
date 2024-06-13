 
create database Supply_chain_managt;
use Supply_chain_managt;
 
 
#................................KPI Total Sales..........................................
select Sum(`Sales Amount`) as'Total Sale'
from f_point_of_sale;

#................................# KPI Total Inventory..........................................
select sum(`Quantity on Hand`) as 'Total Invetory'
from f_inventory_adjusted;


#................................KPI Inventory value..............................................
select sum(Price*`Sales Quantity`) as 'Inventory Value'
from f_inventory_adjusted inv
join f_point_of_sale pos 
on inv.`Product Key` = pos.`Product Key`;


#................................KPI Product wise sales................................................
select `Product Type`, sum(`Sales Quantity`) as 'Quantity sold', sum(`Sales Amount`) as 'Sales Amount'
from d_product dp
join f_point_of_sale pos
on dp.`Product Key`= pos.`Product Key`
group by `Product Type`
order by 'sales amount' desc;


#..................................KPI Day wise Sales Trend..............................................
select date(fs.Date), sum(pos.`Sales Amount`)
from f_point_of_sale pos 
join f_sales fs
on pos.`Order Number`=fs.`Order Number`
group by date(fs.Date)
order by date (fs.Date)asc;


#..................................KPI Over stock, out stock, under stock..................................
select p.`Product Family`,case
when sum(`Quantity on Hand`=3) then 'overstock'
when sum(`Quantity on Hand`=2) then' under stock'
when sum(`Quantity on Hand`=1) then 'Out of Stock'
else " " end as Stockstatus
from f_inventory_adjusted i
join d_product p on i.`Product Key` = p.`Product Key`
group by p.`Product Family`;
