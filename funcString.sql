String functions

select LEFT('Hello',2);
+-----------------+
| LEFT('Hello',2) |
+-----------------+
| He              |
+-----------------+

select RIGHT('Hello',2);
+------------------+
| RIGHT('Hello',2) |
+------------------+
| lo               |
+------------------+

select CONCAT('HELLO',' ','ALL');
+---------------------------+
| CONCAT('HELLO',' ','ALL') |
+---------------------------+
| HELLO ALL                 |
+---------------------------+

select ABS('-70');
+------------+
| ABS('-70') |
+------------+
|         70 |
+------------+

select SUBSTRING('HELLO ALL',1,5);
+----------------------------+
| SUBSTRING('HELLO ALL',1,5) |
+----------------------------+
| HELLO                      |
+----------------------------+

SELECT SUBSTRING_INDEX('John Doe', ' ', 1);  -- Output: John

SELECT SUBSTRING_INDEX('user@example.com', '@', -1);  -- Output: example.com

SELECT SUBSTRING_INDEX('a,b,c,d', ',', 2);  -- Output: a,b


SELECT LENGTH('HELLO ALL');
+---------------------+
| LENGTH('HELLO ALL') |
+---------------------+
|                   9 |
+---------------------+

SELECT TRIM('   HELLO ALL   '); -- Removes trailing and leading white spaces
+-------------------------+
| TRIM('   HELLO ALL   ') |
+-------------------------+
| HELLO ALL               |
+-------------------------+

SELECT REPLACE('HI','I','ELLO');
+--------------------------+
| REPLACE('HI','I','ELLO') |
+--------------------------+
| HELLO                    |
+--------------------------+

SELECT CONCAT_WS("-", "SQL", "Tutorial", "is", "fun!") AS ConcatenatedString;
+----------------------+
| ConcatenatedString   |
+----------------------+
| SQL-Tutorial-is-fun! |
+----------------------+

SELECT LCASE("SQL Tutorial is FUN!");
+-------------------------------+
| LCASE("SQL Tutorial is FUN!") |
+-------------------------------+
| sql tutorial is fun!          |
+-------------------------------+

SELECT LOWER("HELLO");
+----------------+
| LOWER("HELLO") |
+----------------+
| hello          |
+----------------+

SELECT STR_TO_DATE('09/25/2022 12:08:00', '%m/%d/%Y %H:%i:%s');
+---------------------------------------------------------+
| STR_TO_DATE('09/25/2022 12:08:00', '%m/%d/%Y %H:%i:%s') |
+---------------------------------------------------------+
| 2022-09-25 12:08:00                                     |
+---------------------------------------------------------+

%D	Day of the month as a numeric value, followed by suffix (1st, 2nd, 3rd, ...)
%d	Day of the month as a numeric value (01 to 31)
%H	Hour (00 to 23)
%h	Hour (00 to 12)
%i	Minutes (00 to 59)
%M	Month name in full (January to December)
%m	Month name as a numeric value (00 to 12)
%p	AM or PM
%r	Time in 12 hour AM or PM format (hh:mm:ss AM/PM)
%S	Seconds (00 to 59)
%s	Seconds (00 to 59)
%T	Time in 24 hour format (hh:mm:ss)
%w	Day of the week where Sunday=0 and Saturday=6
%Y	Year as a numeric, 4-digit value
%y	Year as a numeric, 2-digit value

String Manipulation / Formatting

Function	Description
CONCAT()	Combines two or more strings
CONCAT_WS()	Concatenates strings with a separator
LEFT(str, len)	Returns the leftmost len characters
RIGHT(str, len)	Returns the rightmost len characters
SUBSTRING(str, pos[, len])	Extracts part of a string
SUBSTRING_INDEX()	Extracts substring based on a delimiter
INSERT(str, pos, len, newstr)	Replaces part of a string
REPLACE(str, from, to)	Replaces all occurrences of a substring
LPAD(str, len, padstr)	Left-pads a string
RPAD(str, len, padstr)	Right-pads a string
REVERSE(str)	Reverses a string
TRIM()	Removes leading/trailing spaces or characters
LTRIM()	Removes leading spaces
RTRIM()	Removes trailing spaces
🔍 Searching / Matching

Function	Description
INSTR(str, substr)	Position of substr in str (1-based)
LOCATE(substr, str[, start])	Same as INSTR, with optional start position
POSITION(substr IN str)	ANSI SQL version of INSTR()
FIND_IN_SET(str, strlist)	Finds str in a comma-separated list
LIKE, REGEXP, RLIKE	Pattern matching with wildcards or regex
🆎 Case Conversion

Function	Description
LOWER() or LCASE()	Converts to lowercase
UPPER() or UCASE()	Converts to uppercase
BINARY	Forces case-sensitive comparison
🔢 Length & Info

Function	Description
LENGTH(str)	Length in bytes
CHAR_LENGTH(str) or CHARACTER_LENGTH()	Number of characters in the string
BIT_LENGTH(str)	Length in bits
OCTET_LENGTH()	Same as LENGTH() — bytes
🔡 Character Encoding / Unicode

Function	Description
ASCII(str)	ASCII value of first character
CHAR(N,...)	Converts ASCII codes to characters
ORD(str)	Returns character code of first byte in string
CONVERT(str USING charset)	Converts string to a different character set
CHARSET(str)	Returns the character set of the string
COLLATION(str)	Returns the collation of the string
🔢 Base Conversion & Hex

Function	Description
HEX(str)	Converts string to hexadecimal
UNHEX(hexstr)	Converts hex to string
BIN(N)	Converts number to binary
OCT(N)	Converts number to octal
CONV(N, from_base, to_base)	Converts between number bases
🆕 String JSON / Advanced (MySQL 5.7+)

Function	Description
JSON_EXTRACT()	Extracts value from JSON
JSON_UNQUOTE()	Removes quotes from a JSON string
JSON_ARRAYAGG()	Aggregates values into JSON array