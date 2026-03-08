
select 
    c.CategoryName,
    round(sum(od.UnitPrice*od.Quantity*(1-od.Discount)), 2) as total_sales,   -- рахуємо суму (ціна* кількість*(1-знижка))
    round(sum(od.UnitPrice*od.Quantity*(1-od.Discount))/count(distinct o.OrderID), 2) as average_order_value,-- середній чек (сума/кількість замовлень)
    avg(datediff(day, o.OrderDate, o.ShippedDate)) as average_time_for_ship,-- середній час доставки в днях
    round(cast(count(distinct o.OrderID) as float)/count(distinct o.CustomerID), 2) as average_order_frequency -- частота замовлень (замовлення/клієнти)
from categories as c
  join products as p on c.CategoryID = p.CategoryID
  join [order details] as od on p.ProductID = od.ProductID
  join orders as o on od.OrderID = o.OrderID
group by c.CategoryName
order by total_sales desc;