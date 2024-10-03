MySQL.ready(function()
    MySQL.Async.fetchScalar("SHOW TABLES LIKE 'n8bstashlocations'", {}, function(result)
        if not result then
            if N8Stash.Debug == true then
                print("Table `n8bstashlocations` being created.")
            end
            MySQL.Async.execute([[
                CREATE TABLE `n8bstashlocations` (
                    `stashid` bigint(20) NOT NULL AUTO_INCREMENT,
                    `name` varchar(150) DEFAULT NULL,
                    `label` varchar(150) DEFAULT NULL,
                    `coordsX` float DEFAULT NULL,
                    `coordsY` float DEFAULT NULL,
                    `coordsZ` float DEFAULT NULL,
                    `key` tinyint(4) DEFAULT 38,
                    `activation` float DEFAULT 1,
                    `slots` bigint(20) DEFAULT 50,
                    `weight` bigint(20) DEFAULT 240000,
                    `useitem` tinyint(1) DEFAULT 0,
                    `stashkey` varchar(50) DEFAULT NULL,
                    `keybitting` varchar(20) DEFAULT NULL,
                    `usekeypad` tinyint(1) DEFAULT 0,
                    `pinnumber` varchar(20) DEFAULT NULL,
                    `citizenid` varchar(50) DEFAULT NULL,
                    `job` varchar(50) DEFAULT NULL,
                    `gang` varchar(50) DEFAULT NULL,
                    `secret` tinyint(1) DEFAULT 1,
                    `created` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                    PRIMARY KEY (`stashid`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
            ]], {}, function(rowsChanged)
                if N8Stash.Debug == true then
                    print("Table `n8bstashlocations` created.")
                end
                MySQL.Async.execute([[
                    INSERT INTO `n8bstashlocations`(`stashid`, `name`, `label`, `coordsX`, `coordsY`, `coordsZ`, `key`, `activation`, `slots`, `weight`, `useitem`, `stashkey`, `keybitting`, `usekeypad`, `pinnumber`, `citizenid`, `job`, `gang`, `secret`, `created`)
                    VALUES 
                    (1,'policelocation','<C>~ws~</C> Job',445.03,-975.09,30.69,38,1.5,25,240000,0,'Item Name',NULL,0,NULL,NULL,'police',NULL,0,'2024-09-24 13:58:41'),
                    (2,'keypadlocation','<C>~ws~</C> Keypad',453.03,-973.11,30.69,38,1.5,25,240000,0,'Item Name',NULL,1,'01234',NULL,NULL,NULL,0,'2024-09-24 13:36:05'),
                    (3,'keylocation','<C>~ws~</C> Key',448.89,-979.46,30.69,38,1.5,25,240000,1,'key','111111',0,NULL,NULL,NULL,NULL,0,'2024-09-24 13:54:45'),
                    (4,'ganglocation','<C>~ws~</C> Gang',386.9,-974.04,29.62,38,1.5,25,240000,0,'Item Name',NULL,0,NULL,NULL,NULL,'ballas',0,'2024-09-24 13:56:57'),
                    (5,'unlockedlocation','<C>~ws~</C> Unlocked',437.37,-978.27,30.69,38,1.5,25,240000,0,'Item Name',NULL,0,NULL,NULL,NULL,NULL,0,'2024-09-24 13:59:54'),
                    (6,'singleowner','<C>~ws~</C> Citizenid',454.4,-985.39,30.69,38,1.5,25,240000,0,'Item Name',NULL,0,NULL,'APL23242',NULL,NULL,0,'2024-09-24 14:02:23')
                ]], {}, function(rowsInserted)
                    if N8Stash.Debug == true then
                        print("Data inserted into `n8bstashlocations`.")
                    end
                end)
            end)
        else
            if N8Stash.Debug == true then
                print("Table `n8bstashlocations` already exists, no changes made.")
            end
        end
    end)
end)
