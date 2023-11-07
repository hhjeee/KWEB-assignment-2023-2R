--1. ID가 11인 노선을 예매한 모든 승객의 ID(id), 이름(name), 좌석 번호(seat_number)를 좌석 번호의 오름차순 으로 조회
SELECT `users`.`id`, `name`, `seat_number` FROM `users` INNER JOIN `tickets` WHERE (`users`.`id` = `tickets`.`user`) and `train` = 11 ORDER BY `tickets`.`seat_number`; 

--2. 각 사용자의 ID(id), 이름(name), 탑승 열차 수(trains_count), 총 거리(total_distance)를 총 거리의 내림 차순으로 상위 6명만 조회
SELECT `users`.`id`, `name`, count(`train`) as `trains_count`, sum(`distance`)/10 as `total_distance` FROM `users` INNER JOIN `tickets` INNER JOIN `trains`
WHERE (`users`.`id` = `tickets`.`user` and `tickets`.`train` = `trains`.`id`) GROUP BY `users`.`id` ORDER BY `total_distance` DESC LIMIT 6;

--3. 각 노선의 ID(id), 열차 종류(type), 출발역(src_stn), 도착역(dst_stn), 여행 시간(travel_time)을 여행 시간의 내림차순으로 상위 6개만 조회
SELECT `trains`.`id`, `types`.`name` as `type`, `src`.`name` as `src_stn`, `dest`.`name` as `dst_stn`, Timediff(`arrival`, `departure`) as `travel_time` 
FROM `trains` INNER JOIN `types` INNER JOIN `stations` as `src` INNER JOIN `stations` as `dest`
WHERE `trains`.`type` = `types`.`id` and `trains`.`source` = `src`.`id` and `trains`.`destination` = `dest`.`id`
ORDER BY `travel_time` DESC LIMIT 6;

--4. 각 노선의 열차 종류(type), 출발역(src_stn), 도착역(dst_stn), 출발 시각(departure), 도착 시각(arrival), 운임(fare; 원 단위)을 출발 시각의 오름차순으로 모두 조회
SELECT `types`.`name` as `type`, `src`.`name` as `src_stn`, `dest`.`name` as `dst_stn`, `departure`, `arrival`, Round((`fare_rate`/100) * (`distance`/10), -2) as `fare`
FROM `types` INNER JOIN `stations` as `src` INNER JOIN `stations` as `dest` INNER JOIN `trains`
WHERE `trains`.`type` = `types`.`id` and `trains`.`source` = `src`.`id` and `trains`.`destination` = `dest`.`id`
ORDER BY `departure`;

--5. 각 노선의 ID(id), 열차종류(type), 출발역(src_stn), 도착역(dst_stn), 예매된 좌석수(occupied), 최대 좌석 수(maximum)를 노선의 ID의 오름차순으로 모두 조회 (예매한 사용자가 없는 노선은 제외)
SELECT `trains`.`id`, `types`.`name` as `type`, `src`.`name` as `src_stn`, `dest`.`name` as `dst_stn`, count(`tickets`.`id`) as `occupied`, `types`.`max_seats` as `maximum`
FROM `trains` INNER JOIN `types` INNER JOIN `stations` as `src` INNER JOIN `stations` as `dest` INNER JOIN `tickets`
WHERE `trains`.`type` = `types`.`id` and `trains`.`source` = `src`.`id` and `trains`.`destination` = `dest`.`id` and `tickets`.`train` = `trains`.`id`
GROUP  BY `tickets`.`train`
ORDER BY `trains`.`id`;

--6 각 노선의 ID(id), 열차종류(type), 출발역(src_stn), 도착역(dst_stn), 예매된 좌석수(occupied), 최대 좌석 수(maximum)를 노선의 ID의 오름차순으로 모두 조회 (예매한 사용자가 없는 노선도 포함)
SELECT `trains`.`id`, `types`.`name` as `type`, `src`.`name` as `src_stn`, `dest`.`name` as `dst_stn`, count(`tickets`.`id`) as `occupied`, `types`.`max_seats` as `maximum`
FROM `trains` INNER JOIN `types` ON `trains`.`type` = `types`.`id`
INNER JOIN `stations` as `src` ON `trains`.`source` = `src`.`id`
INNER JOIN `stations` as `dest` ON `trains`.`destination` = `dest`.`id`
LEFT OUTER JOIN `tickets` ON `tickets`.`train` = `trains`.`id`
GROUP  BY `tickets`.`train`
ORDER BY `trains`.`id`;

/*
CREATE TABLE `stations` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE `types` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `max_seats` VARCHAR(20) NOT NULL,
    `fare_rate` INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE `trains` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `type` INT NOT NULL,
    `source` INT NOT NULL,
    `destination` INT NOT NULL,
    `departure` TIME NOT NULL,
    `arrival` TIME NOT NULL,
    `distance` INT NOT NULL,
    FOREIGN KEY (`type`) REFERENCES `types`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`source`) REFERENCES `stations`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`destination`) REFERENCES `stations`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `users` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE `tickets` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `train` INT NOT NULL,
    `user` INT NOT NULL,
    `seat_number` INT NOT NULL,
    FOREIGN KEY (`train`) REFERENCES `trains`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`user`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;
*/