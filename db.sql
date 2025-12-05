/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 5.5.20-log : Database - geoencryption
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`geoencryption` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `geoencryption`;

/*Table structure for table `allocate` */

DROP TABLE IF EXISTS `allocate`;

CREATE TABLE `allocate` (
  `allotid` int(11) NOT NULL AUTO_INCREMENT,
  `examid` int(50) NOT NULL,
  `staffid` int(50) NOT NULL,
  `clgid` int(11) DEFAULT NULL,
  PRIMARY KEY (`allotid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `allocate` */

insert  into `allocate`(`allotid`,`examid`,`staffid`,`clgid`) values 
(1,2,18,2),
(2,1,1,2),
(3,1,9,2),
(4,5,13,5);

/*Table structure for table `allot_subject` */

DROP TABLE IF EXISTS `allot_subject`;

CREATE TABLE `allot_subject` (
  `alid` int(11) NOT NULL AUTO_INCREMENT,
  `subjid` int(11) DEFAULT NULL,
  `staffid` int(11) DEFAULT NULL,
  PRIMARY KEY (`alid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `allot_subject` */

insert  into `allot_subject`(`alid`,`subjid`,`staffid`) values 
(1,1,18),
(2,2,18),
(3,2,5),
(4,1,1),
(5,20,9),
(6,2,13);

/*Table structure for table `answer` */

DROP TABLE IF EXISTS `answer`;

CREATE TABLE `answer` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `qid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `answer` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `answer` */

/*Table structure for table `certificate` */

DROP TABLE IF EXISTS `certificate`;

CREATE TABLE `certificate` (
  `cid` int(10) NOT NULL,
  `sid` int(10) DEFAULT NULL,
  `pubkey` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `score` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `certificate` */

insert  into `certificate`(`cid`,`sid`,`pubkey`,`date`,`score`) values 
(1,11,'34','2022-03-09','50');

/*Table structure for table `chat` */

DROP TABLE IF EXISTS `chat`;

CREATE TABLE `chat` (
  `chatid` int(11) NOT NULL AUTO_INCREMENT,
  `fromid` int(11) DEFAULT NULL,
  `toid` int(11) DEFAULT NULL,
  `msg` varchar(30) DEFAULT NULL,
  `date` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`chatid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `chat` */

insert  into `chat`(`chatid`,`fromid`,`toid`,`msg`,`date`) values 
(1,40,10,'hii','2023-01-10'),
(2,40,10,'hi','2023-01-10'),
(3,10,40,'jo','2023-01-10'),
(4,40,10,'u have an exam tomorrow ','2023-01-10'),
(5,55,40,'hi','2023-01-10'),
(8,40,55,'oi','2023-01-10'),
(9,5,19,'hello','2023-01-10'),
(10,40,11,'ok','2023-01-10'),
(11,67,10,'hi','2023-02-12'),
(12,67,55,'hello ','2023-02-12'),
(13,55,67,'heloo','2023-02-12'),
(14,67,10,'hlo','2023-02-15');

/*Table structure for table `cipher` */

DROP TABLE IF EXISTS `cipher`;

CREATE TABLE `cipher` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `studentid` varchar(20) DEFAULT NULL,
  `encry_msg` text,
  `private_key` text,
  `public_key` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `cipher` */

insert  into `cipher`(`id`,`studentid`,`encry_msg`,`private_key`,`public_key`) values 
(1,'24','jRwOrazmIKLFJT10sU6BjeffyyiUgkQ0Ss0L5kQ4UdNzR6gYD4wGYNyBycwn1vBnGkF1QCWK0+kdqCKf8Y/sFUUBGHJZ4z5P+lbWrai97d14VvWlLEmdVtbxvTOIMNsVHsNGDJlp+4xadqo2p2XsmqYtKi981B1vsuXYmicNnS0=','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYdz0AK/60G52+sskITorZ3sMj\n+hOGdWwlpeFZSx4q53D3L9JJ6TGVlwd4mprGAyiJIZEHwGYIiPRS0Ft1RXSesSkp\nHwhmWwzWjPXTR8oDeLWifE5q8u80o69C3Dz+rowHxGAPdVZ4SlP1kUdhoAgxIbej\nBTuGTHmduAm19kRVXwIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQDYdz0AK/60G52+sskITorZ3sMj+hOGdWwlpeFZSx4q53D3L9JJ\n6TGVlwd4mprGAyiJIZEHwGYIiPRS0Ft1RXSesSkpHwhmWwzWjPXTR8oDeLWifE5q\n8u80o69C3Dz+rowHxGAPdVZ4SlP1kUdhoAgxIbejBTuGTHmduAm19kRVXwIDAQAB\nAoGBAJPt8LcUWczV7phq7+2IV2WK0YrdlMhXqJ+V3Am8xxIE9nNGsAwom+UhwE5Q\nQaM+d043rThB6Li+d1G86DOdUpL6CMhXLsW4sDLRJq2PH76wrKlAbCZavM7ZWRpT\nn5tQ1LLsfQTAt4oDi4iMnpswMA7phdFAwAWIriCmWdq5ilWRAkEA3HrXjQEBUJtW\nP+qbcpAKtN9wppdz7UStrH7PsjwgklJlnzA9cEXT3OuBTqCvIfp1AYuFhGFgUugS\nJbBK04uMpwJBAPtW2GvSp3r02z1YUnbyKF1u/O102ZGKQeG80unWKgVuC1Wv2bcH\nfhtxqAGEX8RHQPvX5F/74GKMrF9sTbUrcIkCQDSJ7U2DfM25hm8Kt+ov2u1JBW4d\nTxmuMPiW62VcoKJdkivB8hIMAbV2RUT4U2N0bGdm2PU3wx1egdyLSvloGqcCQQDP\nlbrJ0wJgmzs4P2pcs0SDZtefh5LqkbY4KyxH1Yp/UZQrAUJf2OBe6lBIcHxoMDGL\nz5PfcriwrF7xsRG9QFOBAkBjLXqWiWdfxUglRxs7pizFXfqOT6lfP5aP1eK1J860\nrIVuIAmrqJBrU7lzKCbc6RAIvV8QZIyVFpraslIqUTfK\n-----END RSA PRIVATE KEY-----'),
(2,'10','WMEz7yEqlicnFX6TMhK902/e1QNI4kJ/dUFpEpDxBvs1A6+K+uelLmH2F4Q62OKSUu34AAtHMNKBEB4Nr/p7ajZKhYtnLncqKq6ETo1ihMAkYmih08HxU8iguDrgF3Qz+leTLRFPJP2XJLtwvbatL3bFTzUd3B6Ub3XpZY0CSnY=','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDK555iNLYr0a6BXzhg7TI67s5E\nPt0j3vLWgnD3Nm0x5pGFvXaMQXgPnM07sCbZfHd1OZqQesjZekjgZocbGn7J/Xgj\nwgxj7mfIy7eP3d6YENxCrlF6o64jPomZlR/1CSR8QffVB5/wvJtrlfxNpC/orpLr\nPzoFq5oFjtsZncdPowIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQDK555iNLYr0a6BXzhg7TI67s5EPt0j3vLWgnD3Nm0x5pGFvXaM\nQXgPnM07sCbZfHd1OZqQesjZekjgZocbGn7J/Xgjwgxj7mfIy7eP3d6YENxCrlF6\no64jPomZlR/1CSR8QffVB5/wvJtrlfxNpC/orpLrPzoFq5oFjtsZncdPowIDAQAB\nAoGAKn/PJeTCj3UQ5xopteuYzM0+OP8t1JibJqEVxkIJJx2TN38SuJfx7Ns8BZeE\n26L9ZnlVTZPaQ+sgHph7DgtDqO1cjHEQvFaFR05NilniYD6unQX2FcnxSQXkMD64\nq0czGiXNtWYO5EYQvPDKmkAMnIpM45MB+lQv5orc4VRcifECQQDPMQ+lWVMCJ9re\nMvrtkzIVj3Jv8ipDPaQdvQiQQphbXzLaDhOZHImhkhQ/wGQ71Nr0xdfWX14bO3jH\nP/MqfRurAkEA+rQIKkEXnPp2tcvigxuF47+f4AXp3E6mC8vDE1tbc0w6Jwjb5kYw\ndrdznjqpVbo/aMyAAcAEV22ywRbsKqJj6QJAJ4CUGhNYty2AFiMkIk2RG/k4eU1z\nb1R+SMk0q8R2pd0VpetPIz8EopBmWe1Fbv7bLBXYW9/c4lZJZbu0keI+dwJBAL9t\n3JY3IcqxzRc/2XP2/iNLXM54dXvNaiizq/8J0SiW2giYUSDiE3ty1QvLCyX0kxp4\nnH25mxcPImEiGa7sVJECQQDB5CrGJtagewSmN+D1nyvYgE2FFBZDhOisE9QBg6kc\nMwOkUb1wGFx/l/W7TwVl+XnO6FEfIADd1aRaPfWfP2D2\n-----END RSA PRIVATE KEY-----'),
(3,'10','nEp2w7tvp4k3yGuEw3I7mxoLYWiJCttvqNM1pFSJ5qnwjzVHkOZpQBXJq1gjpj3JyTjb5BAk4EE2u+G4xZFimNdS0Xotg66XrRF9jrVQCYxqD5Du/0MNSTKKGRLyUpsboJtHP/acM/RVPMN0p4TsOFmKvUIYKIL3XqfILjonMto=','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPFf6+QJnJqP+NJDA7brl5kiKQ\nq1HmbBJP/KxcSBxzfxvmDSiMjHae6H8rCgWvYaoStluHBUqOe+C0rrtxvnIoBCef\nkvQ+yaaumwF1Yrn4OYffVRw4B5yQIWnrKA5NWp+BmSiAJM3LkiTthzPW4JzSwWxH\nanHKqqo2/1hlthDvtQIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQDPFf6+QJnJqP+NJDA7brl5kiKQq1HmbBJP/KxcSBxzfxvmDSiM\njHae6H8rCgWvYaoStluHBUqOe+C0rrtxvnIoBCefkvQ+yaaumwF1Yrn4OYffVRw4\nB5yQIWnrKA5NWp+BmSiAJM3LkiTthzPW4JzSwWxHanHKqqo2/1hlthDvtQIDAQAB\nAoGBAIqGHQyo6/agjKmePoFTFNDEt0hswXFQc4N78tQcDKQZr9DYlnpF74dm4MIq\nhxkFTJ4Ny/XqzS+4n9xdUdfJXFRBRxQC05V6v94c1G/zIDsow7qaPQLfmwSXAA/v\nNhx3u28ImgBNuZDRiffxFMMglCV6v3dRdgd9WAZ3P0NMSRThAkEA1J/5PtDPmska\n4Pl0RBPwtPNd5wqrwe1zDsfIOSBn9rKfkUr9ffJiwbpYJr5KOJD7+9vRnW3Mo3vw\nH/4w/PkOnQJBAPlUwaENsR8OTBa/mGJVbiRkRkyCyy2VuNk3EBfkuVfxcerBQlko\nI0+qzdbPoQ1O6uI+HcUi0c8NyWWABQo2zfkCQHZhOtwGVg/Pt+9Z86mTkIiulrFz\n93zZPx4TjR6BNGDdwomaPthIg0NpBHtNpvUng6QOFv6Xiz/aWS72zz+JSuECQF6B\ngtdSAkX8PFkPDGqRaStAGulbVjoUGzmyRlZYKuyrpvtNf6Gdtiy3WEhI8QnDVQKm\netBDT3WFC0Z+zOo/NbkCQQCB/Sx6jLTQfuDlABqNjLpXOhuISGFjL90nsdO7s1EC\nnz4UJBjOjpreLfqx/bmQO6C3J0y+I4g192BpBIyvLEMs\n-----END RSA PRIVATE KEY-----'),
(4,'68','hIRqALvc/UWIU7c5VlK3Ix5cV7yLOQ1Od0XvegbPlFL9+O49fSdMmdOU4J5Yu/B7K7vbhCj79YftTLGvIPzCN+E3mLJiqUT9KaDbY+Kbj9umoi95qVkAjwxwOusM+4o3XQso/DcGPEmJbRF+QxWKM1NJVYkyMWbWkfISMukAT/M=','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCuamkPumw7MlsDRpHLm2vcgySY\ntO/Vxttx5Lp0ZkJ/kH1zd/vYfVIbIQ076q42kS0HPjBlbSmKFBrKex2nSjey5NHw\n4nIb9fJOssWudQCqcs8rgNvUoq2uGcBLubG3rQl5YCTbtJuSuSijy47n4Pj1Pim1\n7PBVQOYs7loSdY+mlQIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQCuamkPumw7MlsDRpHLm2vcgySYtO/Vxttx5Lp0ZkJ/kH1zd/vY\nfVIbIQ076q42kS0HPjBlbSmKFBrKex2nSjey5NHw4nIb9fJOssWudQCqcs8rgNvU\noq2uGcBLubG3rQl5YCTbtJuSuSijy47n4Pj1Pim17PBVQOYs7loSdY+mlQIDAQAB\nAoGABPagQMNUWybmsiQq9/lXS3Ir83CKtrGvAwG4UKGsWMb62vNaJmICmSUKpF7c\nUE83UdJyPCCsIvLJhGOWh3E0PoXsOmdA2rKJUID3aBy28Fq4V45TgoXkRWrBOPxP\nQby4FgqvlTUjvY7uzWc5HQ7uRieUjP9/0B8OcaAo2XbOyeECQQC8284o2G/GxyXu\neu0MT019mpaFkUNZtY28Udx0xouzEYbb67ijVnzJOcmNF6JwJjPWIkMaK2GMkNuQ\nlOR896lpAkEA7GwjnqkwuqDtbfbgI8dQ7N+2y2Bp1bHN3WmHWtkL3BGmF0k2L3mz\nJqcEPmUdFB+cxshdRAoMbhzyBXF/1AviTQJBAJ24w/eAqfjMIHWF26pIIGMhU0vB\nAQpOgUwg4Yf0uH6XyJSpy809UYGL7TMT5ejbPrc6befRCuqln3ijoB5thuECQAj4\nxZVEyGOcrcXpg3H4I1sJ1k77dqi0WaKYWZmZ+Pg99zaVAahljuXdmqyfe64C0Rk+\nC0QEuZoIISsRto8ecFUCQQCRRyvVwVSt7h0BzapJ8Ce2wcmLYGk0zuCp+hZo5K1c\ntNdlgJxGSeU13hp+4M53hlsJAQWENLZVjKltoWga8YeQ\n-----END RSA PRIVATE KEY-----'),
(5,'68','VIfIexMdgCBcxl81AbJ6n2ib7BW8BzvJzPcFj/FSoBuKsuGo2BWKGvup4oHPjcsCsWoYbMqAeaUPyqHMG5LqweKX4yjXenJg9R6T7xjtsjHdCuzmgBrzATGG4F454dog9g5BPmO+8MAI6rBy0mBYsEs1o4+pXFCkn7XY4otT2dA=','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC8VY7TWgbQQCoIjMw4/ruyjcVl\nJus7tuwNPcrb6OHUYh3hpDCoD4F4K5LaRDolYWH+fapeQZcASWO0UNuSJu0l1Nd9\nEeSBiciBPhuBaI6tNKZWB3EByDBvsQNl3Y19G++bIRV3r7ncEuaUGGuZlZ4n2IsQ\nOXPcI/jR2ZAO22F8PwIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQC8VY7TWgbQQCoIjMw4/ruyjcVlJus7tuwNPcrb6OHUYh3hpDCo\nD4F4K5LaRDolYWH+fapeQZcASWO0UNuSJu0l1Nd9EeSBiciBPhuBaI6tNKZWB3EB\nyDBvsQNl3Y19G++bIRV3r7ncEuaUGGuZlZ4n2IsQOXPcI/jR2ZAO22F8PwIDAQAB\nAoGAajt8h90lMLywuQfqfk+5wjrT2H2+fH1u4v0y+x5+m9UIc+mwhGvSpN03RaTs\ng39NzkZGHkqzCTdcZS6i2+rXIuFMxDXvUa915voOdpHuuaL/PDPp/b7Xrn3X9ReD\nir3s51q74TmqMN+0td4HnUkIOA3Q2ciD3ZFtmaRinAApxPECQQDCroo391nMK7Jy\n3WCpHmTCtssHSyl/BlxzmOoTvBe8nCdy4Y1ZyLOjzuaYPveIZuZ/+T0ZnN64Op6f\nSRk0DxhZAkEA96c0FLBnbOV/Wz87SfkcrGe6A5aYPmEHyDu5ytoyLceFfoyyBF5S\nSHQN9k5kAxvPfYB3XUSQrI+Jz+0/zVsmVwJAXJYlpfg8/JzLgVVHYybRRMkqRY25\nbm/YCCHxMPGDWG/rUvdyAgExbfY4NK+9iWFmvfYK2OOCCJvYVGivU9LaAQJBAKIE\nbksWuSMB5VbRwDz9z2dvGL+eNw2gNxIlGMCADRHsFQacjx3SgyxJWJUJ5d4uxIjL\nkcufvrJV2YgBI5t6hVMCQCcaSf7YuC97AhbJLvqX3O42amV99h6WBfEThSecXwI6\ndRrnIJ72uz9OrbjKZkHNUSp4VsFZC/rzvf68G50RVRM=\n-----END RSA PRIVATE KEY-----'),
(6,'68','Ukgoyi1JCgMGO6djtMEPyn1w8VzaTJ3mwn7tL7jiKgU1YoxONEVAR0DZUiycw35xM8fKFSlU6uSP2GzProifhLqT7JJMmbDQgb0APpP6T+Tars+hnnS/krTXuqsD3WfeyumcAWa3FfLix/ZMuK0etXFAZiKkppyrkpZo2Epx7Rk=','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrO9BkcuX5tWWfKfE3csxcI/xk\nIZaCW4V9v8gsE1rDdqvfgJ3SahNXaVjq0McUF29jjFg3pSHqZQA8zzqgfS9G4d8n\nVuiXbT1RR+Plua40jt3LP6safgRij6Bsf4dnCniJKS8bdUXG7E4jHL4gJsJ9hqVB\nxsuEKgjW6vniQlR8dQIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQCrO9BkcuX5tWWfKfE3csxcI/xkIZaCW4V9v8gsE1rDdqvfgJ3S\nahNXaVjq0McUF29jjFg3pSHqZQA8zzqgfS9G4d8nVuiXbT1RR+Plua40jt3LP6sa\nfgRij6Bsf4dnCniJKS8bdUXG7E4jHL4gJsJ9hqVBxsuEKgjW6vniQlR8dQIDAQAB\nAoGBAJI/Zf9E+xLJUWAdjH4VOGHCAoDrBweTb3I1aJvsc+rZ4nXj/eeG3bocqer0\nIfQRB/v4FCiCi3MMjKVjQOltwf/ca8DQFkyi+KLjVJUqsvbNMqsrEE3D53xFZ9dU\nDAtW485C+GochnOyVElXjZWpEPKZYb5de8i49tCrm5/wDuyBAkEAyc32RpRx9Tyu\n7IT9rI1KvrQUrx06jTkmxs8WFtUMDTCmWDJQa5Nn27BcOTkuqkZA/wbEjp1yBVvB\nKSG6jKNgMQJBANk4G2BxbpzCRRfbvm0UwlVf6HadjJKscY5isNjOdUh0ozQvShGN\nMk33TRYuTjd1XlYA7nIipSue8fsfRqM184UCQCO1w4e3yvaXd2i5G96F3h0i5qoa\nJPtKircRfBosNwa6fiULOjnfCrjQW3Fw0fYlmmjGfM+zwrJ6CxNJOaabXnECQBC/\nd7Tm6g1iGSuuwK7uY9FrVKQYn6cLbrH4wAPnXzmX7KFwZ/iUd2V1hNcJ+PPjs8NT\nzQ61xyBm3+dp0OtylHUCQQDGaYQ1VUB2SIVfGQN5Gn9/8FQNT0wIdnGEOsGVgCl7\nkjIQoG8pKcxyzC+Muoh3MOvG6CcxmnIstRo56B1VuGim\n-----END RSA PRIVATE KEY-----');

/*Table structure for table `college` */

DROP TABLE IF EXISTS `college`;

CREATE TABLE `college` (
  `college_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) NOT NULL,
  `college_name` varchar(50) NOT NULL,
  `place` varchar(50) DEFAULT NULL,
  `address` varchar(50) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `lati` double DEFAULT NULL,
  `longi` double DEFAULT NULL,
  PRIMARY KEY (`college_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `college` */

insert  into `college`(`college_id`,`login_id`,`college_name`,`place`,`address`,`phone`,`lati`,`longi`) values 
(1,2,'Indian Institute of Management (IIM), Kozhikode ','Calicut','Mavoor road,Kerala',8765432107,11.257296,75.783821),
(2,3,'Sacred Heart College, Ernakulam','Ernakulam','Pallipadi,Kerala',9533937654,12.4,34.5),
(3,40,'St. Thomas College, Thrissur ','Keerankulangara','Palghat Rd,Thrissur,Kerala',7654344457,87.99,87.56),
(4,5,'St. Teresa’s College (STC), Ernakulam ','Kochi','Park Ave,Marine Drive,Kerala',9898765445,23.98,76.98),
(5,6,'Farook College','Kozhikode','jifjrirgjreig',9364728336,23.32,23.32),
(6,57,'casihrd ','vattamkulam ','nellishery vattamkulam ',7542862659,1,1),
(7,66,'Casihrd','vattamkulam ','nellishery vattamkulam ',8766494525,1,1),
(8,67,'Casihrd','vattamkulam ','nellishery vattamkulam ',8766494525,1,1);

/*Table structure for table `company` */

DROP TABLE IF EXISTS `company`;

CREATE TABLE `company` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `lid` int(11) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `place` varchar(30) DEFAULT NULL,
  `post` varchar(30) DEFAULT NULL,
  `pin` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `company` */

insert  into `company`(`cid`,`lid`,`name`,`email`,`phone`,`place`,`post`,`pin`) values 
(1,54,'geo','hhh',678,'ghj','fghj','fghj');

/*Table structure for table `complaints` */

DROP TABLE IF EXISTS `complaints`;

CREATE TABLE `complaints` (
  `comp_id` int(11) NOT NULL AUTO_INCREMENT,
  `complaint` varchar(30) NOT NULL,
  `date` varchar(50) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`comp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `complaints` */

insert  into `complaints`(`comp_id`,`complaint`,`date`,`uid`) values 
(2,'Didnt get the study material','2022-03-03',18),
(3,'qppr not visible\n\n','2022-03-03',18),
(4,'Delaying of Degree Certificate','2022-03-03',18),
(5,'bad','2023-01-05',40),
(6,'bd','2023-01-10',40),
(7,'hhg','2023-01-10',40),
(8,'bad','2023-01-10',5),
(9,'bad','2023-01-10',5),
(10,'hh','2023-01-10',5),
(11,'bad','2023-02-12',67),
(12,'bad','2023-02-15',67),
(13,'good','2023-02-15',67);

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `courseid` int(11) NOT NULL AUTO_INCREMENT,
  `coursename` varchar(50) NOT NULL,
  `departmentid` int(11) NOT NULL,
  PRIMARY KEY (`courseid`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

/*Data for the table `course` */

insert  into `course`(`courseid`,`coursename`,`departmentid`) values 
(1,'Bsc Physics',1),
(4,'Bachelor of Business Administration and Bachelor o',0),
(5,'BTech Electrical',4),
(6,'BArch Bachelor of Architecture',4),
(7,'Bachelor of Education',2),
(8,'Bachelor of Physical Education',2),
(9,'BCOM',5),
(10,'BBA',5),
(11,'BA Violin',6),
(12,'Bachelor of Fine Arts(BFA)',6),
(13,'BA English',17),
(14,'BA Malayalam',17),
(15,'BA Visual Communication',7),
(16,'BA Film and Television',7),
(17,'BA Sociology',9),
(18,'BA History',9),
(19,'BSC Computer Science',10),
(20,'BSc Physics',10),
(21,'BCOM',14),
(22,'BBA',14),
(23,'BA English',8),
(24,'BA Sanskrit',8),
(25,'BTech Information Technology',13),
(26,'BTech Mechanical Engineering',13),
(27,'BSc Chemistry',11),
(28,'BSc Botany',11),
(29,'Bachelor of Laws(LLB)',12),
(30,'Bachelor of Commerce and Bachelor of Laws(B.Com LL',0),
(31,'BA Music',15),
(32,'Bachelor of Theatre Arts(BTA)',15),
(35,'BA Multimedia',0),
(37,'computer science',0),
(38,'ggsgyefiyyf',0),
(39,'juyut',0),
(41,'bhfyutf',0),
(42,'hsgeurf8qwa',0),
(43,'jaHDSUAGD',0),
(44,'qwertyuio',0);

/*Table structure for table `dept` */

DROP TABLE IF EXISTS `dept`;

CREATE TABLE `dept` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(50) NOT NULL,
  `college_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `dept` */

insert  into `dept`(`department_id`,`department_name`,`college_id`) values 
(1,'SCIENCE',67),
(2,'EDUCATION',2),
(3,'LAW',1),
(4,'ENGINEERING',67),
(5,'COMMERCE AND MANAGEMENT STUDIES',2),
(6,'FINE ARTS',2),
(7,'JOURNALISM',3),
(8,'LANGUAGE AND LITERATURE',4),
(9,'HUMANITIES',3),
(10,'SCIENCE',3),
(11,'SCIENCE',4),
(12,'LAW',5),
(13,'ENGINEERING',4),
(14,'COMMERCE AND MANAGEMENT STUDIES',3),
(15,'FINE ARTS',5),
(16,'JOURNALISM',5),
(17,'LANGUAGE AND LITERATURE',2),
(19,'HUMANITIES',5),
(20,'',0),
(21,'',1),
(22,'',1),
(23,'',1),
(24,'',3),
(25,'qwertyu',2),
(26,'ddd',1),
(27,'',1),
(28,'',1),
(29,'',1);

/*Table structure for table `examschedule` */

DROP TABLE IF EXISTS `examschedule`;

CREATE TABLE `examschedule` (
  `examscheduleid` int(11) NOT NULL AUTO_INCREMENT,
  `examdate` varchar(50) NOT NULL,
  `examtime` varchar(50) NOT NULL,
  `subjectid` int(11) NOT NULL,
  PRIMARY KEY (`examscheduleid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `examschedule` */

insert  into `examschedule`(`examscheduleid`,`examdate`,`examtime`,`subjectid`) values 
(1,'2023-01-24','12:22',3),
(3,'2013-12-31','00:00',1),
(4,'2023-02-09','12 pm to 4 pm',2);

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `lid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `user_type` varchar(50) NOT NULL,
  PRIMARY KEY (`lid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`lid`,`username`,`password`,`user_type`) values 
(1,'admin','admin','admin'),
(5,'stteras','1234','college'),
(7,'student','555','student'),
(10,'public','234','public'),
(39,'ishaan','ishaan1234Q','staff'),
(40,'deepa','Deepa123','college'),
(41,'sedr','<function <lambda> at 0x0000022B962C9488>','student'),
(42,'fyjb','tfbj','student'),
(47,'fyjbooi','tfbj','student'),
(49,'fyjbooiggj','tfbj','student'),
(51,'fyjbooiggjnmm','tfbj','student'),
(53,'ass','tfbj','student'),
(54,'com','123','company'),
(55,'ais','123','student'),
(56,'devu','1234','student'),
(67,'ihrdcas','12345','college'),
(68,'ram','123','student');

/*Table structure for table `notes` */

DROP TABLE IF EXISTS `notes`;

CREATE TABLE `notes` (
  `noteid` int(15) NOT NULL AUTO_INCREMENT,
  `subjid` int(15) DEFAULT NULL,
  `note` varchar(567) DEFAULT NULL,
  PRIMARY KEY (`noteid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

/*Data for the table `notes` */

insert  into `notes`(`noteid`,`subjid`,`note`) values 
(1,21,'10160369434601001.pdf'),
(2,1,'storage_emulated_0_DCIM_Screenshots_Screenshot_20220309-103144.png'),
(3,2,'storage_emulated_0_DCIM_Screenshots_Screenshot_20220309-103144.png'),
(4,1,'storage_emulated_0_Download_84c8a5c1-d6c8-42fb-92d9-23297bf9436e-_1.pdf'),
(5,1,'storage_emulated_0_Download_84c8a5c1-d6c8-42fb-92d9-23297bf9436e-_1.pdf'),
(6,1,'storage_emulated_0_Download_84c8a5c1-d6c8-42fb-92d9-23297bf9436e-_1.pdf'),
(7,0,'storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230109-WA0018.jpg'),
(9,23,'storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230110-WA0008.jpg'),
(10,0,'storage_emulated_0_Pictures_Screenshots_Screenshot_20230212_130144.jpg'),
(11,0,'storage_emulated_0_Pictures_Screenshots_Screenshot_20230212_130144.jpg'),
(12,0,'storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230211-WA0031.jpg'),
(13,0,'storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230206-WA0006.jpe'),
(14,2,'storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230211-WA0025.jpg'),
(15,22,'storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230209-WA0011.jpg'),
(16,2,'storage_emulated_0_Pictures_Screenshots_Screenshot_20230212_130144.jpg'),
(17,23,'storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230211-WA0031.jpg'),
(18,1,'storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230214-WA0031.jpg'),
(19,24,'storage_3465-3262_DCIM_Camera_20230124_104159.jpg'),
(20,24,'storage_3465-3262_DCIM_Camera_20230124_104159.jpg'),
(21,24,'storage_emulated_0_Download_student.png'),
(22,24,'storage_3465-3262_DCIM_Camera_20230104_144138.jpg'),
(23,24,'storage_3465-3262_DCIM_Camera_20230124_104159.jpg'),
(24,22,'storage_3465-3262_DCIM_Camera_20230212_194541.jpg');

/*Table structure for table `qppr` */

DROP TABLE IF EXISTS `qppr`;

CREATE TABLE `qppr` (
  `questionppr_id` int(11) NOT NULL AUTO_INCREMENT,
  `questionppr_name` varchar(50) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `college_id` int(11) DEFAULT NULL,
  `armstrongno` int(11) DEFAULT NULL,
  PRIMARY KEY (`questionppr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `qppr` */

insert  into `qppr`(`questionppr_id`,`questionppr_name`,`exam_id`,`college_id`,`armstrongno`) values 
(1,'1_DIP.docx',2,2,153),
(2,'2_DIP.docx',2,3,153),
(3,'3_DIP.docx',2,4,371),
(4,'5_DIP.docx',2,10,371),
(5,'6_DIP.docx',2,20,371),
(6,'7_DIP.docx',2,40,153),
(7,'2_asd.odt',3,2,153),
(8,'3_asd.odt',3,3,370),
(9,'40_asd.odt',3,40,153),
(10,'5_asd.odt',3,5,153),
(11,'6_asd.odt',3,6,370),
(12,'57_asd.odt',3,57,370),
(13,'66_asd.odt',3,66,153),
(14,'67_asd.odt',3,67,407);

/*Table structure for table `question` */

DROP TABLE IF EXISTS `question`;

CREATE TABLE `question` (
  `qid` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL,
  `question` varchar(30) DEFAULT NULL,
  `option1` varchar(30) DEFAULT NULL,
  `option2` varchar(30) DEFAULT NULL,
  `option3` varchar(30) DEFAULT NULL,
  `option4` varchar(30) DEFAULT NULL,
  `answer` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`qid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `question` */

insert  into `question`(`qid`,`tid`,`question`,`option1`,`option2`,`option3`,`option4`,`answer`) values 
(2,1,'what is this','yu','pen','a book','ji','ji'),
(4,1,'what is jdjdjdskj','jjkjkj','jjkj','jj','jjjj','jj'),
(5,1,'sdfg','nkn','tyui','jk','jkjkhh','jkjk'),
(6,1,'what is THIS','this','thjj','sdf','asd','this'),
(8,3,'tyryui','qwtdrt','ergydtrs','tytydrs','uiftd','sdyuds');

/*Table structure for table `reply` */

DROP TABLE IF EXISTS `reply`;

CREATE TABLE `reply` (
  `repid` int(11) NOT NULL AUTO_INCREMENT,
  `compid` int(11) DEFAULT NULL,
  `reply` varchar(30) NOT NULL,
  PRIMARY KEY (`repid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `reply` */

insert  into `reply`(`repid`,`compid`,`reply`) values 
(1,2,'will connect\r\n'),
(2,3,'will send soon'),
(3,5,'ghbkjkjhjk'),
(4,6,'ok\r\n'),
(5,7,'okda\r\n'),
(6,8,'okda\r\n'),
(7,5,'ok'),
(8,5,'ok'),
(9,10,'good'),
(10,5,'yurtfttyuug'),
(11,5,'ok\r\n'),
(12,5,'ok\r\n'),
(13,5,'ok\r\n'),
(14,7,'okey'),
(15,11,'kkkk'),
(16,12,'okey');

/*Table structure for table `request` */

DROP TABLE IF EXISTS `request`;

CREATE TABLE `request` (
  `reid` int(11) NOT NULL AUTO_INCREMENT,
  `jid` int(11) DEFAULT NULL,
  `lid` int(11) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`reid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `request` */

insert  into `request`(`reid`,`jid`,`lid`,`status`) values 
(1,1,55,'Accepted'),
(2,1,55,'Accepted'),
(3,1,55,'Rejected'),
(4,9,55,'pending');

/*Table structure for table `result` */

DROP TABLE IF EXISTS `result`;

CREATE TABLE `result` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL,
  `lid` int(11) DEFAULT NULL,
  `result` varchar(30) DEFAULT NULL,
  `date` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `result` */

insert  into `result`(`rid`,`tid`,`lid`,`result`,`date`) values 
(1,1,55,'30','23/09/12'),
(2,1,55,'4','2023-02-12'),
(3,1,55,'4','2023-02-15');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `studentid` int(10) NOT NULL AUTO_INCREMENT,
  `fname` varchar(20) DEFAULT NULL,
  `lname` varchar(20) DEFAULT NULL,
  `regno` varchar(10) DEFAULT NULL,
  `graduation` varchar(20) DEFAULT NULL,
  `deptid` varchar(20) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `month&year` varchar(15) DEFAULT NULL,
  `photo` varchar(699) DEFAULT NULL,
  PRIMARY KEY (`studentid`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;

/*Data for the table `student` */

insert  into `student`(`studentid`,`fname`,`lname`,`regno`,`graduation`,`deptid`,`gender`,`month&year`,`photo`) values 
(10,'nithya','kishor','432','bscphysics','1','female','mar 2019','123.png'),
(11,'rahul','kp','123','bca','1','male','nov 2020','storage_emulated_0_Pictures_1646903657693.jpg'),
(12,'huj','ghb','hhb','firstclass','1','January','2022','storage_emulated_0_Download_84c8a5c1-d6c8-42fb-92d9-23297bf9436e-_1.pdf'),
(19,'hari','shree','654','firstclass','19','January','2022','storage_emulated_0_Pictures_1646903657693.jpg'),
(20,'krish','na','737','firstclass','','January','2022','storage_emulated_0_DCIM_Screenshots_Screenshot_20220309-104510.png'),
(24,'shaf','nas','75','BSC chemistry','1','January','2022','storage_emulated_0_DCIM_Camera_20220310_151951.jpg'),
(53,'hfc','gfvb','hffb','BSC chemistry','1','Male','January-2022','storage_emulated_0_DCIM_Camera_20220413_161347.jpg'),
(55,'aiswarya','asw','123','Bsc Physics','1','Female','July-2016','storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230106-WA0077.jpeg'),
(56,'devika ','tp','1234','BA Music','15','Female','July-2017','storage_emulated_0_Android_media_com.whatsapp_WhatsApp_Media_WhatsApp_Images_IMG-20230106-WA0077.jpeg'),
(68,'ram','k','1234','Bsc Physics','1','Male','January-2022','storage_3465-3262_DCIM_Camera_20230212_194541.jpg');

/*Table structure for table `subject` */

DROP TABLE IF EXISTS `subject`;

CREATE TABLE `subject` (
  `subjectid` int(11) NOT NULL AUTO_INCREMENT,
  `subjectname` varchar(50) NOT NULL,
  `courseid` int(11) NOT NULL,
  PRIMARY KEY (`subjectid`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `subject` */

insert  into `subject`(`subjectid`,`subjectname`,`courseid`) values 
(1,'science',1),
(2,'maths',1),
(22,'physics',3),
(23,'rrrr',33),
(24,'trade',10),
(26,'jugy',1),
(28,'sdfghj',1);

/*Table structure for table `test` */

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) DEFAULT NULL,
  `details` varchar(40) DEFAULT NULL,
  `vid` int(11) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `test` */

insert  into `test`(`tid`,`type`,`details`,`vid`) values 
(1,'mcq','fghj',1),
(3,'c++','good one',1),
(5,'vbb','bbb',1),
(6,'EWF','SWEAF',1),
(7,'GFY','EWRETF',1);

/*Table structure for table `vaccancy` */

DROP TABLE IF EXISTS `vaccancy`;

CREATE TABLE `vaccancy` (
  `vid` int(11) NOT NULL AUTO_INCREMENT,
  `post` varchar(30) DEFAULT NULL,
  `qualification` varchar(30) DEFAULT NULL,
  `experience` varchar(40) DEFAULT NULL,
  `salary` varchar(45) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `vaccancy` */

insert  into `vaccancy`(`vid`,`post`,`qualification`,`experience`,`salary`,`cid`) values 
(1,'stfff','b tech','8','6567',54),
(6,'sales','hg','6','78989',54),
(9,'hbhjb','njknjk','4','1234567 to 678',54);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
