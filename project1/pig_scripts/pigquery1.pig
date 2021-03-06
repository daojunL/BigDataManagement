transactions = LOAD 'input/transactions.txt' USING PigStorage(',') AS (TransID:int, CustID:int, TransTotal:int, TransNumItems:int, TransDesc:chararray);
customers = LOAD 'input/customer.txt' USING PigStorage(',') AS (ID, Name, Age, Gender, CountryCode, Salary);
A = GROUP transactions BY (CustID);
B = FOREACH customers generate ID, Name;
C = FOREACH A Generate group As CustID, COUNT(transactions.TransID) AS TransNum;
Final = order C by TransNum ASC;
Final2 = LIMIT Final 1;
Final3 = join Final2 by CustID, B by ID;
Final4 = FOREACH Final3 Generate Name, TransNum;
STORE Final4 INTO 'output/PigQuery1.txt' USING PigStorage(',');
