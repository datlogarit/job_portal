import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/home.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class SuggestionSetting extends StatefulWidget {
  const SuggestionSetting({super.key});

  @override
  State<SuggestionSetting> createState() => _SuggestionSettingState();
}

class _SuggestionSettingState extends State<SuggestionSetting> {
  final List<DropdownItem<String>> gender = [
    DropdownItem(label: 'Male', value: 'Male'),
    DropdownItem(label: 'Female', value: 'Female'),
  ];
  final List<DropdownItem<String>> skills = [
    DropdownItem(label: '3D Artist', value: '3D Artist'),
    DropdownItem(label: '3D Max', value: '3D Max'),
    DropdownItem(label: '.NET', value: '.NET'),
    DropdownItem(label: 'ActionScript', value: 'ActionScript'),
    DropdownItem(label: 'Agavi', value: 'Agavi'),
    DropdownItem(label: 'Agile', value: 'Agile'),
    DropdownItem(label: 'Ajax', value: 'Ajax'),
    DropdownItem(label: 'Android', value: 'Android'),
    DropdownItem(label: 'AngularJS', value: 'AngularJS'),
    DropdownItem(label: 'Antiryad Gx', value: 'Antiryad Gx'),
    DropdownItem(label: 'App Game Kit', value: 'App Game Kit'),
    DropdownItem(label: 'ASP.NET', value: 'ASP.NET'),
    DropdownItem(label: 'AutoCAD', value: 'AutoCAD'),
    DropdownItem(label: 'BattryTech', value: 'BattryTech'),
    DropdownItem(label: 'Bootstrap', value: 'Bootstrap'),
    DropdownItem(label: 'Bridge Engineer', value: 'Bridge Engineer'),
    DropdownItem(label: 'C#', value: 'C#'),
    DropdownItem(label: 'C++', value: 'C++'),
    DropdownItem(label: 'Cacti', value: 'Cacti'),
    DropdownItem(label: 'CakePHP', value: 'CakePHP'),
    DropdownItem(label: 'Ceph', value: 'Ceph'),
    DropdownItem(label: 'Cocoonjs', value: 'Cocoonjs'),
    DropdownItem(label: 'Cocos2D', value: 'Cocos2D'),
    DropdownItem(label: 'CodeIgniter', value: 'CodeIgniter'),
    DropdownItem(label: 'Construct 2', value: 'Construct 2'),
    DropdownItem(label: 'CorelDRAW', value: 'CorelDRAW'),
    DropdownItem(label: 'Corona', value: 'Corona'),
    DropdownItem(label: 'CSS', value: 'CSS'),
    DropdownItem(label: 'Designer', value: 'Designer'),
    DropdownItem(label: 'Django', value: 'Django'),
    DropdownItem(label: 'Drupal', value: 'Drupal'),
    DropdownItem(label: 'Edgelib', value: 'Edgelib'),
    DropdownItem(label: 'Elasticsearch', value: 'Elasticsearch'),
    DropdownItem(label: 'Emo', value: 'Emo'),
    DropdownItem(label: 'ERP', value: 'ERP'),
    DropdownItem(label: 'Esenthel Engine', value: 'Esenthel Engine'),
    DropdownItem(label: 'FlightPHP', value: 'FlightPHP'),
    DropdownItem(label: 'FuelPHP', value: 'FuelPHP'),
    DropdownItem(label: 'Game', value: 'Game'),
    DropdownItem(label: 'Game Artist', value: 'Game Artist'),
    DropdownItem(label: 'Game Editor', value: 'Game Editor'),
    DropdownItem(label: 'GameMaker', value: 'GameMaker'),
    DropdownItem(label: 'GameSalad', value: 'GameSalad'),
    DropdownItem(label: 'Gideros', value: 'Gideros'),
    DropdownItem(label: 'Git', value: 'Git'),
    DropdownItem(label: 'Github', value: 'Github'),
    DropdownItem(label: 'GlusterFS', value: 'GlusterFS'),
    DropdownItem(label: 'HDFS', value: 'HDFS'),
    DropdownItem(label: 'HTML', value: 'HTML'),
    DropdownItem(label: 'HTML5', value: 'HTML5'),
    DropdownItem(label: 'Illustrator', value: 'Illustrator'),
    DropdownItem(label: 'iOS', value: 'iOS'),
    DropdownItem(label: 'IT Helpdesk', value: 'IT Helpdesk'),
    DropdownItem(label: 'J2EE', value: 'J2EE'),
    DropdownItem(label: 'Java', value: 'Java'),
    DropdownItem(label: 'Javascript', value: 'Javascript'),
    DropdownItem(label: 'JMonkey', value: 'JMonkey'),
    DropdownItem(label: 'Joomla', value: 'Joomla'),
    DropdownItem(label: 'JQuery', value: 'JQuery'),
    DropdownItem(label: 'JSON', value: 'JSON'),
    DropdownItem(label: 'Knockout JS', value: 'Knockout JS'),
    DropdownItem(label: 'Laravel', value: 'Laravel'),
    DropdownItem(label: 'Libdx', value: 'Libdx'),
    DropdownItem(label: 'Linux', value: 'Linux'),
    DropdownItem(label: 'LiveCode', value: 'LiveCode'),
    DropdownItem(label: 'Lua', value: 'Lua'),
    DropdownItem(label: 'Magento', value: 'Magento'),
    DropdownItem(label: 'Manager', value: 'Manager'),
    DropdownItem(label: 'MariaDB', value: 'MariaDB'),
    DropdownItem(label: 'Marmalade', value: 'Marmalade'),
    DropdownItem(label: 'Maya', value: 'Maya'),
    DropdownItem(label: 'Memcached', value: 'Memcached'),
    DropdownItem(label: 'Microsoft Access', value: 'Microsoft Access'),
    DropdownItem(label: 'MongoDB', value: 'MongoDB'),
    DropdownItem(label: 'MonoGame', value: 'MonoGame'),
    DropdownItem(label: 'MoSync', value: 'MoSync'),
    DropdownItem(label: 'MRTG', value: 'MRTG'),
    DropdownItem(label: 'MS SQL', value: 'MS SQL'),
    DropdownItem(label: 'Multimedia Fusion 2', value: 'Multimedia Fusion 2'),
    DropdownItem(label: 'MVC', value: 'MVC'),
    DropdownItem(label: 'MVC5', value: 'MVC5'),
    DropdownItem(label: 'MySQL', value: 'MySQL'),
    DropdownItem(label: 'Nagios', value: 'Nagios'),
    DropdownItem(label: 'Nette', value: 'Nette'),
    DropdownItem(label: 'Nginx', value: 'Nginx'),
    DropdownItem(label: 'NodeJS', value: 'NodeJS'),
    DropdownItem(label: 'NoSQL', value: 'NoSQL'),
    DropdownItem(label: 'Objective-C', value: 'Objective-C'),
    DropdownItem(label: 'Odoo', value: 'Odoo'),
    DropdownItem(label: 'OOP', value: 'OOP'),
    DropdownItem(label: 'Oracle', value: 'Oracle'),
    DropdownItem(label: 'Orx', value: 'Orx'),
    DropdownItem(
        label: 'Papaya Social Game Engine', value: 'Papaya Social Game Engine'),
    DropdownItem(label: 'Perl', value: 'Perl'),
    DropdownItem(label: 'PhalconPHP', value: 'PhalconPHP'),
    DropdownItem(label: 'Photoshop', value: 'Photoshop'),
    DropdownItem(label: 'PHP', value: 'PHP'),
    DropdownItem(label: 'PHPixie', value: 'PHPixie'),
    DropdownItem(label: 'PlayCanvas', value: 'PlayCanvas'),
    DropdownItem(label: 'PlayIR', value: 'PlayIR'),
    DropdownItem(label: 'PopPHP', value: 'PopPHP'),
    DropdownItem(label: 'PostgreSQL', value: 'PostgreSQL'),
    DropdownItem(label: 'Product Manager', value: 'Product Manager'),
    DropdownItem(label: 'Project Manager', value: 'Project Manager'),
    DropdownItem(label: 'Python', value: 'Python'),
    DropdownItem(label: 'Redis', value: 'Redis'),
    DropdownItem(label: 'REST API', value: 'REST API'),
    DropdownItem(label: 'Riak', value: 'Riak'),
    DropdownItem(label: 'Ruby on Rails', value: 'Ruby on Rails'),
    DropdownItem(label: 'SEM', value: 'SEM'),
    DropdownItem(label: 'SEO', value: 'SEO'),
    DropdownItem(
        label: 'Server-Side Scripting', value: 'Server-Side Scripting'),
    DropdownItem(label: 'Sharepoint', value: 'Sharepoint'),
    DropdownItem(label: 'ShiVa', value: 'ShiVa'),
    DropdownItem(label: 'ShiVa3D', value: 'ShiVa3D'),
    DropdownItem(label: 'Signal R', value: 'Signal R'),
    DropdownItem(label: 'Simple MVC Framework', value: 'Simple MVC Framework'),
    DropdownItem(label: 'Sketch', value: 'Sketch'),
    DropdownItem(label: 'Socket.io', value: 'Socket.io'),
    DropdownItem(label: 'Sparrow', value: 'Sparrow'),
    DropdownItem(label: 'SQL', value: 'SQL'),
    DropdownItem(label: 'SQL Server', value: 'SQL Server'),
    DropdownItem(label: 'Squid', value: 'Squid'),
    DropdownItem(label: 'Starling', value: 'Starling'),
    DropdownItem(label: 'Styncyl', value: 'Styncyl'),
    DropdownItem(label: 'SVN', value: 'SVN'),
    DropdownItem(label: 'Swift', value: 'Swift'),
    DropdownItem(label: 'Symfony', value: 'Symfony'),
    DropdownItem(label: 'System Admin', value: 'System Admin'),
    DropdownItem(label: 'Tester', value: 'Tester'),
    DropdownItem(label: 'UML', value: 'UML'),
    DropdownItem(label: 'Unity', value: 'Unity'),
    DropdownItem(
        label: 'Unreal Development Kit', value: 'Unreal Development Kit'),
    DropdownItem(label: 'UX/UI Design', value: 'UX/UI Design'),
    DropdownItem(label: 'visual-basic', value: 'visual-basic'),
    DropdownItem(label: 'WCF', value: 'WCF'),
    DropdownItem(label: 'Websocket', value: 'Websocket'),
    DropdownItem(label: 'Windows Phone', value: 'Windows Phone'),
    DropdownItem(label: 'Leadership', value: 'Leadership'),
    DropdownItem(label: 'Teamwork', value: 'Teamwork'),
    DropdownItem(label: 'Database', value: 'Database'),
    DropdownItem(label: 'IELTS', value: 'IELTS'),
    DropdownItem(label: 'Word', value: 'Word'),
    DropdownItem(label: 'Excel', value: 'Excel'),
    DropdownItem(label: 'PowerPoint', value: 'PowerPoint'),
    DropdownItem(label: 'GMAT', value: 'GMAT'),
    DropdownItem(label: 'test cases', value: 'test cases'),
    DropdownItem(label: 'test scripts', value: 'test scripts'),
    DropdownItem(label: 'test plan', value: 'test plan'),
    DropdownItem(label: 'Google Analytics', value: 'Google Analytics'),
    DropdownItem(
        label: 'Google Webmaster tool', value: 'Google Webmaster tool'),
    DropdownItem(label: 'iView', value: 'iView'),
    DropdownItem(label: 'iClick', value: 'iClick'),
    DropdownItem(label: 'Facebook Ninja', value: 'Facebook Ninja'),
    DropdownItem(label: 'Rank tracker', value: 'Rank tracker'),
    DropdownItem(label: 'HMA', value: 'HMA'),
    DropdownItem(label: 'Opencart', value: 'Opencart'),
    DropdownItem(label: 'Làm việc độc lập', value: 'Làm việc độc lập'),
    DropdownItem(label: 'Microsoft Office', value: 'Microsoft Office'),
    DropdownItem(label: 'Kỹ năng lãnh đạo', value: 'Kỹ năng lãnh đạo'),
    DropdownItem(label: 'Kỹ năng giao tiếp', value: 'Kỹ năng giao tiếp'),
    DropdownItem(label: 'Làm việc nhóm', value: 'Làm việc nhóm'),
    DropdownItem(label: 'Quản lý thời gian', value: 'Quản lý thời gian'),
    DropdownItem(label: 'Copywriting', value: 'Copywriting'),
    DropdownItem(label: 'Kỹ năng đàm phán', value: 'Kỹ năng đàm phán'),
    DropdownItem(label: 'Tổ chức sự kiện', value: 'Tổ chức sự kiện'),
    DropdownItem(label: 'Market Research', value: 'Market Research'),
    DropdownItem(label: 'Telesales', value: 'Telesales'),
    DropdownItem(
        label: 'Kĩ năng phân tích tổng hợp',
        value: 'Kĩ năng phân tích tổng hợp'),
    DropdownItem(label: 'Kỹ năng lắng nghe', value: 'Kỹ năng lắng nghe'),
    DropdownItem(label: 'Docker', value: 'Docker'),
    DropdownItem(label: 'Redux', value: 'Redux'),
    DropdownItem(label: 'Planning', value: 'Planning'),
    DropdownItem(label: 'Angular 2', value: 'Angular 2'),
    DropdownItem(label: 'LESS', value: 'LESS'),
    DropdownItem(label: 'SASS', value: 'SASS'),
    DropdownItem(label: 'After Effect', value: 'After Effect'),
    DropdownItem(label: 'Google Adwords', value: 'Google Adwords'),
    DropdownItem(label: 'Marketing', value: 'Marketing'),
    DropdownItem(label: 'R&D', value: 'R&D'),
    DropdownItem(label: 'Project Management', value: 'Project Management'),
    DropdownItem(label: 'cs-cart', value: 'cs-cart'),
    DropdownItem(label: 'bitrix', value: 'bitrix'),
    DropdownItem(label: 'Biên tập', value: 'Biên tập'),
    DropdownItem(label: 'React Native', value: 'React Native'),
    DropdownItem(label: 'webpack', value: 'webpack'),
    DropdownItem(label: 'babel', value: 'babel'),
    DropdownItem(label: 'HSK', value: 'HSK'),
    DropdownItem(label: 'CPA', value: 'CPA'),
    DropdownItem(label: 'Tiếng Trung', value: 'Tiếng Trung'),
    DropdownItem(label: 'SCRUM', value: 'SCRUM'),
    DropdownItem(label: 'evm', value: 'evm'),
    DropdownItem(label: 'Dựng phim', value: 'Dựng phim'),
    DropdownItem(label: 'Tiếng Nhật', value: 'Tiếng Nhật'),
    DropdownItem(label: 'QC/QA', value: 'QC/QA'),
    DropdownItem(label: 'Windows Server', value: 'Windows Server'),
    DropdownItem(label: 'Oracle DataGuard', value: 'Oracle DataGuard'),
    DropdownItem(label: 'C&B', value: 'C&B'),
    DropdownItem(label: 'LAN', value: 'LAN'),
    DropdownItem(label: 'WAN', value: 'WAN'),
    DropdownItem(label: 'CRM', value: 'CRM'),
    DropdownItem(label: 'AFC', value: 'AFC'),
    DropdownItem(label: 'ACCA', value: 'ACCA'),
    DropdownItem(label: 'AI', value: 'AI'),
    DropdownItem(label: 'VR', value: 'VR'),
    DropdownItem(label: 'Graphic design', value: 'Graphic design'),
    DropdownItem(label: 'Java GUI Framework', value: 'Java GUI Framework'),
    DropdownItem(label: 'Oracle Database', value: 'Oracle Database'),
    DropdownItem(label: 'UI', value: 'UI'),
    DropdownItem(label: 'GIS', value: 'GIS'),
    DropdownItem(label: 'NPI', value: 'NPI'),
    DropdownItem(label: 'UX', value: 'UX'),
    DropdownItem(label: 'kafka', value: 'kafka'),
    DropdownItem(label: 'Analytics', value: 'Analytics'),
    DropdownItem(label: 'etabs', value: 'etabs'),
    DropdownItem(label: 'AIX platform', value: 'AIX platform'),
    DropdownItem(label: 'IBM HTTP Server', value: 'IBM HTTP Server'),
    DropdownItem(
        label: 'Business Process Analysis', value: 'Business Process Analysis'),
    DropdownItem(label: 'Tiếng Nhật N3', value: 'Tiếng Nhật N3'),
    DropdownItem(label: 'Adobe Photoshop', value: 'Adobe Photoshop'),
    DropdownItem(label: 'AWS', value: 'AWS'),
    DropdownItem(label: 'ORM', value: 'ORM'),
    DropdownItem(label: 'TOEIC', value: 'TOEIC'),
    DropdownItem(label: 'Kỹ năng Thuyết phục', value: 'Kỹ năng Thuyết phục'),
    DropdownItem(label: 'Tiếng Anh giao tiếp', value: 'Tiếng Anh giao tiếp'),
    DropdownItem(label: 'Automation Test', value: 'Automation Test'),
    DropdownItem(label: 'Struts', value: 'Struts'),
    DropdownItem(label: 'Revit', value: 'Revit'),
    DropdownItem(label: 'Sketchup', value: 'Sketchup'),
    DropdownItem(label: 'CSS3', value: 'CSS3'),
    DropdownItem(label: 'OTC', value: 'OTC'),
    DropdownItem(label: 'VB.NET', value: 'VB.NET'),
    DropdownItem(label: '.NET Framework', value: '.NET Framework'),
    DropdownItem(label: 'MSSQL', value: 'MSSQL'),
    DropdownItem(label: 'LinQ', value: 'LinQ'),
    DropdownItem(label: 'Facebook Ads', value: 'Facebook Ads'),
    DropdownItem(label: 'Zalo ads', value: 'Zalo ads'),
    DropdownItem(label: 'SQLite', value: 'SQLite'),
    DropdownItem(label: 'Elixir', value: 'Elixir'),
    DropdownItem(label: 'TESOL', value: 'TESOL'),
    DropdownItem(label: 'TOEFL', value: 'TOEFL'),
    DropdownItem(label: 'Quản lý nhóm', value: 'Quản lý nhóm'),
    DropdownItem(label: 'Tiếng Anh thành thạo', value: 'Tiếng Anh thành thạo'),
    DropdownItem(label: 'Thuyết trình', value: 'Thuyết trình'),
    DropdownItem(label: 'Tư duy hệ thống', value: 'Tư duy hệ thống'),
    DropdownItem(label: 'ASP', value: 'ASP'),
    DropdownItem(label: 'Tiếng Nhật N3', value: 'Tiếng Nhật N3'),
    DropdownItem(label: 'Crystal Reports', value: 'Crystal Reports'),
    DropdownItem(label: 'Hibernate', value: 'Hibernate'),
    DropdownItem(label: 'Kỹ năng quản lý', value: 'Kỹ năng quản lý'),
    DropdownItem(label: 'LabVIEW', value: 'LabVIEW'),
    DropdownItem(label: 'RD', value: 'RD'),
    DropdownItem(label: 'Tiếng Nhật N2', value: 'Tiếng Nhật N2'),
    DropdownItem(label: 'Qt Framework', value: 'Qt Framework'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Trung',
        value: 'Biên phiên dịch tiếng Trung'),
    DropdownItem(label: 'pfSense', value: 'pfSense'),
    DropdownItem(label: 'Tin học văn phòng', value: 'Tin học văn phòng'),
    DropdownItem(label: 'DNS', value: 'DNS'),
    DropdownItem(label: 'Biên tập Video', value: 'Biên tập Video'),
    DropdownItem(label: 'SolidWorks', value: 'SolidWorks'),
    DropdownItem(label: 'Oracle PL/SQL', value: 'Oracle PL/SQL'),
    DropdownItem(label: 'UIKit', value: 'UIKit'),
    DropdownItem(label: 'Core Data', value: 'Core Data'),
    DropdownItem(label: 'Blockchain', value: 'Blockchain'),
    DropdownItem(label: 'Sony Vegas', value: 'Sony Vegas'),
    DropdownItem(label: 'Tiếng Nga giao tiếp', value: 'Tiếng Nga giao tiếp'),
    DropdownItem(label: 'Maven', value: 'Maven'),
    DropdownItem(label: 'Kubernetes', value: 'Kubernetes'),
    DropdownItem(label: 'Cocos2d-x', value: 'Cocos2d-x'),
    DropdownItem(label: 'XCode', value: 'XCode'),
    DropdownItem(label: 'Visual Studio', value: 'Visual Studio'),
    DropdownItem(label: 'Cocos Studio', value: 'Cocos Studio'),
    DropdownItem(label: 'Tiếng Nhật N4', value: 'Tiếng Nhật N4'),
    DropdownItem(label: 'CAD/CAE', value: 'CAD/CAE'),
    DropdownItem(label: 'Angular 4', value: 'Angular 4'),
    DropdownItem(label: 'Javascript Framework', value: 'Javascript Framework'),
    DropdownItem(label: 'Web API', value: 'Web API'),
    DropdownItem(label: 'TypeScript', value: 'TypeScript'),
    DropdownItem(label: 'Stopmotion', value: 'Stopmotion'),
    DropdownItem(label: 'Storyboad', value: 'Storyboad'),
    DropdownItem(label: 'Message Queue', value: 'Message Queue'),
    DropdownItem(label: 'Adobe Illustrator', value: 'Adobe Illustrator'),
    DropdownItem(label: 'Scala', value: 'Scala'),
    DropdownItem(label: 'Chart.JS', value: 'Chart.JS'),
    DropdownItem(label: 'Google APIs', value: 'Google APIs'),
    DropdownItem(label: 'DI', value: 'DI'),
    DropdownItem(label: 'Web Socket', value: 'Web Socket'),
    DropdownItem(label: 'ADO.NET', value: 'ADO.NET'),
    DropdownItem(label: 'Hitosoft', value: 'Hitosoft'),
    DropdownItem(label: 'MVC4', value: 'MVC4'),
    DropdownItem(label: 'Realm', value: 'Realm'),
    DropdownItem(label: 'OpenGL', value: 'OpenGL'),
    DropdownItem(label: 'Android SDK', value: 'Android SDK'),
    DropdownItem(label: 'Android ADT', value: 'Android ADT'),
    DropdownItem(label: 'CentOS', value: 'CentOS'),
    DropdownItem(label: 'Shell script', value: 'Shell script'),
    DropdownItem(label: 'Adobe Audition', value: 'Adobe Audition'),
    DropdownItem(label: 'DaVinci', value: 'DaVinci'),
    DropdownItem(label: 'Adobe Premier', value: 'Adobe Premier'),
    DropdownItem(label: 'Moho', value: 'Moho'),
    DropdownItem(label: 'SDLC', value: 'SDLC'),
    DropdownItem(label: 'Angular 6', value: 'Angular 6'),
    DropdownItem(label: 'TOPIK 4', value: 'TOPIK 4'),
    DropdownItem(label: 'COBOL', value: 'COBOL'),
    DropdownItem(
        label: 'Dịch thuật tiếng Trung', value: 'Dịch thuật tiếng Trung'),
    DropdownItem(label: 'Animation', value: 'Animation'),
    DropdownItem(label: 'Apache', value: 'Apache'),
    DropdownItem(label: 'Scraping', value: 'Scraping'),
    DropdownItem(label: 'Kendo UI', value: 'Kendo UI'),
    DropdownItem(label: 'Archicad', value: 'Archicad'),
    DropdownItem(label: 'Lotus Notes', value: 'Lotus Notes'),
    DropdownItem(label: 'Slim PHP', value: 'Slim PHP'),
    DropdownItem(label: 'JSF', value: 'JSF'),
    DropdownItem(label: 'VLAN', value: 'VLAN'),
    DropdownItem(label: 'Routing IP', value: 'Routing IP'),
    DropdownItem(label: 'Financial office', value: 'Financial office'),
    DropdownItem(label: 'Advertising', value: 'Advertising'),
    DropdownItem(label: 'Vẽ 3D', value: 'Vẽ 3D'),
    DropdownItem(label: 'Junit', value: 'Junit'),
    DropdownItem(label: 'Magento 2', value: 'Magento 2'),
    DropdownItem(label: 'Angular JS', value: 'Angular JS'),
    DropdownItem(label: 'Tiếng Nhật N1', value: 'Tiếng Nhật N1'),
    DropdownItem(label: 'VueJS', value: 'VueJS'),
    DropdownItem(label: 'MS Outlook', value: 'MS Outlook'),
    DropdownItem(label: 'XHTML', value: 'XHTML'),
    DropdownItem(label: 'ISA', value: 'ISA'),
    DropdownItem(label: 'DFS', value: 'DFS'),
    DropdownItem(label: 'MCSA', value: 'MCSA'),
    DropdownItem(label: 'MCSE', value: 'MCSE'),
    DropdownItem(label: 'CCBA', value: 'CCBA'),
    DropdownItem(label: 'CBAP', value: 'CBAP'),
    DropdownItem(label: 'Cad', value: 'Cad'),
    DropdownItem(label: 'Kỹ năng phỏng vấn', value: 'Kỹ năng phỏng vấn'),
    DropdownItem(label: 'counselor', value: 'counselor'),
    DropdownItem(label: 'debug', value: 'debug'),
    DropdownItem(label: 'IOT', value: 'IOT'),
    DropdownItem(label: 'FileMaker', value: 'FileMaker'),
    DropdownItem(label: 'ReactJS', value: 'ReactJS'),
    DropdownItem(label: 'ExpressJS', value: 'ExpressJS'),
    DropdownItem(label: 'MeanJS', value: 'MeanJS'),
    DropdownItem(label: 'Restify', value: 'Restify'),
    DropdownItem(label: 'Kỹ năng sư phạm', value: 'Kỹ năng sư phạm'),
    DropdownItem(label: 'PMP', value: 'PMP'),
    DropdownItem(label: 'PMF', value: 'PMF'),
    DropdownItem(label: 'CSM', value: 'CSM'),
    DropdownItem(label: 'PSM', value: 'PSM'),
    DropdownItem(label: 'Xử lý tình huống', value: 'Xử lý tình huống'),
    DropdownItem(label: 'TBA', value: 'TBA'),
    DropdownItem(label: 'MFĐ', value: 'MFĐ'),
    DropdownItem(label: 'UPS', value: 'UPS'),
    DropdownItem(label: 'Juniper', value: 'Juniper'),
    DropdownItem(label: 'Tiếng Nhật N2 - N1', value: 'Tiếng Nhật N2 - N1'),
    DropdownItem(label: 'N3', value: 'N3'),
    DropdownItem(label: 'N1', value: 'N1'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Hàn', value: 'Biên phiên dịch tiếng Hàn'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Anh', value: 'Biên phiên dịch tiếng Anh'),
    DropdownItem(
        label: 'Kỹ năng phân tích kinh doanh',
        value: 'Kỹ năng phân tích kinh doanh'),
    DropdownItem(label: 'Angular', value: 'Angular'),
    DropdownItem(label: 'Kỹ năng bơi lội', value: 'Kỹ năng bơi lội'),
    DropdownItem(label: 'Meteor', value: 'Meteor'),
    DropdownItem(label: 'Smartfox', value: 'Smartfox'),
    DropdownItem(label: 'Kỹ năng bán hàng', value: 'Kỹ năng bán hàng'),
    DropdownItem(label: 'kỹ năng đào tạo', value: 'kỹ năng đào tạo'),
    DropdownItem(label: 'HTTP/HTTPS', value: 'HTTP/HTTPS'),
    DropdownItem(label: 'FTP', value: 'FTP'),
    DropdownItem(label: 'VNACCS', value: 'VNACCS'),
    DropdownItem(label: 'Framework Django', value: 'Framework Django'),
    DropdownItem(label: 'Lái xe', value: 'Lái xe'),
    DropdownItem(label: 'MVP', value: 'MVP'),
    DropdownItem(label: 'MVV', value: 'MVV'),
    DropdownItem(label: 'Avid Media Composer', value: 'Avid Media Composer'),
    DropdownItem(label: 'Lightworks', value: 'Lightworks'),
    DropdownItem(label: 'Final Cut', value: 'Final Cut'),
    DropdownItem(label: 'Content write', value: 'Content write'),
    DropdownItem(label: 'MES', value: 'MES'),
    DropdownItem(label: 'Flutter', value: 'Flutter'),
    DropdownItem(label: 'IELTS 6.', value: 'IELTS 6.'),
    DropdownItem(label: 'Cimatron', value: 'Cimatron'),
    DropdownItem(label: 'GUI', value: 'GUI'),
    DropdownItem(
        label: 'Đàm phán thương lượng', value: 'Đàm phán thương lượng'),
    DropdownItem(label: 'HSK4', value: 'HSK4'),
    DropdownItem(label: 'DB2', value: 'DB2'),
    DropdownItem(label: 'Avr', value: 'Avr'),
    DropdownItem(label: 'Angular 1', value: 'Angular 1'),
    DropdownItem(label: 'Kỹ năng tuyển dụng', value: 'Kỹ năng tuyển dụng'),
    DropdownItem(label: 'Kỹ năng giảng dạy', value: 'Kỹ năng giảng dạy'),
    DropdownItem(label: 'JLPT  N3', value: 'JLPT  N3'),
    DropdownItem(label: 'HSK5', value: 'HSK5'),
    DropdownItem(label: 'ETAB', value: 'ETAB'),
    DropdownItem(label: 'Fireframe', value: 'Fireframe'),
    DropdownItem(label: 'ASTM', value: 'ASTM'),
    DropdownItem(label: 'phân tích số liệu', value: 'phân tích số liệu'),
    DropdownItem(label: 'Tiếng Hàn', value: 'Tiếng Hàn'),
    DropdownItem(label: 'UCD', value: 'UCD'),
    DropdownItem(label: 'UID', value: 'UID'),
    DropdownItem(label: 'Tiếng Pháp', value: 'Tiếng Pháp'),
    DropdownItem(label: 'Kỹ năng đàm phán', value: 'Kỹ năng đàm phán'),
    DropdownItem(label: 'Business Analyst', value: 'Business Analyst'),
    DropdownItem(label: 'kỹ năng điều tra', value: 'kỹ năng điều tra'),
    DropdownItem(label: 'Unix', value: 'Unix'),
    DropdownItem(label: 'Kỹ năng báo cáo', value: 'Kỹ năng báo cáo'),
    DropdownItem(label: 'Sales', value: 'Sales'),
    DropdownItem(label: 'PR', value: 'PR'),
    DropdownItem(label: 'Tìm kiếm khách hàng', value: 'Tìm kiếm khách hàng'),
    DropdownItem(label: 'Tư vấn', value: 'Tư vấn'),
    DropdownItem(
        label: 'Kỹ năng quản lý công việc', value: 'Kỹ năng quản lý công việc'),
    DropdownItem(label: 'Sales online', value: 'Sales online'),
    DropdownItem(label: 'PQA', value: 'PQA'),
    DropdownItem(label: 'QA', value: 'QA'),
    DropdownItem(label: 'PLC', value: 'PLC'),
    DropdownItem(label: 'Oracle SQL', value: 'Oracle SQL'),
    DropdownItem(label: 'CCNA', value: 'CCNA'),
    DropdownItem(label: 'Flash', value: 'Flash'),
    DropdownItem(label: 'LPI', value: 'LPI'),
    DropdownItem(label: 'Tư duy logic', value: 'Tư duy logic'),
    DropdownItem(label: 'Adobe After Effects', value: 'Adobe After Effects'),
    DropdownItem(label: 'Adobe Dreamweaver', value: 'Adobe Dreamweaver'),
    DropdownItem(label: 'Adobe InDesign', value: 'Adobe InDesign'),
    DropdownItem(
        label: 'Biên phiên dịch Tiếng Nhật',
        value: 'Biên phiên dịch Tiếng Nhật'),
    DropdownItem(label: 'Jenkins', value: 'Jenkins'),
    DropdownItem(label: 'MS Offices', value: 'MS Offices'),
    DropdownItem(label: 'Misa', value: 'Misa'),
    DropdownItem(label: 'Tiếng Anh đọc hiểu', value: 'Tiếng Anh đọc hiểu'),
    DropdownItem(label: 'Adobe Premiere Pro', value: 'Adobe Premiere Pro'),
    DropdownItem(label: 'Golang', value: 'Golang'),
    DropdownItem(label: 'Unity 3D', value: 'Unity 3D'),
    DropdownItem(label: 'Cadewa', value: 'Cadewa'),
    DropdownItem(label: 'Kotlin', value: 'Kotlin'),
    DropdownItem(label: 'Jira', value: 'Jira'),
    DropdownItem(label: 'Tiếng Anh cơ bản', value: 'Tiếng Anh cơ bản'),
    DropdownItem(label: 'Tiếng Anh trung cấp', value: 'Tiếng Anh trung cấp'),
    DropdownItem(label: 'ATSM', value: 'ATSM'),
    DropdownItem(label: 'ASME', value: 'ASME'),
    DropdownItem(label: 'Lightroom', value: 'Lightroom'),
    DropdownItem(label: 'Alige', value: 'Alige'),
    DropdownItem(label: 'VMWare', value: 'VMWare'),
    DropdownItem(label: 'VB6', value: 'VB6'),
    DropdownItem(label: 'Zoho Desk', value: 'Zoho Desk'),
    DropdownItem(label: 'Big Data', value: 'Big Data'),
    DropdownItem(label: 'NLP', value: 'NLP'),
    DropdownItem(label: 'RSpec', value: 'RSpec'),
    DropdownItem(label: 'Devise', value: 'Devise'),
    DropdownItem(label: 'TDD', value: 'TDD'),
    DropdownItem(label: 'CI', value: 'CI'),
    DropdownItem(label: 'Mocking', value: 'Mocking'),
    DropdownItem(label: 'Exploit', value: 'Exploit'),
    DropdownItem(label: 'Eclipse', value: 'Eclipse'),
    DropdownItem(label: 'OOD', value: 'OOD'),
    DropdownItem(label: 'LAMP', value: 'LAMP'),
    DropdownItem(label: 'LEMP', value: 'LEMP'),
    DropdownItem(label: 'VPSSIM', value: 'VPSSIM'),
    DropdownItem(label: 'Ubuntu', value: 'Ubuntu'),
    DropdownItem(label: 'Objective C', value: 'Objective C'),
    DropdownItem(label: 'IRP', value: 'IRP'),
    DropdownItem(label: 'SOA', value: 'SOA'),
    DropdownItem(label: 'Gerber', value: 'Gerber'),
    DropdownItem(label: 'Lectra', value: 'Lectra'),
    DropdownItem(label: 'Negotiation Skill', value: 'Negotiation Skill'),
    DropdownItem(label: 'Tiếng Thái', value: 'Tiếng Thái'),
    DropdownItem(label: 'Spring', value: 'Spring'),
    DropdownItem(label: 'CAD 2D', value: 'CAD 2D'),
    DropdownItem(label: 'Fast', value: 'Fast'),
    DropdownItem(label: 'Amis', value: 'Amis'),
    DropdownItem(label: 'Angular 5', value: 'Angular 5'),
    DropdownItem(label: 'Apache Spark', value: 'Apache Spark'),
    DropdownItem(label: 'HMTL5', value: 'HMTL5'),
    DropdownItem(label: 'Figma', value: 'Figma'),
    DropdownItem(label: 'JET', value: 'JET'),
    DropdownItem(
        label: 'Intermedidate English', value: 'Intermedidate English'),
    DropdownItem(label: 'ABAP', value: 'ABAP'),
    DropdownItem(label: 'Tensorflow', value: 'Tensorflow'),
    DropdownItem(label: 'Pytorch', value: 'Pytorch'),
    DropdownItem(label: 'Zbrush', value: 'Zbrush'),
    DropdownItem(label: 'Sculpt', value: 'Sculpt'),
    DropdownItem(label: 'Spring Framework', value: 'Spring Framework'),
    DropdownItem(label: 'Spring Boot', value: 'Spring Boot'),
    DropdownItem(label: 'BPMN', value: 'BPMN'),
    DropdownItem(
        label: 'Phát triển thị trường', value: 'Phát triển thị trường'),
    DropdownItem(label: 'TCP/IP', value: 'TCP/IP'),
    DropdownItem(label: 'English', value: 'English'),
    DropdownItem(label: 'HSK 6', value: 'HSK 6'),
    DropdownItem(label: 'IELTS 7.0', value: 'IELTS 7.0'),
    DropdownItem(label: 'JLPT N2', value: 'JLPT N2'),
    DropdownItem(label: 'Ruby', value: 'Ruby'),
    DropdownItem(label: 'Tiếng Đức', value: 'Tiếng Đức'),
    DropdownItem(label: 'Tiếng Ý', value: 'Tiếng Ý'),
    DropdownItem(label: 'Tiếng Ả Rập', value: 'Tiếng Ả Rập'),
    DropdownItem(label: 'Tiếng Bồ Đào Nha', value: 'Tiếng Bồ Đào Nha'),
    DropdownItem(label: 'Tiếng Tây Ban Nha', value: 'Tiếng Tây Ban Nha'),
    DropdownItem(label: 'Tiếng Anh', value: 'Tiếng Anh'),
    DropdownItem(label: 'Adobe Premiere', value: 'Adobe Premiere'),
    DropdownItem(label: 'Full Stack', value: 'Full Stack'),
    DropdownItem(label: 'XML', value: 'XML'),
    DropdownItem(label: 'AXure', value: 'AXure'),
    DropdownItem(label: 'TOEIC 600', value: 'TOEIC 600'),
    DropdownItem(label: 'JLPT N4', value: 'JLPT N4'),
    DropdownItem(label: 'JLPT N1', value: 'JLPT N1'),
    DropdownItem(label: 'IELTS 7.5', value: 'IELTS 7.5'),
    DropdownItem(label: 'Tiếng Indonesia', value: 'Tiếng Indonesia'),
    DropdownItem(label: 'TOEIC 550', value: 'TOEIC 550'),
    DropdownItem(label: 'TOEIC 850', value: 'TOEIC 850'),
    DropdownItem(label: 'IELTS 8.5', value: 'IELTS 8.5'),
    DropdownItem(label: 'HKS5', value: 'HKS5'),
    DropdownItem(label: 'HSK6', value: 'HSK6'),
    DropdownItem(label: 'IELTS 6.5', value: 'IELTS 6.5'),
    DropdownItem(label: 'TOEIC 650', value: 'TOEIC 650'),
    DropdownItem(label: 'Tiếng Anh B2', value: 'Tiếng Anh B2'),
    DropdownItem(label: 'IELTS 8.0', value: 'IELTS 8.0'),
    DropdownItem(
        label: 'Performance Marketing', value: 'Performance Marketing'),
    DropdownItem(label: 'Marketing Online', value: 'Marketing Online'),
    DropdownItem(label: 'Programming', value: 'Programming'),
    DropdownItem(label: 'Xây dựng đội nhóm', value: 'Xây dựng đội nhóm'),
    DropdownItem(label: 'Excel cơ bản', value: 'Excel cơ bản'),
    DropdownItem(label: 'API', value: 'API'),
    DropdownItem(label: 'CI/CD', value: 'CI/CD'),
    DropdownItem(label: 'Adobe', value: 'Adobe'),
    DropdownItem(label: 'Quay dựng', value: 'Quay dựng'),
    DropdownItem(label: 'Game Balance', value: 'Game Balance'),
    DropdownItem(label: 'Game Design', value: 'Game Design'),
    DropdownItem(label: 'Event Planning', value: 'Event Planning'),
    DropdownItem(label: 'Public Speaking', value: 'Public Speaking'),
    DropdownItem(label: 'Business Development', value: 'Business Development'),
    DropdownItem(label: 'Communication', value: 'Communication'),
    DropdownItem(label: 'zalo', value: 'zalo'),
    DropdownItem(label: 'facebook', value: 'facebook'),
    DropdownItem(label: 'Content Writer', value: 'Content Writer'),
    DropdownItem(label: 'Sáng tạo nội dung', value: 'Sáng tạo nội dung'),
    DropdownItem(label: 'Phân tích công việc', value: 'Phân tích công việc'),
    DropdownItem(label: 'Windows', value: 'Windows'),
    DropdownItem(label: 'Chịu áp lực cao', value: 'Chịu áp lực cao'),
    DropdownItem(label: 'Direct Sale', value: 'Direct Sale'),
    DropdownItem(label: 'Design Thinking', value: 'Design Thinking'),
    DropdownItem(label: 'RESTful API', value: 'RESTful API'),
    DropdownItem(
        label: 'Back-End Web Development', value: 'Back-End Web Development'),
    DropdownItem(label: 'RabbitMQ', value: 'RabbitMQ'),
    DropdownItem(label: 'Setup hệ thống', value: 'Setup hệ thống'),
    DropdownItem(label: 'Nghiên cứu', value: 'Nghiên cứu'),
    DropdownItem(label: 'Tổ chức công việc', value: 'Tổ chức công việc'),
    DropdownItem(label: 'Nhanh nhẹn', value: 'Nhanh nhẹn'),
    DropdownItem(label: 'Cẩn thận', value: 'Cẩn thận'),
    DropdownItem(label: 'Nhiệt tình', value: 'Nhiệt tình'),
    DropdownItem(label: 'Tự tin', value: 'Tự tin'),
    DropdownItem(label: 'Xây dựng mối quan hệ', value: 'Xây dựng mối quan hệ'),
    DropdownItem(label: 'Thiết kế đồ họa', value: 'Thiết kế đồ họa'),
    DropdownItem(label: 'Cởi mở', value: 'Cởi mở'),
    DropdownItem(label: 'Creativity', value: 'Creativity'),
    DropdownItem(label: 'People Management', value: 'People Management'),
    DropdownItem(label: 'Quản lý con người', value: 'Quản lý con người'),
    DropdownItem(label: 'Time Management', value: 'Time Management'),
    DropdownItem(label: 'Persuasion', value: 'Persuasion'),
    DropdownItem(label: 'Khả năng thuyết phục', value: 'Khả năng thuyết phục'),
    DropdownItem(
        label: 'Emotional Intelligence (EQ)',
        value: 'Emotional Intelligence (EQ)'),
    DropdownItem(label: 'Translation', value: 'Translation'),
    DropdownItem(label: 'Video Production', value: 'Video Production'),
    DropdownItem(
        label: 'Corporate Communications', value: 'Corporate Communications'),
    DropdownItem(label: 'Industrial Design', value: 'Industrial Design'),
    DropdownItem(label: 'Collaboration', value: 'Collaboration'),
    DropdownItem(label: 'Adaptability', value: 'Adaptability'),
    DropdownItem(label: 'Analytical Reasoning', value: 'Analytical Reasoning'),
    DropdownItem(label: 'Sales Leadership', value: 'Sales Leadership'),
    DropdownItem(label: 'Journalism', value: 'Journalism'),
    DropdownItem(
        label: 'Competitive Strategies', value: 'Competitive Strategies'),
    DropdownItem(label: 'Active listening', value: 'Active listening'),
    DropdownItem(label: 'Writing', value: 'Writing'),
    DropdownItem(
        label: 'Nonverbal Communication', value: 'Nonverbal Communication'),
    DropdownItem(label: 'Consulting', value: 'Consulting'),
    DropdownItem(label: 'Research', value: 'Research'),
    DropdownItem(label: 'Problem-solving', value: 'Problem-solving'),
    DropdownItem(label: 'Critical Thinking', value: 'Critical Thinking'),
    DropdownItem(label: 'Data Analysis', value: 'Data Analysis'),
    DropdownItem(label: 'SEO/SEM', value: 'SEO/SEM'),
    DropdownItem(label: 'Social Media', value: 'Social Media'),
    DropdownItem(label: 'Media Planning', value: 'Media Planning'),
    DropdownItem(label: 'Channel Marketing', value: 'Channel Marketing'),
    DropdownItem(label: 'Affiliate Marketing', value: 'Affiliate Marketing'),
    DropdownItem(label: 'Online Marketing', value: 'Online Marketing'),
    DropdownItem(label: 'Strategic Planning', value: 'Strategic Planning'),
    DropdownItem(label: 'Delegating Tasks', value: 'Delegating Tasks'),
    DropdownItem(label: 'Coaching', value: 'Coaching'),
    DropdownItem(label: 'Giảng dạy', value: 'Giảng dạy'),
    DropdownItem(label: 'Negotiation', value: 'Negotiation'),
    DropdownItem(label: 'Đàm phán', value: 'Đàm phán'),
    DropdownItem(
        label: 'Relationship Management', value: 'Relationship Management'),
    DropdownItem(label: 'Cloud Computing', value: 'Cloud Computing'),
    DropdownItem(label: 'Data Presentation', value: 'Data Presentation'),
    DropdownItem(label: 'Tech Support', value: 'Tech Support'),
    DropdownItem(label: 'UI/UX', value: 'UI/UX'),
    DropdownItem(label: 'Software Engineering', value: 'Software Engineering'),
    DropdownItem(label: 'Mobile Development', value: 'Mobile Development'),
    DropdownItem(label: 'Scientific Computing', value: 'Scientific Computing'),
    DropdownItem(label: 'Google', value: 'Google'),
    DropdownItem(label: '.NET CLR', value: '.NET CLR'),
    DropdownItem(
        label: '.NET Compact Framework', value: '.NET Compact Framework'),
    DropdownItem(label: '.com', value: '.com'),
    DropdownItem(label: '.htaccess', value: '.htaccess'),
    DropdownItem(label: '10 Key', value: '10 Key'),
    DropdownItem(label: '1031 Exchanges', value: '1031 Exchanges'),
    DropdownItem(label: '1H NMR', value: '1H NMR'),
    DropdownItem(label: '21 CFR', value: '21 CFR'),
    DropdownItem(label: '21 CFR Part 11', value: '21 CFR Part 11'),
    DropdownItem(label: '21st Century Skills', value: '21st Century Skills'),
    DropdownItem(label: '2D graphics', value: '2D graphics'),
    DropdownItem(
        label: '360 Degree Assessment', value: '360 Degree Assessment'),
    DropdownItem(label: '360 Feedback', value: '360 Feedback'),
    DropdownItem(label: '3Com NBX', value: '3Com NBX'),
    DropdownItem(
        label: '3D Architectural Rendering',
        value: '3D Architectural Rendering'),
    DropdownItem(label: '3D GIS', value: '3D GIS'),
    DropdownItem(label: '3D Graphics', value: '3D Graphics'),
    DropdownItem(label: '3D Modeling', value: '3D Modeling'),
    DropdownItem(label: '3D Rendering', value: '3D Rendering'),
    DropdownItem(label: '3D Scanning', value: '3D Scanning'),
    DropdownItem(
        label: '3D Seismic Interpretation', value: '3D Seismic Interpretation'),
    DropdownItem(label: '3D Studio Max', value: '3D Studio Max'),
    DropdownItem(label: '3D Studio Viz', value: '3D Studio Viz'),
    DropdownItem(label: '3D Visualization', value: '3D Visualization'),
    DropdownItem(label: '401k Rollovers', value: '401k Rollovers'),
    DropdownItem(label: '4th Dimension', value: '4th Dimension'),
    DropdownItem(label: '5 Why', value: '5 Why'),
    DropdownItem(label: '5.1 Mixing', value: '5.1 Mixing'),
    DropdownItem(label: '960 Grid System', value: '960 Grid System'),
    DropdownItem(label: '@Task', value: '@Task'),
    DropdownItem(label: 'A-GPS', value: 'A-GPS'),
    DropdownItem(label: 'A3 Thinking', value: 'A3 Thinking'),
    DropdownItem(label: 'AAAHC', value: 'AAAHC'),
    DropdownItem(label: 'AAC', value: 'AAC'),
    DropdownItem(label: 'AACR2', value: 'AACR2'),
    DropdownItem(label: 'AAMS', value: 'AAMS'),
    DropdownItem(label: 'AAP', value: 'AAP'),
    DropdownItem(label: 'AAR', value: 'AAR'),
    DropdownItem(label: 'AASHTO', value: 'AASHTO'),
    DropdownItem(label: 'AAT', value: 'AAT'),
    DropdownItem(
        label: 'AAUS Scientific Diver', value: 'AAUS Scientific Diver'),
    DropdownItem(label: 'ABAP Web Dynpro', value: 'ABAP Web Dynpro'),
    DropdownItem(label: 'ABAP-OO', value: 'ABAP-OO'),
    DropdownItem(label: 'ABB 800xA', value: 'ABB 800xA'),
    DropdownItem(label: 'ABBYY', value: 'ABBYY'),
    DropdownItem(label: 'ABBYY FineReader', value: 'ABBYY FineReader'),
    DropdownItem(label: 'ABC Analysis', value: 'ABC Analysis'),
    DropdownItem(label: 'ABC Flowcharter', value: 'ABC Flowcharter'),
    DropdownItem(label: 'ABCP', value: 'ABCP'),
    DropdownItem(label: 'ABEL', value: 'ABEL'),
    DropdownItem(label: 'ABI', value: 'ABI'),
    DropdownItem(label: 'ABLS', value: 'ABLS'),
    DropdownItem(label: 'ABO Certified', value: 'ABO Certified'),
    DropdownItem(label: 'ABR', value: 'ABR'),
    DropdownItem(label: 'ABS', value: 'ABS'),
    DropdownItem(label: 'ABV', value: 'ABV'),
    DropdownItem(label: 'AC Nielsen', value: 'AC Nielsen'),
    DropdownItem(label: 'ACAD', value: 'ACAD'),
    DropdownItem(label: 'ACBS', value: 'ACBS'),
    DropdownItem(label: 'ACD', value: 'ACD'),
    DropdownItem(label: 'ACD Management', value: 'ACD Management'),
    DropdownItem(label: 'ACDSee', value: 'ACDSee'),
    DropdownItem(label: 'ACE', value: 'ACE'),
    DropdownItem(label: 'ACE Certified', value: 'ACE Certified'),
    DropdownItem(
        label: 'ACE Certified Personal Trainer',
        value: 'ACE Certified Personal Trainer'),
    DropdownItem(label: 'ACF2', value: 'ACF2'),
    DropdownItem(label: 'ACFE', value: 'ACFE'),
    DropdownItem(label: 'ACH', value: 'ACH'),
    DropdownItem(label: 'ACI Codes', value: 'ACI Codes'),
    DropdownItem(label: 'ACIS', value: 'ACIS'),
    DropdownItem(label: 'ACLS', value: 'ACLS'),
    DropdownItem(label: 'ACLS Instruction', value: 'ACLS Instruction'),
    DropdownItem(label: 'ACMS', value: 'ACMS'),
    DropdownItem(label: 'ACOA', value: 'ACOA'),
    DropdownItem(label: 'ACORD', value: 'ACORD'),
    DropdownItem(label: 'ACP', value: 'ACP'),
    DropdownItem(label: 'ACPI', value: 'ACPI'),
    DropdownItem(label: 'ACR', value: 'ACR'),
    DropdownItem(label: 'ACSA', value: 'ACSA'),
    DropdownItem(label: 'ACSC', value: 'ACSC'),
    DropdownItem(label: 'ACSLS', value: 'ACSLS'),
    DropdownItem(label: 'ACSM', value: 'ACSM'),
    DropdownItem(label: 'ACSM Health Fitness', value: 'ACSM Health Fitness'),
    DropdownItem(label: 'ACSP', value: 'ACSP'),
    DropdownItem(label: 'ACSR', value: 'ACSR'),
    DropdownItem(label: 'ACSS', value: 'ACSS'),
    DropdownItem(label: 'ACT CRM', value: 'ACT CRM'),
    DropdownItem(label: 'ADA Compliance', value: 'ADA Compliance'),
    DropdownItem(label: 'ADABAS', value: 'ADABAS'),
    DropdownItem(label: 'ADB', value: 'ADB'),
    DropdownItem(label: 'ADB Adapter', value: 'ADB Adapter'),
    DropdownItem(label: 'ADCs', value: 'ADCs'),
    DropdownItem(label: 'ADDIE', value: 'ADDIE'),
    DropdownItem(label: 'ADDM', value: 'ADDM'),
    DropdownItem(label: 'ADE', value: 'ADE'),
    DropdownItem(label: 'ADEA', value: 'ADEA'),
    DropdownItem(label: 'ADF', value: 'ADF'),
    DropdownItem(label: 'ADFS', value: 'ADFS'),
    DropdownItem(label: 'ADFS 2.0', value: 'ADFS 2.0'),
    DropdownItem(label: 'ADHD Coaching', value: 'ADHD Coaching'),
    DropdownItem(label: 'API 510', value: 'API 510'),
    DropdownItem(label: 'API 653', value: 'API 653'),
    DropdownItem(label: 'API Development', value: 'API Development'),
    DropdownItem(label: 'API Testing', value: 'API Testing'),
    DropdownItem(label: 'ASAP', value: 'ASAP'),
    DropdownItem(label: 'Accountants', value: 'Accountants'),
    DropdownItem(label: 'Accounting', value: 'Accounting'),
    DropdownItem(label: 'Accounts Payable', value: 'Accounts Payable'),
    DropdownItem(label: 'Accounts Receivable', value: 'Accounts Receivable'),
    DropdownItem(
        label: 'Adobe Design Programs', value: 'Adobe Design Programs'),
    DropdownItem(label: 'Agile Environment', value: 'Agile Environment'),
    DropdownItem(label: 'Agile Testing', value: 'Agile Testing'),
    DropdownItem(label: 'Analytical Skills', value: 'Analytical Skills'),
    DropdownItem(
        label: 'Architectural Illustration',
        value: 'Architectural Illustration'),
    DropdownItem(label: 'Aruba Wireless', value: 'Aruba Wireless'),
    DropdownItem(label: 'Basic HTML', value: 'Basic HTML'),
    DropdownItem(label: 'CAPA', value: 'CAPA'),
    DropdownItem(label: 'CNC', value: 'CNC'),
    DropdownItem(label: 'CNC Machine', value: 'CNC Machine'),
    DropdownItem(label: 'CNC Manufacturing', value: 'CNC Manufacturing'),
    DropdownItem(label: 'CNC Programing', value: 'CNC Programing'),
    DropdownItem(
        label: 'CRM Program Management', value: 'CRM Program Management'),
    DropdownItem(label: 'Cache Coherency', value: 'Cache Coherency'),
    DropdownItem(label: 'Cache Object Script', value: 'Cache Object Script'),
    DropdownItem(label: 'Camtasia', value: 'Camtasia'),
    DropdownItem(label: 'Computer Vision', value: 'Computer Vision'),
    DropdownItem(label: 'Core Java', value: 'Core Java'),
    DropdownItem(label: 'Creative Writing', value: 'Creative Writing'),
    DropdownItem(
        label: 'Cross-cultural Communication Skills',
        value: 'Cross-cultural Communication Skills'),
    DropdownItem(label: 'Crypto', value: 'Crypto'),
    DropdownItem(
        label: 'Custom Facebook Pages', value: 'Custom Facebook Pages'),
    DropdownItem(label: 'Customer Service', value: 'Customer Service'),
    DropdownItem(label: 'Dart', value: 'Dart'),
    DropdownItem(
        label: 'Data Backup Solutions', value: 'Data Backup Solutions'),
    DropdownItem(label: 'Data Domain', value: 'Data Domain'),
    DropdownItem(label: 'Database Marketing', value: 'Database Marketing'),
    DropdownItem(label: 'Digital Art', value: 'Digital Art'),
    DropdownItem(label: 'Digital Media', value: 'Digital Media'),
    DropdownItem(label: 'Dreamweaver', value: 'Dreamweaver'),
    DropdownItem(label: 'ERP Software', value: 'ERP Software'),
    DropdownItem(label: 'Excel Pivot', value: 'Excel Pivot'),
    DropdownItem(label: 'FIFO', value: 'FIFO'),
    DropdownItem(label: 'Final Cut Pro', value: 'Final Cut Pro'),
    DropdownItem(label: 'Finance', value: 'Finance'),
    DropdownItem(label: 'Food Quality', value: 'Food Quality'),
    DropdownItem(
        label: 'Foundation Certificate in IT Service Management',
        value: 'Foundation Certificate in IT Service Management'),
    DropdownItem(label: 'Foundation Design', value: 'Foundation Design'),
    DropdownItem(label: 'Front-end', value: 'Front-end'),
    DropdownItem(label: 'GMP', value: 'GMP'),
    DropdownItem(label: 'German Teaching', value: 'German Teaching'),
    DropdownItem(label: 'German Translation', value: 'German Translation'),
    DropdownItem(label: 'Group Purchasing', value: 'Group Purchasing'),
    DropdownItem(label: 'Heroku', value: 'Heroku'),
    DropdownItem(label: 'IT Recruitment', value: 'IT Recruitment'),
    DropdownItem(label: 'Illustration', value: 'Illustration'),
    DropdownItem(
        label: 'Import/Export Operations', value: 'Import/Export Operations'),
    DropdownItem(label: 'InDesign', value: 'InDesign'),
    DropdownItem(label: 'Indirect Purchasing', value: 'Indirect Purchasing'),
    DropdownItem(label: 'Internet Explorer', value: 'Internet Explorer'),
    DropdownItem(label: 'Interviews', value: 'Interviews'),
    DropdownItem(label: 'JMeter', value: 'JMeter'),
    DropdownItem(label: 'JPA', value: 'JPA'),
    DropdownItem(label: 'Java Web Services', value: 'Java Web Services'),
    DropdownItem(label: 'JavaScript Libraries', value: 'JavaScript Libraries'),
    DropdownItem(label: 'Load Testing', value: 'Load Testing'),
    DropdownItem(label: 'Mac OS X Server', value: 'Mac OS X Server'),
    DropdownItem(label: 'Manual Testing', value: 'Manual Testing'),
    DropdownItem(label: 'Microsoft CRM', value: 'Microsoft CRM'),
    DropdownItem(
        label: 'Microsoft Certified Technology',
        value: 'Microsoft Certified Technology'),
    DropdownItem(
        label: 'Microsoft Dynamics AX', value: 'Microsoft Dynamics AX'),
    DropdownItem(label: 'Microsoft Excel', value: 'Microsoft Excel'),
    DropdownItem(
        label: 'Microsoft Technologies', value: 'Microsoft Technologies'),
    DropdownItem(label: 'Microsoft Word', value: 'Microsoft Word'),
    DropdownItem(label: 'Mobile Games', value: 'Mobile Games'),
    DropdownItem(label: 'Mobile Internet', value: 'Mobile Internet'),
    DropdownItem(
        label: 'Motion Graphic Design', value: 'Motion Graphic Design'),
    DropdownItem(label: 'Motion Graphics', value: 'Motion Graphics'),
    DropdownItem(label: 'MySQL Cluster', value: 'MySQL Cluster'),
    DropdownItem(label: 'PHP Applications', value: 'PHP Applications'),
    DropdownItem(label: 'PHP Frameworks', value: 'PHP Frameworks'),
    DropdownItem(label: 'PKCS', value: 'PKCS'),
    DropdownItem(label: 'PTS', value: 'PTS'),
    DropdownItem(label: 'Pdf', value: 'Pdf'),
    DropdownItem(label: 'Premiere', value: 'Premiere'),
    DropdownItem(label: 'Procurement', value: 'Procurement'),
    DropdownItem(label: 'Project Coordination', value: 'Project Coordination'),
    DropdownItem(label: 'Project Purchasing', value: 'Project Purchasing'),
    DropdownItem(
        label: 'Purchasing Negotiation', value: 'Purchasing Negotiation'),
    DropdownItem(label: 'Purchasing Processes', value: 'Purchasing Processes'),
    DropdownItem(label: 'QC Tools', value: 'QC Tools'),
    DropdownItem(label: 'Quality Control', value: 'Quality Control'),
    DropdownItem(label: 'RNO', value: 'RNO'),
    DropdownItem(label: 'Routers', value: 'Routers'),
    DropdownItem(label: 'SAP', value: 'SAP'),
    DropdownItem(label: 'SAP BI', value: 'SAP BI'),
    DropdownItem(label: 'STLC', value: 'STLC'),
    DropdownItem(label: 'Sales Management', value: 'Sales Management'),
    DropdownItem(label: 'Selenium', value: 'Selenium'),
    DropdownItem(label: 'Selenium Testing', value: 'Selenium Testing'),
    DropdownItem(
        label: 'Social Media Marketing', value: 'Social Media Marketing'),
    DropdownItem(label: 'Sony Vegas Video', value: 'Sony Vegas Video'),
    DropdownItem(label: 'Spine', value: 'Spine'),
    DropdownItem(label: 'Spring MVC', value: 'Spring MVC'),
    DropdownItem(label: 'Sumif', value: 'Sumif'),
    DropdownItem(label: 'Tax Accounting', value: 'Tax Accounting'),
    DropdownItem(label: 'User Research', value: 'User Research'),
    DropdownItem(label: 'VPN', value: 'VPN'),
    DropdownItem(label: 'Video Editing', value: 'Video Editing'),
    DropdownItem(label: 'Vray', value: 'Vray'),
    DropdownItem(label: 'WPF', value: 'WPF'),
    DropdownItem(label: 'Wacom Tablet', value: 'Wacom Tablet'),
    DropdownItem(label: 'Wholesale Purchasing', value: 'Wholesale Purchasing'),
    DropdownItem(label: 'WinForms', value: 'WinForms'),
    DropdownItem(label: 'YouTube', value: 'YouTube'),
    // Bỏ mục 805 vì rỗng
    DropdownItem(label: 'ANOVA', value: 'ANOVA'),
    DropdownItem(label: 'ASP.NET MVC', value: 'ASP.NET MVC'),
    DropdownItem(label: 'Academic Development', value: 'Academic Development'),
    DropdownItem(label: 'Academic Editing', value: 'Academic Editing'),
    DropdownItem(label: 'Academic English', value: 'Academic English'),
    DropdownItem(label: 'Account Management', value: 'Account Management'),
    DropdownItem(label: 'Adaptive Learning', value: 'Adaptive Learning'),
    DropdownItem(label: 'Administration', value: 'Administration'),
    DropdownItem(label: 'Advertising Sales', value: 'Advertising Sales'),
    DropdownItem(label: 'After Effects', value: 'After Effects'),
    DropdownItem(label: 'xCAT', value: 'xCAT'),
    DropdownItem(label: 'xCP', value: 'xCP'),
    DropdownItem(label: 'xPC Target', value: 'xPC Target'),
    DropdownItem(label: 'xPON', value: 'xPON'),
    DropdownItem(label: 'xPression', value: 'xPression'),
    DropdownItem(label: 'xUnit', value: 'xUnit'),
    DropdownItem(label: 'zLinux', value: 'zLinux'),
    DropdownItem(label: 'zSeries', value: 'zSeries'),
    DropdownItem(label: 'Giao tiếp', value: 'Giao tiếp'),
    DropdownItem(label: 'Tư duy sáng tạo', value: 'Tư duy sáng tạo'),
    DropdownItem(label: 'Phân tích dữ liệu', value: 'Phân tích dữ liệu'),
    DropdownItem(label: 'Wordpress', value: 'Wordpress'),
    DropdownItem(label: 'Adobe Acrobat', value: 'Adobe Acrobat'),
  ];
  final List<DropdownItem<int>> categoryJobs = [
    DropdownItem(label: 'Kế toán, kiểm toán', value: 1),
    DropdownItem(label: 'Ngân hàng, dịch vụ tài chính', value: 2),
    DropdownItem(label: 'Bán lẻ, tiêu dùng', value: 24),
    DropdownItem(label: 'Bảo hiểm', value: 26),
    DropdownItem(label: 'Bất động sản', value: 12),
    DropdownItem(label: 'Ceo & general management', value: 14),
    DropdownItem(label: 'Chính phủ/Phi lợi nhuận', value: 31),
    DropdownItem(label: 'Công nghệ thông tin/viễn thông', value: 13),
    DropdownItem(label: 'Cung cấp nhân lực', value: 29),
    DropdownItem(label: 'Dệt may/Da giày', value: 17),
    DropdownItem(label: 'Dịch vụ ăn uống', value: 19),
    DropdownItem(label: 'Dịch vụ khách hàng', value: 15),
    DropdownItem(label: 'Dược', value: 28),
    DropdownItem(label: 'Giáo dục', value: 9),
    DropdownItem(label: 'Hành chính văn phòng', value: 3),
    DropdownItem(label: 'Hậu cần/Xuất nhập khẩu/Kho bãi', value: 10),
    DropdownItem(label: 'Khoa học & kỹ thuật', value: 6),
    DropdownItem(label: 'Kiến trúc/xây dựng', value: 8),
    DropdownItem(label: 'Kinh doanh', value: 11),
    DropdownItem(label: 'Kỹ thuật', value: 20),
    DropdownItem(label: 'Nghệ thuật, Truyền thông/in ấn/xuất bản', value: 30),
    DropdownItem(label: 'Nhà hàng - khách sạn/du lịch', value: 16),
    DropdownItem(label: 'Nhân sự/tuyển dụng', value: 7),
    DropdownItem(label: 'Nông/lâm/ngư nghiệp', value: 22),
    DropdownItem(label: 'Pháp lý', value: 18),
    DropdownItem(label: 'Sản xuất', value: 4),
    DropdownItem(label: 'Thiết kế', value: 23),
    DropdownItem(label: 'Tiếp thị, Quảng cáo/truyền thông', value: 5),
    DropdownItem(label: 'Vận tải', value: 27),
    DropdownItem(label: 'Y tế/chăm sóc sức khoẻ', value: 25),
    DropdownItem(label: 'Khác', value: 21),
  ];
  final List<DropdownItem<String>> workingTime = [
    DropdownItem(label: 'Part-time', value: 'Part-time'),
    DropdownItem(label: 'Full-time', value: 'Full-time'),
    DropdownItem(label: 'Remote', value: 'Remote'),
    DropdownItem(label: 'Hybrid', value: 'Hybrid'),
    DropdownItem(label: 'Other', value: 'Other'),
  ];
  final List<DropdownItem<String>> location = [
    DropdownItem(label: 'An Giang', value: 'An Giang'),
    DropdownItem(label: 'Bà Rịa - Vũng Tàu', value: 'Bà Rịa - Vũng Tàu'),
    DropdownItem(label: 'Bắc Giang', value: 'Bắc Giang'),
    DropdownItem(label: 'Bắc Kạn', value: 'Bắc Kạn'),
    DropdownItem(label: 'Bạc Liêu', value: 'Bạc Liêu'),
    DropdownItem(label: 'Bắc Ninh', value: 'Bắc Ninh'),
    DropdownItem(label: 'Bến Tre', value: 'Bến Tre'),
    DropdownItem(label: 'Bình Định', value: 'Bình Định'),
    DropdownItem(label: 'Bình Dương', value: 'Bình Dương'),
    DropdownItem(label: 'Bình Phước', value: 'Bình Phước'),
    DropdownItem(label: 'Bình Thuận', value: 'Bình Thuận'),
    DropdownItem(label: 'Cà Mau', value: 'Cà Mau'),
    DropdownItem(label: 'Cần Thơ', value: 'Cần Thơ'),
    DropdownItem(label: 'Cao Bằng', value: 'Cao Bằng'),
    DropdownItem(label: 'Đà Nẵng', value: 'Đà Nẵng'),
    DropdownItem(label: 'Đắk Lắk', value: 'Đắk Lắk'),
    DropdownItem(label: 'Đắk Nông', value: 'Đắk Nông'),
    DropdownItem(label: 'Điện Biên', value: 'Điện Biên'),
    DropdownItem(label: 'Đồng Nai', value: 'Đồng Nai'),
    DropdownItem(label: 'Đồng Tháp', value: 'Đồng Tháp'),
    DropdownItem(label: 'Gia Lai', value: 'Gia Lai'),
    DropdownItem(label: 'Hà Giang', value: 'Hà Giang'),
    DropdownItem(label: 'Hà Nam', value: 'Hà Nam'),
    DropdownItem(label: 'Hà Nội', value: 'Hà Nội'),
    DropdownItem(label: 'Hà Tĩnh', value: 'Hà Tĩnh'),
    DropdownItem(label: 'Hải Dương', value: 'Hải Dương'),
    DropdownItem(label: 'Hải Phòng', value: 'Hải Phòng'),
    DropdownItem(label: 'Hậu Giang', value: 'Hậu Giang'),
    DropdownItem(label: 'Hòa Bình', value: 'Hòa Bình'),
    DropdownItem(label: 'Hưng Yên', value: 'Hưng Yên'),
    DropdownItem(label: 'Khánh Hòa', value: 'Khánh Hòa'),
    DropdownItem(label: 'Kiên Giang', value: 'Kiên Giang'),
    DropdownItem(label: 'Kon Tum', value: 'Kon Tum'),
    DropdownItem(label: 'Lai Châu', value: 'Lai Châu'),
    DropdownItem(label: 'Lâm Đồng', value: 'Lâm Đồng'),
    DropdownItem(label: 'Lạng Sơn', value: 'Lạng Sơn'),
    DropdownItem(label: 'Lào Cai', value: 'Lào Cai'),
    DropdownItem(label: 'Long An', value: 'Long An'),
    DropdownItem(label: 'Nam Định', value: 'Nam Định'),
    DropdownItem(label: 'Nghệ An', value: 'Nghệ An'),
    DropdownItem(label: 'Ninh Bình', value: 'Ninh Bình'),
    DropdownItem(label: 'Ninh Thuận', value: 'Ninh Thuận'),
    DropdownItem(label: 'Phú Thọ', value: 'Phú Thọ'),
    DropdownItem(label: 'Phú Yên', value: 'Phú Yên'),
    DropdownItem(label: 'Quảng Bình', value: 'Quảng Bình'),
    DropdownItem(label: 'Quảng Nam', value: 'Quảng Nam'),
    DropdownItem(label: 'Quảng Ngãi', value: 'Quảng Ngãi'),
    DropdownItem(label: 'Quảng Ninh', value: 'Quảng Ninh'),
    DropdownItem(label: 'Quảng Trị', value: 'Quảng Trị'),
    DropdownItem(label: 'Sóc Trăng', value: 'Sóc Trăng'),
    DropdownItem(label: 'Sơn La', value: 'Sơn La'),
    DropdownItem(label: 'Tây Ninh', value: 'Tây Ninh'),
    DropdownItem(label: 'Thái Bình', value: 'Thái Bình'),
    DropdownItem(label: 'Thái Nguyên', value: 'Thái Nguyên'),
    DropdownItem(label: 'Thanh Hóa', value: 'Thanh Hóa'),
    DropdownItem(label: 'Thừa Thiên Huế', value: 'Thừa Thiên Huế'),
    DropdownItem(label: 'Tiền Giang', value: 'Tiền Giang'),
    DropdownItem(label: 'TP. Hồ Chí Minh', value: 'TP. Hồ Chí Minh'),
    DropdownItem(label: 'Trà Vinh', value: 'Trà Vinh'),
    DropdownItem(label: 'Tuyên Quang', value: 'Tuyên Quang'),
    DropdownItem(label: 'Vĩnh Long', value: 'Vĩnh Long'),
    DropdownItem(label: 'Vĩnh Phúc', value: 'Vĩnh Phúc'),
    DropdownItem(label: 'Yên Bái', value: 'Yên Bái'),
  ];
  final List<DropdownItem<String>> experience = [
    DropdownItem(label: 'Chưa có kinh nghiệm', value: 'Chưa có kinh nghiệm'),
    DropdownItem(label: 'Dưới 1 năm', value: 'Dưới 1 năm'),
    DropdownItem(label: '1 năm', value: '1 năm'),
    DropdownItem(label: '2 năm', value: '2 năm'),
    DropdownItem(label: '3 năm', value: '3 năm'),
    DropdownItem(label: '4 năm', value: '4 năm'),
    DropdownItem(label: '5 năm', value: '5 năm'),
    DropdownItem(label: 'Trên 5 năm', value: 'Trên 5 năm'),
  ];
  final List<DropdownItem<String>> sampleJobs = [
    DropdownItem(label: 'Chăm sóc khách hàng', value: 'Chăm sóc khách hàng'),
    DropdownItem(
        label: 'Call Center/Trực tổng đài', value: 'Call Center/Trực tổng đài'),
    DropdownItem(label: 'Trực page', value: 'Trực page'),
    DropdownItem(label: 'Customer Success', value: 'Customer Success'),
    DropdownItem(
        label: 'Customer Experience (Trải nghiệm khách hàng)',
        value: 'Customer Experience (Trải nghiệm khách hàng)'),
    DropdownItem(
        label: 'Dịch vụ khách hàng/Chăm sóc khách hàng khác',
        value: 'Dịch vụ khách hàng/Chăm sóc khách hàng khác'),
    DropdownItem(
        label: 'Vận hành Thương mại điện tử',
        value: 'Vận hành Thương mại điện tử'),
    DropdownItem(
        label: 'Vận hành sàn thương mại điện tử',
        value: 'Vận hành sàn thương mại điện tử'),
    DropdownItem(
        label: 'Business Operation (Vận hành kinh doanh)',
        value: 'Business Operation (Vận hành kinh doanh)'),
    DropdownItem(label: 'Vận hành chung', value: 'Vận hành chung'),
    DropdownItem(
        label: 'Data Labeling (Gán nhãn dữ liệu)',
        value: 'Data Labeling (Gán nhãn dữ liệu)'),
    DropdownItem(label: 'Quản lý vận hành', value: 'Quản lý vận hành'),
    DropdownItem(
        label: 'Quản lý/Trưởng phòng vận hành',
        value: 'Quản lý/Trưởng phòng vận hành'),
    DropdownItem(
        label: 'Giám đốc vận hành/COO', value: 'Giám đốc vận hành/COO'),
    DropdownItem(
        label: 'Giám đốc dịch vụ khách hàng',
        value: 'Giám đốc dịch vụ khách hàng'),
    DropdownItem(
        label: 'Dịch vụ khách hàng/Vận hành khác',
        value: 'Dịch vụ khách hàng/Vận hành khác'),
    DropdownItem(
        label: 'Chuyên môn Dịch vụ khách hàng/Vận hành khác',
        value: 'Chuyên môn Dịch vụ khách hàng/Vận hành khác'),
    DropdownItem(
        label: 'Sales Xuất nhập khẩu/Logistics',
        value: 'Sales Xuất nhập khẩu/Logistics'),
    DropdownItem(label: 'Sales Logistics', value: 'Sales Logistics'),
    DropdownItem(
        label: 'Sales Xuất nhập khẩu/Logistics khác',
        value: 'Sales Xuất nhập khẩu/Logistics khác'),
    DropdownItem(
        label: 'Sales Bất động sản/Xây dựng',
        value: 'Sales Bất động sản/Xây dựng'),
    DropdownItem(
        label: 'Sales bất động sản/Môi giới bất động sản',
        value: 'Sales bất động sản/Môi giới bất động sản'),
    DropdownItem(
        label: 'Kinh doanh thiết bị/vật liệu xây dựng',
        value: 'Kinh doanh thiết bị/vật liệu xây dựng'),
    DropdownItem(label: 'Kinh doanh nội thất', value: 'Kinh doanh nội thất'),
    DropdownItem(
        label: 'Sales Bất động sản/Xây dựng khác',
        value: 'Sales Bất động sản/Xây dựng khác'),
    DropdownItem(
        label: 'Sales Giáo dục/Khoá học', value: 'Sales Giáo dục/Khoá học'),
    DropdownItem(
        label: 'Tư vấn tuyển sinh/khoá học',
        value: 'Tư vấn tuyển sinh/khoá học'),
    DropdownItem(label: 'Tư vấn du học', value: 'Tư vấn du học'),
    DropdownItem(
        label: 'Sales Giáo dục/Khoá học khác',
        value: 'Sales Giáo dục/Khoá học khác'),
    DropdownItem(
        label: 'Sales Admin/Sales Support', value: 'Sales Admin/Sales Support'),
    DropdownItem(
        label: 'Sales Admin/Sales Support/Sales Associate',
        value: 'Sales Admin/Sales Support/Sales Associate'),
    DropdownItem(label: 'Chuyên viên đấu thầu', value: 'Chuyên viên đấu thầu'),
    DropdownItem(label: 'Vận hành Livestream', value: 'Vận hành Livestream'),
    DropdownItem(
        label: 'Sales Tài chính/Ngân hàng/Bảo hiểm',
        value: 'Sales Tài chính/Ngân hàng/Bảo hiểm'),
    DropdownItem(label: 'Tư vấn bảo hiểm', value: 'Tư vấn bảo hiểm'),
    DropdownItem(
        label: 'Quan hệ khách hàng cá nhân/doanh nghiệp',
        value: 'Quan hệ khách hàng cá nhân/doanh nghiệp'),
    DropdownItem(label: 'Tư vấn trả góp', value: 'Tư vấn trả góp'),
    DropdownItem(label: 'Tư vấn tín dụng', value: 'Tư vấn tín dụng'),
    DropdownItem(label: 'Bancassurance', value: 'Bancassurance'),
    DropdownItem(label: 'Tư vấn đầu tư', value: 'Tư vấn đầu tư'),
    DropdownItem(label: 'Tư vấn chứng khoán', value: 'Tư vấn chứng khoán'),
    DropdownItem(
        label: 'Kinh doanh ngoại hối, vàng, phái sinh',
        value: 'Kinh doanh ngoại hối, vàng, phái sinh'),
    DropdownItem(label: 'Tư vấn tài chính', value: 'Tư vấn tài chính'),
    DropdownItem(
        label: 'Sales Tài chính/Ngân hàng/Bảo hiểm khác',
        value: 'Sales Tài chính/Ngân hàng/Bảo hiểm khác'),
    DropdownItem(
        label: 'Sales Bán lẻ/Dịch vụ tiêu dùng',
        value: 'Sales Bán lẻ/Dịch vụ tiêu dùng'),
    DropdownItem(label: 'Kinh doanh kênh MT', value: 'Kinh doanh kênh MT'),
    DropdownItem(label: 'Kinh doanh kênh GT', value: 'Kinh doanh kênh GT'),
    DropdownItem(
        label: 'Bán hàng siêu thị/cửa hàng tiện ích/tiện lợi',
        value: 'Bán hàng siêu thị/cửa hàng tiện ích/tiện lợi'),
    DropdownItem(label: 'Bán hàng điện thoại', value: 'Bán hàng điện thoại'),
    DropdownItem(label: 'Bán hàng điện máy', value: 'Bán hàng điện máy'),
    DropdownItem(label: 'Bán hàng thời trang', value: 'Bán hàng thời trang'),
    DropdownItem(
        label: 'Bán hàng trang sức đá quý', value: 'Bán hàng trang sức đá quý'),
    DropdownItem(label: 'Bán hàng mỹ phẩm', value: 'Bán hàng mỹ phẩm'),
    DropdownItem(label: 'Kinh doanh thực phẩm', value: 'Kinh doanh thực phẩm'),
    DropdownItem(label: 'Kinh doanh bao bì', value: 'Kinh doanh bao bì'),
    DropdownItem(label: 'Sales thẻ tập', value: 'Sales thẻ tập'),
    DropdownItem(
        label: 'Sales Bán lẻ/Dịch vụ tiêu dùng khác',
        value: 'Sales Bán lẻ/Dịch vụ tiêu dùng khác'),
    DropdownItem(label: 'Sales Sản xuất', value: 'Sales Sản xuất'),
    DropdownItem(label: 'Kinh doanh hoá chất', value: 'Kinh doanh hoá chất'),
    DropdownItem(
        label: 'Kinh doanh ô tô/xe máy/xe điện',
        value: 'Kinh doanh ô tô/xe máy/xe điện'),
    DropdownItem(
        label: 'Kinh doanh phụ tùng ô tô/xe máy/xe điện',
        value: 'Kinh doanh phụ tùng ô tô/xe máy/xe điện'),
    DropdownItem(label: 'Sales Sản xuất khác', value: 'Sales Sản xuất khác'),
    DropdownItem(
        label: 'Sales Kỹ thuật (Sales Engineer)',
        value: 'Sales Kỹ thuật (Sales Engineer)'),
    DropdownItem(
        label: 'Bán hàng kỹ thuật Điện/Điện tử/Viễn thông',
        value: 'Bán hàng kỹ thuật Điện/Điện tử/Viễn thông'),
    DropdownItem(
        label: 'Bán hàng kỹ thuật cơ khí', value: 'Bán hàng kỹ thuật cơ khí'),
    DropdownItem(label: 'Bán hàng kỹ thuật IT', value: 'Bán hàng kỹ thuật IT'),
    DropdownItem(label: 'Sales Kỹ thuật khác', value: 'Sales Kỹ thuật khác'),
    DropdownItem(
        label: 'Sales Nhà hàng/Khách sạn/Du lịch',
        value: 'Sales Nhà hàng/Khách sạn/Du lịch'),
    DropdownItem(label: 'Kinh doanh HORECA', value: 'Kinh doanh HORECA'),
    DropdownItem(
        label: 'Sales Tour/Kinh doanh du lịch',
        value: 'Sales Tour/Kinh doanh du lịch'),
    DropdownItem(
        label: 'Kinh doanh khách đoàn (MICE)',
        value: 'Kinh doanh khách đoàn (MICE)'),
    DropdownItem(
        label: 'Bán vé máy bay (Ticketing/Booker)',
        value: 'Bán vé máy bay (Ticketing/Booker)'),
    DropdownItem(label: 'Kinh doanh khách sạn', value: 'Kinh doanh khách sạn'),
    DropdownItem(label: 'Kinh doanh OTA', value: 'Kinh doanh OTA'),
    DropdownItem(
        label: 'Sales Nhà hàng/Khách sạn/Du lịch khác',
        value: 'Sales Nhà hàng/Khách sạn/Du lịch khác'),
    DropdownItem(
        label: 'Sales Dược/Y tế/Sức khoẻ/Làm đẹp',
        value: 'Sales Dược/Y tế/Sức khoẻ/Làm đẹp'),
    DropdownItem(
        label: 'Kinh doanh thiết bị/vật tư y tế',
        value: 'Kinh doanh thiết bị/vật tư y tế'),
    DropdownItem(label: 'Trình dược viên', value: 'Trình dược viên'),
    DropdownItem(label: 'Dược sĩ/Bán thuốc', value: 'Dược sĩ/Bán thuốc'),
    DropdownItem(label: 'Tư vấn thẩm mỹ/Spa', value: 'Tư vấn thẩm mỹ/Spa'),
    DropdownItem(label: 'Tư vấn nha khoa', value: 'Tư vấn nha khoa'),
    DropdownItem(
        label: 'Kinh doanh dịch vụ y tế', value: 'Kinh doanh dịch vụ y tế'),
    DropdownItem(
        label: 'Sales Dược/Y tế/Sức khoẻ/Làm đẹp khác',
        value: 'Sales Dược/Y tế/Sức khoẻ/Làm đẹp khác'),
    DropdownItem(label: 'Sales IT Phần mềm', value: 'Sales IT Phần mềm'),
    DropdownItem(label: 'Kinh doanh phần mềm', value: 'Kinh doanh phần mềm'),
    DropdownItem(
        label: 'Kinh doanh Domain/Hosting/Server',
        value: 'Kinh doanh Domain/Hosting/Server'),
    DropdownItem(
        label: 'Sales IT Phần mềm khác', value: 'Sales IT Phần mềm khác'),
    DropdownItem(
        label: 'Sales Điện/Điện tử/Viễn thông',
        value: 'Sales Điện/Điện tử/Viễn thông'),
    DropdownItem(
        label: 'Kinh doanh thiết bị/linh kiện điện',
        value: 'Kinh doanh thiết bị/linh kiện điện'),
    DropdownItem(
        label: 'Kinh doanh thiết bị công nghiệp',
        value: 'Kinh doanh thiết bị công nghiệp'),
    DropdownItem(
        label: 'Kinh doanh dịch vụ viễn thông',
        value: 'Kinh doanh dịch vụ viễn thông'),
    DropdownItem(
        label: 'Kinh doanh điện mặt trời', value: 'Kinh doanh điện mặt trời'),
    DropdownItem(label: 'Kinh doanh HVAC', value: 'Kinh doanh HVAC'),
    DropdownItem(
        label: 'Sales Điện/Điện tử/Viễn thông khác',
        value: 'Sales Điện/Điện tử/Viễn thông khác'),
    DropdownItem(
        label: 'Sales dịch vụ Quảng cáo/Triển lãm/Sự kiện',
        value: 'Sales dịch vụ Quảng cáo/Triển lãm/Sự kiện'),
    DropdownItem(
        label: 'Kinh doanh dịch vụ quảng cáo',
        value: 'Kinh doanh dịch vụ quảng cáo'),
    DropdownItem(label: 'Kinh doanh triển lãm', value: 'Kinh doanh triển lãm'),
    DropdownItem(
        label: 'Kinh doanh tiệc/sự kiện/hội nghị',
        value: 'Kinh doanh tiệc/sự kiện/hội nghị'),
    DropdownItem(
        label: 'Kinh doanh mảng Nhà tài trợ',
        value: 'Kinh doanh mảng Nhà tài trợ'),
    DropdownItem(
        label: 'Sales dịch vụ Quảng cáo/Triển lãm/Sự kiện khác',
        value: 'Sales dịch vụ Quảng cáo/Triển lãm/Sự kiện khác'),
    DropdownItem(label: 'Sales Marketing', value: 'Sales Marketing'),
    DropdownItem(
        label: 'Sales Thương mại điện tử', value: 'Sales Thương mại điện tử'),
    DropdownItem(
        label: 'Kinh doanh sàn thương mại điện tử',
        value: 'Kinh doanh sàn thương mại điện tử'),
    DropdownItem(label: 'Quản lý kinh doanh', value: 'Quản lý kinh doanh'),
    DropdownItem(
        label: 'Sales Manager/Trưởng phòng kinh doanh',
        value: 'Sales Manager/Trưởng phòng kinh doanh'),
    DropdownItem(
        label: 'Sales Supervisor/Giám sát bán hàng',
        value: 'Sales Supervisor/Giám sát bán hàng'),
    DropdownItem(
        label: 'ASM/Quản lý khu vực/vùng miền',
        value: 'ASM/Quản lý khu vực/vùng miền'),
    DropdownItem(
        label: 'Quản lý cửa hàng/Cửa hàng trưởng',
        value: 'Quản lý cửa hàng/Cửa hàng trưởng'),
    DropdownItem(
        label: 'Sales Director/Giám đốc kinh doanh',
        value: 'Sales Director/Giám đốc kinh doanh'),
    DropdownItem(
        label: 'Chief Customer Officer (CCO)',
        value: 'Chief Customer Officer (CCO)'),
    DropdownItem(
        label: 'Chuyên viên chính sách kinh doanh',
        value: 'Chuyên viên chính sách kinh doanh'),
    DropdownItem(
        label: 'Quản lý Kinh doanh khác', value: 'Quản lý Kinh doanh khác'),
    DropdownItem(
        label: 'Kinh doanh/Bán hàng khác', value: 'Kinh doanh/Bán hàng khác'),
    DropdownItem(label: 'Kinh doanh nông sản', value: 'Kinh doanh nông sản'),
    DropdownItem(label: 'Account Executive', value: 'Account Executive'),
    DropdownItem(
        label: 'Account Manager (Quản lý khách hàng)',
        value: 'Account Manager (Quản lý khách hàng)'),
    DropdownItem(
        label: 'Sales Representative/Phát triển kinh doanh',
        value: 'Sales Representative/Phát triển kinh doanh'),
    DropdownItem(label: 'Trợ lý kinh doanh', value: 'Trợ lý kinh doanh'),
    DropdownItem(
        label: 'Sales Dịch vụ kế toán', value: 'Sales Dịch vụ kế toán'),
    DropdownItem(
        label: 'Chuyên môn Kinh doanh/Bán hàng khác',
        value: 'Chuyên môn Kinh doanh/Bán hàng khác'),
    DropdownItem(label: 'Marketing', value: 'Marketing'),
    DropdownItem(label: 'Digital Marketing', value: 'Digital Marketing'),
    DropdownItem(label: 'Content Marketing', value: 'Content Marketing'),
    DropdownItem(label: 'Copywriter', value: 'Copywriter'),
    DropdownItem(label: 'Content Creator', value: 'Content Creator'),
    DropdownItem(label: 'TikTok Content', value: 'TikTok Content'),
    DropdownItem(label: 'Social Content', value: 'Social Content'),
    DropdownItem(label: 'SEO', value: 'SEO'),
    DropdownItem(label: 'Email Marketing', value: 'Email Marketing'),
    DropdownItem(label: 'Social Media', value: 'Social Media'),
    DropdownItem(label: 'Affiliate Marketing', value: 'Affiliate Marketing'),
    DropdownItem(label: 'In-bound Marketing', value: 'In-bound Marketing'),
    DropdownItem(label: 'Growth Hacker', value: 'Growth Hacker'),
    DropdownItem(label: 'Google Ads', value: 'Google Ads'),
    DropdownItem(label: 'Facebook Ads', value: 'Facebook Ads'),
    DropdownItem(
        label: 'Host Livestream/Streamer', value: 'Host Livestream/Streamer'),
    DropdownItem(label: 'Chuyên môn Marketing', value: 'Chuyên môn Marketing'),
    DropdownItem(label: 'Marketing Planner', value: 'Marketing Planner'),
    DropdownItem(label: 'Brand Marketing', value: 'Brand Marketing'),
    DropdownItem(label: 'Product Marketing', value: 'Product Marketing'),
    DropdownItem(label: 'Trade Marketing', value: 'Trade Marketing'),
    DropdownItem(label: 'Event Marketing', value: 'Event Marketing'),
    DropdownItem(label: 'KOL/KOC Manager', value: 'KOL/KOC Manager'),
    DropdownItem(label: 'Global Marketing', value: 'Global Marketing'),
    DropdownItem(label: 'Marketing Manager', value: 'Marketing Manager'),
    DropdownItem(label: 'Marketing Director', value: 'Marketing Director'),
    DropdownItem(
        label: 'Giám đốc Marketing (CMO)', value: 'Giám đốc Marketing (CMO)'),
    DropdownItem(label: 'Marketing Admin', value: 'Marketing Admin'),
    DropdownItem(label: 'Marketing Operations', value: 'Marketing Operations'),
    DropdownItem(label: 'Quảng cáo/Sáng tạo', value: 'Quảng cáo/Sáng tạo'),
    DropdownItem(label: 'Campaign Manager', value: 'Campaign Manager'),
    DropdownItem(
        label: 'Media Planner/Buyer Executive',
        value: 'Media Planner/Buyer Executive'),
    DropdownItem(
        label: 'Media Placement Specialist',
        value: 'Media Placement Specialist'),
    DropdownItem(label: 'Creative Planner', value: 'Creative Planner'),
    DropdownItem(label: 'Production Manager', value: 'Production Manager'),
    DropdownItem(
        label: 'Ad Operations Manager', value: 'Ad Operations Manager'),
    DropdownItem(label: 'Kiểm duyệt quảng cáo', value: 'Kiểm duyệt quảng cáo'),
    DropdownItem(label: 'Creative Director', value: 'Creative Director'),
    DropdownItem(label: 'Art Director', value: 'Art Director'),
    DropdownItem(
        label: 'Photographer/Video Editor', value: 'Photographer/Video Editor'),
    DropdownItem(
        label: 'Thiết kế đồ họa (Graphic Design)',
        value: 'Thiết kế đồ họa (Graphic Design)'),
    DropdownItem(label: 'Illustration', value: 'Illustration'),
    DropdownItem(label: 'Animation Design', value: 'Animation Design'),
    DropdownItem(label: '3D Modeler', value: '3D Modeler'),
    DropdownItem(
        label: 'Chuyên môn Quảng cáo/Sáng tạo khác',
        value: 'Chuyên môn Quảng cáo/Sáng tạo khác'),
    DropdownItem(
        label: 'Quan hệ Công chúng (PR)', value: 'Quan hệ Công chúng (PR)'),
    DropdownItem(
        label: 'Chuyên môn Quan hệ Công chúng',
        value: 'Chuyên môn Quan hệ Công chúng'),
    DropdownItem(label: 'PR Specialist', value: 'PR Specialist'),
    DropdownItem(label: 'Quan hệ báo chí', value: 'Quan hệ báo chí'),
    DropdownItem(
        label: 'Xử lý khủng hoảng truyền thông',
        value: 'Xử lý khủng hoảng truyền thông'),
    DropdownItem(
        label: 'Corporate Communication', value: 'Corporate Communication'),
    DropdownItem(
        label: 'Xây dựng và bảo vệ thương hiệu',
        value: 'Xây dựng và bảo vệ thương hiệu'),
    DropdownItem(label: 'Truyền thông nội bộ', value: 'Truyền thông nội bộ'),
    DropdownItem(label: 'Phát triển cộng đồng', value: 'Phát triển cộng đồng'),
    DropdownItem(label: 'Quan hệ Chính phủ', value: 'Quan hệ Chính phủ'),
    DropdownItem(
        label: 'Chuyên môn Quan hệ chính phủ',
        value: 'Chuyên môn Quan hệ chính phủ'),
    DropdownItem(label: 'Quan hệ đối ngoại', value: 'Quan hệ đối ngoại'),
    DropdownItem(label: 'Hợp tác quốc tế', value: 'Hợp tác quốc tế'),
    DropdownItem(
        label: 'Public Affairs Manager', value: 'Public Affairs Manager'),
    DropdownItem(
        label: 'Nghiên cứu chính sách', value: 'Nghiên cứu chính sách'),
    DropdownItem(
        label: 'Goverment Affairs Manager', value: 'Goverment Affairs Manager'),
    DropdownItem(label: 'Vận động hành lang', value: 'Vận động hành lang'),
    DropdownItem(label: 'Pháp chế', value: 'Pháp chế'),
    DropdownItem(
        label: 'Market Research and Analysis',
        value: 'Market Research and Analysis'),
    DropdownItem(
        label: 'Nghiên cứu thị trường (Market Research)',
        value: 'Nghiên cứu thị trường (Market Research)'),
    DropdownItem(
        label: 'Business Intelligence', value: 'Business Intelligence'),
    DropdownItem(label: 'Quantitative Analyst', value: 'Quantitative Analyst'),
    DropdownItem(label: 'Data Analyst', value: 'Data Analyst'),
    DropdownItem(
        label: 'Chuyên môn Market Research and Analysis khác',
        value: 'Chuyên môn Market Research and Analysis khác'),
    DropdownItem(
        label: 'Marketing/PR/Quảng cáo khác',
        value: 'Marketing/PR/Quảng cáo khác'),
    DropdownItem(
        label:
            'Vendor Management Executive/Supplier Relationship Management Executive',
        value:
            'Vendor Management Executive/Supplier Relationship Management Executive'),
    DropdownItem(
        label: 'Nhân viên phát tờ rơi', value: 'Nhân viên phát tờ rơi'),
    DropdownItem(label: 'PG', value: 'PG'),
    DropdownItem(
        label: 'Chuyên môn Marketing/PR/Quảng cáo khác',
        value: 'Chuyên môn Marketing/PR/Quảng cáo khác'),
    DropdownItem(label: 'Nhân sự', value: 'Nhân sự'),
    DropdownItem(label: 'Tuyển dụng', value: 'Tuyển dụng'),
    DropdownItem(
        label: 'Đối tác nhân sự (HRBP)', value: 'Đối tác nhân sự (HRBP)'),
    DropdownItem(label: 'Đào tạo', value: 'Đào tạo'),
    DropdownItem(label: 'Quan hệ lao động', value: 'Quan hệ lao động'),
    DropdownItem(label: 'Phát triển tổ chức', value: 'Phát triển tổ chức'),
    DropdownItem(
        label: 'Chuyên viên phát triển văn hóa doanh nghiệp',
        value: 'Chuyên viên phát triển văn hóa doanh nghiệp'),
    DropdownItem(
        label: 'Payroll/C&B (Lương/Thưởng/Phúc lợi)',
        value: 'Payroll/C&B (Lương/Thưởng/Phúc lợi)'),
    DropdownItem(label: 'Nhân sự tổng hợp', value: 'Nhân sự tổng hợp'),
    DropdownItem(label: 'Trưởng phòng nhân sự', value: 'Trưởng phòng nhân sự'),
    DropdownItem(label: 'Giám đốc nhân sự', value: 'Giám đốc nhân sự'),
    DropdownItem(
        label: 'Chuyên môn Nhân sự khác', value: 'Chuyên môn Nhân sự khác'),
    DropdownItem(label: 'Hành chính', value: 'Hành chính'),
    DropdownItem(label: 'Hành chính nhân sự', value: 'Hành chính nhân sự'),
    DropdownItem(label: 'Hành chính tổng hợp', value: 'Hành chính tổng hợp'),
    DropdownItem(
        label: 'Trưởng phòng hành chính', value: 'Trưởng phòng hành chính'),
    DropdownItem(label: 'Giám đốc hành chính', value: 'Giám đốc hành chính'),
    DropdownItem(label: 'Giám đốc điều hành', value: 'Giám đốc điều hành'),
    DropdownItem(label: 'Lễ tân/Đón tiếp', value: 'Lễ tân/Đón tiếp'),
    DropdownItem(label: 'Văn thư', value: 'Văn thư'),
    DropdownItem(
        label: 'Quản lý cơ sở vật chất', value: 'Quản lý cơ sở vật chất'),
    DropdownItem(label: 'Lái xe văn phòng', value: 'Lái xe văn phòng'),
    DropdownItem(label: 'Lái xe cho sếp', value: 'Lái xe cho sếp'),
    DropdownItem(label: 'Trợ lý/Thư ký', value: 'Trợ lý/Thư ký'),
    DropdownItem(
        label: 'Project Administrator', value: 'Project Administrator'),
    DropdownItem(label: 'Xử lý hồ sơ', value: 'Xử lý hồ sơ'),
    DropdownItem(label: 'Chuyên viên hợp đồng', value: 'Chuyên viên hợp đồng'),
    DropdownItem(
        label: 'Chuyên môn Hành chính khác',
        value: 'Chuyên môn Hành chính khác'),
    DropdownItem(
        label: 'Dịch vụ pháp chế (In-house)',
        value: 'Dịch vụ pháp chế (In-house)'),
    DropdownItem(label: 'Giám đốc pháp chế', value: 'Giám đốc pháp chế'),
    DropdownItem(
        label: 'Chuyên môn Pháp chế khác', value: 'Chuyên môn Pháp chế khác'),
    DropdownItem(
        label: 'Nhân sự/Hành chính/Pháp chế khác',
        value: 'Nhân sự/Hành chính/Pháp chế khác'),
    DropdownItem(
        label: 'Chuyên môn Nhân sự/Hành chính/Pháp chế khác',
        value: 'Chuyên môn Nhân sự/Hành chính/Pháp chế khác'),
    DropdownItem(label: 'Software Engineering', value: 'Software Engineering'),
    DropdownItem(label: 'Software Engineer', value: 'Software Engineer'),
    DropdownItem(label: 'Backend Developer', value: 'Backend Developer'),
    DropdownItem(label: 'Frontend Developer', value: 'Frontend Developer'),
    DropdownItem(label: 'Mobile Developer', value: 'Mobile Developer'),
    DropdownItem(label: 'Fullstack Developer', value: 'Fullstack Developer'),
    DropdownItem(label: 'Blockchain Engineer', value: 'Blockchain Engineer'),
    DropdownItem(label: 'Software Testing', value: 'Software Testing'),
    DropdownItem(
        label: 'Software Tester (Automation & Manual)',
        value: 'Software Tester (Automation & Manual)'),
    DropdownItem(label: 'Automation Tester', value: 'Automation Tester'),
    DropdownItem(label: 'Manual Tester', value: 'Manual Tester'),
    DropdownItem(label: 'Game Tester', value: 'Game Tester'),
    DropdownItem(label: 'QA Engineer', value: 'QA Engineer'),
    DropdownItem(
        label: 'Process Quality Assurance (PQA)',
        value: 'Process Quality Assurance (PQA)'),
    DropdownItem(
        label: 'Artificial Intelligence (AI)',
        value: 'Artificial Intelligence (AI)'),
    DropdownItem(label: 'AI Engineer', value: 'AI Engineer'),
    DropdownItem(label: 'AI Researcher', value: 'AI Researcher'),
    DropdownItem(label: 'Data Science', value: 'Data Science'),
    DropdownItem(label: 'Data Engineer', value: 'Data Engineer'),
    DropdownItem(label: 'Data Scientist', value: 'Data Scientist'),
    DropdownItem(
        label: 'IT Infrastructure and Operations',
        value: 'IT Infrastructure and Operations'),
    DropdownItem(
        label: 'IT Helpdesk/IT support', value: 'IT Helpdesk/IT support'),
    DropdownItem(label: 'DevOps Engineer', value: 'DevOps Engineer'),
    DropdownItem(label: 'Network Engineer', value: 'Network Engineer'),
    DropdownItem(label: 'System Engineer', value: 'System Engineer'),
    DropdownItem(label: 'System Administrator', value: 'System Administrator'),
    DropdownItem(
        label: 'Database Administrator (DBA)',
        value: 'Database Administrator (DBA)'),
    DropdownItem(label: 'Cloud Engineer', value: 'Cloud Engineer'),
    DropdownItem(label: 'Kỹ thuật IT', value: 'Kỹ thuật IT'),
    DropdownItem(label: 'Information Security', value: 'Information Security'),
    DropdownItem(
        label: 'Chuyên viên Cyber Security',
        value: 'Chuyên viên Cyber Security'),
    DropdownItem(
        label: 'Chuyên viên IT Security', value: 'Chuyên viên IT Security'),
    DropdownItem(
        label: 'Chiến lược và phân tích bảo mật',
        value: 'Chiến lược và phân tích bảo mật'),
    DropdownItem(
        label: 'Quản trị và vận hành bảo mật',
        value: 'Quản trị và vận hành bảo mật'),
    DropdownItem(
        label: 'Tuân thủ và kiểm toán bảo mật',
        value: 'Tuân thủ và kiểm toán bảo mật'),
    DropdownItem(
        label: 'Phòng chống lừa đảo và an ninh mạng',
        value: 'Phòng chống lừa đảo và an ninh mạng'),
    DropdownItem(
        label: 'Bảo mật ứng dụng và phát triển',
        value: 'Bảo mật ứng dụng và phát triển'),
    DropdownItem(
        label: 'Mã hóa và bảo mật dữ liệu', value: 'Mã hóa và bảo mật dữ liệu'),
    DropdownItem(
        label: 'Kiểm thử và đánh giá bảo mật',
        value: 'Kiểm thử và đánh giá bảo mật'),
    DropdownItem(
        label: 'IoT/Embedded Engineer', value: 'IoT/Embedded Engineer'),
    DropdownItem(
        label: 'Kỹ sư IoT (IoT Engineer)', value: 'Kỹ sư IoT (IoT Engineer)'),
    DropdownItem(
        label: 'Embedded Engineer/Lập trình nhúng',
        value: 'Embedded Engineer/Lập trình nhúng'),
    DropdownItem(
        label: 'IT Project Management', value: 'IT Project Management'),
    DropdownItem(label: 'IT Project Manager', value: 'IT Project Manager'),
    DropdownItem(label: 'Scrum Master', value: 'Scrum Master'),
    DropdownItem(label: 'Kỹ sư cầu nối BrSE', value: 'Kỹ sư cầu nối BrSE'),
    DropdownItem(label: 'IT Comtor', value: 'IT Comtor'),
    DropdownItem(
        label: 'IT Management/Specialist', value: 'IT Management/Specialist'),
    DropdownItem(label: 'Software Architect', value: 'Software Architect'),
    DropdownItem(label: 'System Architect', value: 'System Architect'),
    DropdownItem(label: 'Solution Architect', value: 'Solution Architect'),
    DropdownItem(label: 'Technical Leader', value: 'Technical Leader'),
    DropdownItem(label: 'Technical Manager', value: 'Technical Manager'),
    DropdownItem(label: 'Head of Engineering', value: 'Head of Engineering'),
    DropdownItem(label: 'Technical Director', value: 'Technical Director'),
    DropdownItem(
        label: 'Chief Technology Officer (CTO)',
        value: 'Chief Technology Officer (CTO)'),
    DropdownItem(
        label: 'Chief Information Officer (CIO)',
        value: 'Chief Information Officer (CIO)'),
    DropdownItem(label: 'Software Design', value: 'Software Design'),
    DropdownItem(label: 'UI/UX Design', value: 'UI/UX Design'),
    DropdownItem(label: 'Interaction Designer', value: 'Interaction Designer'),
    DropdownItem(label: 'Product Management', value: 'Product Management'),
    DropdownItem(
        label: 'Product Owner/Product Manager',
        value: 'Product Owner/Product Manager'),
    DropdownItem(
        label: 'Business Analyst (Phân tích nghiệp vụ)',
        value: 'Business Analyst (Phân tích nghiệp vụ)'),
    DropdownItem(
        label: 'Product Analyst/Research', value: 'Product Analyst/Research'),
    DropdownItem(label: 'Game Development', value: 'Game Development'),
    DropdownItem(label: 'Game Developer', value: 'Game Developer'),
    DropdownItem(label: 'Concept Artist', value: 'Concept Artist'),
    DropdownItem(label: 'Game Design', value: 'Game Design'),
    DropdownItem(label: 'AR/VR Developer', value: 'AR/VR Developer'),
    DropdownItem(
        label: 'Vị trí Game Development khác',
        value: 'Vị trí Game Development khác'),
    DropdownItem(
        label: 'Công nghệ thông tin khác', value: 'Công nghệ thông tin khác'),
    DropdownItem(label: 'IT Consultant', value: 'IT Consultant'),
    DropdownItem(label: 'GIS Engineer', value: 'GIS Engineer'),
    DropdownItem(label: 'BIM Engineer', value: 'BIM Engineer'),
    DropdownItem(
        label: 'Chuyên môn Công nghệ thông tin khác',
        value: 'Chuyên môn Công nghệ thông tin khác'),
    DropdownItem(label: 'Tài chính', value: 'Tài chính'),
    DropdownItem(label: 'Chuyên môn Tài chính', value: 'Chuyên môn Tài chính'),
    DropdownItem(label: 'Hoạch định tài chính', value: 'Hoạch định tài chính'),
    DropdownItem(label: 'Định chế tài chính', value: 'Định chế tài chính'),
    DropdownItem(
        label: 'Kiểm soát và báo cáo tài chính',
        value: 'Kiểm soát và báo cáo tài chính'),
    DropdownItem(label: 'Giám đốc tài chính', value: 'Giám đốc tài chính'),
    DropdownItem(label: 'Huy động vốn', value: 'Huy động vốn'),
    DropdownItem(label: 'Ngân hàng', value: 'Ngân hàng'),
    DropdownItem(label: 'Giao dịch viên', value: 'Giao dịch viên'),
    DropdownItem(label: 'Chuyên viên xử lý nợ', value: 'Chuyên viên xử lý nợ'),
    DropdownItem(label: 'Kinh doanh nguồn vốn', value: 'Kinh doanh nguồn vốn'),
    DropdownItem(label: 'Tài trợ thương mại', value: 'Tài trợ thương mại'),
    DropdownItem(
        label: 'Giám đốc khối khách hàng cá nhân',
        value: 'Giám đốc khối khách hàng cá nhân'),
    DropdownItem(
        label: 'Giám đốc khối khách hàng doanh nghiệp',
        value: 'Giám đốc khối khách hàng doanh nghiệp'),
    DropdownItem(
        label: 'Giám đốc khối nguồn vốn và thị trường',
        value: 'Giám đốc khối nguồn vốn và thị trường'),
    DropdownItem(
        label: 'Giám đốc kinh doanh bảo hiểm',
        value: 'Giám đốc kinh doanh bảo hiểm'),
    DropdownItem(label: 'Giám đốc ngân hàng', value: 'Giám đốc ngân hàng'),
    DropdownItem(label: 'Thẩm định tín dụng', value: 'Thẩm định tín dụng'),
    DropdownItem(label: 'Tác nghiệp tín dụng', value: 'Tác nghiệp tín dụng'),
    DropdownItem(label: 'Kiểm soát tuân thủ', value: 'Kiểm soát tuân thủ'),
    DropdownItem(
        label: 'Chuyên môn Ngân hàng khác', value: 'Chuyên môn Ngân hàng khác'),
    DropdownItem(label: 'Chứng khoán', value: 'Chứng khoán'),
    DropdownItem(
        label: 'Phân tích đầu tư chứng khoán',
        value: 'Phân tích đầu tư chứng khoán'),
    DropdownItem(
        label: 'Quản lý danh mục đầu tư', value: 'Quản lý danh mục đầu tư'),
    DropdownItem(
        label: 'Chuyên môn Chứng khoán khác',
        value: 'Chuyên môn Chứng khoán khác'),
    DropdownItem(
        label: 'Thẩm định và quản trị rủi ro',
        value: 'Thẩm định và quản trị rủi ro'),
    DropdownItem(label: 'Quản trị rủi ro', value: 'Quản trị rủi ro'),
    DropdownItem(label: 'Phòng chống rửa tiền', value: 'Phòng chống rửa tiền'),
    DropdownItem(label: 'Quản lý thanh khoản', value: 'Quản lý thanh khoản'),
    DropdownItem(label: 'Định giá tài sản', value: 'Định giá tài sản'),
    DropdownItem(label: 'Thu hồi nợ', value: 'Thu hồi nợ'),
    DropdownItem(
        label: 'Giám đốc tuân thủ và pháp lý',
        value: 'Giám đốc tuân thủ và pháp lý'),
    DropdownItem(
        label: 'Giám đốc quản lý rủi ro (CRO)',
        value: 'Giám đốc quản lý rủi ro (CRO)'),
    DropdownItem(
        label: 'Chuyên môn Thẩm định và quản trị rủi ro khác',
        value: 'Chuyên môn Thẩm định và quản trị rủi ro khác'),
    DropdownItem(label: 'Đầu tư và Tài trợ', value: 'Đầu tư và Tài trợ'),
    DropdownItem(label: 'Phân tích đầu tư', value: 'Phân tích đầu tư'),
    DropdownItem(
        label: 'Mua bán và sáp nhập (M&A)', value: 'Mua bán và sáp nhập (M&A)'),
    DropdownItem(label: 'Quan hệ nhà đầu tư', value: 'Quan hệ nhà đầu tư'),
    DropdownItem(label: 'Quản lý tài sản', value: 'Quản lý tài sản'),
    DropdownItem(label: 'Quản lý danh mục/quỹ', value: 'Quản lý danh mục/quỹ'),
    DropdownItem(
        label: 'Giám đốc/Phó giám đốc đầu tư',
        value: 'Giám đốc/Phó giám đốc đầu tư'),
    DropdownItem(
        label: 'Chuyên môn đầu tư và tài trợ khác',
        value: 'Chuyên môn đầu tư và tài trợ khác'),
    DropdownItem(label: 'Bảo hiểm', value: 'Bảo hiểm'),
    DropdownItem(label: 'Bồi thường bảo hiểm', value: 'Bồi thường bảo hiểm'),
    DropdownItem(label: 'Định phí bảo hiểm', value: 'Định phí bảo hiểm'),
    DropdownItem(
        label: 'Thẩm định và phát hành hợp đồng bảo hiểm',
        value: 'Thẩm định và phát hành hợp đồng bảo hiểm'),
    DropdownItem(
        label: 'Quản lý hợp đồng bảo hiểm', value: 'Quản lý hợp đồng bảo hiểm'),
    DropdownItem(
        label: 'Chuyên môn Bảo hiểm khác', value: 'Chuyên môn Bảo hiểm khác'),
    DropdownItem(
        label: 'Tài chính/Ngân hàng/Bảo hiểm khác',
        value: 'Tài chính/Ngân hàng/Bảo hiểm khác'),
    DropdownItem(label: 'Chuyên viên kế hoạch', value: 'Chuyên viên kế hoạch'),
    DropdownItem(
        label: 'Chuyên môn Tài chính/Ngân hàng/Bảo hiểm khác',
        value: 'Chuyên môn Tài chính/Ngân hàng/Bảo hiểm khác'),
    DropdownItem(label: 'Công nhân', value: 'Công nhân'),
    DropdownItem(label: 'Thợ may', value: 'Thợ may'),
    DropdownItem(label: 'Thợ cơ khí', value: 'Thợ cơ khí'),
    DropdownItem(label: 'Công nhân xây dựng', value: 'Công nhân xây dựng'),
    DropdownItem(label: 'Công nhân thời vụ', value: 'Công nhân thời vụ'),
    DropdownItem(label: 'Bốc xếp hàng hóa', value: 'Bốc xếp hàng hóa'),
    DropdownItem(label: 'Đóng gói hàng hóa', value: 'Đóng gói hàng hóa'),
    DropdownItem(label: 'Nhân viên môi trường', value: 'Nhân viên môi trường'),
    DropdownItem(label: 'Công nhân chăn nuôi', value: 'Công nhân chăn nuôi'),
    DropdownItem(
        label: 'Công nhân làm nước đá', value: 'Công nhân làm nước đá'),
    DropdownItem(label: 'Công nhân xưởng gỗ', value: 'Công nhân xưởng gỗ'),
    DropdownItem(label: 'Công nhân bao bì', value: 'Công nhân bao bì'),
    DropdownItem(label: 'Công nhân điện tử', value: 'Công nhân điện tử'),
    DropdownItem(label: 'Công nhân sản xuất', value: 'Công nhân sản xuất'),
    DropdownItem(label: 'Công nhân ép nhựa', value: 'Công nhân ép nhựa'),
    DropdownItem(label: 'Công nhân giày da', value: 'Công nhân giày da'),
    DropdownItem(
        label: 'Công nhân vận hành máy', value: 'Công nhân vận hành máy'),
    DropdownItem(
        label: 'Công nhân khai thác than', value: 'Công nhân khai thác than'),
    DropdownItem(label: 'Công nhân lắp ráp', value: 'Công nhân lắp ráp'),
    DropdownItem(
        label: 'Công nhân xếp quần áo', value: 'Công nhân xếp quần áo'),
    DropdownItem(label: 'Tài xế', value: 'Tài xế'),
    DropdownItem(label: 'Tài xế taxi', value: 'Tài xế taxi'),
    DropdownItem(label: 'Tài xế B2', value: 'Tài xế B2'),
    DropdownItem(label: 'Tài xế xe tải', value: 'Tài xế xe tải'),
    DropdownItem(label: 'Phụ xe', value: 'Phụ xe'),
    DropdownItem(label: 'Tài xế công nghệ', value: 'Tài xế công nghệ'),
    DropdownItem(label: 'Tài xế container', value: 'Tài xế container'),
    DropdownItem(label: 'Tài xế xe khách', value: 'Tài xế xe khách'),
    DropdownItem(label: 'Tài xế lái xe nâng', value: 'Tài xế lái xe nâng'),
    DropdownItem(
        label: 'Tài xế lái xe đường dài', value: 'Tài xế lái xe đường dài'),
    DropdownItem(label: 'Kho vận/Giao hàng', value: 'Kho vận/Giao hàng'),
    DropdownItem(label: 'Nhân viên kho', value: 'Nhân viên kho'),
    DropdownItem(
        label: 'Shipper (Nhân viên giao hàng)',
        value: 'Shipper (Nhân viên giao hàng)'),
    DropdownItem(label: 'Bưu tá', value: 'Bưu tá'),
    DropdownItem(
        label: 'Phân loại/Sắp xếp hàng hoá',
        value: 'Phân loại/Sắp xếp hàng hoá'),
    DropdownItem(
        label: 'Bảo vệ/Bảo trì/Sửa chữa', value: 'Bảo vệ/Bảo trì/Sửa chữa'),
    DropdownItem(label: 'Sửa chữa điện thoại', value: 'Sửa chữa điện thoại'),
    DropdownItem(label: 'Bảo vệ', value: 'Bảo vệ'),
    DropdownItem(
        label: 'Sửa chữa/Bảo trì điện nước',
        value: 'Sửa chữa/Bảo trì điện nước'),
    DropdownItem(label: 'Thợ sửa khoá', value: 'Thợ sửa khoá'),
    DropdownItem(label: 'Thợ điện', value: 'Thợ điện'),
    DropdownItem(label: 'Thợ điện lạnh', value: 'Thợ điện lạnh'),
    DropdownItem(label: 'Bảo trì tòa nhà', value: 'Bảo trì tòa nhà'),
    DropdownItem(label: 'Thợ sửa xe', value: 'Thợ sửa xe'),
    DropdownItem(label: 'Nhân viên rửa xe', value: 'Nhân viên rửa xe'),
    DropdownItem(
        label: 'Sửa chữa máy tính và máy in',
        value: 'Sửa chữa máy tính và máy in'),
    DropdownItem(
        label: 'Lắp đặt/bảo trì thang máy', value: 'Lắp đặt/bảo trì thang máy'),
    DropdownItem(
        label: 'Việc làm Bảo vệ/Bảo trì/Sửa chữa khác',
        value: 'Việc làm Bảo vệ/Bảo trì/Sửa chữa khác'),
    DropdownItem(
        label: 'Vệ sinh/Giúp việc/Bảo mẫu', value: 'Vệ sinh/Giúp việc/Bảo mẫu'),
    DropdownItem(label: 'Vệ sinh/Tạp vụ', value: 'Vệ sinh/Tạp vụ'),
    DropdownItem(label: 'Giúp việc', value: 'Giúp việc'),
    DropdownItem(
        label: 'Bảo mẫu/Người trông trẻ', value: 'Bảo mẫu/Người trông trẻ'),
    DropdownItem(
        label: 'Nhân viên dọn vệ sinh', value: 'Nhân viên dọn vệ sinh'),
    DropdownItem(
        label: 'Dịch vụ vệ sinh/nhà cửa khác',
        value: 'Dịch vụ vệ sinh/nhà cửa khác'),
    DropdownItem(
        label: 'Chăm sóc sức khoẻ/Làm đẹp', value: 'Chăm sóc sức khoẻ/Làm đẹp'),
    DropdownItem(label: 'Phun xăm thẩm mỹ', value: 'Phun xăm thẩm mỹ'),
    DropdownItem(
        label: 'Thợ xăm (Tattoo Artist)', value: 'Thợ xăm (Tattoo Artist)'),
    DropdownItem(label: 'Kỹ thuật viên Spa', value: 'Kỹ thuật viên Spa'),
    DropdownItem(label: 'Thợ cắt tóc', value: 'Thợ cắt tóc'),
    DropdownItem(label: 'Thợ nail/mi', value: 'Thợ nail/mi'),
    DropdownItem(label: 'Nhân viên massage', value: 'Nhân viên massage'),
    DropdownItem(label: 'Dịch vụ làm đẹp khác', value: 'Dịch vụ làm đẹp khác'),
    DropdownItem(
        label: 'Nhà hàng/Dịch vụ ăn uống', value: 'Nhà hàng/Dịch vụ ăn uống'),
    DropdownItem(label: 'Đầu bếp', value: 'Đầu bếp'),
    DropdownItem(label: 'Pha chế (Barista)', value: 'Pha chế (Barista)'),
    DropdownItem(label: 'Phục vụ', value: 'Phục vụ'),
    DropdownItem(label: 'Phụ bếp', value: 'Phụ bếp'),
    DropdownItem(label: 'Thợ làm bánh', value: 'Thợ làm bánh'),
    DropdownItem(
        label: 'Chuyên môn Nhà hàng/Dịch vụ ăn uống khác',
        value: 'Chuyên môn Nhà hàng/Dịch vụ ăn uống khác'),
    DropdownItem(
        label: 'Khách sạn/Dịch vụ cư trú', value: 'Khách sạn/Dịch vụ cư trú'),
    DropdownItem(label: 'Giặt là', value: 'Giặt là'),
    DropdownItem(
        label: 'Bellman (nhân viên hành lý)',
        value: 'Bellman (nhân viên hành lý)'),
    DropdownItem(label: 'Buồng phòng', value: 'Buồng phòng'),
    DropdownItem(
        label: 'Nhân viên đỗ xe (Valet Parking)',
        value: 'Nhân viên đỗ xe (Valet Parking)'),
    DropdownItem(label: 'Tiếp thị/Bán hàng', value: 'Tiếp thị/Bán hàng'),
    DropdownItem(
        label: 'Hiệu đính và nhập liệu', value: 'Hiệu đính và nhập liệu'),
    DropdownItem(label: 'Thu ngân', value: 'Thu ngân'),
    DropdownItem(label: 'Nhân viên siêu thị', value: 'Nhân viên siêu thị'),
    DropdownItem(label: 'Nhân viên cây xăng', value: 'Nhân viên cây xăng'),
    DropdownItem(label: 'Thợ thủ công', value: 'Thợ thủ công'),
    DropdownItem(label: 'Thợ cắm hoa', value: 'Thợ cắm hoa'),
    DropdownItem(label: 'Thợ cắt vải', value: 'Thợ cắt vải'),
    DropdownItem(label: 'Thợ thủ công mỹ nghệ', value: 'Thợ thủ công mỹ nghệ'),
    DropdownItem(label: 'Thợ thủ công khác', value: 'Thợ thủ công khác'),
    DropdownItem(label: 'Gia công cơ khí', value: 'Gia công cơ khí'),
    DropdownItem(label: 'Thợ hàn', value: 'Thợ hàn'),
    DropdownItem(label: 'Thợ tiện', value: 'Thợ tiện'),
    DropdownItem(label: 'Thợ khoan', value: 'Thợ khoan'),
    DropdownItem(label: 'Thợ mài', value: 'Thợ mài'),
    DropdownItem(label: 'Thợ phay', value: 'Thợ phay'),
    DropdownItem(
        label: 'Thợ Gia công cơ khí khác', value: 'Thợ Gia công cơ khí khác'),
    DropdownItem(label: 'Thợ xây dựng', value: 'Thợ xây dựng'),
    DropdownItem(
        label: 'Thợ xây/Thợ nề/Thợ hồ', value: 'Thợ xây/Thợ nề/Thợ hồ'),
    DropdownItem(label: 'Thợ mộc', value: 'Thợ mộc'),
    DropdownItem(label: 'Thợ sơn', value: 'Thợ sơn'),
    DropdownItem(label: 'Thợ nhôm kính', value: 'Thợ nhôm kính'),
    DropdownItem(label: 'Thợ xây dựng khác', value: 'Thợ xây dựng khác'),
    DropdownItem(
        label: 'Quản lý dự án xây dựng', value: 'Quản lý dự án xây dựng'),
    DropdownItem(
        label: 'Quản lý dự án thi công xây dựng',
        value: 'Quản lý dự án thi công xây dựng'),
    DropdownItem(label: 'Dự toán công trình', value: 'Dự toán công trình'),
    DropdownItem(
        label: 'Giám sát dự án/công trình/thi công',
        value: 'Giám sát dự án/công trình/thi công'),
    DropdownItem(label: 'Thư ký công trình', value: 'Thư ký công trình'),
    DropdownItem(
        label: 'Nhân viên hồ sơ xây dựng', value: 'Nhân viên hồ sơ xây dựng'),
    DropdownItem(label: 'Nhân viên vật tư', value: 'Nhân viên vật tư'),
    DropdownItem(label: 'Nhân viên trắc đạc', value: 'Nhân viên trắc đạc'),
    DropdownItem(
        label: 'Kỹ sư an toàn lao động (HSE)',
        value: 'Kỹ sư an toàn lao động (HSE)'),
    DropdownItem(label: 'Kỹ sư hiện trường', value: 'Kỹ sư hiện trường'),
    DropdownItem(label: 'Quản đốc công trình', value: 'Quản đốc công trình'),
    DropdownItem(
        label: 'Quản lý chất lượng công trình',
        value: 'Quản lý chất lượng công trình'),
    DropdownItem(label: 'Kỹ sư địa chất', value: 'Kỹ sư địa chất'),
    DropdownItem(
        label: 'Giám sát thi công nội thất',
        value: 'Giám sát thi công nội thất'),
    DropdownItem(
        label: 'Giám đốc dự án bất động sản',
        value: 'Giám đốc dự án bất động sản'),
    DropdownItem(
        label: 'Quản lý dự án xây dựng khác',
        value: 'Quản lý dự án xây dựng khác'),
    DropdownItem(
        label: 'Thiết kế và Kiến trúc', value: 'Thiết kế và Kiến trúc'),
    DropdownItem(
        label: 'Kỹ sư kết cấu công trình', value: 'Kỹ sư kết cấu công trình'),
    DropdownItem(label: 'Thiết kế cảnh quan', value: 'Thiết kế cảnh quan'),
    DropdownItem(label: 'Thiết kế nội thất', value: 'Thiết kế nội thất'),
    DropdownItem(label: 'Kiến trúc sư', value: 'Kiến trúc sư'),
    DropdownItem(label: 'Kỹ sư xây dựng', value: 'Kỹ sư xây dựng'),
    DropdownItem(
        label: 'Kỹ sư hệ thống điện nhẹ', value: 'Kỹ sư hệ thống điện nhẹ'),
    DropdownItem(label: 'Kỹ sư cơ điện', value: 'Kỹ sư cơ điện'),
    DropdownItem(label: 'Kỹ sư cấp thoát nước', value: 'Kỹ sư cấp thoát nước'),
    DropdownItem(label: 'Kỹ sư HVAC', value: 'Kỹ sư HVAC'),
    DropdownItem(
        label: 'Kỹ sư thiết kế nhôm kính', value: 'Kỹ sư thiết kế nhôm kính'),
    DropdownItem(label: 'Kỹ sư PCCC', value: 'Kỹ sư PCCC'),
    DropdownItem(label: 'Kỹ sư cầu đường', value: 'Kỹ sư cầu đường'),
    DropdownItem(
        label: 'Chuyên môn Thiết kế và Kiến trúc khác',
        value: 'Chuyên môn Thiết kế và Kiến trúc khác'),
    DropdownItem(
        label: 'Công nhân Xây dựng/Cải tạo',
        value: 'Công nhân Xây dựng/Cải tạo'),
    DropdownItem(label: 'Nhân viên thi công', value: 'Nhân viên thi công'),
    DropdownItem(
        label: 'Quản lý vận hành bất động sản',
        value: 'Quản lý vận hành bất động sản'),
    DropdownItem(label: 'Quản lý tòa nhà', value: 'Quản lý tòa nhà'),
    DropdownItem(
        label: 'Giám sát bảo trì tòa nhà', value: 'Giám sát bảo trì tòa nhà'),
    DropdownItem(label: 'Nhân viên cảnh quan', value: 'Nhân viên cảnh quan'),
    DropdownItem(label: 'Bảo trì PCCC', value: 'Bảo trì PCCC'),
    DropdownItem(
        label: 'Quản lý vận hành bất động sản khác',
        value: 'Quản lý vận hành bất động sản khác'),
    DropdownItem(
        label: 'Quy hoạch và phát triển bất động sản',
        value: 'Quy hoạch và phát triển bất động sản'),
    DropdownItem(
        label: 'Quy hoạch và thiết kế đô thị',
        value: 'Quy hoạch và thiết kế đô thị'),
    DropdownItem(
        label: 'Đấu thầu bất động sản', value: 'Đấu thầu bất động sản'),
    DropdownItem(
        label: 'Quản lý dự án bất động sản',
        value: 'Quản lý dự án bất động sản'),
    DropdownItem(
        label: 'Quy hoạch bất động sản', value: 'Quy hoạch bất động sản'),
    DropdownItem(label: 'Phát triển mặt bằng', value: 'Phát triển mặt bằng'),
    DropdownItem(label: 'Giải phóng mặt bằng', value: 'Giải phóng mặt bằng'),
    DropdownItem(
        label: 'Thẩm định giá bất động sản',
        value: 'Thẩm định giá bất động sản'),
    DropdownItem(label: 'Kỹ sư hạ tầng đô thị', value: 'Kỹ sư hạ tầng đô thị'),
    DropdownItem(
        label: 'Giám đốc kế hoạch bất động sản',
        value: 'Giám đốc kế hoạch bất động sản'),
    DropdownItem(
        label: 'Giám đốc đấu thầu bất động sản',
        value: 'Giám đốc đấu thầu bất động sản'),
    DropdownItem(
        label: 'Bất động sản/Xây dựng khác',
        value: 'Bất động sản/Xây dựng khác'),
    DropdownItem(
        label: 'Chuyên môn Bất động sản/Xây dựng khác',
        value: 'Chuyên môn Bất động sản/Xây dựng khác'),
    DropdownItem(label: 'Kế toán', value: 'Kế toán'),
    DropdownItem(label: 'Kế toán tổng hợp', value: 'Kế toán tổng hợp'),
    DropdownItem(label: 'Kế toán nội bộ', value: 'Kế toán nội bộ'),
    DropdownItem(label: 'Kế toán công nợ', value: 'Kế toán công nợ'),
    DropdownItem(label: 'Kế toán thuế', value: 'Kế toán thuế'),
    DropdownItem(
        label: 'Kế toán chi phí/giá thành', value: 'Kế toán chi phí/giá thành'),
    DropdownItem(label: 'Kế toán bán hàng', value: 'Kế toán bán hàng'),
    DropdownItem(label: 'Kế toán doanh thu', value: 'Kế toán doanh thu'),
    DropdownItem(label: 'Kế toán tài chính', value: 'Kế toán tài chính'),
    DropdownItem(label: 'Kế toán đầu tư', value: 'Kế toán đầu tư'),
    DropdownItem(
        label: 'Kế toán tài sản cố định', value: 'Kế toán tài sản cố định'),
    DropdownItem(label: 'Kế toán mua hàng', value: 'Kế toán mua hàng'),
    DropdownItem(label: 'Kế toán thanh toán', value: 'Kế toán thanh toán'),
    DropdownItem(
        label: 'Kế toán kho/nguyên vật liệu',
        value: 'Kế toán kho/nguyên vật liệu'),
    DropdownItem(label: 'Kế toán tiền lương', value: 'Kế toán tiền lương'),
    DropdownItem(label: 'Kế toán quản trị', value: 'Kế toán quản trị'),
    DropdownItem(label: 'Kế toán trưởng', value: 'Kế toán trưởng'),
    DropdownItem(label: 'Kế toán công trình', value: 'Kế toán công trình'),
    DropdownItem(label: 'Kế toán sản xuất', value: 'Kế toán sản xuất'),
    DropdownItem(label: 'Kế toán dự án', value: 'Kế toán dự án'),
    DropdownItem(
        label: 'Kế toán xuất nhập khẩu', value: 'Kế toán xuất nhập khẩu'),
    DropdownItem(label: 'Kế toán ngân hàng', value: 'Kế toán ngân hàng'),
    DropdownItem(label: 'Thủ quỹ', value: 'Thủ quỹ'),
    DropdownItem(label: 'Kế toán khác', value: 'Kế toán khác'),
    DropdownItem(label: 'Kiểm toán', value: 'Kiểm toán'),
    DropdownItem(label: 'Kiểm toán viên', value: 'Kiểm toán viên'),
    DropdownItem(label: 'Kiểm toán nội bộ', value: 'Kiểm toán nội bộ'),
    DropdownItem(label: 'Kiểm toán độc lập', value: 'Kiểm toán độc lập'),
    DropdownItem(
        label: 'Trưởng nhóm kiểm toán', value: 'Trưởng nhóm kiểm toán'),
    DropdownItem(
        label: 'Chuyên môn Kiểm toán khác', value: 'Chuyên môn Kiểm toán khác'),
    DropdownItem(label: 'Thuế', value: 'Thuế'),
    DropdownItem(label: 'Chuyên viên thuế', value: 'Chuyên viên thuế'),
    DropdownItem(label: 'Chuyên môn Thuế khác', value: 'Chuyên môn Thuế khác'),
    DropdownItem(
        label: 'Kế toán/Kiểm toán/Thuế khác',
        value: 'Kế toán/Kiểm toán/Thuế khác'),
    DropdownItem(
        label: 'Chuyên môn Kế toán/Kiểm toán/Thuế khác',
        value: 'Chuyên môn Kế toán/Kiểm toán/Thuế khác'),
    DropdownItem(
        label: 'Giáo viên/Giảng viên/Gia sư',
        value: 'Giáo viên/Giảng viên/Gia sư'),
    DropdownItem(label: 'Giáo viên mầm non', value: 'Giáo viên mầm non'),
    DropdownItem(
        label: 'Giáo viên giáo dục sớm', value: 'Giáo viên giáo dục sớm'),
    DropdownItem(label: 'Giáo viên tiểu học', value: 'Giáo viên tiểu học'),
    DropdownItem(
        label: 'Giảng viên thỉnh giảng', value: 'Giảng viên thỉnh giảng'),
    DropdownItem(label: 'Giáo viên Toán', value: 'Giáo viên Toán'),
    DropdownItem(
        label: 'Giáo viên Tiếng Việt/Ngữ văn',
        value: 'Giáo viên Tiếng Việt/Ngữ văn'),
    DropdownItem(label: 'Giáo viên Tin học', value: 'Giáo viên Tin học'),
    DropdownItem(
        label: 'Giáo viên Giáo dục thể chất',
        value: 'Giáo viên Giáo dục thể chất'),
    DropdownItem(
        label: 'Giáo viên dạy nhảy/múa', value: 'Giáo viên dạy nhảy/múa'),
    DropdownItem(label: 'Giáo viên tiếng Anh', value: 'Giáo viên tiếng Anh'),
    DropdownItem(label: 'Giáo viên tiếng Nhật', value: 'Giáo viên tiếng Nhật'),
    DropdownItem(label: 'Giáo viên tiếng Hàn', value: 'Giáo viên tiếng Hàn'),
    DropdownItem(
        label: 'Giáo viên tiếng Trung', value: 'Giáo viên tiếng Trung'),
    DropdownItem(label: 'Giáo viên tiếng Đức', value: 'Giáo viên tiếng Đức'),
    DropdownItem(
        label: 'Giáo viên ngoại ngữ khác', value: 'Giáo viên ngoại ngữ khác'),
    DropdownItem(
        label: 'Giáo viên bộ môn khác', value: 'Giáo viên bộ môn khác'),
    DropdownItem(
        label: 'Văn hoá/Nghệ thuật/Khoa học',
        value: 'Văn hoá/Nghệ thuật/Khoa học'),
    DropdownItem(label: 'Giáo viên mỹ thuật', value: 'Giáo viên mỹ thuật'),
    DropdownItem(label: 'Giáo viên âm nhạc', value: 'Giáo viên âm nhạc'),
    DropdownItem(
        label: 'Giáo viên dạy chơi cờ', value: 'Giáo viên dạy chơi cờ'),
    DropdownItem(label: 'Giáo viên STEAM/STEM', value: 'Giáo viên STEAM/STEM'),
    DropdownItem(
        label: 'Giáo viên Văn hóa/Nghệ thuật/Khoa học khác',
        value: 'Giáo viên Văn hóa/Nghệ thuật/Khoa học khác'),
    DropdownItem(label: 'Thể chất/Thể hình', value: 'Thể chất/Thể hình'),
    DropdownItem(
        label: 'Huấn luyện viên Thể hình (PT)',
        value: 'Huấn luyện viên Thể hình (PT)'),
    DropdownItem(
        label: 'Huấn luyện viên bóng rổ', value: 'Huấn luyện viên bóng rổ'),
    DropdownItem(label: 'Huấn luyện viên Yoga', value: 'Huấn luyện viên Yoga'),
    DropdownItem(
        label: 'Huấn luyện viên bơi lội', value: 'Huấn luyện viên bơi lội'),
    DropdownItem(
        label: 'Huấn luyện viên võ thuật', value: 'Huấn luyện viên võ thuật'),
    DropdownItem(
        label: 'Huấn luyện viên trượt patin',
        value: 'Huấn luyện viên trượt patin'),
    DropdownItem(
        label: 'Huấn luyện viên bóng bàn', value: 'Huấn luyện viên bóng bàn'),
    DropdownItem(
        label: 'Huấn luyện viên bóng đá', value: 'Huấn luyện viên bóng đá'),
    DropdownItem(
        label: 'Huấn luyện viên cầu lông', value: 'Huấn luyện viên cầu lông'),
    DropdownItem(
        label: 'Huấn luyện viên quyền anh (Boxing)',
        value: 'Huấn luyện viên quyền anh (Boxing)'),
    DropdownItem(
        label: 'Huấn luyện viên Bi-a (Billiard)',
        value: 'Huấn luyện viên Bi-a (Billiard)'),
    DropdownItem(
        label: 'Huấn luyện viên thể thao khác',
        value: 'Huấn luyện viên thể thao khác'),
    DropdownItem(label: 'Quản lý giáo dục', value: 'Quản lý giáo dục'),
    DropdownItem(label: 'Quản lý học vụ', value: 'Quản lý học vụ'),
    DropdownItem(
        label: 'Chuyên viên điều phối giáo viên',
        value: 'Chuyên viên điều phối giáo viên'),
    DropdownItem(
        label: 'Hiệu trưởng/Phó hiệu trưởng',
        value: 'Hiệu trưởng/Phó hiệu trưởng'),
    DropdownItem(label: 'Giáo viên chủ nhiệm', value: 'Giáo viên chủ nhiệm'),
    DropdownItem(label: 'Quản lý giảng dạy', value: 'Quản lý giảng dạy'),
    DropdownItem(
        label: 'Quản lý chất lượng giáo dục',
        value: 'Quản lý chất lượng giáo dục'),
    DropdownItem(
        label: 'Quản lý giáo dục khác', value: 'Quản lý giáo dục khác'),
    DropdownItem(label: 'Trợ giảng', value: 'Trợ giảng'),
    DropdownItem(label: 'Trợ giảng tiếng Anh', value: 'Trợ giảng tiếng Anh'),
    DropdownItem(
        label: 'Trợ giảng tiếng Trung', value: 'Trợ giảng tiếng Trung'),
    DropdownItem(label: 'Trợ giảng tiếng Nhật', value: 'Trợ giảng tiếng Nhật'),
    DropdownItem(label: 'Trợ giảng tiếng Hàn', value: 'Trợ giảng tiếng Hàn'),
    DropdownItem(label: 'Trợ giảng tiếng Đức', value: 'Trợ giảng tiếng Đức'),
    DropdownItem(
        label: 'Trợ giảng ngoại ngữ khác', value: 'Trợ giảng ngoại ngữ khác'),
    DropdownItem(
        label: 'Trợ giảng bộ môn khác', value: 'Trợ giảng bộ môn khác'),
    DropdownItem(
        label: 'Quản lý/Hỗ trợ lớp học', value: 'Quản lý/Hỗ trợ lớp học'),
    DropdownItem(
        label: 'Quản lý/Vận hành lớp học', value: 'Quản lý/Vận hành lớp học'),
    DropdownItem(label: 'Hỗ trợ lớp học', value: 'Hỗ trợ lớp học'),
    DropdownItem(
        label: 'Chăm sóc/Hỗ trợ học viên', value: 'Chăm sóc/Hỗ trợ học viên'),
    DropdownItem(
        label: 'Quản lý/Hỗ trợ lớp học khác',
        value: 'Quản lý/Hỗ trợ lớp học khác'),
    DropdownItem(
        label: 'Giáo dục/Đào tạo khác', value: 'Giáo dục/Đào tạo khác'),
    DropdownItem(
        label: 'Giáo viên dạy lái xe ô tô', value: 'Giáo viên dạy lái xe ô tô'),
    DropdownItem(label: 'Giáo viên dạy nghề', value: 'Giáo viên dạy nghề'),
    DropdownItem(
        label: 'Giáo viên giáo dục đặc biệt',
        value: 'Giáo viên giáo dục đặc biệt'),
    DropdownItem(
        label: 'Giáo viên dạy cắm hoa', value: 'Giáo viên dạy cắm hoa'),
    DropdownItem(label: 'Giáo viên dạy nấu ăn', value: 'Giáo viên dạy nấu ăn'),
    DropdownItem(label: 'Thủ thư', value: 'Thủ thư'),
    DropdownItem(
        label: 'Phát triển học liệu/Thiết kế khóa học',
        value: 'Phát triển học liệu/Thiết kế khóa học'),
    DropdownItem(label: 'Cố vấn học tập', value: 'Cố vấn học tập'),
    DropdownItem(label: 'Tư vấn hướng nghiệp', value: 'Tư vấn hướng nghiệp'),
    DropdownItem(
        label: 'Tư vấn tâm lý học đường', value: 'Tư vấn tâm lý học đường'),
    DropdownItem(
        label: 'Chuyên môn Giáo dục/Đào tạo khác',
        value: 'Chuyên môn Giáo dục/Đào tạo khác'),
    DropdownItem(label: 'Thiết kế/chế tạo máy', value: 'Thiết kế/chế tạo máy'),
    DropdownItem(label: 'Kỹ sư lập trình máy', value: 'Kỹ sư lập trình máy'),
    DropdownItem(label: 'Kỹ sư tự động hóa', value: 'Kỹ sư tự động hóa'),
    DropdownItem(label: 'Kỹ sư cơ khí', value: 'Kỹ sư cơ khí'),
    DropdownItem(label: 'Kỹ sư kết cấu máy', value: 'Kỹ sư kết cấu máy'),
    DropdownItem(label: 'Kỹ sư quy trình', value: 'Kỹ sư quy trình'),
    DropdownItem(label: 'Kỹ sư khuôn mẫu', value: 'Kỹ sư khuôn mẫu'),
    DropdownItem(
        label: 'Kỹ sư thiết kế cơ khí', value: 'Kỹ sư thiết kế cơ khí'),
    DropdownItem(label: 'Kỹ sư vật liệu', value: 'Kỹ sư vật liệu'),
    DropdownItem(
        label: 'Kỹ sư công nghiệp (IE)', value: 'Kỹ sư công nghiệp (IE)'),
    DropdownItem(label: 'Kỹ sư thiết kế HVAC', value: 'Kỹ sư thiết kế HVAC'),
    DropdownItem(
        label: 'Chuyên môn Thiết kế/chế tạo máy khác',
        value: 'Chuyên môn Thiết kế/chế tạo máy khác'),
    DropdownItem(label: 'Hoá chất/Hoá mỹ phẩm', value: 'Hoá chất/Hoá mỹ phẩm'),
    DropdownItem(
        label: 'Kỹ thuật viên phòng thí nghiệm',
        value: 'Kỹ thuật viên phòng thí nghiệm'),
    DropdownItem(label: 'Kỹ sư hóa học', value: 'Kỹ sư hóa học'),
    DropdownItem(
        label: 'Nghiên cứu và phát triển (R&D) thực phẩm/đồ uống',
        value: 'Nghiên cứu và phát triển (R&D) thực phẩm/đồ uống'),
    DropdownItem(
        label: 'Nghiên cứu và phát triển (R&D) mỹ phẩm',
        value: 'Nghiên cứu và phát triển (R&D) mỹ phẩm'),
    DropdownItem(
        label: 'Chuyên môn Hoá chất/Hoá mỹ phẩm khác',
        value: 'Chuyên môn Hoá chất/Hoá mỹ phẩm khác'),
    DropdownItem(label: 'May mặc/Dệt may/Da', value: 'May mặc/Dệt may/Da'),
    DropdownItem(label: 'Thiết kế rập', value: 'Thiết kế rập'),
    DropdownItem(label: 'Thiết kế vải', value: 'Thiết kế vải'),
    DropdownItem(
        label: 'Chuyên môn May mặc/Dệt may/Da khác',
        value: 'Chuyên môn May mặc/Dệt may/Da khác'),
    DropdownItem(label: 'R&D/Sản xuất ô tô', value: 'R&D/Sản xuất ô tô'),
    DropdownItem(label: 'Kỹ sư thiết kế ô tô', value: 'Kỹ sư thiết kế ô tô'),
    DropdownItem(label: 'Kỹ sư khung gầm', value: 'Kỹ sư khung gầm'),
    DropdownItem(label: 'Kỹ sư lắp ráp ô tô', value: 'Kỹ sư lắp ráp ô tô'),
    DropdownItem(
        label: 'Chuyên môn R&D/Sản xuất ô tô khác',
        value: 'Chuyên môn R&D/Sản xuất ô tô khác'),
    DropdownItem(label: 'Thợ kỹ thuật', value: 'Thợ kỹ thuật'),
    DropdownItem(label: 'Kỹ sư thiết kế điện', value: 'Kỹ sư thiết kế điện'),
    DropdownItem(label: 'Thợ kỹ thuật khác', value: 'Thợ kỹ thuật khác'),
    DropdownItem(
        label: 'Vận hành thiết bị vận tải/thiết bị nặng',
        value: 'Vận hành thiết bị vận tải/thiết bị nặng'),
    DropdownItem(
        label: 'Tài xế lái máy công trình', value: 'Tài xế lái máy công trình'),
    DropdownItem(
        label: 'Vận hành thiết bị nặng/phụ trợ',
        value: 'Vận hành thiết bị nặng/phụ trợ'),
    DropdownItem(
        label: 'Vận hành thiết bị vận tải/thiết bị nặng khác',
        value: 'Vận hành thiết bị vận tải/thiết bị nặng khác'),
    DropdownItem(label: 'Quản lý chất lượng', value: 'Quản lý chất lượng'),
    DropdownItem(
        label: 'Quản lý chất lượng (QA)', value: 'Quản lý chất lượng (QA)'),
    DropdownItem(
        label: 'Kiểm soát chất lượng (QC)', value: 'Kiểm soát chất lượng (QC)'),
    DropdownItem(
        label: 'Kỹ sư phân tích lỗi (PE)', value: 'Kỹ sư phân tích lỗi (PE)'),
    DropdownItem(label: 'Phát triển bao bì', value: 'Phát triển bao bì'),
    DropdownItem(
        label: 'Kỹ sư quản lý chất lượng nhà cung cấp (SQE)',
        value: 'Kỹ sư quản lý chất lượng nhà cung cấp (SQE)'),
    DropdownItem(
        label: 'Quản lý chất lượng khác', value: 'Quản lý chất lượng khác'),
    DropdownItem(label: 'Vận hành sản xuất', value: 'Vận hành sản xuất'),
    DropdownItem(label: 'Giám đốc sản xuất', value: 'Giám đốc sản xuất'),
    DropdownItem(
        label: 'Trưởng phòng sản xuất', value: 'Trưởng phòng sản xuất'),
    DropdownItem(
        label: 'Quản đốc phân xưởng/nhà máy',
        value: 'Quản đốc phân xưởng/nhà máy'),
    DropdownItem(
        label: 'Trưởng chuyền/Tổ trưởng sản xuất',
        value: 'Trưởng chuyền/Tổ trưởng sản xuất'),
    DropdownItem(label: 'Trưởng ca', value: 'Trưởng ca'),
    DropdownItem(label: 'Giám sát sản xuất', value: 'Giám sát sản xuất'),
    DropdownItem(label: 'Theo dõi đơn hàng', value: 'Theo dõi đơn hàng'),
    DropdownItem(label: 'Kế hoạch sản xuất', value: 'Kế hoạch sản xuất'),
    DropdownItem(label: 'Thủ kho/Quản lý kho', value: 'Thủ kho/Quản lý kho'),
    DropdownItem(
        label: 'Quản lý thiết bị sản xuất', value: 'Quản lý thiết bị sản xuất'),
    DropdownItem(
        label: 'Chuyên môn Vận hành sản xuất khác',
        value: 'Chuyên môn Vận hành sản xuất khác'),
    DropdownItem(label: 'Bảo trì, sửa chữa', value: 'Bảo trì, sửa chữa'),
    DropdownItem(
        label: 'Sửa chữa/Bảo trì máy công nghiệp',
        value: 'Sửa chữa/Bảo trì máy công nghiệp'),
    DropdownItem(
        label: 'Kỹ thuật viên lắp đặt', value: 'Kỹ thuật viên lắp đặt'),
    DropdownItem(
        label: 'Bảo trì, sửa chữa khác', value: 'Bảo trì, sửa chữa khác'),
    DropdownItem(label: 'Sản xuất khác', value: 'Sản xuất khác'),
    DropdownItem(
        label: 'Trợ lý/Thư ký sản xuất', value: 'Trợ lý/Thư ký sản xuất'),
    DropdownItem(
        label: 'Chuyên môn Sản xuất khác', value: 'Chuyên môn Sản xuất khác'),
    DropdownItem(label: 'Điện/Tự động hoá', value: 'Điện/Tự động hoá'),
    DropdownItem(label: 'Kỹ sư điện', value: 'Kỹ sư điện'),
    DropdownItem(
        label: 'Kỹ sư lập trình PLC/SCADA', value: 'Kỹ sư lập trình PLC/SCADA'),
    DropdownItem(label: 'Kỹ sư robot', value: 'Kỹ sư robot'),
    DropdownItem(
        label: 'Chuyên môn Điện/Tự động hoá khác',
        value: 'Chuyên môn Điện/Tự động hoá khác'),
    DropdownItem(label: 'Điện tử/Phần cứng', value: 'Điện tử/Phần cứng'),
    DropdownItem(label: 'Kỹ sư điện tử', value: 'Kỹ sư điện tử'),
    DropdownItem(
        label: 'Thiết kế mạch điện/vi mạch',
        value: 'Thiết kế mạch điện/vi mạch'),
    DropdownItem(label: 'Kỹ sư phần cứng', value: 'Kỹ sư phần cứng'),
    DropdownItem(
        label: 'Sửa chữa/Bảo trì điện tử/viễn thông',
        value: 'Sửa chữa/Bảo trì điện tử/viễn thông'),
    DropdownItem(label: 'Phát triển FPGA', value: 'Phát triển FPGA'),
    DropdownItem(label: 'Vi điều khiển', value: 'Vi điều khiển'),
    DropdownItem(
        label: 'Kỹ sư phát triển Driver', value: 'Kỹ sư phát triển Driver'),
    DropdownItem(label: 'Kỹ sư PCB', value: 'Kỹ sư PCB'),
    DropdownItem(label: 'Kỹ sư RF', value: 'Kỹ sư RF'),
    DropdownItem(label: 'Tích hợp hệ thống', value: 'Tích hợp hệ thống'),
    DropdownItem(label: 'Kỹ sư quang học', value: 'Kỹ sư quang học'),
    DropdownItem(label: 'Phát triển DSP', value: 'Phát triển DSP'),
    DropdownItem(label: 'Phát triển ARM', value: 'Phát triển ARM'),
    DropdownItem(
        label: 'Kỹ thuật điện/điện tử', value: 'Kỹ thuật điện/điện tử'),
    DropdownItem(
        label: 'Chuyên môn Điện tử/Phần cứng khác',
        value: 'Chuyên môn Điện tử/Phần cứng khác'),
    DropdownItem(
        label: 'Nhiệt/Gió/Điều hoà (HVAC-R)',
        value: 'Nhiệt/Gió/Điều hoà (HVAC-R)'),
    DropdownItem(label: 'Kỹ sư nhiệt lạnh', value: 'Kỹ sư nhiệt lạnh'),
    DropdownItem(label: 'Kỹ sư điện lạnh', value: 'Kỹ sư điện lạnh'),
    DropdownItem(
        label: 'Chuyên môn Nhiệt/Gió/Điều hoà (HVAC-R)',
        value: 'Chuyên môn Nhiệt/Gió/Điều hoà (HVAC-R)'),
    DropdownItem(label: 'Chất bán dẫn/Chip', value: 'Chất bán dẫn/Chip'),
    DropdownItem(label: 'Thiết kế vi mạch IC', value: 'Thiết kế vi mạch IC'),
    DropdownItem(label: 'Kỹ sư kiểm định IC', value: 'Kỹ sư kiểm định IC'),
    DropdownItem(
        label: 'Analog Layout Design Engineer',
        value: 'Analog Layout Design Engineer'),
    DropdownItem(label: 'Chip test Engineer', value: 'Chip test Engineer'),
    DropdownItem(label: 'DFT Engineer', value: 'DFT Engineer'),
    DropdownItem(label: 'FAE', value: 'FAE'),
    DropdownItem(
        label: 'Digital Front-end Designer',
        value: 'Digital Front-end Designer'),
    DropdownItem(label: 'Back-end Engineer', value: 'Back-end Engineer'),
    DropdownItem(
        label: 'Analog IC Design Engineer', value: 'Analog IC Design Engineer'),
    DropdownItem(
        label: 'Chuyên môn Chất bán dẫn/Chip khác',
        value: 'Chuyên môn Chất bán dẫn/Chip khác'),
    DropdownItem(
        label: 'Quản lý/Vận hành dự án kỹ thuật',
        value: 'Quản lý/Vận hành dự án kỹ thuật'),
    DropdownItem(label: 'Quản lý dự án điện', value: 'Quản lý dự án điện'),
    DropdownItem(
        label: 'Quản lý dự án kỹ thuật', value: 'Quản lý dự án kỹ thuật'),
    DropdownItem(
        label: 'Trợ lý dự án kỹ thuật', value: 'Trợ lý dự án kỹ thuật'),
    DropdownItem(
        label: 'Chuyên viên dự án kỹ thuật',
        value: 'Chuyên viên dự án kỹ thuật'),
    DropdownItem(label: 'Kỹ sư triển khai', value: 'Kỹ sư triển khai'),
    DropdownItem(label: 'Tư vấn triển khai', value: 'Tư vấn triển khai'),
    DropdownItem(
        label: 'Kỹ sư phân tích yêu cầu', value: 'Kỹ sư phân tích yêu cầu'),
    DropdownItem(
        label: 'Quản lý dự án phần cứng', value: 'Quản lý dự án phần cứng'),
    DropdownItem(
        label: 'Quản lý dự án viễn thông', value: 'Quản lý dự án viễn thông'),
    DropdownItem(
        label: 'Quản lý dự án hệ thống tự động hóa',
        value: 'Quản lý dự án hệ thống tự động hóa'),
    DropdownItem(
        label: 'Quản lý dự án năng lượng tái tạo',
        value: 'Quản lý dự án năng lượng tái tạo'),
    DropdownItem(
        label: 'Chuyên môn Quản lý/Vận hành dự án kỹ thuật khác',
        value: 'Chuyên môn Quản lý/Vận hành dự án kỹ thuật khác'),
    DropdownItem(label: 'Viễn thông', value: 'Viễn thông'),
    DropdownItem(
        label: 'Kỹ sư điện tử viễn thông', value: 'Kỹ sư điện tử viễn thông'),
    DropdownItem(label: 'Kỹ thuật viễn thông', value: 'Kỹ thuật viễn thông'),
    DropdownItem(
        label: 'Kỹ sư nghiên cứu và phát triển viễn thông',
        value: 'Kỹ sư nghiên cứu và phát triển viễn thông'),
    DropdownItem(
        label: 'Kỹ sư truyền thông không dây/vô tuyến (RF)',
        value: 'Kỹ sư truyền thông không dây/vô tuyến (RF)'),
    DropdownItem(
        label: 'Kỹ sư truyền thông di động',
        value: 'Kỹ sư truyền thông di động'),
    DropdownItem(
        label: 'Kỹ sư mạng viễn thông', value: 'Kỹ sư mạng viễn thông'),
    DropdownItem(
        label: 'Kỹ sư truyền thông dữ liệu',
        value: 'Kỹ sư truyền thông dữ liệu'),
    DropdownItem(
        label: 'Kỹ sư kiểm thử viễn thông', value: 'Kỹ sư kiểm thử viễn thông'),
    DropdownItem(
        label: 'Kỹ sư truyền thông quang học',
        value: 'Kỹ sư truyền thông quang học'),
    DropdownItem(label: 'Kỹ sư mạng quang', value: 'Kỹ sư mạng quang'),
    DropdownItem(
        label: 'Kỹ sư điện viễn thông', value: 'Kỹ sư điện viễn thông'),
    DropdownItem(label: 'Kỹ sư truyền dẫn cáp', value: 'Kỹ sư truyền dẫn cáp'),
    DropdownItem(
        label: 'Kỹ sư thiết bị viễn thông', value: 'Kỹ sư thiết bị viễn thông'),
    DropdownItem(label: 'Kỹ sư mạng lõi', value: 'Kỹ sư mạng lõi'),
    DropdownItem(
        label: 'Kỹ sư tiêu chuẩn hóa viễn thông',
        value: 'Kỹ sư tiêu chuẩn hóa viễn thông'),
    DropdownItem(label: 'Kỹ sư mạng', value: 'Kỹ sư mạng'),
    DropdownItem(
        label: 'Chuyên môn Viễn thông khác',
        value: 'Chuyên môn Viễn thông khác'),
    DropdownItem(
        label: 'Vận hành và bảo trì/Hỗ trợ kỹ thuật',
        value: 'Vận hành và bảo trì/Hỗ trợ kỹ thuật'),
    DropdownItem(label: 'Kỹ sư hệ thống', value: 'Kỹ sư hệ thống'),
    DropdownItem(
        label: 'Kỹ sư tài liệu kỹ thuật', value: 'Kỹ sư tài liệu kỹ thuật'),
    DropdownItem(label: 'Vận hành điện', value: 'Vận hành điện'),
    DropdownItem(
        label: 'Chuyên môn Vận hành và bảo trì/Hỗ trợ kỹ thuật khác',
        value: 'Chuyên môn Vận hành và bảo trì/Hỗ trợ kỹ thuật khác'),
    DropdownItem(
        label: 'Điện/Điện tử/Viễn thông khác',
        value: 'Điện/Điện tử/Viễn thông khác'),
    DropdownItem(
        label: 'Chuyên môn Điện/Điện tử/Viễn thông khác',
        value: 'Chuyên môn Điện/Điện tử/Viễn thông khác'),
    DropdownItem(
        label: 'Xuất nhập khẩu/Logistics', value: 'Xuất nhập khẩu/Logistics'),
    DropdownItem(
        label: 'Chuyên môn Xuất nhập khẩu/Logistics',
        value: 'Chuyên môn Xuất nhập khẩu/Logistics'),
    DropdownItem(label: 'Giám đốc Logistics', value: 'Giám đốc Logistics'),
    DropdownItem(
        label: 'Nhân viên hiện trường Logistics',
        value: 'Nhân viên hiện trường Logistics'),
    DropdownItem(
        label: 'Quản lý hệ thống vận tải (TMS)',
        value: 'Quản lý hệ thống vận tải (TMS)'),
    DropdownItem(
        label: 'Giám sát/Điều phối hàng hoá và kho vận',
        value: 'Giám sát/Điều phối hàng hoá và kho vận'),
    DropdownItem(
        label: 'Chứng từ xuất nhập khẩu', value: 'Chứng từ xuất nhập khẩu'),
    DropdownItem(label: 'Vận tải', value: 'Vận tải'),
    DropdownItem(
        label: 'Giám sát/Điều phối vận tải',
        value: 'Giám sát/Điều phối vận tải'),
    DropdownItem(
        label: 'Tài xế lái xe chuyên dụng', value: 'Tài xế lái xe chuyên dụng'),
    DropdownItem(label: 'Dịch vụ vận tải khác', value: 'Dịch vụ vận tải khác'),
    DropdownItem(label: 'Giao nhận', value: 'Giao nhận'),
    DropdownItem(
        label: 'Quản lý trạm giao nhận/bưu cục',
        value: 'Quản lý trạm giao nhận/bưu cục'),
    DropdownItem(label: 'Điều phối giao hàng', value: 'Điều phối giao hàng'),
    DropdownItem(label: 'Freight Forwarder', value: 'Freight Forwarder'),
    DropdownItem(
        label: 'Dịch vụ giao nhận khác', value: 'Dịch vụ giao nhận khác'),
    DropdownItem(label: 'Kho vận', value: 'Kho vận'),
    DropdownItem(label: 'Hành chính kho', value: 'Hành chính kho'),
    DropdownItem(
        label: 'Trưởng kho/Giám sát kho', value: 'Trưởng kho/Giám sát kho'),
    DropdownItem(
        label: 'Chuyên môn Kho vận khác', value: 'Chuyên môn Kho vận khác'),
    DropdownItem(label: 'Thu mua/Mua hàng', value: 'Thu mua/Mua hàng'),
    DropdownItem(
        label: 'Chuyên môn Thu mua/Mua hàng',
        value: 'Chuyên môn Thu mua/Mua hàng'),
    DropdownItem(
        label: 'Quản lý/Giám sát mua hàng', value: 'Quản lý/Giám sát mua hàng'),
    DropdownItem(label: 'Điều phối hàng hóa', value: 'Điều phối hàng hóa'),
    DropdownItem(
        label: 'Quản lý hàng hoá (Merchandiser)',
        value: 'Quản lý hàng hoá (Merchandiser)'),
    DropdownItem(
        label: 'Giám đốc Thu mua/Mua hàng', value: 'Giám đốc Thu mua/Mua hàng'),
    DropdownItem(
        label: 'Chuyên viên hồ sơ thầu', value: 'Chuyên viên hồ sơ thầu'),
    DropdownItem(
        label: 'Khai báo hải quan và kiểm dịch',
        value: 'Khai báo hải quan và kiểm dịch'),
    DropdownItem(label: 'Chuỗi cung ứng', value: 'Chuỗi cung ứng'),
    DropdownItem(
        label: 'Chuyên môn chuỗi cung ứng', value: 'Chuyên môn chuỗi cung ứng'),
    DropdownItem(
        label: 'Quản lý/Giám sát chuỗi cung ứng',
        value: 'Quản lý/Giám sát chuỗi cung ứng'),
    DropdownItem(
        label: 'Giám đốc chuỗi cung ứng', value: 'Giám đốc chuỗi cung ứng'),
    DropdownItem(
        label: 'Quản lý sản xuất/Quản lý nguyên vật liệu (PMC)',
        value: 'Quản lý sản xuất/Quản lý nguyên vật liệu (PMC)'),
    DropdownItem(label: 'Logistics khác', value: 'Logistics khác'),
    DropdownItem(
        label: 'Chuyên môn Logistics khác', value: 'Chuyên môn Logistics khác'),
    DropdownItem(label: 'Bán lẻ', value: 'Bán lẻ'),
    DropdownItem(label: 'Giám sát thu ngân', value: 'Giám sát thu ngân'),
    DropdownItem(
        label: 'Phòng chống thất thoát', value: 'Phòng chống thất thoát'),
    DropdownItem(label: 'Giám đốc siêu thị', value: 'Giám đốc siêu thị'),
    DropdownItem(
        label: 'Vận hành trung tâm thương mại',
        value: 'Vận hành trung tâm thương mại'),
    DropdownItem(label: 'Dịch vụ làm đẹp', value: 'Dịch vụ làm đẹp'),
    DropdownItem(label: 'Quản lý Spa', value: 'Quản lý Spa'),
    DropdownItem(
        label: 'Trợ lý/Học việc làm tóc', value: 'Trợ lý/Học việc làm tóc'),
    DropdownItem(label: 'Makeup/Stylist', value: 'Makeup/Stylist'),
    DropdownItem(
        label: 'Dịch vụ chăm sóc sức khoẻ', value: 'Dịch vụ chăm sóc sức khoẻ'),
    DropdownItem(
        label: 'Chuyên viên vật lý trị liệu',
        value: 'Chuyên viên vật lý trị liệu'),
    DropdownItem(
        label: 'Kỹ thuật viên châm cứu bấm huyệt',
        value: 'Kỹ thuật viên châm cứu bấm huyệt'),
    DropdownItem(
        label: 'Dịch vụ chăm sóc sức khỏe khác',
        value: 'Dịch vụ chăm sóc sức khỏe khác'),
    DropdownItem(
        label: 'Dịch vụ vệ sinh/nhà cửa', value: 'Dịch vụ vệ sinh/nhà cửa'),
    DropdownItem(label: 'Giám sát vệ sinh', value: 'Giám sát vệ sinh'),
    DropdownItem(
        label: 'Sắp xếp tủ quần áo và nhà cửa',
        value: 'Sắp xếp tủ quần áo và nhà cửa'),
    DropdownItem(label: 'Tài xế/Lái xe', value: 'Tài xế/Lái xe'),
    DropdownItem(label: 'Tài xế lái xe thuê', value: 'Tài xế lái xe thuê'),
    DropdownItem(
        label: 'Tài xế lái xe văn phòng', value: 'Tài xế lái xe văn phòng'),
    DropdownItem(
        label: 'Dịch vụ an ninh và bảo trì',
        value: 'Dịch vụ an ninh và bảo trì'),
    DropdownItem(label: 'Giám sát an ninh', value: 'Giám sát an ninh'),
    DropdownItem(label: 'Nhân viên PCCC', value: 'Nhân viên PCCC'),
    DropdownItem(
        label: 'Sửa chữa thiết bị gia dụng',
        value: 'Sửa chữa thiết bị gia dụng'),
    DropdownItem(label: 'Dịch vụ bà mẹ trẻ em', value: 'Dịch vụ bà mẹ trẻ em'),
    DropdownItem(label: 'Chăm sóc mẹ và bé', value: 'Chăm sóc mẹ và bé'),
    DropdownItem(
        label: 'Dịch vụ bà mẹ trẻ em khác', value: 'Dịch vụ bà mẹ trẻ em khác'),
    DropdownItem(
        label: 'Dịch vụ ô tô/xe máy/xe điện',
        value: 'Dịch vụ ô tô/xe máy/xe điện'),
    DropdownItem(
        label: 'Thợ độ xe ô tô/xe máy/xe điện',
        value: 'Thợ độ xe ô tô/xe máy/xe điện'),
    DropdownItem(
        label: 'Quản lý cửa hàng sửa chữa và bảo trì ô tô/xe máy/xe điện',
        value: 'Quản lý cửa hàng sửa chữa và bảo trì ô tô/xe máy/xe điện'),
    DropdownItem(label: 'Kiểm định ô tô', value: 'Kiểm định ô tô'),
    DropdownItem(
        label: 'Giám định bồi thường ô tô', value: 'Giám định bồi thường ô tô'),
    DropdownItem(
        label: 'Dịch vụ ô tô/xe máy/xe điện khác',
        value: 'Dịch vụ ô tô/xe máy/xe điện khác'),
    DropdownItem(label: 'Dịch vụ thú cưng', value: 'Dịch vụ thú cưng'),
    DropdownItem(
        label: 'Chuyên viên chăm sóc/spa thú cưng',
        value: 'Chuyên viên chăm sóc/spa thú cưng'),
    DropdownItem(label: 'Bác sĩ thú y', value: 'Bác sĩ thú y'),
    DropdownItem(
        label: 'Dịch vụ thú cưng khác', value: 'Dịch vụ thú cưng khác'),
    DropdownItem(
        label: 'Bán lẻ/Dịch vụ đời sống khác',
        value: 'Bán lẻ/Dịch vụ đời sống khác'),
    DropdownItem(
        label: 'Tổ chức tiệc cưới (Wedding Planner)',
        value: 'Tổ chức tiệc cưới (Wedding Planner)'),
    DropdownItem(label: 'Quản lý quán net', value: 'Quản lý quán net'),
    DropdownItem(
        label: 'Chuyên viên đo thị lực', value: 'Chuyên viên đo thị lực'),
    DropdownItem(
        label: 'Nhân viên rạp chiếu phim', value: 'Nhân viên rạp chiếu phim'),
    DropdownItem(
        label: 'Nhân viên cứu hộ (Lifeguard)',
        value: 'Nhân viên cứu hộ (Lifeguard)'),
    DropdownItem(
        label: 'Chuyên viên điều khiển drone',
        value: 'Chuyên viên điều khiển drone'),
    DropdownItem(
        label: 'Tổ chức sự kiện (Event Planner)',
        value: 'Tổ chức sự kiện (Event Planner)'),
    DropdownItem(
        label: 'Việc làm Bán lẻ/Dịch vụ đời sống khác',
        value: 'Việc làm Bán lẻ/Dịch vụ đời sống khác'),
    DropdownItem(
        label: 'Tư vấn/Phân tích chuyên môn',
        value: 'Tư vấn/Phân tích chuyên môn'),
    DropdownItem(
        label: 'Tư vấn quản lý doanh nghiệp',
        value: 'Tư vấn quản lý doanh nghiệp'),
    DropdownItem(label: 'Tư vấn chiến lược', value: 'Tư vấn chiến lược'),
    DropdownItem(
        label: 'Tư vấn CNTT/IT consultant', value: 'Tư vấn CNTT/IT consultant'),
    DropdownItem(label: 'Tư vấn nhân sự', value: 'Tư vấn nhân sự'),
    DropdownItem(label: 'Tư vấn headhunting', value: 'Tư vấn headhunting'),
    DropdownItem(label: 'Tư vấn tâm lý', value: 'Tư vấn tâm lý'),
    DropdownItem(label: 'Tư vấn hôn nhân', value: 'Tư vấn hôn nhân'),
    DropdownItem(label: 'Phân tích dữ liệu', value: 'Phân tích dữ liệu'),
    DropdownItem(
        label: 'Các vị trí tư vấn khác', value: 'Các vị trí tư vấn khác'),
    DropdownItem(label: 'Quản lý lễ tân', value: 'Quản lý lễ tân'),
    DropdownItem(label: 'Bếp trưởng', value: 'Bếp trưởng'),
    DropdownItem(label: 'Quản lý bếp', value: 'Quản lý bếp'),
    DropdownItem(label: 'Chuyên gia thẩm rượu', value: 'Chuyên gia thẩm rượu'),
    DropdownItem(label: 'Quản lý nhà hàng', value: 'Quản lý nhà hàng'),
    DropdownItem(label: 'Quản lý khách sạn', value: 'Quản lý khách sạn'),
    DropdownItem(label: 'Quản lý homestay', value: 'Quản lý homestay'),
    DropdownItem(
        label: 'Chuyên môn Khách sạn/Dịch vụ cư trú khác',
        value: 'Chuyên môn Khách sạn/Dịch vụ cư trú khác'),
    DropdownItem(label: 'Dịch vụ du lịch', value: 'Dịch vụ du lịch'),
    DropdownItem(
        label: 'Hướng dẫn viên du lịch', value: 'Hướng dẫn viên du lịch'),
    DropdownItem(label: 'Điều hành tour', value: 'Điều hành tour'),
    DropdownItem(label: 'Nhân viên visa', value: 'Nhân viên visa'),
    DropdownItem(
        label: 'Chuyên môn Dịch vụ du lịch khác',
        value: 'Chuyên môn Dịch vụ du lịch khác'),
    DropdownItem(
        label: 'Nhà hàng/Khách sạn/Du lịch khác',
        value: 'Nhà hàng/Khách sạn/Du lịch khác'),
    DropdownItem(
        label: 'Chuyên môn Nhà hàng/Khách sạn/Du lịch khác',
        value: 'Chuyên môn Nhà hàng/Khách sạn/Du lịch khác'),
    DropdownItem(label: 'Năng lượng/Địa chất', value: 'Năng lượng/Địa chất'),
    DropdownItem(label: 'Kỹ sư năng lượng', value: 'Kỹ sư năng lượng'),
    DropdownItem(label: 'Kỹ sư điện mặt trời', value: 'Kỹ sư điện mặt trời'),
    DropdownItem(label: 'Kỹ sư thủy lợi', value: 'Kỹ sư thủy lợi'),
    DropdownItem(
        label: 'Chuyên môn Năng lượng/Địa chất khác',
        value: 'Chuyên môn Năng lượng/Địa chất khác'),
    DropdownItem(
        label: 'An toàn lao động/Môi trường',
        value: 'An toàn lao động/Môi trường'),
    DropdownItem(label: 'Kỹ sư môi trường', value: 'Kỹ sư môi trường'),
    DropdownItem(
        label: 'Vận hành hệ thống xử lý nước thải',
        value: 'Vận hành hệ thống xử lý nước thải'),
    DropdownItem(label: 'Nông/Lâm/Ngư nghiệp', value: 'Nông/Lâm/Ngư nghiệp'),
    DropdownItem(
        label: 'Kỹ thuật viên nông nghiệp/trồng trọt',
        value: 'Kỹ thuật viên nông nghiệp/trồng trọt'),
    DropdownItem(label: 'Kỹ sư lâm nghiệp', value: 'Kỹ sư lâm nghiệp'),
    DropdownItem(label: 'Kiểm lâm', value: 'Kiểm lâm'),
    DropdownItem(
        label: 'Chuyên môn Nông/Lâm/Ngư nghiệp khác',
        value: 'Chuyên môn Nông/Lâm/Ngư nghiệp khác'),
    DropdownItem(
        label: 'Năng lượng/Môi trường/Nông nghiệp khác',
        value: 'Năng lượng/Môi trường/Nông nghiệp khác'),
    DropdownItem(
        label: 'Chuyên môn Năng lượng/Môi trường/Nông nghiệp khác',
        value: 'Chuyên môn Năng lượng/Môi trường/Nông nghiệp khác'),
    DropdownItem(label: 'Đưa đón', value: 'Đưa đón'),
    DropdownItem(label: 'Dịch vụ đưa đón khác', value: 'Dịch vụ đưa đón khác'),
    DropdownItem(label: 'Hàng hải', value: 'Hàng hải'),
    DropdownItem(label: 'Chuyên môn Hàng hải', value: 'Chuyên môn Hàng hải'),
    DropdownItem(
        label: 'NGO/Phi chính phủ/Phi lợi nhuận',
        value: 'NGO/Phi chính phủ/Phi lợi nhuận'),
    DropdownItem(
        label: 'Chuyên môn NGO/Phi chính phủ/Phi lợi nhuận',
        value: 'Chuyên môn NGO/Phi chính phủ/Phi lợi nhuận'),
    DropdownItem(label: 'Nghề khác', value: 'Nghề khác'),
    DropdownItem(label: 'Chuyên môn khác', value: 'Chuyên môn khác'),
    DropdownItem(label: 'Nghề Biên phiên dịch', value: 'Nghề Biên phiên dịch'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Anh', value: 'Biên phiên dịch tiếng Anh'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Trung',
        value: 'Biên phiên dịch tiếng Trung'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Nhật',
        value: 'Biên phiên dịch tiếng Nhật'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Hàn', value: 'Biên phiên dịch tiếng Hàn'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Nga', value: 'Biên phiên dịch tiếng Nga'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Tây Ban Nha',
        value: 'Biên phiên dịch tiếng Tây Ban Nha'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Đức', value: 'Biên phiên dịch tiếng Đức'),
    DropdownItem(
        label: 'Biên phiên dịch tiếng Pháp',
        value: 'Biên phiên dịch tiếng Pháp'),
    DropdownItem(
        label: 'Biên phiên dịch ngôn ngữ khác',
        value: 'Biên phiên dịch ngôn ngữ khác'),
    DropdownItem(
        label: 'Biên phiên dịch đa ngôn ngữ',
        value: 'Biên phiên dịch đa ngôn ngữ'),
    DropdownItem(label: 'Tư vấn dịch thuật', value: 'Tư vấn dịch thuật'),
    DropdownItem(
        label: 'Dịch vụ pháp lý (Agency/Firm)',
        value: 'Dịch vụ pháp lý (Agency/Firm)'),
    DropdownItem(label: 'Luật sư', value: 'Luật sư'),
    DropdownItem(label: 'Chuyên viên pháp lý', value: 'Chuyên viên pháp lý'),
    DropdownItem(
        label: 'Thư ký công chứng viên', value: 'Thư ký công chứng viên'),
    DropdownItem(
        label: 'Thư ký văn phòng luật sư/Thư ký pháp lý',
        value: 'Thư ký văn phòng luật sư/Thư ký pháp lý'),
    DropdownItem(
        label: 'Chuyên môn Pháp lý khác', value: 'Chuyên môn Pháp lý khác'),
    DropdownItem(label: 'Nghề Y tá/Điều dưỡng', value: 'Nghề Y tá/Điều dưỡng'),
    DropdownItem(label: 'Y tá/Điều dưỡng', value: 'Y tá/Điều dưỡng'),
    DropdownItem(
        label: 'Y tá trưởng/Điều dưỡng trưởng',
        value: 'Y tá trưởng/Điều dưỡng trưởng'),
    DropdownItem(label: 'Hộ lý/Hộ sinh', value: 'Hộ lý/Hộ sinh'),
    DropdownItem(label: 'Bác sĩ/Kỹ thuật viên', value: 'Bác sĩ/Kỹ thuật viên'),
    DropdownItem(label: 'Bác sĩ ngoại khoa', value: 'Bác sĩ ngoại khoa'),
    DropdownItem(label: 'Bác sĩ nội khoa', value: 'Bác sĩ nội khoa'),
    DropdownItem(label: 'Bác sĩ da liễu', value: 'Bác sĩ da liễu'),
    DropdownItem(
        label: 'Bác sĩ sản khoa và phụ khoa',
        value: 'Bác sĩ sản khoa và phụ khoa'),
    DropdownItem(label: 'Bác sĩ nhi khoa', value: 'Bác sĩ nhi khoa'),
    DropdownItem(label: 'Bác sĩ nhãn khoa', value: 'Bác sĩ nhãn khoa'),
    DropdownItem(label: 'Bác sĩ tâm lý', value: 'Bác sĩ tâm lý'),
    DropdownItem(label: 'Bác sĩ thẩm mỹ', value: 'Bác sĩ thẩm mỹ'),
    DropdownItem(label: 'Bác sĩ đa khoa', value: 'Bác sĩ đa khoa'),
    DropdownItem(label: 'Bác sĩ tai mũi họng', value: 'Bác sĩ tai mũi họng'),
    DropdownItem(label: 'Bác sĩ siêu âm', value: 'Bác sĩ siêu âm'),
    DropdownItem(
        label: 'Bác sĩ gây mê hồi sức', value: 'Bác sĩ gây mê hồi sức'),
    DropdownItem(
        label: 'Bác sĩ y học cổ truyền', value: 'Bác sĩ y học cổ truyền'),
    DropdownItem(label: 'Bác sĩ nha khoa', value: 'Bác sĩ nha khoa'),
    DropdownItem(
        label: 'Kỹ thuật viên xét nghiệm', value: 'Kỹ thuật viên xét nghiệm'),
    DropdownItem(
        label: 'Kỹ thuật viên chẩn đoán hình ảnh',
        value: 'Kỹ thuật viên chẩn đoán hình ảnh'),
    DropdownItem(label: 'Kỹ thuật viên gây mê', value: 'Kỹ thuật viên gây mê'),
    DropdownItem(
        label: 'Kỹ thuật viên đo thị lực', value: 'Kỹ thuật viên đo thị lực'),
    DropdownItem(label: 'Quản lý y tế', value: 'Quản lý y tế'),
    DropdownItem(
        label: 'Các vị trí bác sĩ khác', value: 'Các vị trí bác sĩ khác'),
    DropdownItem(
        label: 'Vật lý trị liệu và chăm sóc sức khỏe',
        value: 'Vật lý trị liệu và chăm sóc sức khỏe'),
    DropdownItem(
        label: 'Chuyên gia dinh dưỡng/quản lý sức khoẻ',
        value: 'Chuyên gia dinh dưỡng/quản lý sức khoẻ'),
    DropdownItem(
        label: 'Kỹ thuật viên phục hồi chức năng',
        value: 'Kỹ thuật viên phục hồi chức năng'),
    DropdownItem(
        label: 'Chuyên môn Vật lý trị liệu và chăm sóc sức khỏe khác',
        value: 'Chuyên môn Vật lý trị liệu và chăm sóc sức khỏe khác'),
    DropdownItem(
        label: 'Dược phẩm/Công nghệ sinh học',
        value: 'Dược phẩm/Công nghệ sinh học'),
    DropdownItem(
        label: 'Quản lý cửa hàng thuốc', value: 'Quản lý cửa hàng thuốc'),
    DropdownItem(label: 'Nghiên cứu sinh học', value: 'Nghiên cứu sinh học'),
    DropdownItem(label: 'R&D y dược', value: 'R&D y dược'),
    DropdownItem(label: 'Kỹ sư Bioinformatics', value: 'Kỹ sư Bioinformatics'),
    DropdownItem(label: 'Sản xuất dược phẩm', value: 'Sản xuất dược phẩm'),
    DropdownItem(label: 'Đăng ký dược phẩm', value: 'Đăng ký dược phẩm'),
    DropdownItem(label: 'Quản lý dự án y dược', value: 'Quản lý dự án y dược'),
    DropdownItem(
        label: 'Kỹ thuật viên nuôi cấy tế bào',
        value: 'Kỹ thuật viên nuôi cấy tế bào'),
    DropdownItem(
        label: 'Chuyên môn Dược phẩm/Công nghệ sinh học khác',
        value: 'Chuyên môn Dược phẩm/Công nghệ sinh học khác'),
    DropdownItem(label: 'Thiết bị y tế', value: 'Thiết bị y tế'),
    DropdownItem(
        label: 'Quản lý thiết bị y tế', value: 'Quản lý thiết bị y tế'),
    DropdownItem(label: 'Phát triển thuốc thử', value: 'Phát triển thuốc thử'),
    DropdownItem(
        label: 'Kỹ thuật viên phòng lab', value: 'Kỹ thuật viên phòng lab'),
    DropdownItem(label: 'Quản lý phòng lab', value: 'Quản lý phòng lab'),
    DropdownItem(
        label: 'Chuyên môn Thiết bị y tế khác',
        value: 'Chuyên môn Thiết bị y tế khác'),
    DropdownItem(
        label: 'Dược/Y tế/Sức khoẻ/Công nghệ sinh học khác',
        value: 'Dược/Y tế/Sức khoẻ/Công nghệ sinh học khác'),
    DropdownItem(label: 'Thử nghiệm lâm sàng', value: 'Thử nghiệm lâm sàng'),
    DropdownItem(
        label: 'Chuyên môn Dược/Y tế/Sức khoẻ/Công nghệ sinh học khác',
        value: 'Chuyên môn Dược/Y tế/Sức khoẻ/Công nghệ sinh học khác'),
    DropdownItem(
        label: 'Thiết kế Đồ hoạ/Giao diện/Trải nghiệm',
        value: 'Thiết kế Đồ hoạ/Giao diện/Trải nghiệm'),
    DropdownItem(
        label: 'Chuyên môn Thiết kế Đồ hoạ/Giao diện/Trải nghiệm khác',
        value: 'Chuyên môn Thiết kế Đồ hoạ/Giao diện/Trải nghiệm khác'),
    DropdownItem(
        label: 'Thiết kế Nhà/Nội thất/Môi trường',
        value: 'Thiết kế Nhà/Nội thất/Môi trường'),
    DropdownItem(
        label: 'Thiết kế triển lãm/trưng bày',
        value: 'Thiết kế triển lãm/trưng bày'),
    DropdownItem(
        label: 'Thiết kế mỹ thuật sân khấu',
        value: 'Thiết kế mỹ thuật sân khấu'),
    DropdownItem(label: 'Vẽ AutoCAD', value: 'Vẽ AutoCAD'),
    DropdownItem(
        label: 'Chuyên môn Thiết kế Nhà/Nội thất/Môi trường khác',
        value: 'Chuyên môn Thiết kế Nhà/Nội thất/Môi trường khác'),
    DropdownItem(label: 'Thiết kế Công nghiệp', value: 'Thiết kế Công nghiệp'),
    DropdownItem(
        label: 'Thiết kế sản phẩm nội thất',
        value: 'Thiết kế sản phẩm nội thất'),
    DropdownItem(
        label: 'Chuyên môn Thiết kế Công nghiệp',
        value: 'Chuyên môn Thiết kế Công nghiệp'),
    DropdownItem(label: 'Thiết kế bao bì', value: 'Thiết kế bao bì'),
    DropdownItem(
        label: 'Thiết kế đồ trang sức', value: 'Thiết kế đồ trang sức'),
    DropdownItem(label: 'Vẽ kỹ thuật', value: 'Vẽ kỹ thuật'),
    DropdownItem(label: 'Thiết kế Thời trang', value: 'Thiết kế Thời trang'),
    DropdownItem(
        label: 'Chuyên môn Thiết kế Thời trang',
        value: 'Chuyên môn Thiết kế Thời trang'),
    DropdownItem(
        label: 'Nghệ thuật/Hoạt hình/Game', value: 'Nghệ thuật/Hoạt hình/Game'),
    DropdownItem(label: 'Motion Graphic', value: 'Motion Graphic'),
    DropdownItem(label: 'Hoạ sĩ truyện tranh', value: 'Hoạ sĩ truyện tranh'),
    DropdownItem(
        label: 'Chỉnh sửa ảnh (Retouch)', value: 'Chỉnh sửa ảnh (Retouch)'),
    DropdownItem(
        label: 'Chuyên môn Nghệ thuật/Hoạt hình/Game khác',
        value: 'Chuyên môn Nghệ thuật/Hoạt hình/Game khác'),
    DropdownItem(
        label: 'Nghiên cứu người dùng', value: 'Nghiên cứu người dùng'),
    DropdownItem(
        label: 'Chuyên môn nghiên cứu người dùng',
        value: 'Chuyên môn nghiên cứu người dùng'),
    DropdownItem(label: 'Quản lý thiết kế', value: 'Quản lý thiết kế'),
    DropdownItem(
        label: 'Quản lý/Giám sát thiết kế', value: 'Quản lý/Giám sát thiết kế'),
    DropdownItem(
        label: 'Giám đốc/Đạo diễn thiết kế',
        value: 'Giám đốc/Đạo diễn thiết kế'),
    DropdownItem(
        label: 'Giám đốc thiết kế hình ảnh (Visual)',
        value: 'Giám đốc thiết kế hình ảnh (Visual)'),
    DropdownItem(
        label: 'Quản lý thiết kế khác', value: 'Quản lý thiết kế khác'),
    DropdownItem(label: 'Thiết kế khác', value: 'Thiết kế khác'),
    DropdownItem(
        label: 'Chuyên môn Thiết kế khác', value: 'Chuyên môn Thiết kế khác'),
  ];

  final _formKey = GlobalKey<FormState>();
  final MultiSelectController<int> controllerCategory = MultiSelectController();
  final MultiSelectController<String> controllerDesiredJob =
      MultiSelectController();
  final MultiSelectController<String> controllerLocation =
      MultiSelectController();
  final MultiSelectController<String> controllerCurrentJob =
      MultiSelectController();
  final MultiSelectController<String> controllerExperience =
      MultiSelectController();
  final MultiSelectController<String> controllerSkills =
      MultiSelectController();
 
  @override
  void initState() {
    final applicantProvider = context.read<ApplicantProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _desiredJobController.text = applicantProvider.applicant.desiredPosition!;
      // controllerGender.setItems(gender);
      // controllerGender.selectWhere(
      //     (item) => item.value == '${applicantProvider.applicant.gender}');
      // controllerWorkingTime.setItems(workingTime);
      // controllerWorkingTime.selectWhere(
      //     (item) => item.value == '${applicantProvider.applicant.workingTime}');
      controllerCurrentJob.setItems(sampleJobs);
      controllerCurrentJob.selectWhere(
          (item) => item.value == applicantProvider.applicant.currentPosition);
      controllerDesiredJob.setItems(sampleJobs);
      controllerDesiredJob.selectWhere(
          (item) => item.value == applicantProvider.applicant.desiredPosition);
      controllerCategory.setItems(categoryJobs);
      controllerCategory.selectWhere(
          (item) => item.value == applicantProvider.applicant.field!.id);
      controllerLocation.setItems(location);
      controllerLocation.selectWhere((item) =>
          item.value == '${applicantProvider.applicant.desiredLocation}');
      controllerExperience.setItems(experience);
      controllerExperience.selectWhere((item) =>
          item.value == '${applicantProvider.applicant.workExperience}');
      controllerSkills.setItems(skills);
      controllerSkills.selectWhere((item) => applicantProvider.applicant.skills!
          .split(',')
          .map((e) => e.trim())
          .toList()
          .contains(item.value));
    });
  }

  @override
  Widget build(BuildContext context) {

    final applicantProvider = context.watch<ApplicantProvider>();

    List<String>? selectedSkills;
    int? selectedProfessional;
    String? selectedWorkLocation;
    String? selectedExperience;
    String? selectedDesiredJob;
    String? selectedCurrentJob;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Setting job suggestions',
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Info for suggest jobs",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      const Text("Desired field"),
                      const SizedBox(height: 6),
                      MultiDropdown<int>(
                        controller: controllerCategory,
                        items: categoryJobs,
                        searchEnabled: true,
                        singleSelect: true,
                        chipDecoration: const ChipDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
                        fieldDecoration: FieldDecoration(
                          hintText: 'Select the category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        dropdownDecoration: const DropdownDecoration(
                          header: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Select the category',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onSelectionChange: (selected) {
                          selectedProfessional = selected.first;
                          debugPrint('Selected: $selectedProfessional');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 16),

                      const Text("Desired job"),
                      const SizedBox(height: 6),
                      MultiDropdown<String>(
                        controller: controllerDesiredJob,
                        items: sampleJobs,
                        searchEnabled: true,
                        singleSelect: true,
                        chipDecoration: const ChipDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
                        fieldDecoration: FieldDecoration(
                          hintText: 'Select the job',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        dropdownDecoration: const DropdownDecoration(
                          header: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Select the job',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onSelectionChange: (selected) {
                          selectedDesiredJob = selected.first;
                          debugPrint('Selected: $selected');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 16),

                      const Text("Work location"),
                      const SizedBox(height: 6),
                      MultiDropdown<String>(
                        controller: controllerLocation,
                        items: location,
                        searchEnabled: true,
                        singleSelect: true,
                        chipDecoration: const ChipDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
                        fieldDecoration: FieldDecoration(
                          hintText: 'Select the work location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        dropdownDecoration: const DropdownDecoration(
                          header: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Select the work location',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onSelectionChange: (selected) {
                          selectedWorkLocation = selected.first;
                          debugPrint('Selected: $selected');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 26),

                      const Text(
                        "Info about you",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      const Text("Current job"),
                      const SizedBox(height: 6),
                      MultiDropdown<String>(
                        controller: controllerCurrentJob,
                        items: sampleJobs,
                        searchEnabled: true,
                        singleSelect: true,
                        chipDecoration: const ChipDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
                        fieldDecoration: FieldDecoration(
                          hintText: 'Select the current job',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        dropdownDecoration: const DropdownDecoration(
                          header: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Select the current job',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onSelectionChange: (selected) {
                          selectedCurrentJob = selected.first;
                          debugPrint('Selected: $selected');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 16),

                      const Text("Experience"),
                      const SizedBox(height: 6),
                      MultiDropdown<String>(
                        controller: controllerExperience,
                        items: experience,
                        searchEnabled: false,
                        singleSelect: true,
                        chipDecoration: const ChipDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
                        fieldDecoration: FieldDecoration(
                          hintText: 'Select your experience',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        dropdownDecoration: const DropdownDecoration(
                          header: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Select your experience',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onSelectionChange: (selected) {
                          selectedExperience = selected.first;
                          debugPrint('Selected: $selected');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 16),

                      const Text("Existing skills"),
                      const SizedBox(height: 6),
                      MultiDropdown<String>(
                        controller: controllerSkills,
                        items: skills,
                        searchEnabled: true,
                        maxSelections: 5,
                        singleSelect: false,
                        chipDecoration: const ChipDecoration(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            labelStyle: TextStyle(fontSize: 15),
                            wrap: true),
                        fieldDecoration: FieldDecoration(
                          hintText: 'Select your skill',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        dropdownDecoration: const DropdownDecoration(
                          // backgroundColor: Color(0xFFE5E7EB),
                          header: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Select up to 5 skills',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onSelectionChange: (selected) {
                          selectedSkills = selected;
                          debugPrint('Selected: $selectedSkills');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 18), // để tránh đè nút
                    ],
                  ),
                ),
              ),
            ),

            // const Spacer(),

            // Buttons
            // SafeArea(
            // child:
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //nếu mà validate thì gửi dữ liệu lên cho backend đã, sau đó chuyển màn hìnhhình
                  bool result = await applicantProvider.updateUser(
                    applicantProvider.applicant.id!,
                    "",
                    "",
                    "",
                    "",
                    // selectedGender,
                    // selectedWorkingTime,
                    selectedProfessional,
                    selectedDesiredJob,
                    selectedWorkLocation,
                    selectedCurrentJob,
                    selectedExperience,
                    selectedSkills,
                  );
                  result
                      ? QuickAlert.show(
                          // ignore: use_build_context_synchronously
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Change infomation successfully!',
                          // autoCloseDuration: const Duration(seconds: 3),
                          showConfirmBtn: true,
                          onConfirmBtnTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          })
                      : Fluttertoast.showToast(msg: "An error occurred");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Center(
                child: Text(
                  "Change",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class SuggestionSetting extends StatelessWidget {
//   SuggestionSetting({super.key});
  

//   @override
  
// }