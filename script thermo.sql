-- Criação do Banco de Dados ThermoHolic
CREATE DATABASE ThermoHolic;

-- Selecionando o Banco de Dados
USE ThermoHolic; 

-- Criando a tabela empresa 
CREATE TABLE Empresa (
	IdEmpresa INT PRIMARY KEY auto_increment, -- ID da empresa
	Nome varchar(70),-- nome da empresa
    Email varchar(50), -- email institucional empresa
	CNPJ char(18) NOT NULL, -- cnpj da empresa
	QtdTanques INT -- quantidade de tanques de fermentação na empresa, sera feito o update da informação será feito apos o acordo com o cliente
);

INSERT INTO Empresa VALUES 
	(null, 'Brejaway', 'brejaway@outlook.com', '07.526.557/0001-00', null),
	(null, 'Cevada Pura', 'cevada.pura@outlook.com', '08.930.673/0001-24', null),
	(null, 'Dogma', 'dogma@gtmail', '07.526.557/0001-00', null),
	(null, 'Bar do Urso', 'urso.bar@gmail.com', '21.900.899/0001-79', null);
    
-- update Empresa set QtdTanques = 3 where id = 1;


-- SELECTS:
-- Exibição dos registros da tabela empresa
SELECT * FROM Empresa; 
-- Exibição dos nomes das empresas
SELECT Nome FROM Empresa; 
-- Exibição dos CNPJS das empresas
SELECT CNPJ FROM Empresa; 
-- Exibição da quantidade de tanques de fermentação das empresas
SELECT QtdTanques FROM Empresa; 

-- Descrição da tabela Empresa
DESC Empresa;

---------------------------------------------------------------------------------------------------------------------------------------
-- Criando a tabela usuário 
CREATE TABLE Usuario(
IdUsuario INT PRIMARY KEY auto_increment, -- ID do usuario
Nome VARCHAR(50) NOT NULL, -- nome do usuario
Email VARCHAR (100), -- email do usuario
Celular CHAR (11), -- celular do usuario
CPF CHAR(14), -- cpf usuario
Senha VARCHAR(8) NOT NULL, -- senha usuario
TipoUsuario VARCHAR(20), -- tipo de usuario (no cadastro o administrador se cadastra e no dashboard ele adiciona novos funcionarios)
	constraint chkTipoUsuario check (TipoUsuario in ('Administrador', 'Funcionário')),
fkEmpresaU int, -- chave estrangeira com a table empresa
	constraint fkEmpresaU foreign key (fkEmpresaU) references Empresa (IdEmpresa) -- chave estrangeira que identifica a empresa em que o usuario esta localizado
);

INSERT INTO Usuario VALUES
(NULL, 'Gyulia Martins Piqueira', 'gyulia.piqueira@sptech.school', '11975536244', '075.675.234-00', 'Gyulia06', 'Administrador', 1),
(NULL, 'Natalia Russo', 'natalia.russo@sptech.school', '11913653449', '234.567.235-09', 'Nat029', 'Administrador', 2),
(NULL, 'Isabel Bermudes', 'isabel.bermudes@sptech.school', '11944556244', '607.845.623-60', 'Isabel12', 'Administrador', 3),
(NULL, 'Alexandre Murata', 'alexandre.murata@sptech.school', '11975533333', '142.456.834-90', 'Alex1', 'Administrador', 4),
(NULL, 'Luiz Adorno', 'luiz.adorno@sptech.school', '11975534455', '000.023.012-91', 'Luiz0901', 'Funcionário', 4),
(NULL, 'Brudney Ramos', 'brudney.ramosjr@sptech.school', '11975532366', '923.534.890-96', 'Brudney2', 'Funcionário', 2);


-- SELECTS:
-- Exibir todos os dados da tabela usuario
SELECT * FROM Usuario;
-- Exibição dos registros com a *ultima* letra do nome sendo A
SELECT * FROM Usuario WHERE Nome LIKE '%A';
-- Exibição dos registros com a *primeira* letra do nome sendo G 
SELECT * FROM Usuario WHERE Nome LIKE 'G%'; 
-- Exibição dos registros com a *penultima* letra do nome sendo O
SELECT * FROM Usuario WHERE Nome LIKE '%O_'; 
-- Exibição dos registros com a *segunda* letra do nome sendo U
SELECT * FROM Usuario WHERE Nome LIKE '_U%'; 
-- Exibição dos registros ordenados em ordem decrescente do nome
SELECT * FROM Usuario ORDER BY Nome DESC; 
-- Exibição do cpf dos usuarios
SELECT CPF FROM Usuario; 
-- Exibição dos registros ordenados em ordem decrescente do email
SELECT * FROM Usuario ORDER BY Email; 
 -- Exibição do telefone dos usuarios
SELECT Celular FROM Usuario;

-- SELECTS + JOIN:
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuario
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU; 

-- Exibição do nome e da senha do usuario (com os campos escritos de outra forma) junto com o nome das empresas
SELECT 
Usuario.nome AS Nome_Usuario, 
Usuario.senha AS Senha_Usuario, 
Usuario.celular AS Celular_Usuario,
Empresa.nome AS Nome_Empresa
FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU;

-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuario para o usuario com um determinado nome
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.nome= 'Natalia Russo';

-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuario para o usuario com uma determinada *penultima* letra do nome
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.nome LIKE '%O_'; 
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuario para o usuario com um determinado CPF 
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.CPF= '607.845.623-60';
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuario para o usuario com uma determinada senha
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.Senha= 'Alex1';
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuario para o usuario com um determinado ID
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.IdUsuario= '1'; 
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuario para empresa com um determinado ID 
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.fkEmpresaU= '4';
-- Exibição do id de um determinado email
SELECT IdUsuario FROM Usuario WHERE Email LIKE 'alexandre.murata@sptech.school'; 
 

-- Exibição dos nomes das empresas e dos nomes dos usuarios contidos nela
SELECT 
e.nome AS'NOME_EMPRESA',
u.nome AS 'NOME_USUARIO'
FROM empresa AS e JOIN usuario AS u ON u.fkEmpresaU = e.idEmpresa; 


-- Exibição de um determinado nome da empresa e dos nomes dos usuarios contidos nela
SELECT 
e.nome AS'NOME_EMPRESA',
u.nome AS 'NOME_USUARIO'
FROM empresa AS e JOIN usuario AS u ON u.fkEmpresaU = e.idEmpresa WHERE e.nome = 'Cevada Pura';

-- Exibição da descrição da tabela usuario
DESC Usuario; 

----------------------------------------------------------------------------------------------------------------------------------------
-- Criando a tabela sensor 
CREATE TABLE Sensor (
	IdSensor INT PRIMARY KEY auto_increment, -- ID do sensor 
    NomeSensor VARCHAR(10) NOT NULL, -- nome do modelo do sensor (apenas o LM35)
    CONSTRAINT ckcSensor CHECK (NomeSensor IN ('LM35')),  -- configuração da checagem do modelo do sensor
	StatusSensor VARCHAR(10), -- status do sensor
    CONSTRAINT ckcStatusSensor CHECK (StatusSensor in ('Ativo', 'Inativo', 'Manutenção')), -- configuração da checagem do status
    SalaSensor VARCHAR(45) -- sala que o sensor esta localizado
);

INSERT INTO Sensor VALUES 
	(null, 'LM35', 'Ativo' , 'Sala1'),
	(null, 'LM35',  'Ativo' , 'Sala2'),
	(null, 'LM35',  'Ativo', 'Sala10'),
	(null, 'LM35',  'Ativo' , 'Sala5');
    
-- Exibição dos registros da tabela sensor
SELECT * FROM Sensor; 

-- SELECTS:
-- Exibição dos registros com determinado status
SELECT * FROM Sensor WHERE StatusSensor = 'Ativo';
-- Exibição do tanque de um determinado sensor por id
SELECT NomeSensor FROM Sensor WHERE IdSensor= 1; 

-- Exibição da descrição da tabela sensor
DESC Sensor; 
----------------------------------------------------------------------------------------------------------------------------------------
-- Criando a tabela leitura 
CREATE TABLE Leitura (
IdLeitura INT PRIMARY KEY auto_increment, -- id de identificar o registro da temperatura
TemperaturaTanque FLOAT, -- registro da temperatura
DtAtual DATETIME DEFAULT current_timestamp, -- data e horário do registro
fkSensorL INT, -- chave estrangeira com a table sensor
	CONSTRAINT fkSensorL FOREIGN KEY (fkSensorL) REFERENCES Sensor(IdSensor) -- chave estrangeira que identifica a leitura do sensor cadastrado
);

INSERT INTO Leitura (IdLeitura, TemperaturaTanque, fkSensorL) VALUES 
	(null, 50.90, 2),
	(null, 52.00, 1),
	(null, 55.00, 4),
	(null, 60.00, 3);

-- SELECTS:
-- Exibição dos registros da tabela leitura
SELECT * FROM Leitura; 
-- Exibição dos sensores da tabela leitura
SELECT fkSensor FROM Leitura; 
-- Exibição das datas dos registros de leitura
SELECT DtAtual FROM Leitura; 
-- Exibição dos registros de temperatura em ordem decrescente da leitura
SELECT TemperaturaTanque FROM Leitura ORDER BY TemperaturaTanque DESC; 

-- SELECTS + JOIN:
-- Exibição de todos os dados da tabela leitura junto com todos os dados da tabela sensor
SELECT * FROM Leitura JOIN Sensor ON idSensor = fkSensorL; 
-- Exibição de todos os dados da tabela leitura junto com todos os dados da tabela sensor e empresa
SELECT * FROM Leitura JOIN Sensor ON idSensor = fkSensorL JOIN Empresa ON idEmpresa = fkEmpresa;  
-- Exibição de todos os dados da tabela leitura junto com todos os dados da tabela sensor e empresa de uma determinada empresa
SELECT * FROM Leitura JOIN Sensor ON idSensor = fkSensor JOIN Empresa ON idEmpresa = fkEmpresaS WHERE Empresa.nome= 'Dogma'; 
-- Exibição de todos os dados da tabela leitura junto com todos os dados da tabela sensor, empresa e usuario
SELECT * FROM Leitura JOIN Sensor ON idSensor = fkSensor JOIN Empresa ON idEmpresa = fkEmpresaS JOIN Usuario ON idEmpresa = fkEmpresa; 

-- Exibição das 4 tabelas
SELECT * FROM Leitura JOIN Sensor ON idSensor = fkSensor 
JOIN Empresa ON idEmpresa = fkEmpresaS 
JOIN Usuario ON idEmpresa = fkEmpresa ; 
 
 -- Exibição dos campos determinados da tabela usuario, contato, sensor, leitura e empresa 
SELECT
Leitura.DtAtual,
Sensor.idsensor, 
Empresa.cnpj, 
Usuario.nome 
FROM Leitura JOIN Sensor ON idSensor = fkSensor 
JOIN Empresa ON idEmpresa = fkEmpresaS 
JOIN Usuario ON idEmpresa = fkEmpresa; 

-- Exibição dos campos determinados da tabela sensor, leitura e empresa pelo id da leitura 
SELECT 
Leitura.TemperaturaTanque,
Empresa.nome, 
Sensor.salasensor
FROM Leitura JOIN Sensor ON idSensor = fkSensor JOIN Empresa ON idEmpresa = fkEmpresaS WHERE IdLeitura= 4; 

 -- Exibição de todos os dados da tabela leitura junto com todos os dados da tabela sensor para um sensor com um determinado status
SELECT * FROM Leitura JOIN Sensor ON idSensor = fkSensor WHERE Sensor.StatusSensor= 'Inativo'; 


------------------------------------------------------------------------------------------------------------------------------------------
-- Criando a tabela tanque 
CREATE TABLE Tanque (
IdFermentacao INT PRIMARY KEY auto_increment, -- ID da fermentacao 
Nome VARCHAR(10) NOT NULL, -- tanque no qual o sensor foi colocado
NomeReceita VARCHAR(40), -- nome do tipo de cerveja/receita produzida
TempMax DECIMAL (4,2), -- temperatura máxima que a temperatura pode chegar para que o produtor não corra riscos 
TempMin DECIMAL (4,2), -- temperatura mínima que a temperatura pode chegar para que o produtor não corra riscos 
EtapaFermentacao CHAR(1), 
	CONSTRAINT chkEtapa check (EtapaFermentacao in ('1', '2', '3')), -- etapa de fermentação (primária, secundária, terciaria)
fkSensorT INT, -- chave estrangeira com a table sensor
	CONSTRAINT fkSensorT FOREIGN KEY (fkSensorT) REFERENCES Sensor(IdSensor),  -- chave estrangeira que identifica o tipo de fermentacao do sensor cadastrado
fkEmpresaT INT, -- chave estrangeira com a table empresa
		CONSTRAINT fkEmpresaT FOREIGN KEY (fkEmpresaT) REFERENCES Empresa(idEmpresa) -- chave estrangeira que identifica a empresa em que o sensor esta localizado
);

INSERT INTO Tanque VALUES 
	(null, 'Tanque A', 'IPA', '18', '20', 1, 2, 3), -- ALE
	(null, 'Tanque B' ,'Pilsen', '10', '12', 2, 1, 4), -- LAGER
	(null, 'Tanque C', 'Stout', '18', '20', 3, 4, 2), -- ALE
	(null, 'Tanque D','Schwarzbier', '10', '12', 1, 3, 1); -- LAGER
    
 -- Exibição dos registros da tabela fermentacao
SELECT * FROM Tanque; 

-- SELECTS:
-- Exibição da temperatura máxima dos registros de fermentacao
SELECT TempMax FROM Tanque; 
-- Exibição dos registros de temperatura minima em ordem decrescente da tabela fermentacao
SELECT TempMin FROM Tanque ORDER BY TempMin DESC; 

-- SELECTS + JOIN:
-- Exibição de todos os dados da tabela fermentacao junto com todos os dados da tabela sensor
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT; 
-- Exibição de todos os dados da tabela fermentacao junto com todos os dados da tabela sensor e leitura
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL;
-- Exibição de todos os dados da tabela fermentacao junto com todos os dados da tabela sensor, leitura e empresa
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL JOIN Empresa ON idEmpresa = fkEmpresaT; 
 -- Exibição de todos os dados da tabela fermentacao junto com todos os dados da tabela sensor, leitura, usuario e empresa
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL JOIN Empresa ON idEmpresa = fkEmpresaT JOIN Usuario ON idEmpresa = fkEmpresaU; 

-- Exibição de todos os dados da tabela fermentacao junto com todos os dados da tabela sensor e leitura onde o nome da receita
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL WHERE Tanque.NomeReceita= 'IPA';

-- Exibição dos campos determinados da tabela usuario, contato, sensor, leitura, fermentacao e empresa 
SELECT
Tanque.NomeReceita,
Leitura.DtAtual,
Sensor.idsensor, 
Empresa.cnpj, 
Usuario.nome, 
Usuario.email
FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL 
JOIN Empresa ON idEmpresa = fkEmpresaT JOIN Usuario ON idEmpresa = fkEmpresaU;


 -- Exibição de todos os dados da tabela fermentacao junto com todos os dados da tabela sensor para um sensor com um determinado status 
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT WHERE Sensor.StatusSensor= 'manutenção';

------------------------------------------------------------------------------------------------------------------------------------------


-- OUTROS TIPOS DE SELECT:
SELECT TemperaturaTanque, timestampdiff(DAY,DtAtual, NOW()) AS TEMPO FROM Leitura;
        
SELECT DATE_FORMAT(DtAtual,'%d/%m/%Y') AS formatoBR FROM Leitura;
SELECT DATE_FORMAT(DtAtual,'%d/%m/%y') AS formatoBR FROM Leitura;
SELECT DATE_FORMAT(DtAtual,'%d/%M/%y') AS formatoBR FROM Leitura;
SELECT DATE_FORMAT(DtAtual,'%D/%M/%Y') AS formatoBR FROM Leitura;
SELECT DATE_FORMAT(DtAtual,'%D/%m/%y') AS formatoBR FROM Leitura;

SELECT  
CONCAT('O usuario ', Usuario.nome, ' pertence à empresa ', Empresa.Nome) AS frase FROM Usuario JOIN Empresa on idEmpresa = fkEmpresa;
        
