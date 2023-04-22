-- Criação do Banco de Dados ThermoHolic
CREATE DATABASE ThermoHolic;

-- Selecionando o Banco de Dados
USE ThermoHolic; 

-- Criando a tabela empresa 
CREATE TABLE Empresa (
	IdEmpresa INT PRIMARY KEY auto_increment, -- ID da Empresa
	Nome varchar(70),-- Nome da empresa
    Email varchar(50), -- Email da empresa
	CNPJ char(18) NOT NULL, -- CNPJ da empresa
	QtdTanques INT -- Quantidade de tanques de fermentação na empresa (o update da informação será feito após a conversa e acordo com o cliente, por isso essa informação não terá que ser preenchida na aba de cadastro)
);

-- Inserindo dados na tabela empresa
INSERT INTO Empresa VALUES 
	(null, 'Brejaway', 'brejaway@outlook.com', '07.526.557/0001-00', null),
	(null, 'Cevada Pura', 'cevada.pura@outlook.com', '08.930.673/0001-24', null),
	(null, 'Dogma', 'dogma@gtmail', '07.526.557/0001-00', null),
	(null, 'Bar do Urso', 'urso.bar@gmail.com', '21.900.899/0001-79', null);
    
-- Depois do acordo feito com o cliente, será realizado o UPDATE na quantidade de tanques:  UPDATE Empresa SET QtdTanques = 3 WHERE IdEmpresa = 1;

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
IdUsuario INT, -- ID do Usuário
Nome VARCHAR(50) NOT NULL, -- Nome do usuário
Email VARCHAR (100), -- Email do usuário
Celular CHAR (11), -- Celular do usuário
CPF CHAR(14), -- CPF usuário
Senha VARCHAR(8) NOT NULL, -- Senha usuário
TipoUsuario VARCHAR(20), -- Tipo de usuário (no cadastro o administrador se cadastra e no dashboard ele adiciona novos funcionários)
	constraint chkTipoUsuario check (TipoUsuario in ('Administrador', 'Funcionário')),
fkEmpresaU int, -- chave estrangeira com a table empresa
	constraint fkEmpresaU foreign key (fkEmpresaU) references Empresa (IdEmpresa), -- chave estrangeira que identifica a empresa em que o usuario esta localizado
    constraint pkCompostaU PRIMARY KEY (IdUsuario, fkEmpresaU) -- PRIMARY KEY COMPOSTA
);

-- OBS: Quando temos a chave primária composta, podemos repetir os números do id pois eles vão se diferenciar de acordo com a empresa que eles pertencerem
-- Inserindo dados na tabela usuário
INSERT INTO Usuario VALUES
(1, 'Gyulia Martins Piqueira', 'gyulia.piqueira@sptech.school', '11975536244', '075.675.234-00', 'Gyulia06', 'Administrador', 1),
(1, 'Natalia Russo', 'natalia.russo@sptech.school', '11913653449', '234.567.235-09', 'Nat029', 'Administrador', 2),
(1, 'Isabel Bermudes', 'isabel.bermudes@sptech.school', '11944556244', '607.845.623-60', 'Isabel12', 'Administrador', 3),
(1, 'Alexandre Murata', 'alexandre.murata@sptech.school', '11975533333', '142.456.834-90', 'Alex1', 'Administrador', 4),
(2, 'Luiz Adorno', 'luiz.adorno@sptech.school', '11975534455', '000.023.012-91', 'Luiz0901', 'Funcionário', 4),
(2, 'Brudney Ramos', 'brudney.ramosjr@sptech.school', '11975532366', '923.534.890-96', 'Brudney2', 'Funcionário', 2);


-- SELECTS:
-- Exibir todos os dados da tabela usuário
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
-- Exibição do CPF dos usuários
SELECT CPF FROM Usuario; 
-- Exibição dos registros ordenados em ordem decrescente do email
SELECT * FROM Usuario ORDER BY Email; 
 -- Exibição do telefone dos usuárioS
SELECT Celular FROM Usuario;

-- SELECTS + JOIN:
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuário
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU; 

-- Exibição do nome e da senha do usuário (com os campos escritos de outra forma) junto com o nome das empresas
SELECT 
Usuario.nome AS Nome_Usuario, 
Usuario.senha AS Senha_Usuario, 
Usuario.celular AS Celular_Usuario,
Empresa.nome AS Nome_Empresa
FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU;

-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuário para o usuário com um determinado nome
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.nome= 'Natalia Russo';

-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuário para o usuário com uma determinada *penúltima* letra do nome
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.nome LIKE '%O_'; 
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuário para o usuário com um determinado CPF 
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.CPF= '607.845.623-60';
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuário para o usuário com uma determinada senha
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.Senha= 'Alex1';
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuário para o usuário com um determinado ID
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.IdUsuario= '1'; 
-- Exibição de todos os dados da tabela empresa junto com todos os dados da tabela usuário para empresa com um determinado ID 
SELECT * FROM Empresa JOIN Usuario ON idEmpresa = fkEmpresaU WHERE Usuario.fkEmpresaU= '4';
-- Exibição do id de um determinado email
SELECT IdUsuario FROM Usuario WHERE Email LIKE 'alexandre.murata@sptech.school'; 
 

-- Exibição dos nomes das empresas e dos nomes dos usuários contidos nela
SELECT 
e.nome AS'NOME_EMPRESA',
u.nome AS 'NOME_USUARIO'
FROM empresa AS e JOIN usuario AS u ON u.fkEmpresaU = e.idEmpresa; 


-- Exibição de um determinado nome da empresa e dos nomes dos usuários contidos nela
SELECT 
e.nome AS'NOME_EMPRESA',
u.nome AS 'NOME_USUARIO'
FROM empresa AS e JOIN usuario AS u ON u.fkEmpresaU = e.idEmpresa WHERE e.nome = 'Cevada Pura';

-- Exibição da descrição da tabela usuário
DESC Usuario; 

----------------------------------------------------------------------------------------------------------------------------------------
-- Criando a tabela sensor 
CREATE TABLE Sensor (
	IdSensor INT PRIMARY KEY auto_increment, -- ID do Sensor 
    NomeSensor VARCHAR(10) NOT NULL, -- Nome do modelo do sensor (apenas o LM35)
    CONSTRAINT ckcSensor CHECK (NomeSensor IN ('LM35')),  -- Configuração da checagem do modelo do sensor
	StatusSensor VARCHAR(10), -- Status do sensor
    CONSTRAINT ckcStatusSensor CHECK (StatusSensor in ('Ativo', 'Inativo', 'Manutenção')), -- Configuração da checagem do status
    SalaSensor VARCHAR(45) -- Sala que o sensor est localizado
);

-- Inserindo dados na tabela sensor 
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
IdLeitura INT, -- Id da Leitura para identificar o registro da temperatura
TemperaturaTanque FLOAT, -- Registro da temperatura
DtAtual DATETIME DEFAULT current_timestamp, -- Data e horário do registro
fkSensorL INT, -- Chave estrangeira com a table sensor
	CONSTRAINT fkSensorL FOREIGN KEY (fkSensorL) REFERENCES Sensor(IdSensor), -- Chave estrangeira que identifica a leitura do sensor cadastrado
	CONSTRAINT pkCompostaL PRIMARY KEY (IdLeitura, fkSensorL) -- PRIMARY KEY COMPOSTA
);

-- Inserindo dados na tabela leitura
INSERT INTO Leitura (IdLeitura, TemperaturaTanque, fkSensorL) VALUES 
	(1, 50.90, 2),
	(1, 52.00, 1),
	(1, 55.00, 4),
	(1, 60.00, 3);

-- SELECTS:
-- Exibição dos registros da tabela leitura
SELECT * FROM Leitura; 
-- Exibição dos sensores da tabela leitura
SELECT fkSensorL FROM Leitura; 
-- Exibição das datas dos registros de leitura
SELECT DtAtual FROM Leitura; 
-- Exibição dos registros de temperatura em ordem decrescente da leitura
SELECT TemperaturaTanque FROM Leitura ORDER BY TemperaturaTanque DESC; 

-- SELECTS + JOIN:
-- Exibição de todos os dados da tabela leitura junto com todos os dados da tabela sensor
SELECT * FROM Leitura JOIN Sensor ON idSensor = fkSensorL; 
-- Exibição de todos os dados da tabela leitura junto com todos os dados da tabela sensor e tanque
SELECT * FROM Leitura JOIN Sensor ON idSensor = fkSensorL JOIN Tanque ON idSensor = fkSensorT;  
-- Exibição de todos os dados da tabela leitura junto com todos os dados da tabela sensor e tanque de uma determinada empresa
SELECT * FROM Leitura JOIN Sensor ON idSensor = fkSensorL JOIN Tanque ON idSensor = fkSensorT JOIN Empresa ON idEmpresa = fkEmpresaT WHERE Empresa.nome= 'Dogma'; 
 
 

------------------------------------------------------------------------------------------------------------------------------------------
-- Criando a tabela tanque de fermentação
CREATE TABLE Tanque (
IdTanque INT, -- ID da Fermentação
Nome VARCHAR(10) NOT NULL, -- Tanque no qual o sensor foi colocado
NomeReceita VARCHAR(40), -- Nome do tipo de cerveja/receita produzida
TempMax DECIMAL (4,2), -- Temperatura máxima que a temperatura pode chegar para que o produtor não corra riscos 
TempMin DECIMAL (4,2), -- Temperatura mínima que a temperatura pode chegar para que o produtor não corra riscos 
EtapaFermentacao CHAR(1), 
	CONSTRAINT chkEtapa check (EtapaFermentacao in ('1', '2', '3')), -- Etapa de fermentação (primária, secundária, terciária)
fkSensorT INT, -- Chave estrangeira com a tabela sensor (onde as duas tabelas são fortes)
	CONSTRAINT fkSensorT FOREIGN KEY (fkSensorT) REFERENCES Sensor(IdSensor),  -- Chave estrangeira que identifica o tipo de fermentação do sensor cadastrado
fkEmpresaT INT, -- Chave estrangeira com a tabela empresa
		CONSTRAINT fkEmpresaT FOREIGN KEY (fkEmpresaT) REFERENCES Empresa(idEmpresa), -- Chave estrangeira que identifica a empresa em que o tanque está localizado
	CONSTRAINT pkCompostaT PRIMARY KEY (IdTanque, fkEmpresaT) -- PRIMARY KEY COMPOSTA
);

-- O tanque depende da empresa pois ele precisa ser comprado para a empresa ser caracterizada como cervejaria e para haver fermentação.
-- Inserindo dados na tabela tanque
INSERT INTO Tanque VALUES 
	(1, 'Tanque A', 'IPA', '18', '20', 1, 2, 3), -- ALE
	(1, 'Tanque B' ,'Pilsen', '10', '12', 2, 1, 4), -- LAGER
	(1, 'Tanque C', 'Stout', '18', '20', 3, 4, 2), -- ALE
	(1, 'Tanque D','Schwarzbier', '10', '12', 1, 3, 1); -- LAGER
    
 -- Exibição dos registros da tabela tanque
SELECT * FROM Tanque; 

-- SELECTS:
-- Exibição da temperatura máxima dos registros de tanque
SELECT TempMax FROM Tanque; 
-- Exibição dos registros de temperatura mínima em ordem decrescente da tabela tanque
SELECT TempMin FROM Tanque ORDER BY TempMin DESC; 

-- SELECTS + JOIN:
-- Exibição de todos os dados da tabela tanque junto com todos os dados da tabela sensor
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT; 
-- Exibição de todos os dados da tabela tanque junto com todos os dados da tabela sensor e leitura
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL;
-- Exibição de todos os dados da tabela tanque junto com todos os dados da tabela sensor, leitura e empresa
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL JOIN Empresa ON idEmpresa = fkEmpresaT; 
 -- Exibição de todos os dados da tabela tanque junto com todos os dados da tabela sensor, leitura, usuário e empresa
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL JOIN Empresa ON idEmpresa = fkEmpresaT JOIN Usuario ON idEmpresa = fkEmpresaU; 

-- Exibição de todos os dados da tabela tanque junto com todos os dados da tabela sensor e leitura de determinado nome de receita
SELECT * FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL WHERE Tanque.NomeReceita= 'IPA';

-- Exibição dos campos determinados da tabela usuário, sensor, leitura, tanque e empresa 
SELECT
Tanque.NomeReceita,
Leitura.DtAtual,
Sensor.idsensor, 
Empresa.cnpj, 
Usuario.nome, 
Usuario.email
FROM Tanque JOIN Sensor ON idSensor = fkSensorT JOIN Leitura ON idSensor = fkSensorL 
JOIN Empresa ON idEmpresa = fkEmpresaT JOIN Usuario ON idEmpresa = fkEmpresaU;


------------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS TIPOS DE SELECT:

SELECT TemperaturaTanque, timestampdiff(DAY,DtAtual, NOW()) AS TEMPO FROM Leitura;
        
SELECT DATE_FORMAT(DtAtual,'%d/%m/%Y') AS formatoBR FROM Leitura;
SELECT DATE_FORMAT(DtAtual,'%d/%m/%y') AS formatoBR FROM Leitura;
SELECT DATE_FORMAT(DtAtual,'%d/%M/%y') AS formatoBR FROM Leitura;
SELECT DATE_FORMAT(DtAtual,'%D/%M/%Y') AS formatoBR FROM Leitura;
SELECT DATE_FORMAT(DtAtual,'%D/%m/%y') AS formatoBR FROM Leitura;

SELECT  
CONCAT('O usuario ', Usuario.nome, ' pertence à empresa ', Empresa.Nome) AS frase FROM Usuario JOIN Empresa on idEmpresa = fkEmpresau;
    
    
-- ALTER TABLE:
-- ALTER TABLE *TABELA* ADD COLUMN *NOMEDACOLUNA* TIPO;
-- ALTER TABLE *TABELA* RENAME COLUMN *NOMEDACOLUNAATUAL* TO *NOVONOME*;
-- ALTER TABLE *TABELA* MODIFY COLUMN *NOMEDACOLUNAATUAL* *NOVOTIPO*;
-- ALTER TABLE *TABELA* DROP COLUMN *NOMEDACOLUNAATUAL*;
-- TRUNCATE TABLE *TABELA*;
-- UPDATE *TABELA* SET *COLUNAASERALTERADA* = *NOVOVALOR* WHERE *CONDIÇÃO*;
-- DELETE FROM *TABELA* WHERE *CONDIÇÃO*
