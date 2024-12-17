-- dataset link: https://github.com/najirh/Library-System-Management---P2

create database library;

/*  2. CRUD Operations
Create: Inserted sample records into the books table.
Read: Retrieved and displayed data from various tables.
Update: Updated records in the employees table.
Delete: Removed records from the members table as needed. */

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books(isbn, book_title, category, rental_price, status, author, publisher)
values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

select * from books;

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';


-- Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE   issued_id =   'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

select * from employees
where emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

select * from members;
select * from issued_status;

select m.member_name,m.member_id, count( i.issued_book_name) as No_of_book_issued  from members as m
join issued_status as i
on m.member_id = i.issued_member_id
group by 1,2
having  count( i.issued_book_name)>1
;

/* 3. CTAS (Create Table As Select)
Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**  */




create table Total_issued_book_count as
select b.book_title , b.isbn, count(i.issued_book_name)as No_book_issued
from books as b join issued_status as i
on b.isbn= i.issued_book_isbn
group by 1,2
order by 2 desc;

-- Task 7. Retrieve All Books in a Specific Category:
select * from books;
select * from issued_status;

select * from books
where category = 'Fiction';

-- Task 8: Find Total Rental Income by Category:

select * from books;
select * from issued_status;

select category,   COUNT(*),sum(rental_price) as Total_rental_income
 from books
 group by 1;
 
 -- Task 9. List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';

-- Task 10. List Employees with Their Branch Manager's Name and their branch details:

select (e.emp_name)as branch_manager, e.branch_id,b.manager_id,b.branch_address
from employees as e
join branch as b
on e.branch_id = b. branch_id
where e.position ='Manager';

-- task 11. Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;

-- Task 12: Retrieve the List of Books Not Yet Returned

select * from return_status;
select * from issued_status;

select i.issued_book_isbn from issued_status as i 
left  join return_status as r 
on i.issued_id = r.issued_id
where r.issued_id is null;

select   i.issued_book_name,i.issued_member_id from issued_status as i
left join return_status as r
on i.issued_id = r.issued_id
where r.return_id is null;





