CREATE TABLE `students` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(10) NOT NULL,
    `student_number` INT NOT NULL, -- 개별번호
    `year` INT NOT NULL, -- 입학연도
    `major` INT NOT NULL, -- 전공 
    `phone_number` VARCHAR(11) NOT NULL,
    `address` VARCHAR(50) NOT NULL,
    `accumulated_credit` INT NOT NULL DEFAULT 0,
    `average_grade` DOUBLE NOT NULL DEFAULT 0.0,
    `is_in_school` TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--학번 = 입학 연도 + 전공 + 개별 번호