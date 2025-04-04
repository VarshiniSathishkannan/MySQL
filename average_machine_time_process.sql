Activity table:

CREATE TABLE Activity (
    machine_id VARCHAR(512),
    process_id VARCHAR(512),
    activity_type VARCHAR(512),
    timestamp DOUBLE
);

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('0', '0', 'start', '0.712');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('0', '0', 'end', '1.520');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('0', '1', 'start', '3.140');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('0', '1', 'end', '4.120');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('1', '0', 'start', '0.550');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('1', '0', 'end', '1.550');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('1', '1', 'start', '0.430');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('1', '1', 'end', '1.420');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('2', '0', 'start', '4.100');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('2', '0', 'end', '4.512');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('2', '1', 'start', '2.500');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('2', '1', 'end', '5.000');

+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |
+------------+------------+---------------+-----------+
Output: 
+------------+-----------------+
| machine_id | processing_time |
+------------+-----------------+
| 0          | 0.894           |
| 1          | 0.995           |
| 2          | 1.456           |
+------------+-----------------+
-- Explanation: 
-- There are 3 machines running 2 processes each.
-- Machine 0's average time is ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
-- Machine 1's average time is ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995
-- Machine 2's average time is ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456

select a.machine_id, round(sum(b.timestamp - a.timestamp)/count(*),3) as processing_time from Activity a join Activity b on a.machine_id = b.machine_id and a.process_id = b.process_id where a.activity_type = 'start' and b.activity_type = 'end' group by a.machine_id;

select machine_id, round(sum(case when activity_type = 'start' then -timestamp when activity_type = 'end' then timestamp end)/count(case when process_id = '1' then 1 end),3) as Avg from Activity group by machine_id;