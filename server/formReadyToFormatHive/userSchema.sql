CREATE TABLE IF NOT EXISTS users (
    user_id INT,
    user_name STRING,
    user_password STRING,
    user_email STRING,
    user_activity_use_count INT,
    user_tag_event INT,
    user_tag_edit INT,
    user_tag_delete INT,
    user_client_event INT,
    user_client_edit INT,
    user_client_delete INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;


------------------------------------------


CREATE TABLE IF NOT EXISTS projects (
    project_id INT,
    project_name STRING,
    project_description STRING,
    start_date STRING,
    end_date STRING,
    user_id INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;


------------------------------------------


CREATE TABLE IF NOT EXISTS kiosks (
    kiosk_id INT,
    kiosk_name STRING,
    kiosk_location STRING,
    user_id INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;


------------------------------------------


CREATE TABLE IF NOT EXISTS timesheets (
    timesheet_id INT,
    user_id INT,
    project_id INT,
    kiosk_id INT,
    hours_worked FLOAT,
    work_date STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;
