CREATE TABLE `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `password` VARCHAR(20) NOT NULL,
    `nickname` VARCHAR(20) NOT NULL,
    `profile_img_link` VARCHAR(128) NOT NULL,
    `profile_message` VARCHAR(128) NOT NULL,
    `deleting_account` TINYINT(1) NOT NULL DEFAULT 0,
    `date_join` DATETIME NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `channels` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `user_create` INT NOT NULL, 
    `channel_link` VARCHAR(128) NOT NULL,
    `maximum_user` INT NOT NULL,
    `deleting_account` TINYINT(1) NOT NULL DEFAULT 0,
    `date_create` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_create`)
    REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `chats` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `content` TEXT NOT NULL,
    `user_write` INT NOT NULL, 
    `channel` INT NOT NULL, 
    `date_create_chats` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_write`)
    REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`channel`)
    REFERENCES `channels`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `blocks` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `blocked` INT NOT NULL, 
    `blocking` INT NOT NULL, 
    `date_block` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`blocked`)
    REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`blocking`)
    REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `follows` (
    `id` INT NOT NULL AUTO_INCREMENT,
   `follower` INT NOT NULL, 
   `followee` INT NOT NULL, 
   `date_follow` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`follower`)
    REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`followee`)
    REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;