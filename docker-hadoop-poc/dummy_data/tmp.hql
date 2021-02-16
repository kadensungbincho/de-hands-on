--    DB: tmp
--        Daily: daily_employee
--        Hourly: hourly_employee

SET hive.exec.dynamic.partition=true;

-- tmp db
CREATE SCHEMA IF NOT EXISTS tmp;

DROP TABLE IF EXISTS tmp.daily_employee;
CREATE TABLE IF NOT EXISTS tmp.daily_employee (
    eid int,
    name String,
    salary String,
    destination String
)
COMMENT 'Employee schedule details'
PARTITIONED BY (pt_date String)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"'
)
STORED AS TEXTFILE;


INSERT INTO TABLE tmp.daily_employee PARTITION (pt_date=20191011)
    VALUES
        (1, 'Kaden', '10000', 'Seoul'),
        (2, 'Barney', '20000', 'Berlin');

INSERT INTO TABLE tmp.daily_employee PARTITION (pt_date=20191010)
    VALUES
        (3, 'Sungbin', '10000', 'Sinsa'),
        (4, 'Bob', '20000', 'NewYork');

DROP TABLE IF EXISTS tmp.hourly_employee;
CREATE TABLE IF NOT EXISTS tmp.hourly_employee (
     eid int,
     name String,
     salary String,
     destination String
 )
 COMMENT 'Employee schedule details'
 PARTITIONED BY (pt_hour String)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"'
)
STORED AS TEXTFILE;


INSERT INTO TABLE tmp.hourly_employee PARTITION (pt_hour='2019101001')
    VALUES
        (1, 'Kaden', '10000', 'Seoul'),
        (2, 'Barney', '20000', 'Berlin');

INSERT INTO TABLE tmp.hourly_employee PARTITION (pt_hour='2019101104')
    VALUES
        (3, 'Sungbin', '10000', 'Sinsa'),
        (4, 'Bob', '20000', 'NewYork');
