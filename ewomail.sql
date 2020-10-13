-- phpMyAdmin SQL Dump
-- version 4.4.11
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2020-10-13 18:34:21
-- 服务器版本： 5.5.62
-- PHP Version: 5.4.43

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ewomail`
--

-- --------------------------------------------------------

--
-- 表的结构 `i_admin`
--

CREATE TABLE IF NOT EXISTS `i_admin` (
  `aid` int(11) NOT NULL,
  `username` varchar(30) NOT NULL COMMENT '账号',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `name` varchar(30) NOT NULL COMMENT '真实名称',
  `super` int(1) NOT NULL DEFAULT '0' COMMENT '是否为超级管理员',
  `gid` int(11) NOT NULL DEFAULT '0' COMMENT '管理组id',
  `active` int(1) NOT NULL DEFAULT '1' COMMENT '是否正常：1是，0否',
  `is_webmail` int(1) NOT NULL DEFAULT '0' COMMENT '是否有web控制面板权限：0否：1是',
  `ctime` datetime NOT NULL COMMENT '创建时间'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员账号';

--
-- 转存表中的数据 `i_admin`
--

INSERT INTO `i_admin` (`aid`, `username`, `password`, `name`, `super`, `gid`, `active`, `is_webmail`, `ctime`) VALUES
(1, 'admin', '3bb3733de472b226208307ec1e689347', 'admin', 1, 0, 1, 1, '2016-03-25 21:45:46');

-- --------------------------------------------------------

--
-- 表的结构 `i_admin_group`
--

CREATE TABLE IF NOT EXISTS `i_admin_group` (
  `gid` int(11) NOT NULL,
  `title` varchar(30) NOT NULL COMMENT '标题',
  `auth` text
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='管理组';

--
-- 转存表中的数据 `i_admin_group`
--

INSERT INTO `i_admin_group` (`gid`, `title`, `auth`) VALUES
(8, '客服', 'a:7:{i:101;a:3:{s:4:"view";s:1:"1";s:4:"edit";s:1:"1";s:7:"menu_id";s:3:"101";}i:103;a:2:{s:4:"view";s:1:"1";s:7:"menu_id";s:3:"103";}i:105;a:2:{s:4:"view";s:1:"1";s:7:"menu_id";s:3:"105";}i:201;a:2:{s:4:"view";s:1:"1";s:7:"menu_id";s:3:"201";}i:203;a:2:{s:4:"view";s:1:"1";s:7:"menu_id";s:3:"203";}i:205;a:2:{s:4:"view";s:1:"1";s:7:"menu_id";s:3:"205";}i:206;a:2:{s:4:"view";s:1:"1";s:7:"menu_id";s:3:"206";}}');

-- --------------------------------------------------------

--
-- 表的结构 `i_admin_log`
--

CREATE TABLE IF NOT EXISTS `i_admin_log` (
  `log_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL COMMENT '管理员账号',
  `ip` varchar(255) NOT NULL,
  `explain` text COMMENT '说明',
  `ctime` datetime NOT NULL COMMENT '创建时间'
) ENGINE=MyISAM AUTO_INCREMENT=209 DEFAULT CHARSET=utf8 COMMENT='管理员操作日志';

--
-- 转存表中的数据 `i_admin_log`
--

INSERT INTO `i_admin_log` (`log_id`, `username`, `ip`, `explain`, `ctime`) VALUES
(207, '', '192.168.200.200', '[操作：登陆]登录账号：admin', '2020-10-13 18:32:43'),
(208, 'admin', '192.168.200.200', '[操作：添加]邮件地址：admin@ukatoo.com', '2020-10-13 18:33:38');

-- --------------------------------------------------------

--
-- 表的结构 `i_admin_menu`
--

CREATE TABLE IF NOT EXISTS `i_admin_menu` (
  `menu_id` int(11) NOT NULL,
  `mark` varchar(30) NOT NULL DEFAULT '' COMMENT '备注',
  `lang` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `top_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级id',
  `edit` int(1) NOT NULL DEFAULT '0' COMMENT '添加和编辑权限',
  `del` int(1) NOT NULL DEFAULT '0' COMMENT '删除权限',
  `edit_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联编辑id',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台菜单栏目';

--
-- 转存表中的数据 `i_admin_menu`
--

INSERT INTO `i_admin_menu` (`menu_id`, `mark`, `lang`, `url`, `top_id`, `edit`, `del`, `edit_id`, `sort`) VALUES
(100, '邮件管理', '90100', '', 0, 0, 0, 0, 0),
(101, '邮件列表', '90101', '/Users', 100, 1, 1, 0, 0),
(102, '邮件添加', '90102', '/Users/edit', 100, 0, 0, 101, 0),
(103, '邮件域名', '90103', '/Domain', 100, 1, 1, 0, 0),
(105, '邮件系统设置', '90105', '/Users/config', 100, 1, 0, 0, 0),
(200, '系统管理', '90200', '', 0, 0, 0, 0, 0),
(201, '管理员列表', '90201', '/Admin', 200, 1, 1, 0, 0),
(202, '管理员添加', '90202', '/Admin/edit', 200, 0, 0, 201, 0),
(203, '角色列表', '90203', '/Group', 200, 1, 1, 0, 0),
(204, '角色添加', '90204', '/Group/edit', 200, 0, 0, 203, 0),
(205, '系统设置', '90205', '/System/config', 200, 1, 0, 0, 0),
(206, '操作日志', '90206', '/Log', 200, 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `i_aliases`
--

CREATE TABLE IF NOT EXISTS `i_aliases` (
  `id` int(11) NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮箱别名转发';

-- --------------------------------------------------------

--
-- 表的结构 `i_bcc_user`
--

CREATE TABLE IF NOT EXISTS `i_bcc_user` (
  `source` varchar(255) NOT NULL COMMENT '接收邮件的email',
  `to_email` varchar(255) NOT NULL COMMENT '目标用户的邮件'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件转发';

-- --------------------------------------------------------

--
-- 表的结构 `i_domains`
--

CREATE TABLE IF NOT EXISTS `i_domains` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` int(1) NOT NULL DEFAULT '0',
  `s_num` int(11) NOT NULL DEFAULT '0' COMMENT '邮件每天的发送量，0不受限制',
  `c_num` int(11) NOT NULL DEFAULT '0' COMMENT '邮件每天的接收量，0不受限制',
  `c_ip` int(11) NOT NULL DEFAULT '0' COMMENT '限制IP每天发送到邮件的数量，0不受限制',
  `g` int(11) NOT NULL DEFAULT '0' COMMENT '容量限制，单位G',
  `g_boundary` int(11) NOT NULL DEFAULT '0' COMMENT '容量达到边界发送通知(百分比)',
  `ctime` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `i_domains`
--

INSERT INTO `i_domains` (`id`, `name`, `active`, `s_num`, `c_num`, `c_ip`, `g`, `g_boundary`, `ctime`) VALUES
(1, 'ukatoo.com', 1, 0, 0, 0, 0, 0, '2020-09-27 13:51:20');

-- --------------------------------------------------------

--
-- 表的结构 `i_mail_config`
--

CREATE TABLE IF NOT EXISTS `i_mail_config` (
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `i_mail_config`
--

INSERT INTO `i_mail_config` (`name`, `value`) VALUES
('imap', 'imap.ukatoo.com'),
('mydomain', 'ukatoo.com'),
('myhostname', 'mail.ukatoo.com'),
('smtp', 'smtp.ukatoo.com');

-- --------------------------------------------------------

--
-- 表的结构 `i_quota`
--

CREATE TABLE IF NOT EXISTS `i_quota` (
  `email` varchar(100) NOT NULL,
  `bytes` bigint(20) NOT NULL DEFAULT '0',
  `messages` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `i_system_config`
--

CREATE TABLE IF NOT EXISTS `i_system_config` (
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置表';

--
-- 转存表中的数据 `i_system_config`
--

INSERT INTO `i_system_config` (`name`, `value`) VALUES
('copyright', 'Copyright © 2016-2017 | ewomail.com 版权所有'),
('icp', 'ICP证：粤ICP备**********号'),
('lang', 'zh-cn'),
('title', 'ewomail.com');

-- --------------------------------------------------------

--
-- 表的结构 `i_users`
--

CREATE TABLE IF NOT EXISTS `i_users` (
  `id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `password` varchar(106) NOT NULL,
  `email` varchar(100) NOT NULL,
  `maildir` varchar(255) NOT NULL,
  `uname` varchar(255) DEFAULT NULL COMMENT '姓名',
  `tel` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `active` int(1) NOT NULL DEFAULT '1' COMMENT '是否正常：1是，0否',
  `limits` int(1) NOT NULL DEFAULT '1' COMMENT '收发限制',
  `limitg` int(1) NOT NULL DEFAULT '1' COMMENT '容量限制',
  `ctime` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='邮箱用户表';

--
-- 转存表中的数据 `i_users`
--

INSERT INTO `i_users` (`id`, `domain_id`, `password`, `email`, `maildir`, `uname`, `tel`, `active`, `limits`, `limitg`, `ctime`) VALUES
(1, 1, 'd0ad64b0d105567b26082bb7ce1be67a', 'admin@ukatoo.com', '/ewomail/mail/vmail/ukatoo.com/a/d/m/admin.20201013', 'Yaomin', '18569547889', 1, 0, 0, '2020-10-13 18:33:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `i_admin`
--
ALTER TABLE `i_admin`
  ADD PRIMARY KEY (`aid`),
  ADD UNIQUE KEY `username` (`username`) USING BTREE;

--
-- Indexes for table `i_admin_group`
--
ALTER TABLE `i_admin_group`
  ADD PRIMARY KEY (`gid`);

--
-- Indexes for table `i_admin_log`
--
ALTER TABLE `i_admin_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `i_admin_menu`
--
ALTER TABLE `i_admin_menu`
  ADD PRIMARY KEY (`menu_id`),
  ADD KEY `top_id` (`top_id`) USING BTREE,
  ADD KEY `edit_id` (`edit_id`);

--
-- Indexes for table `i_aliases`
--
ALTER TABLE `i_aliases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `source` (`source`) USING BTREE;

--
-- Indexes for table `i_bcc_user`
--
ALTER TABLE `i_bcc_user`
  ADD KEY `source` (`source`) USING BTREE;

--
-- Indexes for table `i_domains`
--
ALTER TABLE `i_domains`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`) USING BTREE,
  ADD KEY `active` (`active`);

--
-- Indexes for table `i_mail_config`
--
ALTER TABLE `i_mail_config`
  ADD UNIQUE KEY `key` (`name`) USING BTREE;

--
-- Indexes for table `i_quota`
--
ALTER TABLE `i_quota`
  ADD PRIMARY KEY (`email`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `i_system_config`
--
ALTER TABLE `i_system_config`
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `i_users`
--
ALTER TABLE `i_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`) USING BTREE,
  ADD KEY `domain_id` (`domain_id`) USING BTREE,
  ADD KEY `active` (`active`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `i_admin`
--
ALTER TABLE `i_admin`
  MODIFY `aid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `i_admin_group`
--
ALTER TABLE `i_admin_group`
  MODIFY `gid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `i_admin_log`
--
ALTER TABLE `i_admin_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=209;
--
-- AUTO_INCREMENT for table `i_aliases`
--
ALTER TABLE `i_aliases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `i_domains`
--
ALTER TABLE `i_domains`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `i_users`
--
ALTER TABLE `i_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
