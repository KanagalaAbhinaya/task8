-- Drop existing function, procedure, and table to avoid errors
DROP FUNCTION IF EXISTS GetBonus;
DROP PROCEDURE IF EXISTS GetEmployeesByDept;
DROP TABLE IF EXISTS Employees;

-- Step 1: Create Table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Step 2: Insert Sample Data
INSERT INTO Employees (EmpID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 40000),
(2, 'Bob', 'IT', 60000),
(3, 'Charlie', 'Sales', 55000),
(4, 'Diana', 'HR', 48000),
(5, 'Eve', 'IT', 70000);

-- Step 3: Create Function to Calculate Bonus Based on Salary
DELIMITER //
CREATE FUNCTION GetBonus(salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10,2);
    
    IF salary >= 60000 THEN
        SET bonus = salary * 0.12;
    ELSEIF salary >= 50000 THEN
        SET bonus = salary * 0.08;
    ELSE
        SET bonus = salary * 0.05;
    END IF;
    
    RETURN bonus;
END;
//
DELIMITER ;

-- Step 4: Create Procedure to Get Employees by Department
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN dept_name VARCHAR(50))
BEGIN
    SELECT EmpID, Name, Salary
    FROM Employees
    WHERE Department = dept_name;
END;
//
DELIMITER ;

-- Step 5: Test Procedure
-- This will show all employees in 'HR'
CALL GetEmployeesByDept('HR');

-- Step 6: Test Function
-- This will show each employee's name, salary, and calculated bonus
SELECT Name, Salary, GetBonus(Salary) AS Bonus
FROM Employees;