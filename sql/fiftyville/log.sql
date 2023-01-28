-- Keep a log of any SQL queries you execute as you solve the mystery.
-- List of suspects
# Bruce (SELECT * FROM "people" WHERE "license_plate" = '94KL13X)
-- id	    name	phone_number	passport_number	    license_plate
-- 686048	Bruce	(367) 555-5533	5773159633	        94KL13X

SELECT * FROM "people" WHERE "passport_number" = '5773159633'
name	phone_number	passport_number	license_plate
Bruce	(367) 555-5533	5773159633	    94KL13X

# Check passport number from passengers
SELECT * FROM "passengers" WHERE "passport_number" = '5773159633'
flight_id	passport_number	seat
36	        5773159633	    4A = Bruce
--
flight_id	passport_number	    seat
36	        5773159633	        4A

-- ACCOMPLICE
SELECT * FROM "phone_calls" WHERE "caller" = '(367) 555-5533' AND "year" = '2021' AND "month" = '7' AND "day" = '28' AND "duration" < '60'
(375) 555-8161


SELECT id, name, phone_number, passport_number, license_plate FROM "people" WHERE "phone_number" = '(375) 555-8161' OR "phone_number" = '(344) 555-9601' OR "phone_number" = '(022) 555-4052' OR "phone_number" = '(704) 555-5790'
-- id	name	phone_number	passport_number	    license_plate
864400	Robin	(375) 555-8161	NULL	            4V16VO0

--- Crime scene reports
SELECT description FROM crime_scene_reports WHERE month = 7 AND day = 28 AND street = 'Humphrey Street'
# Results: Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses
# who were present at the time – each of their interview transcripts mentions the bakery.
# Littering took place at 16:36. No known witnesses.




#159	“I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”
#160	“You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.”
--      He looked from one to the other of us, as if uncertain which to address.
#191	Our neighboring courthouse has a very annoying rooster that crows loudly at 6am every day. My sons Robert and Patrick took
--      the rooster to a city far, far away, so it may never bother us again. My sons have successfully arrived in Paris.






-------------------------------------------------------------------------------------------------------------------------------------
# As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief
say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end
of the phone to purchase the flight ...

# (367) 555-5533 = Bruce
caller	            receiver
(130) 555-0289	(996) 555-8899
(499) 555-9472	(892) 555-8872
(367) 555-5533	(375) 555-8161 - Bruce	Robin
(499) 555-9472	(717) 555-1342
(286) 555-6063	(676) 555-6554
(770) 555-1861	(725) 555-3243
(031) 555-6622	(910) 555-3251
(826) 555-1652	(066) 555-9701
(338) 555-6650	(704) 555-2131

id	origin_airport_id	destination_airport_id	year	month	day	hour	minute
18	8	                6	                    2021	7	    29	16	    0
23	8	                11	                    2021	7	    29	12	    15
36	8	                4	                    2021	7	    29	8	    20 --- Earliest flight
43	8	                1	                    2021	7	    29	9	    30
53	8	                9	                    2021	7	    29	15	    20

# Check for flight ID 36
SELECT passport_number, seat FROM "passengers" WHERE "flight_id" = '36' ORDER BY "flight_id"
passport_number	seat
7214083635	    2A
1695452385	    3B
5773159633	    4A
1540955065	    5C
8294398571	    6C
1988161715	    6D
9878712108	    7A
8496433585	    7B
-------------------------------------------------------------------------------------------------------------------------------------
# I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was
walking by the ATM on Leggett Street and saw the thief there withdrawing some money.

# Check ATM transactions
SELECT id, account_number, amount FROM "atm_transactions" WHERE "year" = '2021' AND "month" = '7' AND "day" = '28' AND "atm_location" LIKE 'Leggett Street' AND "transaction_type" LIKE 'withdraw'
id	    account_number	amount
246	    28500762	    48
264	    28296815	    20
266	    76054385	    60
267	    49610011	    50
269	    16153065	    80
288	    25506511	    20
313	    81061156	    30
336	    26013199	    35

# Check person ID from bank accounts
SELECT * FROM "bank_accounts" WHERE "account_number" = '28500762' OR "account_number" = '28296815' OR "account_number" = '76054385' OR "account_number" = '49610011' OR "account_number" = '16153065' OR "account_number" = '25506511' OR "account_number" = '81061156' OR "account_number" = '26013199'

account_number	person_id	creation_year
49610011	    686048	    2010
26013199	    514354	    2012
16153065	    458378	    2012
28296815	    395717	    2014
25506511	    396669	    2014
28500762	    467400	    2014
76054385	    449774	    2015
81061156	    438727	    2018

SELECT * FROM "people" WHERE "id" = '686048' OR "id" = '514354' OR "id" = '458378' OR "id" = '395717' OR "id" = '396669' OR "id" = '467400' OR "id" = '449774' OR "id" = '438727'
id	    name	phone_number	passport_number	license_plate
395717	Kenny	(826) 555-1652	9878712108	    30G67EN
396669	Iman	(829) 555-5269	7049073643	    L93JTIZ
438727	Benista	(338) 555-6650	9586786673	    8X428L0
449774	Taylor	(286) 555-6063	1988161715	    1106N58
458378	Brooke	(122) 555-4581	4408372428	    QX4YZN3
467400	Luca	(389) 555-5198	8496433585	    4328GD8
514354	Diana	(770) 555-1861	3592750733	    322W7JE
686048	Bruce	(367) 555-5533	5773159633	    94KL13X
-------------------------------------------------------------------------------------------------------------------------------------
# Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have
security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.

# Check names of those who left the parking lot
SELECT * FROM "people" WHERE "license_plate" = '5P2BI95' OR "license_plate" = '94KL13X' OR "license_plate" = '6P58WS2' OR "license_plate" = '4328GD8' OR "license_plate" = 'G412CB7' OR "license_plate" = 'L93JTIZ' OR "license_plate" = '322W7JE' OR "license_plate" = '0NTHK55'
id	name	phone_number	passport_number	license_plate
221103	Vanessa	(725) 555-4692	2963008352	5P2BI95
243696	Barry	(301) 555-4174	7526138472	6P58WS2
396669	Iman	(829) 555-5269	7049073643	L93JTIZ
398010	Sofia	(130) 555-0289	1695452385	G412CB7
467400	Luca	(389) 555-5198	8496433585	4328GD8
514354	Diana	(770) 555-1861	3592750733	322W7JE
560886	Kelsey	(499) 555-9472	8294398571	0NTHK55
686048	Bruce	(367) 555-5533	5773159633	94KL13X
----------------------------------------------------