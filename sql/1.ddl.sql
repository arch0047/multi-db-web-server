CREATE SCHEMA IF NOT EXISTS `rollcall_db`;
USE `rollcall_db` ;

-- -----------------------------------------------------
-- Table `rollcall_db`.`kea_departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rollcall_db`.`kea_departments` (
`department_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
`department_name` VARCHAR(20) NOT NULL);

-- -----------------------------------------------------
-- Table `rollcall_db`.`program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rollcall_db`.`programs` (
`program_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
`program_name` VARCHAR(60) NOT NULL,
`department_id` INT NOT NULL);

-- -----------------------------------------------------
-- Table `rollcall_db`.`subjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rollcall_db`.`subjects` (
`subject_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
`subject_name` VARCHAR(200) NOT NULL,
`program_id` INT NOT NULL);

-- -----------------------------------------------------
-- Table `rollcall_db`.`teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rollcall_db`.`teachers` (
`teacher_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
`first_name` VARCHAR(20) NOT NULL,
`last_name` VARCHAR(20) NOT NULL,
`email` VARCHAR(60) NOT NULL,
`password` VARCHAR(120) NOT NULL,
`department_id` INT NOT NULL);

-- -----------------------------------------------------
-- Table `rollcall_db`.`teachers_subjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rollcall_db`.`teachers_subjects` (
`teacher_id` INT NOT NULL,
`subject_id` INT NOT NULL);

-- -----------------------------------------------------
-- Table `rollcall_db`.`code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rollcall_db`.`code` (
`code_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
`current_dateTime` DATETIME NOT NULL,
`teacher_id` INT NOT NULL,
`subject_id` INT NOT NULL);

-- -----------------------------------------------------
-- Table `rollcall_db`.`students_subjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rollcall_db`.`students_subjects` (
`student_id` INT NOT NULL,
`subject_id` INT NOT NULL);


-- -----------------------------------------------------
-- Table `rollcall_db`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rollcall_db`.`students` (
`student_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
`first_name` VARCHAR(20) NOT NULL,
`last_name` VARCHAR(20) NOT NULL,
`user_name` VARCHAR(20) NOT NULL,
`password` VARCHAR(120) NOT NULL,
`program_id` INT NOT NULL);



-- -----------------------------------------------------
-- Table `rollcall_db`.`students_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rollcall_db`.`students_status` (
`status_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
`is_present` TINYINT(1) NOT NULL,
`current_datetime` DATETIME NOT NULL,
`subject_id` INT NOT NULL,
`student_id` INT NOT NULL);



ALTER TABLE `rollcall_db`.`kea_departments` ADD PRIMARY KEY (`department_id`);

ALTER TABLE `rollcall_db`.`programs` ADD PRIMARY KEY (`program_id`);
ALTER TABLE `rollcall_db`.`programs` ADD FOREIGN KEY (`department_id`) REFERENCES `rollcall_db`.`kea_departments` (`department_id`);

ALTER TABLE `rollcall_db`.`subjects` ADD PRIMARY KEY (`subject_id`);
ALTER TABLE `rollcall_db`.`subjects` ADD FOREIGN KEY (`program_id`) REFERENCES `rollcall_db`.`programs` (`program_id`);

ALTER TABLE `rollcall_db`.`teachers` ADD PRIMARY KEY (`teacher_id`);
ALTER TABLE `rollcall_db`.`teachers` ADD FOREIGN KEY (`department_id`) REFERENCES `rollcall_db`.`kea_departments` (`department_id`);

ALTER TABLE `teachers_subjects` ADD PRIMARY KEY(`teacher_id`, `subject_id`);
ALTER TABLE `teachers_subjects` ADD FOREIGN KEY(`subject_id`) REFERENCES `rollcall_db`.`subjects` (`subject_id`);
ALTER TABLE `teachers_subjects` ADD FOREIGN KEY (`teacher_id`) REFERENCES `rollcall_db`.`teachers` (`teacher_id`);

ALTER TABLE `rollcall_db`.`code` ADD PRIMARY KEY (`code_id`, `teacher_id`, `subject_id`);
ALTER TABLE `rollcall_db`.`code` ADD FOREIGN KEY (`teacher_id` , `subject_id`) REFERENCES `rollcall_db`.`teachers_subjects` (`teacher_id` , `subject_id`);

ALTER TABLE `rollcall_db`.`students` ADD PRIMARY KEY (`student_id`);
ALTER TABLE `rollcall_db`.`students` ADD FOREIGN KEY (`program_id`) REFERENCES `rollcall_db`.`programs` (`program_id`);

ALTER TABLE `rollcall_db`.`students_subjects` ADD PRIMARY KEY (`student_id`, `subject_id`);
ALTER TABLE `rollcall_db`.`students_subjects` ADD FOREIGN KEY (`student_id`) REFERENCES `rollcall_db`.`students` (`student_id`);
ALTER TABLE `rollcall_db`.`students_subjects` ADD FOREIGN KEY (`subject_id`) REFERENCES `rollcall_db`.`subjects` (`subject_id`);

ALTER TABLE `rollcall_db`.`students_status` ADD PRIMARY KEY (`status_id`, `subject_id`, `student_id`);
ALTER TABLE `rollcall_db`.`students_status` ADD FOREIGN KEY (`subject_id` , `student_id`) REFERENCES `rollcall_db`.`students_subjects` (`subject_id` , `student_id`);