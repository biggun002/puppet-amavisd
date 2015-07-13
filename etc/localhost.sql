-- Adminer 4.1.0 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';

DROP DATABASE IF EXISTS `maia`;
CREATE DATABASE `maia` /*!40100 DEFAULT CHARACTER SET latin1 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bayes_global_vars`;
CREATE TABLE `bayes_global_vars` (
  `variable` varchar(30) NOT NULL DEFAULT '',
  `value` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bayes_seen`;
CREATE TABLE `bayes_seen` (
  `id` int(11) NOT NULL DEFAULT '0',
  `msgid` varchar(200) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `flag` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`msgid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bayes_token`;
CREATE TABLE `bayes_token` (
  `id` int(11) NOT NULL DEFAULT '0',
  `token` binary(5) NOT NULL DEFAULT '\0\0\0\0\0',
  `spam_count` int(11) NOT NULL DEFAULT '0',
  `ham_count` int(11) NOT NULL DEFAULT '0',
  `atime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`token`),
  KEY `bayes_token_idx1` (`id`,`atime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_banned_attachments_found`;
CREATE TABLE `maia_banned_attachments_found` (
  `mail_id` int(10) unsigned NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(20) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`mail_id`,`file_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_config`;
CREATE TABLE `maia_config` (
  `id` int(10) unsigned NOT NULL,
  `enable_user_autocreation` char(1) NOT NULL DEFAULT 'N',
  `enable_false_negative_management` char(1) NOT NULL DEFAULT 'Y',
  `enable_stats_tracking` char(1) NOT NULL DEFAULT 'Y',
  `enable_virus_scanning` char(1) NOT NULL DEFAULT 'Y',
  `enable_spam_filtering` char(1) NOT NULL DEFAULT 'Y',
  `enable_banned_files_checking` char(1) NOT NULL DEFAULT 'Y',
  `enable_bad_header_checking` char(1) NOT NULL DEFAULT 'Y',
  `enable_charts` char(1) NOT NULL DEFAULT 'N',
  `enable_spamtraps` char(1) NOT NULL DEFAULT 'N',
  `enable_stats_reporting` char(1) NOT NULL DEFAULT 'N',
  `enable_address_linking` char(1) NOT NULL DEFAULT 'Y',
  `enable_privacy_invasion` char(1) NOT NULL DEFAULT 'N',
  `enable_username_changes` char(1) NOT NULL DEFAULT 'Y',
  `internal_auth` char(1) NOT NULL DEFAULT 'N',
  `system_default_user_is_local` char(1) NOT NULL DEFAULT 'Y',
  `user_virus_scanning` char(1) NOT NULL DEFAULT 'Y',
  `user_spam_filtering` char(1) NOT NULL DEFAULT 'Y',
  `user_banned_files_checking` char(1) NOT NULL DEFAULT 'Y',
  `user_bad_header_checking` char(1) NOT NULL DEFAULT 'Y',
  `admin_email` varchar(255) DEFAULT NULL,
  `expiry_period` int(10) unsigned DEFAULT '30',
  `ham_cache_expiry_period` int(10) unsigned DEFAULT '5',
  `reminder_threshold_count` int(10) unsigned DEFAULT '100',
  `reminder_threshold_size` int(10) unsigned DEFAULT '500000',
  `reminder_template_file` varchar(255) DEFAULT 'reminder.tpl',
  `reminder_login_url` varchar(255) DEFAULT NULL,
  `newuser_template_file` varchar(255) DEFAULT 'newuser.tpl',
  `smtp_server` varchar(255) DEFAULT 'localhost',
  `smtp_port` int(10) unsigned DEFAULT '10025',
  `currency_label` varchar(15) DEFAULT '$',
  `bandwidth_cost` float NOT NULL DEFAULT '0',
  `chart_ham_colour` varchar(32) DEFAULT '#DDDDB7',
  `chart_spam_colour` varchar(32) DEFAULT '#FFAAAA',
  `chart_virus_colour` varchar(32) DEFAULT '#CCFFCC',
  `chart_fp_colour` varchar(32) DEFAULT '#C4CA73',
  `chart_fn_colour` varchar(32) DEFAULT '#FF7575',
  `chart_suspected_ham_colour` varchar(32) DEFAULT '#FFFFB7',
  `chart_suspected_spam_colour` varchar(32) DEFAULT '#FFCCCC',
  `chart_wl_colour` varchar(32) DEFAULT '#eeeeee',
  `chart_bl_colour` varchar(32) DEFAULT '#888888',
  `chart_background_colour` varchar(32) DEFAULT '#B0ECFF',
  `chart_font_colour` varchar(32) DEFAULT '#3D3D50',
  `chart_autogeneration_interval` int(10) unsigned DEFAULT '60',
  `banner_title` varchar(255) DEFAULT 'Maia Mailguard',
  `use_icons` char(1) NOT NULL DEFAULT 'Y',
  `use_logo` char(1) NOT NULL DEFAULT 'Y',
  `logo_url` varchar(255) DEFAULT 'http://www.maiamailguard.com/',
  `logo_file` varchar(255) DEFAULT 'images/maia-logotoolbar.gif',
  `logo_alt_text` varchar(255) DEFAULT 'Maia Mailguard Home Page',
  `virus_info_url` varchar(255) DEFAULT 'http://www.google.com/search?q=%%VIRUSNAME%%+virus+information',
  `virus_lookup` varchar(20) DEFAULT 'google',
  `primary_report_server` varchar(255) DEFAULT 'maia.renaissoft.com',
  `primary_report_port` int(10) unsigned DEFAULT '443',
  `secondary_report_server` varchar(255) DEFAULT NULL,
  `secondary_report_port` int(10) unsigned DEFAULT '443',
  `reporter_sitename` varchar(255) DEFAULT NULL,
  `reporter_username` varchar(50) DEFAULT NULL,
  `reporter_password` varchar(50) DEFAULT NULL,
  `size_limit` int(10) unsigned DEFAULT '1000000',
  `oversize_policy` char(1) NOT NULL DEFAULT 'B',
  `sa_score_set` int(10) unsigned NOT NULL DEFAULT '0',
  `key_file` varchar(255) DEFAULT 'blowfish.key',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_domains`;
CREATE TABLE `maia_domains` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL,
  `reminders` char(1) NOT NULL DEFAULT 'N',
  `charts` char(1) NOT NULL DEFAULT 'N',
  `enable_user_autocreation` char(1) NOT NULL DEFAULT 'Y',
  `language` varchar(10) NOT NULL DEFAULT 'en',
  `charset` varchar(20) NOT NULL DEFAULT 'ISO-8859-1',
  `routing_domain` varchar(255) NOT NULL DEFAULT '',
  `transport` varchar(255) NOT NULL DEFAULT ':',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`),
  KEY `maia_domains_idx_routing_domain` (`routing_domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_domain_admins`;
CREATE TABLE `maia_domain_admins` (
  `domain_id` int(10) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`domain_id`,`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_languages`;
CREATE TABLE `maia_languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_name` varchar(100) NOT NULL,
  `abbreviation` char(2) NOT NULL,
  `installed` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbreviation` (`abbreviation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_mail`;
CREATE TABLE `maia_mail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `received_date` datetime NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `sender_email` varbinary(255) NOT NULL,
  `envelope_to` blob NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `contents` longblob NOT NULL,
  `score` float DEFAULT NULL,
  `autolearn_status` varchar(15) NOT NULL DEFAULT 'unavailable',
  PRIMARY KEY (`id`),
  KEY `maia_mail_idx_received_date` (`received_date`),
  KEY `maia_mail_idx_sender_email` (`sender_email`),
  KEY `maia_mail_idx_subject` (`subject`),
  KEY `maia_mail_idx_score` (`score`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_mail_recipients`;
CREATE TABLE `maia_mail_recipients` (
  `mail_id` int(10) unsigned NOT NULL,
  `recipient_id` int(10) unsigned NOT NULL,
  `type` char(1) NOT NULL,
  `token` char(64) NOT NULL,
  PRIMARY KEY (`mail_id`,`recipient_id`),
  UNIQUE KEY `token_system_idx` (`token`),
  KEY `maia_mail_recipients_idx_type` (`type`),
  KEY `maia_mail_recipients_idx_recipient_id` (`recipient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_sa_rules`;
CREATE TABLE `maia_sa_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rule_name` varchar(255) NOT NULL,
  `rule_description` varchar(255) NOT NULL DEFAULT '',
  `rule_score_0` float NOT NULL DEFAULT '1',
  `rule_score_1` float NOT NULL DEFAULT '1',
  `rule_score_2` float NOT NULL DEFAULT '1',
  `rule_score_3` float NOT NULL DEFAULT '1',
  `rule_count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rule_name` (`rule_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_sa_rules_triggered`;
CREATE TABLE `maia_sa_rules_triggered` (
  `mail_id` int(10) unsigned NOT NULL,
  `rule_id` int(10) unsigned NOT NULL,
  `rule_score` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`mail_id`,`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_stats`;
CREATE TABLE `maia_stats` (
  `user_id` int(10) unsigned NOT NULL,
  `oldest_suspected_ham_date` datetime DEFAULT NULL,
  `newest_suspected_ham_date` datetime DEFAULT NULL,
  `smallest_suspected_ham_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_suspected_ham_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_suspected_ham_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lowest_suspected_ham_score` float NOT NULL DEFAULT '0',
  `highest_suspected_ham_score` float NOT NULL DEFAULT '0',
  `total_suspected_ham_score` float NOT NULL DEFAULT '0',
  `total_suspected_ham_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_ham_date` datetime DEFAULT NULL,
  `newest_ham_date` datetime DEFAULT NULL,
  `smallest_ham_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_ham_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_ham_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lowest_ham_score` float NOT NULL DEFAULT '0',
  `highest_ham_score` float NOT NULL DEFAULT '0',
  `total_ham_score` float NOT NULL DEFAULT '0',
  `total_ham_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_wl_date` datetime DEFAULT NULL,
  `newest_wl_date` datetime DEFAULT NULL,
  `smallest_wl_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_wl_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_wl_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_wl_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_bl_date` datetime DEFAULT NULL,
  `newest_bl_date` datetime DEFAULT NULL,
  `smallest_bl_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_bl_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_bl_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_bl_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_suspected_spam_date` datetime DEFAULT NULL,
  `newest_suspected_spam_date` datetime DEFAULT NULL,
  `smallest_suspected_spam_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_suspected_spam_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_suspected_spam_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lowest_suspected_spam_score` float NOT NULL DEFAULT '0',
  `highest_suspected_spam_score` float NOT NULL DEFAULT '0',
  `total_suspected_spam_score` float NOT NULL DEFAULT '0',
  `total_suspected_spam_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_fp_date` datetime DEFAULT NULL,
  `newest_fp_date` datetime DEFAULT NULL,
  `smallest_fp_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_fp_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_fp_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lowest_fp_score` float NOT NULL DEFAULT '0',
  `highest_fp_score` float NOT NULL DEFAULT '0',
  `total_fp_score` float NOT NULL DEFAULT '0',
  `total_fp_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_fn_date` datetime DEFAULT NULL,
  `newest_fn_date` datetime DEFAULT NULL,
  `smallest_fn_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_fn_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_fn_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lowest_fn_score` float NOT NULL DEFAULT '0',
  `highest_fn_score` float NOT NULL DEFAULT '0',
  `total_fn_score` float NOT NULL DEFAULT '0',
  `total_fn_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_spam_date` datetime DEFAULT NULL,
  `newest_spam_date` datetime DEFAULT NULL,
  `smallest_spam_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_spam_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_spam_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lowest_spam_score` float NOT NULL DEFAULT '0',
  `highest_spam_score` float NOT NULL DEFAULT '0',
  `total_spam_score` float NOT NULL DEFAULT '0',
  `total_spam_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_virus_date` datetime DEFAULT NULL,
  `newest_virus_date` datetime DEFAULT NULL,
  `smallest_virus_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_virus_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_virus_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_virus_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_bad_header_date` datetime DEFAULT NULL,
  `newest_bad_header_date` datetime DEFAULT NULL,
  `smallest_bad_header_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_bad_header_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_bad_header_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_bad_header_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_banned_file_date` datetime DEFAULT NULL,
  `newest_banned_file_date` datetime DEFAULT NULL,
  `smallest_banned_file_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_banned_file_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_banned_file_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_banned_file_items` int(10) unsigned NOT NULL DEFAULT '0',
  `oldest_oversized_date` datetime DEFAULT NULL,
  `newest_oversized_date` datetime DEFAULT NULL,
  `smallest_oversized_size` int(10) unsigned NOT NULL DEFAULT '0',
  `largest_oversized_size` int(10) unsigned NOT NULL DEFAULT '0',
  `total_oversized_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_oversized_items` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_stats_history`;
CREATE TABLE `maia_stats_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` char(1) NOT NULL DEFAULT 'H',
  `taken_at` datetime NOT NULL,
  `total_ham_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_ham_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_spam_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_spam_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_virus_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_virus_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_fp_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_fp_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_fn_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_fn_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_banned_file_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_banned_file_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_bad_header_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_bad_header_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_wl_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_wl_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_bl_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_bl_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_oversized_items` int(10) unsigned NOT NULL DEFAULT '0',
  `total_oversized_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_themes`;
CREATE TABLE `maia_themes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `path` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_tokens`;
CREATE TABLE `maia_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token_system` varchar(32) NOT NULL,
  `token` char(64) NOT NULL,
  `data` blob NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`,`token_system`),
  KEY `token_system` (`token_system`),
  KEY `expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_users`;
CREATE TABLE `maia_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_level` char(1) NOT NULL DEFAULT 'U',
  `reminders` char(1) NOT NULL DEFAULT 'Y',
  `charts` char(1) NOT NULL DEFAULT 'N',
  `primary_email_id` int(10) unsigned NOT NULL DEFAULT '0',
  `language` varchar(10) NOT NULL DEFAULT 'en',
  `charset` varchar(20) NOT NULL DEFAULT 'ISO-8859-1',
  `spamtrap` char(1) NOT NULL DEFAULT 'N',
  `password` varchar(32) DEFAULT NULL,
  `auto_whitelist` char(1) NOT NULL DEFAULT 'Y',
  `items_per_page` int(10) unsigned NOT NULL DEFAULT '50',
  `spam_quarantine_sort` char(2) NOT NULL DEFAULT 'XA',
  `virus_quarantine_sort` char(2) NOT NULL DEFAULT 'DA',
  `header_quarantine_sort` char(2) NOT NULL DEFAULT 'DA',
  `attachment_quarantine_sort` char(2) NOT NULL DEFAULT 'DA',
  `ham_cache_sort` char(2) NOT NULL DEFAULT 'XD',
  `discard_ham` char(1) NOT NULL DEFAULT 'N',
  `theme_id` int(10) unsigned NOT NULL DEFAULT '1',
  `quarantine_digest_interval` int(10) unsigned NOT NULL DEFAULT '0',
  `last_digest_sent` datetime DEFAULT NULL,
  `truncate_subject` int(10) unsigned NOT NULL DEFAULT '20',
  `truncate_email` int(10) unsigned NOT NULL DEFAULT '20',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `primary_email_idx` (`primary_email_id`),
  KEY `theme_id` (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_viruses`;
CREATE TABLE `maia_viruses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `virus_name` varchar(255) NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virus_name` (`virus_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_viruses_detected`;
CREATE TABLE `maia_viruses_detected` (
  `mail_id` int(10) unsigned NOT NULL,
  `virus_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`mail_id`,`virus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `maia_virus_aliases`;
CREATE TABLE `maia_virus_aliases` (
  `virus_id` int(10) unsigned NOT NULL,
  `virus_alias` varchar(255) NOT NULL,
  PRIMARY KEY (`virus_id`,`virus_alias`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `mailaddr`;
CREATE TABLE `mailaddr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL DEFAULT '7',
  `email` varbinary(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `policy`;
CREATE TABLE `policy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `policy_name` varchar(255) DEFAULT NULL,
  `virus_lover` char(1) DEFAULT 'Y',
  `spam_lover` char(1) DEFAULT 'Y',
  `banned_files_lover` char(1) DEFAULT 'Y',
  `bad_header_lover` char(1) DEFAULT 'Y',
  `bypass_virus_checks` char(1) DEFAULT 'Y',
  `bypass_spam_checks` char(1) DEFAULT 'Y',
  `bypass_banned_checks` char(1) DEFAULT 'Y',
  `bypass_header_checks` char(1) DEFAULT 'Y',
  `discard_viruses` char(1) DEFAULT 'N',
  `discard_spam` char(1) DEFAULT 'N',
  `discard_banned_files` char(1) DEFAULT 'N',
  `discard_bad_headers` char(1) DEFAULT 'N',
  `spam_modifies_subj` char(1) DEFAULT 'N',
  `spam_quarantine_to` varchar(64) DEFAULT NULL,
  `spam_tag_level` float DEFAULT '999',
  `spam_tag2_level` float DEFAULT '999',
  `spam_kill_level` float DEFAULT '999',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


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
  `maia_user_id` int(10) unsigned NOT NULL,
  `maia_domain_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_idx_maia_user_id` (`maia_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `wblist`;
CREATE TABLE `wblist` (
  `rid` int(10) unsigned NOT NULL,
  `sid` int(10) unsigned NOT NULL,
  `wb` char(1) NOT NULL,
  PRIMARY KEY (`rid`,`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP DATABASE IF EXISTS `mysql`;
CREATE DATABASE `mysql` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mysql`;

DROP TABLE IF EXISTS `columns_priv`;
CREATE TABLE `columns_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Column_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column privileges';


DROP TABLE IF EXISTS `db`;
CREATE TABLE `db` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database privileges';


DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `body` longblob NOT NULL,
  `definer` char(77) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `execute_at` datetime DEFAULT NULL,
  `interval_value` int(11) DEFAULT NULL,
  `interval_field` enum('YEAR','QUARTER','MONTH','DAY','HOUR','MINUTE','WEEK','SECOND','MICROSECOND','YEAR_MONTH','DAY_HOUR','DAY_MINUTE','DAY_SECOND','HOUR_MINUTE','HOUR_SECOND','MINUTE_SECOND','DAY_MICROSECOND','HOUR_MICROSECOND','MINUTE_MICROSECOND','SECOND_MICROSECOND') DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_executed` datetime DEFAULT NULL,
  `starts` datetime DEFAULT NULL,
  `ends` datetime DEFAULT NULL,
  `status` enum('ENABLED','DISABLED','SLAVESIDE_DISABLED') NOT NULL DEFAULT 'ENABLED',
  `on_completion` enum('DROP','PRESERVE') NOT NULL DEFAULT 'DROP',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH') NOT NULL DEFAULT '',
  `comment` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `originator` int(10) unsigned NOT NULL,
  `time_zone` char(64) CHARACTER SET latin1 NOT NULL DEFAULT 'SYSTEM',
  `character_set_client` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body_utf8` longblob,
  PRIMARY KEY (`db`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Events';


DROP TABLE IF EXISTS `func`;
CREATE TABLE `func` (
  `name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ret` tinyint(1) NOT NULL DEFAULT '0',
  `dl` char(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` enum('function','aggregate') CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User defined functions';


DROP TABLE IF EXISTS `general_log`;
CREATE TABLE `general_log` (
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_host` mediumtext NOT NULL,
  `thread_id` bigint(21) unsigned NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `command_type` varchar(64) NOT NULL,
  `argument` mediumtext NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='General log';


DROP TABLE IF EXISTS `help_category`;
CREATE TABLE `help_category` (
  `help_category_id` smallint(5) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `parent_category_id` smallint(5) unsigned DEFAULT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help categories';


DROP TABLE IF EXISTS `help_keyword`;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help keywords';


DROP TABLE IF EXISTS `help_relation`;
CREATE TABLE `help_relation` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `help_keyword_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`help_keyword_id`,`help_topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='keyword-topic relation';


DROP TABLE IF EXISTS `help_topic`;
CREATE TABLE `help_topic` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint(5) unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help topics';


DROP TABLE IF EXISTS `innodb_index_stats`;
CREATE TABLE `innodb_index_stats` (
  `database_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `index_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stat_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `stat_value` bigint(20) unsigned NOT NULL,
  `sample_size` bigint(20) unsigned DEFAULT NULL,
  `stat_description` varchar(1024) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`database_name`,`table_name`,`index_name`,`stat_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0;


DROP TABLE IF EXISTS `innodb_table_stats`;
CREATE TABLE `innodb_table_stats` (
  `database_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `n_rows` bigint(20) unsigned NOT NULL,
  `clustered_index_size` bigint(20) unsigned NOT NULL,
  `sum_of_other_index_sizes` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`database_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0;


DROP TABLE IF EXISTS `ndb_binlog_index`;
CREATE TABLE `ndb_binlog_index` (
  `Position` bigint(20) unsigned NOT NULL,
  `File` varchar(255) NOT NULL,
  `epoch` bigint(20) unsigned NOT NULL,
  `inserts` int(10) unsigned NOT NULL,
  `updates` int(10) unsigned NOT NULL,
  `deletes` int(10) unsigned NOT NULL,
  `schemaops` int(10) unsigned NOT NULL,
  `orig_server_id` int(10) unsigned NOT NULL,
  `orig_epoch` bigint(20) unsigned NOT NULL,
  `gci` int(10) unsigned NOT NULL,
  PRIMARY KEY (`epoch`,`orig_server_id`,`orig_epoch`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `plugin`;
CREATE TABLE `plugin` (
  `name` varchar(64) NOT NULL DEFAULT '',
  `dl` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='MySQL plugins';


DROP TABLE IF EXISTS `proc`;
CREATE TABLE `proc` (
  `db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `type` enum('FUNCTION','PROCEDURE') NOT NULL,
  `specific_name` char(64) NOT NULL DEFAULT '',
  `language` enum('SQL') NOT NULL DEFAULT 'SQL',
  `sql_data_access` enum('CONTAINS_SQL','NO_SQL','READS_SQL_DATA','MODIFIES_SQL_DATA') NOT NULL DEFAULT 'CONTAINS_SQL',
  `is_deterministic` enum('YES','NO') NOT NULL DEFAULT 'NO',
  `security_type` enum('INVOKER','DEFINER') NOT NULL DEFAULT 'DEFINER',
  `param_list` blob NOT NULL,
  `returns` longblob NOT NULL,
  `body` longblob NOT NULL,
  `definer` char(77) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH') NOT NULL DEFAULT '',
  `comment` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `character_set_client` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body_utf8` longblob,
  PRIMARY KEY (`db`,`name`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stored Procedures';


DROP TABLE IF EXISTS `procs_priv`;
CREATE TABLE `procs_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Routine_name` char(64) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `Routine_type` enum('FUNCTION','PROCEDURE') COLLATE utf8_bin NOT NULL,
  `Grantor` char(77) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proc_priv` set('Execute','Alter Routine','Grant') CHARACTER SET utf8 NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Procedure privileges';


DROP TABLE IF EXISTS `proxies_priv`;
CREATE TABLE `proxies_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proxied_host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proxied_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `With_grant` tinyint(1) NOT NULL DEFAULT '0',
  `Grantor` char(77) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Host`,`User`,`Proxied_host`,`Proxied_user`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User proxy privileges';


DROP TABLE IF EXISTS `servers`;
CREATE TABLE `servers` (
  `Server_name` char(64) NOT NULL DEFAULT '',
  `Host` char(64) NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `Username` char(64) NOT NULL DEFAULT '',
  `Password` char(64) NOT NULL DEFAULT '',
  `Port` int(4) NOT NULL DEFAULT '0',
  `Socket` char(64) NOT NULL DEFAULT '',
  `Wrapper` char(64) NOT NULL DEFAULT '',
  `Owner` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`Server_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='MySQL Foreign Servers table';


DROP TABLE IF EXISTS `slave_master_info`;
CREATE TABLE `slave_master_info` (
  `Number_of_lines` int(10) unsigned NOT NULL COMMENT 'Number of lines in the file.',
  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The name of the master binary log currently being read from the master.',
  `Master_log_pos` bigint(20) unsigned NOT NULL COMMENT 'The master log position of the last read event.',
  `Host` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The host name of the master.',
  `User_name` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The user name used to connect to the master.',
  `User_password` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The password used to connect to the master.',
  `Port` int(10) unsigned NOT NULL COMMENT 'The network port used to connect to the master.',
  `Connect_retry` int(10) unsigned NOT NULL COMMENT 'The period (in seconds) that the slave will wait before trying to reconnect to the master.',
  `Enabled_ssl` tinyint(1) NOT NULL COMMENT 'Indicates whether the server supports SSL connections.',
  `Ssl_ca` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file used for the Certificate Authority (CA) certificate.',
  `Ssl_capath` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The path to the Certificate Authority (CA) certificates.',
  `Ssl_cert` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the SSL certificate file.',
  `Ssl_cipher` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the cipher in use for the SSL connection.',
  `Ssl_key` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the SSL key file.',
  `Ssl_verify_server_cert` tinyint(1) NOT NULL COMMENT 'Whether to verify the server certificate.',
  `Heartbeat` float NOT NULL,
  `Bind` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Displays which interface is employed when connecting to the MySQL server',
  `Ignored_server_ids` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The number of server IDs to be ignored, followed by the actual server IDs',
  `Uuid` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The master server uuid.',
  `Retry_count` bigint(20) unsigned NOT NULL COMMENT 'Number of reconnect attempts, to the master, before giving up.',
  `Ssl_crl` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file used for the Certificate Revocation List (CRL)',
  `Ssl_crlpath` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The path used for Certificate Revocation List (CRL) files',
  `Enabled_auto_position` tinyint(1) NOT NULL COMMENT 'Indicates whether GTIDs will be used to retrieve events from the master.',
  PRIMARY KEY (`Host`,`Port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 COMMENT='Master Information';


DROP TABLE IF EXISTS `slave_relay_log_info`;
CREATE TABLE `slave_relay_log_info` (
  `Number_of_lines` int(10) unsigned NOT NULL COMMENT 'Number of lines in the file or rows in the table. Used to version table definitions.',
  `Relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The name of the current relay log file.',
  `Relay_log_pos` bigint(20) unsigned NOT NULL COMMENT 'The relay log position of the last executed event.',
  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The name of the master binary log file from which the events in the relay log file were read.',
  `Master_log_pos` bigint(20) unsigned NOT NULL COMMENT 'The master log position of the last executed event.',
  `Sql_delay` int(11) NOT NULL COMMENT 'The number of seconds that the slave must lag behind the master.',
  `Number_of_workers` int(10) unsigned NOT NULL,
  `Id` int(10) unsigned NOT NULL COMMENT 'Internal Id that uniquely identifies this record.',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 COMMENT='Relay Log Information';


DROP TABLE IF EXISTS `slave_worker_info`;
CREATE TABLE `slave_worker_info` (
  `Id` int(10) unsigned NOT NULL,
  `Relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Relay_log_pos` bigint(20) unsigned NOT NULL,
  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Master_log_pos` bigint(20) unsigned NOT NULL,
  `Checkpoint_relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Checkpoint_relay_log_pos` bigint(20) unsigned NOT NULL,
  `Checkpoint_master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Checkpoint_master_log_pos` bigint(20) unsigned NOT NULL,
  `Checkpoint_seqno` int(10) unsigned NOT NULL,
  `Checkpoint_group_size` int(10) unsigned NOT NULL,
  `Checkpoint_group_bitmap` blob NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 COMMENT='Worker Information';


DROP TABLE IF EXISTS `slow_log`;
CREATE TABLE `slow_log` (
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_host` mediumtext NOT NULL,
  `query_time` time NOT NULL,
  `lock_time` time NOT NULL,
  `rows_sent` int(11) NOT NULL,
  `rows_examined` int(11) NOT NULL,
  `db` varchar(512) NOT NULL,
  `last_insert_id` int(11) NOT NULL,
  `insert_id` int(11) NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `sql_text` mediumtext NOT NULL,
  `thread_id` bigint(21) unsigned NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='Slow log';


DROP TABLE IF EXISTS `tables_priv`;
CREATE TABLE `tables_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Grantor` char(77) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view','Trigger') CHARACTER SET utf8 NOT NULL DEFAULT '',
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table privileges';


DROP TABLE IF EXISTS `time_zone`;
CREATE TABLE `time_zone` (
  `Time_zone_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Use_leap_seconds` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Time_zone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zones';


DROP TABLE IF EXISTS `time_zone_leap_second`;
CREATE TABLE `time_zone_leap_second` (
  `Transition_time` bigint(20) NOT NULL,
  `Correction` int(11) NOT NULL,
  PRIMARY KEY (`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Leap seconds information for time zones';


DROP TABLE IF EXISTS `time_zone_name`;
CREATE TABLE `time_zone_name` (
  `Name` char(64) NOT NULL,
  `Time_zone_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone names';


DROP TABLE IF EXISTS `time_zone_transition`;
CREATE TABLE `time_zone_transition` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_time` bigint(20) NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Time_zone_id`,`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transitions';


DROP TABLE IF EXISTS `time_zone_transition_type`;
CREATE TABLE `time_zone_transition_type` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  `Offset` int(11) NOT NULL DEFAULT '0',
  `Is_DST` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Abbreviation` char(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`Time_zone_id`,`Transition_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transition types';


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Password` char(41) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Reload_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Shutdown_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Process_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `File_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_db_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Super_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Repl_slave_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Repl_client_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_user_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tablespace_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `ssl_type` enum('','ANY','X509','SPECIFIED') CHARACTER SET utf8 NOT NULL DEFAULT '',
  `ssl_cipher` blob NOT NULL,
  `x509_issuer` blob NOT NULL,
  `x509_subject` blob NOT NULL,
  `max_questions` int(11) unsigned NOT NULL DEFAULT '0',
  `max_updates` int(11) unsigned NOT NULL DEFAULT '0',
  `max_connections` int(11) unsigned NOT NULL DEFAULT '0',
  `max_user_connections` int(11) unsigned NOT NULL DEFAULT '0',
  `plugin` char(64) COLLATE utf8_bin DEFAULT 'mysql_native_password',
  `authentication_string` text COLLATE utf8_bin,
  `password_expired` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and global privileges';


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


DROP DATABASE IF EXISTS `test`;
CREATE DATABASE `test` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `test`;

-- 2015-06-22 17:28:15
