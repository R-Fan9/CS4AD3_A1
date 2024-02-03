connect to db4ad3; 

--1: Find all products (their ID, model number, name, and price) that cost more than \$950 and less than \$1000. 
select p.id, p.name, p.modelNumber, p.price
from Product p
where p.price >950 AND p.price <1000;

--2: Find all attendees (their ID, first name, last name) who live in an area with postal code starting with the letter 'N' and have a birth year greater than 1990.  

select a.ID, p.firstName, p.lastName
from Attendee a, Person p
where a.id = p.id and p.postalCode like 'N%' and year(p.dateOfBirth) > 1990;

--3: Determine the number of unique products that have an extended warranty. 
select count (p.ID) as numExtendedWarrantyProds
from product p, warranty w, with
where with.productID = p.ID
        and with.warrantyID = w.ID
        and w.type = 'Extended';

--4: Find the total transaction sales (amount) per day of all credit card and debit payments.   List the date and the sales per day.
select sum(t.amount) as totalSales, t.Date
from Transaction t
where t.paymentMethod = 'credit' or t.paymentMethod = 'debit'
GROUP BY t.Date;

--5: List the names of all vendors who sell at least one product in the 'LED' product sub-category.  Do not return duplicate vendor names.
select distinct v.name
from Vendor v, Product p, Sell, ProductBelongToSubcategory bt, productSubCategory ps
where Sell.vendorID = v.ID
        and Sell.productID = p.ID
        and p.ID = bt.productID
        and bt.productSubCategoryID = ps.ID
        and ps.name = 'LED';

--6a: List the vendor name and the number of distinct products that each vendor carries.  For example, Samsung may carry a variety of products across different product categories, such as televisions, laundry machines, smart phones, computers, etc.  Group your results by vendor name.  
select v.name, count(*)
from SELL s, VENDOR v
where v.ID = s.vendorID
GROUP BY v.name;

--6b  From the query above, list the vendors that sell greater than 35products. Again, group your results by vendor name.

select v.name, count(*)
from SELL s, VENDOR v
where v.ID = s.vendorID
GROUP BY v.name
HAVING count(*) > 35;

--7.a) List the vendor (ID, name) that sold greater than 10 (quantity) products each day.  Order your results in ascending order by date and the total quantity sold.  Show the total number of products sold for each vendor.

select v.ID, v.name, SUM(t.quantity) as numProducts, t.Date
from Vendor v, Transaction t
where v.ID = t.vendorID
group by v.ID, v.name, t.Date
having SUM(t.quantity) > 10
order by t.Date, sum(t.quantity);

--7b): List the vendor (ID, name) that had greater than \$5000 monetary sales per day.  Order your results in ascending order by date and total sales.  Show the total sales amount for each qualifying vendor each day.

select v.ID, v.name, SUM(t.amount) as totalSales, t.Date
from Vendor v, Transaction t
where v.ID = t.vendorID
group by v.ID, v.name, t.Date
having SUM(t.amount) > 5000
order by t.Date, sum(t.amount);

--8: Find all persons (their last name, first name, birth date) who have the same birth date as another person.
-- ORDER BY is optional here
select p1.firstName, p1.lastName, p1.dateOfBirth
from person p1, person p2
where p1.dateOfBirth = p2.dateOfBirth AND
p1.lastName <> p2.lastName AND p1.firstName <> p2.firstName
order by p1.dateOfBirth;

--Q9 Find all attendees that listened to a keynote speaker with expertise in 'Smartphones' or Wearable Technology'.    Return the attendee's first name, last name, and the speaker's area of expertise.
(select p.firstName, p.lastName, k.areaOfExpertise 
from Person p, Attendee a, KeynoteSpeaker k, ListenTo l
where p.ID = a.ID AND a.ID = l.attendeeID AND l.keynoteSpeakerID = k.ID
	and k.areaOfExpertise = 'Smartphones')
UNION 
(select p.firstName, p.lastName, k.areaOfExpertise
from Person p, Attendee a, KeynoteSpeaker k, ListenTo l
where p.ID = a.ID AND a.ID = l.attendeeID AND l.keynoteSpeakerID = k.ID
        and k.areaOfExpertise = 'Wearable Technology'); 


--Q10a  Find all products (ID, model number, name) that were purchased by an attendee who also did a product trial of the same product.  
SELECT p.ID, p.modelNumber, p.name
FROM Product p,
((SELECT pt.attendeeID, pt.productID
FROM productTrial pt)
INTERSECT
(select t.attendeeID, t.productID
from transaction t)) bt
WHERE p.ID = bt.productID;

--Q10b  Find all attendees (ID, last name, first name) who did a product trial of a product for greater than or equal to 10 minutes, but did not purchase the product. 

SELECT p.ID, p.firstName, p.lastName
FROM Person p,
((SELECT pt.attendeeID, pt.productID
FROM productTrial pt
WHERE minutesTried >= 10)
EXCEPT
(select t.attendeeID, t.productID
from transaction t)) bt
WHERE p.ID = bt.attendeeID;

--Q11  Find all attendees (ID, first name, last name) that purchased at least one product each day of the three day event (April 2 - 4, 2014).
SELECT p.ID, p.firstName, p.lastName
FROM person p
WHERE p.ID in (select t1.attendeeID 
		from Transaction t1, Transaction t2, Transaction t3
		where t1.attendeeID = t2.attendeeID
		and t2. attendeeID = t3.attendeeID
		and t1.attendeeID = t3. attendeeID
		and t1.Date = '04/02/2014'
		and t2.Date = '04/03/2014'
		and t3.Date = '04/04/2014');


--Q12  Determine the highest total sales for a product sub-category over the entire three day event.  For example, if the 'laptop' sub-category had the highest sales amount across all the sub-categories, then report this amount. 


SELECT MAX(totalSales) 
FROM 
(
SELECT ps.name as groupName, SUM(t.amount) as totalSales
FROM ProductSubCategory ps, Product p, Transaction t, ProductBelongToSubcategory pbs
WHERE pbs.productSubCategoryID = ps.ID
	and pbs.productID = p.ID
	and p.ID = t.productID
GROUP BY ps.name);


connect reset;
