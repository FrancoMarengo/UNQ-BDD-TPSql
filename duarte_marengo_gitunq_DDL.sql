-- TABLAS --

-- Usuarios identificados por su nombre -usuario-
CREATE TABLE USUARIO ( 
	usuario VARCHAR(16) PRIMARY KEY,
	correo VARCHAR(50),
	fecha_nacimiento DATE,
	ciudad VARCHAR(40),
	nyap VARCHAR(30),
	contrasenia VARCHAR(200) NOT NULL,
	cantidad_pull_request INT DEFAULT 0
);


-- Repositorios identificados por su nombre -nombre- y el usuario autor -usuario-
CREATE TABLE REPOSITORIO ( 
	nombre VARCHAR(12), 
	usuario VARCHAR(16), 
	tipo_repositorio VARCHAR(12),
	cantidad_favoritos INT DEFAULT 0,
	cantidad_pull_request INT DEFAULT 0,
	PRIMARY KEY(nombre, usuario)
);


-- Un archivo se identifica por un código serial -id-
-- Un archivo pertenece a un único REPOSITORIO, referenciado por su clave compuesta 
CREATE TABLE ARCHIVO ( 
	id SERIAL PRIMARY KEY,
	nombre_repositorio VARCHAR(12),
	usuario_repositorio VARCHAR(16),
	contenido VARCHAR(255)
);


-- Un commit se identifica por un código calculado -hash-
-- Un commit modifica un ARCHIVO(id_archivo)
CREATE TABLE COMMIT ( 
	hash VARCHAR(40) PRIMARY KEY,
	id_archivo INT,
	titulo VARCHAR(30),
	descripcion VARCHAR(200),
	fecha_cambio DATE DEFAULT CURRENT_DATE
);


-- Representa a cada contribución en el sistema
-- A través de COMMIT(-hash-), modificando un archivo por el usuario -usuario-
CREATE TABLE CONTRIBUCION ( 
	hash VARCHAR(40),
	usuario VARCHAR(16),
	cantidad_cambios INT,
	PRIMARY KEY(hash, usuario)
);


-- DATOS --

INSERT INTO USUARIO (usuario, correo, fecha_nacimiento, ciudad, nyap, contrasenia, cantidad_pull_request)
VALUES
('space.dragon' , 'space.dragon@gmail.com' , '1963-11-20' , 'Solano' , 'Santigo Lorenzo' , 'gatitos789' , 180),
('red' , 'red@outlook.com' , '1965-06-18' , 'Solano' , 'Catalina Medici' , 'contraseñaSuperSegura123' , 68),
('wartortle.22' , 'wartortle.22@gmail.com' , '2012-10-18' , 'Solano' , 'Bianca Mendoza' , 'VacaPatoConejo95' , 194),
('Jorge_99' , 'Jorge_99@gmail.com' , '1980-03-23' , 'Solano' , 'Juan Cruz Quispe' , 'qwertyuiop#[;lkjhgfdsazxcvbñ#]' , 492),
('ZainParsec' , 'ZainParsec@outlook.com' , '1986-02-24' , 'Solano' , 'Gabriel Torres' , 'qwerty00' , 349),
('Miguel_Half.Moon' , 'Miguel_Half.Moon@outlook.com' , '1987-03-28' , 'Solano' , 'Renata Guidi' , 'kriinlkiu3994' , 84),
('Truett.-Penumbra' , 'Truett.-Penumbra@outlook.com' , '1988-03-15' , 'Quilmes' , 'Manuel Vidal' , 'admin123' , 312),
('DilanLens.78' , 'DilanLens.78@gmail.com' , '1992-09-04' , 'Quilmes' , 'David Piriz' , 'AgUaNtEgOkU' , 444),
('eliotmiranda' , 'eliotmiranda@aol.com' , '1979-10-02' , 'Quilmes' , 'Eliot Miranda' , 'Riv3rPl4t3' , 288),
('aka-nice' , 'aka-nice@gmail.com' , '2014-05-29' , 'Varela' , 'Marcelo Gallardo' , 'MilanesasConPure#' , 168),
('EACCES' , 'EACCES@gmail.com' , '1963-08-03' , 'Varela' , 'Lautaro Coronel' , 'messi10' , 361),
('astares' , 'astares@aol.com' , '1967-02-28' , 'Varela' , 'Braian Sanchez Ruiz' , '{x/_![C`}h)TgGb#D' , 99),
('theViper' , 'theViper@gmail.com' , '1968-09-18' , 'Varela' , 'Orjan Larsen' , ';bWy@U&fVQn>h*o' , 23),
('DauT' , 'DauT@gmail.com' , '1970-02-04' , 'Don Bosco' , 'Antonella Vico' , 'qwerty' , 207),
('Liereyy' , 'Liereyy@gmail.com' , '1970-06-11' , 'Don Bosco' , 'Maria Salvatti' , '<~dBY;IgrPzirrt8u%iT' , 14),
('NicoV' , 'NicoV@gmail.com' , '1975-05-15' , 'Parque Chas' , 'Nicolas Gomez Vega' , 'Kul1)C+&5Wq@g^n$+ou;' , 282),
('_i_am_groot' , '_i_am_groot@gmail.com' , '1979-12-02' , 'Parque Chas' , 'Claudio Hernandez' , '5BA$%T[L"KJ~(5!{KS!' , 478),
('capoch' , 'capoch@gmail.com' , '1982-07-07' , 'Parque Chas' , 'Carlos Pitti' , 'lkjhiue325' , 404),
('ruki_5353' , 'ruki_5353@gmail.com' , '1983-11-04' , 'Monserrat' , 'Ruben Vargas' , '123456' , 439),
('M1lanes4' , 'M1lanes4@proton.me' , '1986-02-18' , '3 de Febrero' , 'Renata Ferrara' , 'Sarasa_95' , 162),
('D0n.S4tur25' , 'D0n.S4tur25@proton.me' , '1989-08-09' , '3 de Febrero' , 'Virginia Drago' , 'h[_&^nhc/**a}^@' , 10),
('Carlin__C' , 'Carlin__C@proton.me' , '1989-12-06' , '3 de Febrero' , 'Carlos Calvo' , '&r^.=a{%|dhcpz`[q' , 408),
('d4n11.nube' , 'd4n11.nube@proton.me' , '1991-04-17' , '3 de Febrero' , 'Daniela Diaz' , 'ugaGvcP}X,mH++8t' , 333),
('jorgelin-88' , 'jorgelin-88@proton.me' , '1995-11-02' , '3 de Febrero' , 'Jorge Perez Diaz' , 'password' , 375),
('dark..empire' , 'dark..empire@proton.me' , '1998-02-14' , '3 de Febrero' , 'Ivan Drago' , 'YE$%/-R66/66@$/{[' , 212),
('anaM0nk' , 'anaM0nk@gmail.com' , '1998-06-18' , '3 de Febrero' , 'Ana Laura Montiel' , 'abc123' , 179),
('Taylor13' , 'Taylor13@gmail.com' , '2000-09-14' , 'Bernal' , 'Mauricio Gabriel' , 'oj=N8tMm;cq!Y>b"d' , 49),
('3v4_Warlock' , '3v4_Warlock@gmail.com' , '2001-03-28' , 'Bernal' , 'Juan Francisco Garcia' , 'nDCEmL' , 214),
('juan' , 'juan@yahoo.com.ar' , '2006-02-13' , 'Bernal' , 'Juan Perez' , 'celular' , 271),
('blake-kid' , 'blake-kid@gmail.com' , '2007-02-27' , 'Bernal' , 'Tomas Figueroa' , 'CAmbio432' , 385),
('miss.pink' , 'miss.pink@yahoo.com.ar' , '2008-01-14' , 'Bernal' , 'Amelia Gonzalez' , 'asd321' , 191),
('M0th' , 'M0th@gmail.com' , '2011-01-26' , 'Bernal' , 'Oriana Fiore' , 'PRaUQbGS4CK49AeDqxZdpSkSzHrFuBaThaEKWbtQDNwqeASuWujWcurnMFSR7SB2D' , 29),
('MonkeyJunkie' , 'MonkeyJunkie@gmail.com' , '2014-11-16' , 'Bernal' , 'Julian Ambrosi' , 'ip0OdF' , 304),
('African__Whiz' , 'African__Whiz@gmail.com' , '2015-02-05' , 'Bernal' , 'Esteban Di Lorenzo' , '$>gw*1~fY?jAdJ~P7w' , 101),
('Cuccittini' , 'Cuccittini@yahoo.com.ar' , '2015-05-07' , 'Bernal' , 'Andres Cuccittini' , 'Po>Hs*ktaJn+{fE>CS' , 261),
('Prixie' , 'Prixie@gmail.com' , '1991-04-09' , 'Bernal' , 'Priscila Presley' , 'AeHUJH74Bcnx3E6YA#xPQAETtSEp694MA8k6' , 310),
('j.l3tto' , 'j.l3tto@yahoo.com.ar' , '1992-04-29' , 'Vicente Lopez' , 'Jose Letto' , '+*P7`*b`Qk@<Ee2~' , 335),
('wanakin' , 'wanakin@yahoo.com.ar' , '1996-06-24' , 'Almagro' , 'Ezequiel Quiroga' , 'GiIIk~%Z#7vIp' , 280),
('QuEnDi' , 'QuEnDi@gmail.com' , '1994-06-24' , 'Vicente Lopez' , 'Basilio Biondi' , 'www.google.com' , 41),
('juan.carlos' , 'juan.carlos@gmail.com' , '1994-11-29' , 'Vicente Lopez' , 'Juan Carlos Martinez' , 'yR25tFuu#VvA#GHfk#WJ8EVMsuQs6xzJhN7YEM' , 56),
('zeroCool' , 'zeroCool@gmail.com' , '1995-01-15' , 'Olavarria' , 'Daniel Montes de Oca' , '[YFH>/%`AJelUu}:u' , 456),
('crash.ovrrde' , 'crash.ovrrde@yahoo.com.ar' , '1995-05-19' , 'Olavarria' , 'Carla Suarez' , 'PAlanca39' , 28),
('acid_burn' , 'acid_burn@gmail.com' , '1997-03-08' , 'Olavarria' , 'Catalina Libby' , 'rVzIJXGmtBtjMgIOl' , 93),
('d.phntm_phreak' , 'd.phntm_phreak@gmail.com' , '1997-06-27' , 'Olavarria' , 'Ramon Sanchez' , 'vncgdNWtbVUMCCvUB' , 44),
('CerealKiller' , 'CerealKiller@gmail.com' , '2000-01-12' , 'Olavarria' , 'Emmanuel Goldstein' , '1]!"^:^c*g$9p-m/\' , 490),
('LRD.nikon' , 'LRD.nikon@yahoo.com.ar' , '2001-10-07' , 'Olavarria' , 'Paula Castro' , 'mo99((\n+a5=<hhm6' , 29),
('HAL9000' , 'HAL9000@yahoo.com.ar' , '2004-07-22' , 'Barcelona' , 'Arthur Clarke' , 'phn:([_s=7z@#sh' , 349),
('the_plague5' , 'the_plague5@gmail.com' , '2004-10-16' , 'Barcelona' , 'Eugenia Beltran' , 'p$1*-wcgr"9i7p7' , 284),
('Jonesy' , 'Jonesy@yahoo.com.ar' , '2005-04-22' , 'Barcelona' , 'Juan Luis Guerra' , 'Bizum321' , 110),
('salem.96' , 'salem.96@gmail.com' , '2006-04-25' , 'Vigo' , 'Sabrina Spellman' , 'CamperA50' , 28),
('dr.advogato' , 'dr.advogato@gmail.com' , '2006-11-12' , 'Villa España' , 'Gaston Char' , 'lbzum5tzck9z91d' , 99),
('Tama' , 'Tama@gmail.com' , '2010-03-09' , 'Vigo' , 'Damian Gotelli' , 'hkz4qe' , 121),
('Nitama' , 'Nitama@hotmail.com' , '2013-08-20' , 'Vigo' , 'Martin San Juan' , 'uzuyag' , 135),
('Nntendo' , 'Nntendo@hotmail.com' , '2015-12-08' , 'Bosques' , 'Martin Palermo' , 'EQYO53WQYCI5' , 85),
('graffiti5sandra.' , 'graffiti5sandra.@gmail.com' , '2014-03-22' , 'Bosques' , 'Gian Luca Vinci' , 'hcNqNzAzi' , 370),
('maria_lorena' , 'maria_lorena@hotmail.com' , '2015-06-21' , 'Bosques' , 'Maria Lorena Gabo' , 'WCAiQ%/ta' , 158),
('Titta' , 'Titta@gmail.com' , '2015-01-24' , 'Longchamps' , 'Camila Lopez' , 'HqNTzYURj' , 20),
('Rh0de_s1a' , 'Rh0de_s1a@aol.com' , '2015-09-09' , 'Berazategui' , 'Giorgina Campo' , '0bz8k2qze' , 496),
('la__one' ,'la__one@aol.com' , '2015-03-22' , 'Berazategui' , 'Moria Casan' , 'efxp7x6ss' , 336);


INSERT INTO REPOSITORIO (nombre, usuario, tipo_repositorio, cantidad_favoritos, cantidad_pull_request)
VALUES
('BBDD_22' , 'wartortle.22' , 'informativo' , 85 , 175),
('Tetris_java' , 'Jorge_99' , 'informativo' , 116 , 137),
('Duelo-de-ley' , 'ZainParsec' , 'informativo' , 51 , 26),
('OS_unq_Equip' , 'Miguel_Half.Moon' , 'informativo' , 85 , 90),
('MiPrimerRepo' , 'Truett.-Penumbra' , 'informativo' , 102 , 89),
('datePasers' , 'DilanLens.78' , 'informativo' , 0 , 229),
('CogVM' , 'eliotmiranda' , 'informativo' , 127 , 9),
('Awesome-pyth' , 'aka-nice' , 'informativo' , 69 , 26),
('papers-we-lo' , 'EACCES' , 'informativo' , 46 , 199),
('HelloGithub' , 'astares' , 'informativo' , 44 , 47),
('git-cheat-sh' , 'theViper' , 'informativo' , 86 , 66),
('css-protips' , 'DauT' , 'informativo' , 81 , 195),
('go-patterns' , 'Liereyy' , 'empresarial' , 108 , 103),
('weekly' , 'NicoV' , 'empresarial' , 82 , 125),
('my-mac-scrip' , '_i_am_groot' , 'empresarial' , 65 , 189),
('HarmonyOS' , 'Carlin__C' , 'empresarial' , 26 , 60),
('SpaceVim' , 'd4n11.nube' , 'empresarial' , 8 , 183),
('dotnet-core' , 'jorgelin-88' , 'empresarial' , 85 , 95),
('vim-galore' , 'dark..empire' , 'empresarial' , 61 , 216),
('QiX' , 'anaM0nk' , 'educacional' , 40 , 86),
('devops-exerc' , 'Taylor13' , 'educacional' , 144 , 56),
('pulumi' , '3v4_Warlock' , 'educacional' , 112 , 11),
('infracost' , 'juan' , 'educacional' , 146 , 25),
('formidable' , 'wartortle.22' , 'educacional' , 12 , 137),
('RenoirSt' , 'Jorge_99' , 'educacional' , 90 , 194),
('Willow' , 'ZainParsec' , 'educacional' , 74 , 89),
('Willow-Boots' , 'Miguel_Half.Moon' , 'educacional' , 72 , 181),
('Sagan' , 'Truett.-Penumbra' , 'educacional' , 22 , 55),
('Hyperspace' , 'DilanLens.78' , 'educacional' , 7 , 156),
('Stargate-Con' , 'eliotmiranda' , 'educacional' , 88 , 175),
('instagram-sc' , 'aka-nice' , 'educacional' , 94 , 181),
('app-ideas' , 'EACCES' , 'educacional' , 140 , 135),
('links' , 'astares' , 'educacional' , 15 , 233),
('svelte' , 'theViper' , 'educacional' , 95 , 55),
('DeeplFaceLiv' , 'DauT' , 'educacional' , 55 , 194),
('cleanCode-do' , 'Liereyy' , 'educacional' , 27 , 146),
('docker-andro' , 'NicoV' , 'empresarial' , 74 , 108),
('checkov' , '_i_am_groot' , 'empresarial' , 65 , 122),
('cloud-custod' , 'wanakin' , 'comercial' , 44 , 56),
('My-AWS-app' , 'wanakin' , 'comercial' , 149 , 89),
('ScoutSuite' , 'wanakin' , 'comercial' , 108 , 134),
('autorest' , 'wanakin' , 'comercial' , 45 , 175),
('azure-sdk' , 'juan.carlos' , 'comercial' , 37 , 31),
('terraform-pr' , 'zeroCool' , 'comercial' , 14 , 6),
('SynapseML' , 'crash.ovrrde' , 'comercial' , 132 , 81),
('MachineL-boo' , 'acid_burn' , 'comercial' , 140 , 137),
('Powershell' , 'd.phntm_phreak' , 'comercial' , 127 , 179),
('DevSecOps' , 'CerealKiller' , 'comercial' , 140 , 64),
('openapi-dire' , 'LRD.nikon' , 'empresarial' , 150 , 190),
('komiser' , 'HAL9000' , 'empresarial' , 122 , 38),
('learn-to-clo' , 'the_plague5' , 'comercial' , 98 , 180),
('SmartStoreNE' , 'juan.carlos' , 'comercial' , 95 , 56),
('AcademicCont' , 'zeroCool' , 'educacional' , 117 , 65),
('cloudquery' , 'crash.ovrrde' , 'educacional' , 34 , 135),
('gardener' , 'acid_burn' , 'educacional' , 150 , 66),
('cloudsploit' , 'd.phntm_phreak' , 'educacional' , 104 , 229),
('BaGet' , 'CerealKiller' , 'comercial' , 95 , 165),
('cyberduck' , 'LRD.nikon' , 'comercial' , 82 , 205),
('spark' , 'HAL9000' , 'comercial' , 83 , 98),
('examples' , 'the_plague5' , 'comercial' , 18 , 172),
('thyphoon' , 'maria_lorena' , 'empresarial' , 125 , 35),
('bank-vaults' , 'Titta' , 'informativo' , 118 , 161),
('foundatio' , 'Rh0de_s1a' , 'empresarial' , 126 , 143),
('seldon-serve' , 'la__one' , 'empresarial' , 43 , 26),
('cloudpods' , 'maria_lorena' , 'empresarial' , 112 , 33),
('manageiq' , 'Titta' , 'empresarial' , 135 , 71),
('pgbackrest' , 'Rh0de_s1a' , 'informativo' , 81 , 197),
('altium-libra' , 'la__one' , 'informativo' , 126 , 107),
('s3proxy' , 'maria_lorena' , 'informativo' , 135 , 101),
('freqtrade' , 'Titta' , 'comercial' , 122 , 180),
('ZeroNet' , 'Rh0de_s1a' , 'empresarial' , 38 , 77),
('gekko' , 'la__one' , 'informativo' , 46 , 69),
('solana' , 'maria_lorena' , 'empresarial' , 58 , 145),
('lbry-sdk' , 'Titta' , 'empresarial' , 102 , 199),
('electrum' , 'Rh0de_s1a' , 'educacional' , 133 , 65);

INSERT INTO ARCHIVO (id, nombre_repositorio, usuario_repositorio, contenido)
VALUES
(1, 'manageiq' , 'Titta' , '#include <stdio.h>int main() {printf("Hello World");return 0;}'),
(2, 'cloud-custod' , 'wanakin' , '#include <iostream>int main() { std::cout << "Hello World"; return 0;}'),
(3, 'Duelo-de-ley' , 'ZainParsec' , 'IDENTIFICATION DIVISION.PROGRAM-ID. Hello-world.PROCEDURE DIVISION.  DISPLAY "Hello World".  .'),
(4, 'checkov' , '_i_am_groot' , 'object HelloWorld extends App {  printIn("Hello World")}'),
(5, 'solana' , 'maria_lorena' , 'disp(''Hello World'')'),
(6, 'git-cheat-sh' , 'theViper' , 'namespace HelloWorld{  class Hello {        static void Main(string[] args)   {      System.Console.WriteLine("Hello World");    }  }}'),
(7, 'devops-exerc' , 'Taylor13' , 'console.lof ''Hello World'''),
(8, 'BaGet' , 'CerealKiller' , 'program HelloWorld;begin WriteLn(''Hello World'');end.'),
(9, 'lbry-sdk' , 'Titta' , 'main(){ print(''Hello World'');}'),
(10, 'gardener' , 'acid_burn' , 'module Main where main :: IO () main = putStrLn "Hello World"'),
(11, 'Awesome-pyth' , 'aka-nice' , 'program Hello;begin writeln (''Hello, world.'');end.'),
(12, 'links' , 'astares' , 'puts ''Hello World'''),
(13, 'HarmonyOS' , 'Carlin__C' , 'print("Hello World")'),
(14, 'Powershell' , 'd.phntm_phreak' , 'Write-Output "test output"'),
(15, 'HelloGithub' , 'astares' , 'cat(''Hello World'')'),
(16, 'cleanCode-do' , 'Liereyy' , 'println(''Hello World'');'),
(17, 'thyphoon' , 'maria_lorena' , 'fun main(args: Array<String>){ println("Hello World")}'),
(18, 'Stargate-Con' , 'eliotmiranda' , 'stopMonitoring watcher ifNotNil: [self processBrowser terminateProcess: watcher. watcher := nil.]'),
(19, 'cyberduck' , 'LRD.nikon' , '/*package whatever //do not write package name here */import java.io.*;class GFG { public static void main (String[] args) {  System.out.println("Hello World"); }}'),
(20, 'SmartStoreNE' , 'juan.carlos' , 'println(''Hello World");'),
(21, 'RenoirSt' , 'Jorge_99' , 'processBrowser ^ Smalltalk tools processBrowser'),
(22, 'AcademicCont' , 'zeroCool' , '(print "Hello World")'),
(23, 'gekko' , 'la__one' , 'console.log("Hello World");'),
(24, 'freqtrade' , 'Titta' , 'BEGIN DISPLAY("Hello World") END.'),
(25, 'QiX' , 'anaM0nk' , 'print "Hello World";'),
(26, 'weekly' , 'NicoV' , 'puts "Hello World"'),
(27, 'Sagan' , 'Truett.-Penumbra' , 'self nextPut: Character cr'),
(28, 'MachineL-boo' , 'acid_burn' , 'program helloworld  print *, "Hello World" end program helloworld'),
(29, 'instagram-sc' , 'aka-nice' , 'echo "Hello World"'),
(30, 'examples' , 'the_plague5' , '<!DOCTYPE html><html><head></head><body><h1>Hello World<h1></body></html>'),
(31, 'css-protips' , 'DauT' , 'Transcript show: ''Hello world'''),
(32, 'vim-galore' , 'dark..empire' , 'cat(''Hello World'')'),
(33, 'Willow' , 'ZainParsec' , '(#(''BBDD_22'' ''solana'' ''lbry-sdk'' ''electrum'') asOrderedCollection collect:[:each| each size > 12 ifTrue:[each first: 12] ifFalse:[each]]) do: [ :repo | Transcript crShow: repo ]'),
(34, 'ScoutSuite' , 'wanakin' , 'fun main(args: Array<String>){ println("Hello World")}'),
(35, 'My-AWS-app' , 'wanakin' , 'echo "Hello World";'),
(36, 'datePasers' , 'DilanLens.78' , '/*package whatever //do not write package name here */import java.io.*;class GFG { public static void main (String[] args) {  System.out.println("Hello World"); }}'),
(37, 'Tetris_java' , 'Jorge_99' , '#include <stdio.h>int main() {printf("Hello World");return 0;}'),
(38, 'cloudsploit' , 'd.phntm_phreak' , 'IDENTIFICATION DIVISION.PROGRAM-ID. Hello-world.PROCEDURE DIVISION.  DISPLAY "Hola Munro".  .'),
(39, 'CogVM' , 'eliotmiranda' , 'Transcript show: ''Hola Munro'''),
(40, 'SynapseML' , 'crash.ovrrde' , '<!DOCTYPE html><html><head></head><body><h1>Hagan el TP<h1></body></html>');

INSERT INTO COMMIT(hash, id_archivo, titulo, descripcion, fecha_cambio)
VALUES 
('5845e4645c5e6d088af47dd4b3fbb9b53ca0abac' , 25 , 'headline' , 'Theres no reason a hula hoop cant also be a circus ring.' , '2009-07-30'),
('k5pjn7wuqv9rykgf7u5z53zs6ssrgit6t8gm5im1' , 7 , 'technology' , 'She was too short to see over the fence.' , '2009-10-05'),
('znw1e9u5oxn7upv0f8vw8yjlkhxq6pgv2i27hmib' , 3 , 'administration' , 'They improved dramatically once the lead singer left.' , '2009-12-26'),
('vvu766olrew2l6ehf4777dlq51thp6bqrvn4rhvp' , 31 , 'lay' , 'Garlic ice-cream was her favorite.' , '2010-03-15'),
('vsyd266u0sgh50gxv3h68pqtlqp0gudht1lldhl4' , 39 , 'impulse' , 'Hang on, my kittens are scratching at the bathtub and theyll upset by the lack of biscuits.' , '2010-08-29'),
('caxrh9cn47xqeqbxavn9rnibx3ijqj38z65m6nz0' , 31 , 'strict' , 'Yeah, I think its a good environment for learning English.' , '2010-10-09'),
('0o47bx5mkonmjm4pgliemqu0ztt18y9ycjbum66w' , 18 , 'cassette' , 'You have every right to be angry, but that doesnt give you the right to be mean.' , '2011-07-15'),
('e4mvde2u5g890fijz3npj1r1ke2ip79911u4l24w' , 8 , 'swell' , 'That is an appealing treasure map that I cant read.' , '2011-12-26'),
('v5k8p2l1vfnxz7ji7ggt7ncy98innu8oqyml6ecs' , 9 , 'junior' , 'The old apple revels in its authority.' , '2012-03-05'),
('zvomvdaqoui83xd15493f7xhnu7sqiivjcn5fnlt' , 11 , 'deserve' , 'He watched the dancing piglets with panda bear tummies in the swimming pool.' , '2012-03-17'),
('12zxyw569nqduw2i8fuaf3zwc5ppf6fne4a265el' , 36 , 'crime' , 'He learned the important lesson that a picnic at the beach on a windy day is a bad idea.' , '2012-11-20'),
('51rdfkx6xk8lcjgpyykorckdk0bizuku1iy6s1jg' , 40 , 'insert' , 'Jim liked driving around town with his hazard lights on.' , '2013-09-14'),
('tma32e9hcrwxdeq3152ozbbayrxaqfb9rrizchmu' , 39 , 'prisoner' , 'He barked orders at his daughters but they just stared back with amusement.' , '2015-11-15'),
('us30aqe5kxcaaidw6ism9bp3byx57v77dgytxipn' , 14 , 'native' , 'She did not cheat on the test, for it was not the right thing to do.' , '2016-04-18'),
('xwmimhrxqe9byimaih8fd8u77r9ouosyb463rnq7' , 21 , 'flock' , 'Carol drank the blood as if she were a vampire.' , '2016-07-03'),
('8pf8chb09d797ngv0vb6rcx7t9m6q2ck9w5cg072' , 5 , 'motorist' , 'She found it strange that people use their cellphones to actually talk to one another.' , '2016-11-19'),
('7lvq1swu3tfkj2b9tjdcoehhsgoalrz8u47n3uou' , 10 , 'alive' , 'The hawk didn’t understand why the ground squirrels didn’t want to be his friend.' , '2016-12-15'),
('otikn1mr8ruy04cfy6lbi1ygby39rhl9cdfj45sf' , 40 , 'way' , 'He told us a very exciting adventure story.' , '2017-11-13'),
('z0yhgmot1ths0ylc9xtqyn2r9jfvmzua3955pg9l' , 20 , 'staircase' , 'He had a wall full of masks so she could wear a different face every day.' , '2018-11-21'),
('gblifd45z1fsd4p844v2oy1oved7mbe4ypjh5w89' , 37 , 'movement' , 'She can live her life however she wants as long as she listens to what I have to say.' , '2019-07-09'),
('axix4dhqa4a3a56vpwjet2th34c9fyozcxebfokc' , 3 , 'displace' , 'Stop waiting for exceptional things to just happen.' , '2019-08-16'),
('szb6pnrmolx5yh6osobhor88x7iptg1dqs46lgw5' , 3 , 'execute' , 'If any cop asks you where you were, just say you were visiting Kansas.' , '2019-12-14'),
('2tgjumfu5qu3whmq9kv15hm81sdx92ky9iavonsn' , 39 , 'wrist' , 'More RVs were seen in the storage lot than at the campground.' , '2020-06-04'),
('d7tbfnxcnifb47gfejr2jp9e9zmxysbp4og2lgfc' , 27 , 'consumption' , 'He embraced his new life as an eggplant.' , '2020-11-23'),
('45at10lxm8q0dv7fyfz9up9f0xyl5ufrf1cm3kkc' , 3 , 'fluctuation' , 'David proudly graduated from high school top of his class at age 97.' , '2021-05-31'),
('ry1pja1jdrb52nntgjk2z679uhz8msxjipf6okeb' , 39 , 'pardon' , 'Theres an art to getting your way, and spitting olive pits across the table isnt it.' , '2009-10-23'),
('fvuakz6mauq7emxo38p5akc5cekfasu5kdx3weks' , 21 , 'compact' , 'He swore he just saw his sushi move.' , '2010-04-06'),
('40rnde11x18tfb14y22el0pv3zv3llrhmtoqz9ca' , 4 , 'zero' , 'Traveling became almost extinct during the pandemic.' , '2010-05-23'),
('h5ui8d3xh5n053m2dhk9wdxvao901z62a54ca5r7' , 8 , 'modest' , 'Having no hair made him look even hairier.' , '2010-08-25'),
('gfsynzul47utqhm7attchv1w3bozssmwuqf0876v' , 6 , 'wheel' , 'Had he known what was going to happen, he would have never stepped into the shower.' , '2010-09-04'),
('teaytstlpe1s2rh01bcvy3hwp1kik93zs4k740lj' , 1 , 'performer' , 'Standing on ones head at job interviews forms a lasting impression.' , '2013-02-04'),
('b6oxd2s2c9jwo3f7dlkja7c0zgm2st0nj9kbej5k' , 26 , 'basin' , 'They desperately needed another drummer since the current one only knew how to play bongos.' , '2013-03-18'),
('hnkjen45cjhahtfrgnfpjv0o870oumhk6ch3lrzi' , 16 , 'calf' , 'Separation anxiety is what happens when you cant find your phone.' , '2014-05-27'),
('5j2uj5n2ebzqww0uv6g1t9hgbhqbmf2lgzo869p2' , 32 , 'first commit' , 'This made him feel like an old-style rootbeer float smells.' , '2014-07-13'),
('cpxwagwok5p5eg2zayaem9jg3ap323hb8pl1jbev' , 27 , 'automatic commit' , 'Ive always wanted to go to Tajikistan, but my cat would miss me.' , '2014-08-06'),
('q6sk3nk4t6ewm7waymapfeqiflzg6qvhtohog2je' , 38 , 'mutation' , 'She had a difficult time owning up to her own crazy self.' , '2015-10-03'),
('crewfqmayvo6q5nzs63bgwewr4ikf851zrc1tc4v' , 34 , 'draft' , 'I purchased a baby clown from the Russian terrorist black market.' , '2016-02-18'),
('q136ci50b91m6k004srqib061pdbrhbnlp6kwyha' , 27 , 'provoke' , 'He hated that he loved what she hated about hate.' , '2016-06-12'),
('jy96fo621wcalq9gitvdgp6yox4vppnok7ceu4og' , 31 , 'groan' , 'She was only made the society president because she can whistle with her toes.' , '2016-06-15'),
('v2hn0ze1lg126xhg682n1pmdtxgcktxp6izgnk3z' , 9 , 'solid' , 'The complicated school homework left the parents trying to help their kids quite confused.' , '2016-06-27'),
('qtcw57fr9uugropg0nwm5upkflfqql39dp4gass8' , 14 , 'distinct' , 'There have been days when I wished to be separated from my body, but today wasn’t one of those days.' , '2016-08-02'),
('l98mw0539ni5f5f2ibqgqw1q63nycrdh0b5jfbhd' , 38 , 'confidence' , 'The ants enjoyed the barbecue more than the family.' , '2016-11-10'),
('7i2hn7609lg3rizjws2dpai7w6qdslnhn4tnyrz7' , 34 , 'sensitivity' , 'We need to rent a room for our party.' , '2016-12-17'),
('m5efo6i5io66zyysr5ci9hic2gey976mus21gooa' , 18 , 'border' , 'He found rain fascinating yet unpleasant.' , '2017-11-20'),
('41gka8ypl3ce776th849ph7jls7f68lbqk077lj9' , 24 , 'factor' , 'The changing of down comforters to cotton bedspreads always meant the squirrels had returned.' , '2018-03-23'),
('5hz8ojppu3tzbgjw3kzf7j88xytxz795yndw5x03' , 37 , 'folk' , 'Some bathing suits just shouldn’t be worn by some people.' , '2018-08-03'),
('oyfel7o1np1471i4926422p170yycuttddkwvvlq' , 28 , 'peel' , 'I would have gotten the promotion, but my attendance wasn’t good enough.' , '2020-03-18'),
('e8v54vti5jefhxvm3dco2h28himb1jv07hhk4yig' , 12 , 'opera' , 'Youre good at English when you know the difference between a man eating chicken and a man-eating chicken.' , '2020-04-09'),
('69qh1euh55ybbx9881nshc8lx2pa1wy3zyb5fdob' , 10 , 'promise' , 'The chic gangster liked to start the day with a pink scarf.' , '2020-08-11'),
('f81rpu1o667jzeogatp5n8sytmhs6wj0vhm2kkvu' , 25 , 'privilege' , 'Id rather be a bird than a fish.' , '2021-09-26');

INSERT INTO CONTRIBUCION (hash, usuario, cantidad_cambios)
VALUES
('5845e4645c5e6d088af47dd4b3fbb9b53ca0abac' , 'juan' , 24),
('k5pjn7wuqv9rykgf7u5z53zs6ssrgit6t8gm5im1' , 'zeroCool' , 22),
('znw1e9u5oxn7upv0f8vw8yjlkhxq6pgv2i27hmib' , 'd4n11.nube' , 186),
('vvu766olrew2l6ehf4777dlq51thp6bqrvn4rhvp' , 'wartortle.22' , 243),
('vsyd266u0sgh50gxv3h68pqtlqp0gudht1lldhl4' , 'Prixie' , 129),
('caxrh9cn47xqeqbxavn9rnibx3ijqj38z65m6nz0' , 'blake-kid' , 103),
('0o47bx5mkonmjm4pgliemqu0ztt18y9ycjbum66w' , 'jorgelin-88' , 183),
('e4mvde2u5g890fijz3npj1r1ke2ip79911u4l24w' , 'Taylor13' , 252),
('v5k8p2l1vfnxz7ji7ggt7ncy98innu8oqyml6ecs' , 'j.l3tto' , 234),
('zvomvdaqoui83xd15493f7xhnu7sqiivjcn5fnlt' , 'wanakin' , 106),
('12zxyw569nqduw2i8fuaf3zwc5ppf6fne4a265el' , 'dark..empire' , 170),
('51rdfkx6xk8lcjgpyykorckdk0bizuku1iy6s1jg' , 'Nitama' , 36),
('tma32e9hcrwxdeq3152ozbbayrxaqfb9rrizchmu' , 'graffiti5sandra.' , 85),
('us30aqe5kxcaaidw6ism9bp3byx57v77dgytxipn' , 'Nntendo' , 209),
('xwmimhrxqe9byimaih8fd8u77r9ouosyb463rnq7' , 'Tama' , 30),
('8pf8chb09d797ngv0vb6rcx7t9m6q2ck9w5cg072' , 'Prixie' , 237),
('7lvq1swu3tfkj2b9tjdcoehhsgoalrz8u47n3uou' , 'jorgelin-88' , 182),
('otikn1mr8ruy04cfy6lbi1ygby39rhl9cdfj45sf' , 'theViper' , 78),
('z0yhgmot1ths0ylc9xtqyn2r9jfvmzua3955pg9l' , 'blake-kid' , 48),
('gblifd45z1fsd4p844v2oy1oved7mbe4ypjh5w89' , 'zeroCool' , 186),
('axix4dhqa4a3a56vpwjet2th34c9fyozcxebfokc' , 'd.phntm_phreak' , 183),
('szb6pnrmolx5yh6osobhor88x7iptg1dqs46lgw5' , 'd4n11.nube' , 196),
('2tgjumfu5qu3whmq9kv15hm81sdx92ky9iavonsn' , 'ZainParsec' , 293),
('d7tbfnxcnifb47gfejr2jp9e9zmxysbp4og2lgfc' , 'DilanLens.78' , 192),
('45at10lxm8q0dv7fyfz9up9f0xyl5ufrf1cm3kkc' , 'MonkeyJunkie' , 92),
('ry1pja1jdrb52nntgjk2z679uhz8msxjipf6okeb' , 'wartortle.22' , 38),
('fvuakz6mauq7emxo38p5akc5cekfasu5kdx3weks' , 'wanakin' , 125),
('40rnde11x18tfb14y22el0pv3zv3llrhmtoqz9ca' , 'Jonesy' , 276),
('h5ui8d3xh5n053m2dhk9wdxvao901z62a54ca5r7' , 'd4n11.nube' , 39),
('gfsynzul47utqhm7attchv1w3bozssmwuqf0876v' , 'red' , 79),
('teaytstlpe1s2rh01bcvy3hwp1kik93zs4k740lj' , 'salem.96' , 106),
('b6oxd2s2c9jwo3f7dlkja7c0zgm2st0nj9kbej5k' , 'aka-nice' , 14),
('hnkjen45cjhahtfrgnfpjv0o870oumhk6ch3lrzi' , 'Cuccittini' , 208),
('5j2uj5n2ebzqww0uv6g1t9hgbhqbmf2lgzo869p2' , 'NicoV' , 188),
('cpxwagwok5p5eg2zayaem9jg3ap323hb8pl1jbev' , 'EACCES' , 221),
('q6sk3nk4t6ewm7waymapfeqiflzg6qvhtohog2je' , 'NicoV' , 193),
('crewfqmayvo6q5nzs63bgwewr4ikf851zrc1tc4v' , 'miss.pink' , 251),
('q136ci50b91m6k004srqib061pdbrhbnlp6kwyha' , 'ruki_5353' , 93),
('jy96fo621wcalq9gitvdgp6yox4vppnok7ceu4og' , 'Jonesy' , 83),
('v2hn0ze1lg126xhg682n1pmdtxgcktxp6izgnk3z' , 'Titta' , 128),
('qtcw57fr9uugropg0nwm5upkflfqql39dp4gass8' , 'theViper' , 108),
('l98mw0539ni5f5f2ibqgqw1q63nycrdh0b5jfbhd' , 'Carlin__C' , 126),
('7i2hn7609lg3rizjws2dpai7w6qdslnhn4tnyrz7' , 'M1lanes4' , 225),
('m5efo6i5io66zyysr5ci9hic2gey976mus21gooa' , 'dark..empire' , 267),
('41gka8ypl3ce776th849ph7jls7f68lbqk077lj9' , 'LRD.nikon' , 11),
('5hz8ojppu3tzbgjw3kzf7j88xytxz795yndw5x03' , 'Liereyy' , 236),
('oyfel7o1np1471i4926422p170yycuttddkwvvlq' , 'red' , 64),
('e8v54vti5jefhxvm3dco2h28himb1jv07hhk4yig' , 'anaM0nk' , 23),
('69qh1euh55ybbx9881nshc8lx2pa1wy3zyb5fdob' , 'juan' , 258),
('f81rpu1o667jzeogatp5n8sytmhs6wj0vhm2kkvu' , 'juan.carlos' , 55);

-- QUERIES --


-- 1 --
/*
  Para crear nuestra base de datos, usamos el motor de PostgreSQL, pgAdmin 4.
  Primero, una vez abierta la aplicación, fue necesario conectarnos a la base de datos existente por defecto, "postgres", y desde la misma,
  acceder al entorno "Query Tool". Este entorno nos permite ejecutar consultas SQL, así que ejecutamos:

  CREATE DATABASE tp_duarte_marengo;

  Así, fue creada la base de datos en la que resolvimos el tp actual.
*/


-- 2 --
/*
  Resueltas las creaciones de las tablas en base al enunciado al principio de este archivo.
  La fecha de cambio por defecto de un commit es la del momento en que es insertada, por la restricción que le sigue:

  fecha_cambio DATE DEFAULT CURRENT_DATE,

  La cantidad de favoritos y pull requests de un repositorio es de 0 por las restricciones:

  cantidad_favoritos INT DEFAULT 0,
  cantidad_pull_request INT DEFAULT 0,

  Finalmente, la cantidad de pull requests de un usuario es de 0 por la restricción:

  cantidad_pull_request INT DEFAULT 0
*/


-- 3 --
-- La tabla USUARIO no tiene clave/s foránea/s.

-- La tabla REPOSITORIO cuenta con 1 clave foránea, referenciando al usuario que lo creó:
ALTER TABLE REPOSITORIO
ADD CONSTRAINT fk_usuario FOREIGN KEY (usuario)
REFERENCES usuario(usuario);

-- La tabla ARCHIVO cuenta con 1 clave foránea compuesta, referenciando a la clave primaria compuesta
-- del REPOSITORIO adonde se subió:
ALTER TABLE ARCHIVO
ADD CONSTRAINT fk_repositorio_usuario FOREIGN KEY (nombre_repositorio, usuario_repositorio)
REFERENCES repositorio(nombre, usuario);

-- La tabla COMMIT cuenta con 1 clave foránea, referenciando al archivo que se commiteó:
ALTER TABLE COMMIT
ADD CONSTRAINT fk_id_archivo FOREIGN KEY (id_archivo)
REFERENCES archivo(id);

-- La tabla CONTRIBUCIÓN cuenta con 2 claves foráneas, referenciando al "hash" identificador del commit al que se contribuyó,
-- y al mismo usuario que contribuyó, respectivamente:
ALTER TABLE CONTRIBUCION
ADD CONSTRAINT fk_hash_commit FOREIGN KEY (hash)
REFERENCES commit(hash);

ALTER TABLE CONTRIBUCION
ADD CONSTRAINT fk_usuario FOREIGN KEY (usuario)
REFERENCES usuario(usuario);


-- 4 --
ALTER TABLE USUARIO
ADD CONSTRAINT ck_fecha_nacimiento
CHECK(fecha_nacimiento < CAST('2015-12-13' AS DATE));

ALTER TABLE REPOSITORIO
ADD CONSTRAINT ck_tipo_repositorio
CHECK(tipo_repositorio IN ('informativo', 'empresarial', 'educacional', 'comercial'));


-- 5 --
-- Ejecutadas todas las queries funcionando en la DB --


-- 6 --
/*
  Insertados todos los datos brindados.
  Luego de crear las tablas y ejecutar las queries para lograr las restricciones pedidas,
  ejecutamos en su conjunto, a todas las queries encargadas de insertar los datos funcionando perfectamente. 
*/


-- 7 --
-- Inserción de usuario 'pepim' nacido en 'Solano' en el año 1997
-- Datos faltantes completados arbitrariamente -> correo, dia y mes de fecha_nacimiento, nyap, contrasenia 
INSERT INTO USUARIO(usuario, correo, fecha_nacimiento, ciudad, nyap, contrasenia)
VALUES
('pepim', 'pepim@gmail.com', '1997-02-18', 'Solano', 'José Sardina', 'holasoypepim123'); -- pull request en 0 por defecto

-- Inserción de repositorio de 'pepim' de tipo 'informativo' con 30 favoritos y 5 pull request
-- Datos faltantes completados arbitrariamente -> nombre
INSERT INTO REPOSITORIO (nombre, usuario, tipo_repositorio, cantidad_favoritos, cantidad_pull_request)
VALUES
('INFO_PEPE' , 'pepim' , 'informativo' , 30 , 5);

-- Inserción de usuario 'solan'
-- Datos faltantes completados arbitrariamente (todos menos -usuario-)
INSERT INTO USUARIO(usuario, correo, fecha_nacimiento, ciudad, nyap, contrasenia)
VALUES
('solan', 'solan@outlook.com', '2000-09-11', 'Berazategui', 'Mar Solan', 'holasoysolan123');

-- Inserción de tres nuevos archivos correspondientes al repositorio de 'pepim'
INSERT INTO ARCHIVO (id, nombre_repositorio, usuario_repositorio, contenido)
VALUES
(41, 'INFO_PEPE' , 'pepim' , 'object wollokObject { method holaMundo() {} }'),
(42, 'INFO_PEPE' , 'pepim' , 'class JavaClass { public string holaMundo() {} }'),
(43, 'INFO_PEPE' , 'pepim' , 'module RubyObject def holaMundo  end end');

-- Inserción de tres nuevos commits, correspondientes a los 3 nuevos archivos consecutivamente
INSERT INTO COMMIT(hash, id_archivo, titulo, descripcion, fecha_cambio)
VALUES 
('5845e4645c5e6d088af47dd4b3fbb9b53ca0aaaa' , 41 , '1ero solan->pepim' , 'Wollok es mejor que Smalltalk' , '2015-10-19'),
('5845e4645c5e6d088af47dd4b3fbb9b53ca0bbbb' , 42 , '2do solan->pepim' , 'Java es una experiencia' , '2015-02-28'),
('5845e4645c5e6d088af47dd4b3fbb9b53ca0cccc' , 43 , '3ero solan->pepim' , 'La sintaxis de Ruby es ...' , '2022-10-29');

-- Inserción de tres nuevas colaboraciones, refiriendo a que fue 'solan' quien "commiteó" lo anterior
INSERT INTO CONTRIBUCION (hash, usuario, cantidad_cambios)
VALUES
('5845e4645c5e6d088af47dd4b3fbb9b53ca0aaaa' , 'solan' , 45),
('5845e4645c5e6d088af47dd4b3fbb9b53ca0bbbb' , 'solan' , 48),
('5845e4645c5e6d088af47dd4b3fbb9b53ca0cccc' , 'solan' , 40);


/*
-- Con la siguiente query, podemos corroborar que el único que ha contribuido en commits del
-- repositorio de 'pepim', fue 'solan'
SELECT DISTINCT contribucion.usuario -- Si quitamos el DISTINCT, 3 veces aparecerá 'solan' (3 archivos commiteó)
FROM CONTRIBUCION
NATURAL JOIN commit 
JOIN archivo ON commit.id_archivo = archivo.id
JOIN repositorio ON nombre_repositorio = repositorio.nombre AND usuario_repositorio = repositorio.usuario
WHERE repositorio.usuario = 'pepim'; -- o, repositorio.nombre = 'INFO_PEPE';
*/