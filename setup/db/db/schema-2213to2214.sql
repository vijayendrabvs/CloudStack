--;
-- Schema upgrade from 2.2.13 to 2.2.14;
--;

ALTER TABLE `cloud`.`vm_template` MODIFY `extractable` int(1) unsigned NOT NULL default 0 COMMENT 'Is this template extractable';
INSERT INTO configuration (category, instance, component, name, value, description) VALUES ('Advanced', 'DEFAULT', 'management-server', 'external.network.stats.interval', '300', 'Interval (in seconds) to report external network statistics.');

CREATE TABLE  `cloud`.`mshost_peer` (
  `id` bigint unsigned NOT NULL auto_increment,
  `owner_mshost` bigint unsigned NOT NULL,
  `peer_mshost` bigint unsigned NOT NULL,
  `peer_runid` bigint NOT NULL,
  `peer_state` varchar(10) NOT NULL DEFAULT 'Down',
  `last_update` DATETIME NULL COMMENT 'Last record update time',
  
  PRIMARY KEY  (`id`),
  CONSTRAINT `fk_mshost_peer__owner_mshost` FOREIGN KEY (`owner_mshost`) REFERENCES `mshost`(`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mshost_peer__peer_mshost` FOREIGN KEY (`peer_mshost`) REFERENCES `mshost`(`id`),
  UNIQUE `i_mshost_peer__owner_peer_runid`(`owner_mshost`, `peer_mshost`, `peer_runid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

