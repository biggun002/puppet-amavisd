-- Adminer 4.1.0 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';

DROP DATABASE IF EXISTS `amacube`;
CREATE DATABASE `amacube` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `amacube`;

DROP TABLE IF EXISTS `mailbox`;
CREATE TABLE `mailbox` (
  `email` varbinary(255) NOT NULL,
  `catchall` int(1) NOT NULL DEFAULT '1',
  `filter` int(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP DATABASE IF EXISTS `maia`;
CREATE DATABASE `maia` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `maia`;

DROP TABLE IF EXISTS `awl`;
CREATE TABLE `awl` (
  `username` varchar(100) NOT NULL DEFAULT '',
  `email` varbinary(255) NOT NULL DEFAULT '',
  `ip` varchar(40) NOT NULL DEFAULT '',
  `count` int(11) DEFAULT '0',
  `totscore` float NOT NULL DEFAULT '0',
  `signedby` varchar(255) NOT NULL DEFAULT '',
  `lastupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`,`email`,`signedby`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bayes_expire`;
CREATE TABLE `bayes_expire` (
  `id` int(11) NOT NULL DEFAULT '0',
  `runtime` int(11) NOT NULL DEFAULT '0',
  KEY `bayes_expire_idx1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `bayes_global_vars`;
CREATE TABLE `bayes_global_vars` (
  `variable` varchar(30) NOT NULL DEFAULT '',
  `value` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `bayes_seen`;
CREATE TABLE `bayes_seen` (
  `id` int(11) NOT NULL DEFAULT '0',
  `msgid` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `flag` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`msgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `bayes_token`;
CREATE TABLE `bayes_token` (
  `id` int(11) NOT NULL DEFAULT '0',
  `token` binary(5) NOT NULL DEFAULT '\0\0\0\0\0',
  `spam_count` int(11) NOT NULL DEFAULT '0',
  `ham_count` int(11) NOT NULL DEFAULT '0',
  `atime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`token`),
  KEY `bayes_token_idx1` (`id`,`atime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `bayes_vars`;
CREATE TABLE `bayes_vars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) NOT NULL DEFAULT '',
  `spam_count` int(11) NOT NULL DEFAULT '0',
  `ham_count` int(11) NOT NULL DEFAULT '0',
  `token_count` int(11) NOT NULL DEFAULT '0',
  `last_expire` int(11) NOT NULL DEFAULT '0',
  `last_atime_delta` int(11) NOT NULL DEFAULT '0',
  `last_expire_reduce` int(11) NOT NULL DEFAULT '0',
  `oldest_token_age` int(11) NOT NULL DEFAULT '2147483647',
  `newest_token_age` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `bayes_vars_idx1` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `maddr`;
CREATE TABLE `maddr` (
  `partition_tag` int(11) DEFAULT '0',
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varbinary(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `part_email` (`partition_tag`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `mailaddr`;
CREATE TABLE `mailaddr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL DEFAULT '7',
  `email` varbinary(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `msgrcpt`;
CREATE TABLE `msgrcpt` (
  `partition_tag` int(11) NOT NULL DEFAULT '0',
  `mail_id` varbinary(16) NOT NULL,
  `rseqnum` int(11) NOT NULL DEFAULT '0',
  `rid` bigint(20) unsigned NOT NULL,
  `is_local` char(1) NOT NULL DEFAULT '',
  `content` char(1) NOT NULL DEFAULT '',
  `ds` char(1) NOT NULL,
  `rs` char(1) NOT NULL,
  `bl` char(1) DEFAULT '',
  `wl` char(1) DEFAULT '',
  `bspam_level` float DEFAULT NULL,
  `smtp_resp` varchar(255) DEFAULT '',
  PRIMARY KEY (`partition_tag`,`mail_id`,`rseqnum`),
  KEY `msgrcpt_idx_mail_id` (`mail_id`),
  KEY `msgrcpt_idx_rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `msgs`;
CREATE TABLE `msgs` (
  `partition_tag` int(11) NOT NULL DEFAULT '0',
  `mail_id` varbinary(16) NOT NULL,
  `secret_id` varbinary(16) DEFAULT '',
  `am_id` varchar(20) NOT NULL,
  `time_num` int(10) unsigned NOT NULL,
  `time_iso` char(16) NOT NULL,
  `sid` bigint(20) unsigned NOT NULL,
  `policy` varchar(255) DEFAULT '',
  `client_addr` varchar(255) DEFAULT '',
  `size` int(10) unsigned NOT NULL,
  `originating` char(1) NOT NULL DEFAULT '',
  `content` char(1) DEFAULT NULL,
  `quar_type` char(1) DEFAULT NULL,
  `quar_loc` varbinary(255) DEFAULT '',
  `dsn_sent` char(1) DEFAULT NULL,
  `spam_level` float DEFAULT NULL,
  `message_id` varchar(255) DEFAULT '',
  `from_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `host` varchar(255) NOT NULL,
  PRIMARY KEY (`partition_tag`,`mail_id`),
  KEY `msgs_idx_sid` (`sid`),
  KEY `msgs_idx_mess_id` (`message_id`),
  KEY `msgs_idx_time_num` (`time_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `policy`;
CREATE TABLE `policy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `policy_name` varchar(32) DEFAULT NULL,
  `virus_lover` char(1) DEFAULT NULL,
  `spam_lover` char(1) DEFAULT NULL,
  `unchecked_lover` char(1) DEFAULT NULL,
  `banned_files_lover` char(1) DEFAULT NULL,
  `bad_header_lover` char(1) DEFAULT NULL,
  `bypass_virus_checks` char(1) DEFAULT NULL,
  `bypass_spam_checks` char(1) DEFAULT NULL,
  `bypass_banned_checks` char(1) DEFAULT NULL,
  `bypass_header_checks` char(1) DEFAULT NULL,
  `virus_quarantine_to` varchar(64) DEFAULT NULL,
  `spam_quarantine_to` varchar(64) DEFAULT NULL,
  `banned_quarantine_to` varchar(64) DEFAULT NULL,
  `unchecked_quarantine_to` varchar(64) DEFAULT NULL,
  `bad_header_quarantine_to` varchar(64) DEFAULT NULL,
  `clean_quarantine_to` varchar(64) DEFAULT NULL,
  `archive_quarantine_to` varchar(64) DEFAULT NULL,
  `spam_tag_level` float DEFAULT NULL,
  `spam_tag2_level` float DEFAULT NULL,
  `spam_tag3_level` float DEFAULT NULL,
  `spam_kill_level` float DEFAULT NULL,
  `spam_dsn_cutoff_level` float DEFAULT NULL,
  `spam_quarantine_cutoff_level` float DEFAULT NULL,
  `addr_extension_virus` varchar(64) DEFAULT NULL,
  `addr_extension_spam` varchar(64) DEFAULT NULL,
  `addr_extension_banned` varchar(64) DEFAULT NULL,
  `addr_extension_bad_header` varchar(64) DEFAULT NULL,
  `warnvirusrecip` char(1) DEFAULT NULL,
  `warnbannedrecip` char(1) DEFAULT NULL,
  `warnbadhrecip` char(1) DEFAULT NULL,
  `newvirus_admin` varchar(64) DEFAULT NULL,
  `virus_admin` varchar(64) DEFAULT NULL,
  `banned_admin` varchar(64) DEFAULT NULL,
  `bad_header_admin` varchar(64) DEFAULT NULL,
  `spam_admin` varchar(64) DEFAULT NULL,
  `spam_subject_tag` varchar(64) DEFAULT NULL,
  `spam_subject_tag2` varchar(64) DEFAULT NULL,
  `spam_subject_tag3` varchar(64) DEFAULT NULL,
  `message_size_limit` int(11) DEFAULT NULL,
  `banned_rulenames` varchar(64) DEFAULT NULL,
  `disclaimer_options` varchar(64) DEFAULT NULL,
  `forward_method` varchar(64) DEFAULT NULL,
  `sa_userconf` varchar(64) DEFAULT NULL,
  `sa_username` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `quarantine`;
CREATE TABLE `quarantine` (
  `partition_tag` int(11) NOT NULL DEFAULT '0',
  `mail_id` varbinary(16) NOT NULL,
  `chunk_ind` int(10) unsigned NOT NULL,
  `mail_text` blob NOT NULL,
  PRIMARY KEY (`partition_tag`,`mail_id`,`chunk_ind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE `schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL DEFAULT '7',
  `policy_id` int(10) unsigned NOT NULL DEFAULT '1',
  `email` varbinary(255) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `wblist`;
CREATE TABLE `wblist` (
  `rid` int(10) unsigned NOT NULL,
  `sid` int(10) unsigned NOT NULL,
  `wb` varchar(10) NOT NULL,
  PRIMARY KEY (`rid`,`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP DATABASE IF EXISTS `postfix`;
CREATE DATABASE `postfix` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `postfix`;

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Admins';


DROP TABLE IF EXISTS `alias`;
CREATE TABLE `alias` (
  `address` varchar(255) NOT NULL,
  `goto` text NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`address`),
  KEY `domain` (`domain`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Aliases';


DROP TABLE IF EXISTS `alias_domain`;
CREATE TABLE `alias_domain` (
  `alias_domain` varchar(255) NOT NULL,
  `target_domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`alias_domain`),
  KEY `active` (`active`),
  KEY `target_domain` (`target_domain`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Domain Aliases';


DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `value` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='PostfixAdmin settings';


DROP TABLE IF EXISTS `domain`;
CREATE TABLE `domain` (
  `domain` varchar(255) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 NOT NULL,
  `aliases` int(10) NOT NULL DEFAULT '0',
  `mailboxes` int(10) NOT NULL DEFAULT '0',
  `maxquota` bigint(20) NOT NULL DEFAULT '0',
  `quota` bigint(20) NOT NULL DEFAULT '0',
  `transport` varchar(255) NOT NULL,
  `backupmx` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`domain`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Domains';


DROP TABLE IF EXISTS `domain_admins`;
CREATE TABLE `domain_admins` (
  `username` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Domain Admins';


DROP TABLE IF EXISTS `expires`;
CREATE TABLE `expires` (
  `username` varchar(100) NOT NULL,
  `mailbox` varchar(255) NOT NULL,
  `expire_stamp` int(11) NOT NULL,
  PRIMARY KEY (`username`,`mailbox`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fetchmail`;
CREATE TABLE `fetchmail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mailbox` varchar(255) NOT NULL,
  `src_server` varchar(255) NOT NULL,
  `src_auth` enum('password','kerberos_v5','kerberos','kerberos_v4','gssapi','cram-md5','otp','ntlm','msn','ssh','any') DEFAULT NULL,
  `src_user` varchar(255) NOT NULL,
  `src_password` varchar(255) NOT NULL,
  `src_folder` varchar(255) NOT NULL,
  `poll_time` int(11) unsigned NOT NULL DEFAULT '10',
  `fetchall` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `keep` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `protocol` enum('POP3','IMAP','POP2','ETRN','AUTO') DEFAULT NULL,
  `ssl` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `usessl` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `extra_options` text,
  `returned_text` text,
  `mda` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `username` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `data` text NOT NULL,
  KEY `timestamp` (`timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Log';


DROP TABLE IF EXISTS `mailbox`;
CREATE TABLE `mailbox` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `maildir` varchar(255) NOT NULL,
  `quota` bigint(20) NOT NULL DEFAULT '0',
  `local_part` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`username`),
  KEY `domain` (`domain`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Mailboxes';


DROP TABLE IF EXISTS `quota`;
CREATE TABLE `quota` (
  `username` varchar(255) NOT NULL,
  `path` varchar(100) NOT NULL,
  `current` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`username`,`path`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `quota2`;
CREATE TABLE `quota2` (
  `username` varchar(100) NOT NULL,
  `bytes` bigint(20) NOT NULL DEFAULT '0',
  `messages` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `vacation`;
CREATE TABLE `vacation` (
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8 NOT NULL,
  `body` text CHARACTER SET utf8 NOT NULL,
  `cache` text NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`email`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Vacation';


DROP TABLE IF EXISTS `vacation_notification`;
CREATE TABLE `vacation_notification` (
  `on_vacation` varchar(255) CHARACTER SET latin1 NOT NULL,
  `notified` varchar(255) CHARACTER SET latin1 NOT NULL,
  `notified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`on_vacation`,`notified`),
  CONSTRAINT `vacation_notification_pkey` FOREIGN KEY (`on_vacation`) REFERENCES `vacation` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Postfix Admin - Virtual Vacation Notifications';


DROP DATABASE IF EXISTS `roundcube`;
CREATE DATABASE `roundcube` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `roundcube`;

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `user_id` int(10) unsigned NOT NULL,
  `cache_key` varchar(128) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  KEY `expires_index` (`expires`),
  KEY `user_cache_index` (`user_id`,`cache_key`),
  CONSTRAINT `user_id_fk_cache` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cache_index`;
CREATE TABLE `cache_index` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `expires` datetime DEFAULT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `user_id_fk_cache_index` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cache_messages`;
CREATE TABLE `cache_messages` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`mailbox`,`uid`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `user_id_fk_cache_messages` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cache_shared`;
CREATE TABLE `cache_shared` (
  `cache_key` varchar(255) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  KEY `expires_index` (`expires`),
  KEY `cache_key_index` (`cache_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cache_thread`;
CREATE TABLE `cache_thread` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `user_id_fk_cache_thread` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `contactgroupmembers`;
CREATE TABLE `contactgroupmembers` (
  `contactgroup_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`contactgroup_id`,`contact_id`),
  KEY `contactgroupmembers_contact_index` (`contact_id`),
  CONSTRAINT `contact_id_fk_contacts` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contactgroup_id_fk_contactgroups` FOREIGN KEY (`contactgroup_id`) REFERENCES `contactgroups` (`contactgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contactgroups`;
CREATE TABLE `contactgroups` (
  `contactgroup_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`contactgroup_id`),
  KEY `contactgroups_user_index` (`user_id`,`del`),
  CONSTRAINT `user_id_fk_contactgroups` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `email` text NOT NULL,
  `firstname` varchar(128) NOT NULL DEFAULT '',
  `surname` varchar(128) NOT NULL DEFAULT '',
  `vcard` longtext,
  `words` text,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `user_contacts_index` (`user_id`,`del`),
  CONSTRAINT `user_id_fk_contacts` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `user_id` int(10) unsigned DEFAULT NULL,
  `language` varchar(5) NOT NULL,
  `data` longtext NOT NULL,
  UNIQUE KEY `uniqueness` (`user_id`,`language`),
  CONSTRAINT `user_id_fk_dictionary` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `identities`;
CREATE TABLE `identities` (
  `identity_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `standard` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `organization` varchar(128) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL,
  `reply-to` varchar(128) NOT NULL DEFAULT '',
  `bcc` varchar(128) NOT NULL DEFAULT '',
  `signature` longtext,
  `html_signature` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`identity_id`),
  KEY `user_identities_index` (`user_id`,`del`),
  KEY `email_identities_index` (`email`,`del`),
  CONSTRAINT `user_id_fk_identities` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `plugin_manager`;
CREATE TABLE `plugin_manager` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `conf` text NOT NULL,
  `value` text,
  `type` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `searches`;
CREATE TABLE `searches` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` int(3) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `data` text,
  PRIMARY KEY (`search_id`),
  UNIQUE KEY `uniqueness` (`user_id`,`type`,`name`),
  CONSTRAINT `user_id_fk_searches` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `sess_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `ip` varchar(40) NOT NULL,
  `vars` mediumtext NOT NULL,
  PRIMARY KEY (`sess_id`),
  KEY `changed_index` (`changed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `system`;
CREATE TABLE `system` (
  `name` varchar(64) NOT NULL,
  `value` mediumtext,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `mail_host` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `last_login` datetime DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `preferences` longtext,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`,`mail_host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2015-07-09 05:51:06
