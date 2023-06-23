

--Cria a tabela coordenadores;

CREATE TABLE coordenadores (
                id_coordenador 							NUMERIC(38) NOT NULL,
                nome_coordenador 						VARCHAR(255) NOT NULL,
                email 								VARCHAR(255) NOT NULL,
                CONSTRAINT id_coordenador_pk PRIMARY KEY (id_coordenador)
);

--Comentários da tabela e colunas;

COMMENT ON TABLE coordenadores IS 						'Tabela referente aos coordenadores.';
COMMENT ON COLUMN coordenadores.id_coordenador IS 				'Número de identificação dos coordenadores.';
COMMENT ON COLUMN coordenadores.nome_coordenador IS 				'Nome dos coordenadores.';
COMMENT ON COLUMN coordenadores.email IS 					'Email de contato dos coordenadores.';

--Cria a tabela alunos;

CREATE TABLE alunos (
                matricula 							VARCHAR(10) NOT NULL,
                nome_aluno 							VARCHAR(255) NOT NULL,
                email 								VARCHAR(255) NOT NULL,
                curso 								VARCHAR(40) NOT NULL,
                endereco 							VARCHAR(512) NOT NULL,
                CONSTRAINT nome_aluno_pk PRIMARY KEY (matricula)
);

--Comentários da tabela e colunas;

COMMENT ON TABLE alunos IS 							'Tabela referente aos alunos.';
COMMENT ON COLUMN alunos.matricula IS 						'Número de matrícula dos alunos.';
COMMENT ON COLUMN alunos.nome_aluno IS 						'Nome dos alunos.';
COMMENT ON COLUMN alunos.email IS 						'Email dos alunos.';
COMMENT ON COLUMN alunos.curso IS 						'Curso dos alunos.';
COMMENT ON COLUMN alunos.endereco IS 						'Endereço dos alunos.';

--Cria a tabela certificados;

CREATE TABLE certificados (
                id_certificado 							NUMERIC(38) NOT NULL,
                data_envio 							TIMESTAMP NOT NULL,
                materia 							VARCHAR(100) NOT NULL,
                situacao 							VARCHAR(15) NOT NULL,
                id_coordenador 							NUMERIC(38) NOT NULL,
                matricula 							VARCHAR(10) NOT NULL,
                CONSTRAINT id_certificado_pk PRIMARY KEY (id_certificado)
);

--Comentários da tabela e colunas;

COMMENT ON TABLE certificados IS 						'Tabela referente aos certificados enviados pelos alunos.';
COMMENT ON COLUMN certificados.id_certificado IS 				'Número que identifica o certificado.';
COMMENT ON COLUMN certificados.data_envio IS 					'Data que enviou o certificado.';
COMMENT ON COLUMN certificados.materia IS 					'Matéria dos certificados dos alunos.';
COMMENT ON COLUMN certificados.situacao IS 					'Situação do certificado: Aprovado, Pendente e Reprovado.';
COMMENT ON COLUMN certificados.id_coordenador IS 				'Número de identificação dos coordenadores.';
COMMENT ON COLUMN certificados.matricula IS 					'Número de matrícula dos alunos.';

--Cria a tabela login;

CREATE TABLE login (
                matricula 							VARCHAR(10) 				NOT NULL,
                id_coordenador 							NUMERIC(38) 				NOT NULL,
                senha_coordenador 						VARCHAR(20) 				NOT NULL,
                senha_aluno 							VARCHAR(20) 				NOT NULL,
                CONSTRAINT matricula_id_coordenador PRIMARY KEY (matricula, id_coordenador)
);

--Comentários da tabela e colunas;

COMMENT ON TABLE login IS 							'Tabela referente ao login dos alunos e coordenadores.';
COMMENT ON COLUMN login.matricula IS 						'Número de matrícula dos alunos.';
COMMENT ON COLUMN login.id_coordenador IS 					'Número de identificação dos coordenadores.';
COMMENT ON COLUMN login.senha_coordenador IS 					'Senha de acesso dos coordenadores.';
COMMENT ON COLUMN login.senha_aluno IS 						'Senha de acesso dos alunos.';

/*Esses comandos são responsáveis por gerar as chaves estrangeiras para todas as tabelas do banco de dados atividadescomplementares*/

ALTER TABLE login 								ADD CONSTRAINT coordenadores_login_fk
FOREIGN KEY (id_coordenador)
REFERENCES coordenadores (id_coordenador)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE certificados 							ADD CONSTRAINT coordenadores_certificados_fk
FOREIGN KEY (id_coordenador)
REFERENCES coordenadores (id_coordenador)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE login 								ADD CONSTRAINT alunos_login_fk
FOREIGN KEY (matricula)
REFERENCES alunos (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE certificados 							ADD CONSTRAINT alunos_certificados_fk
FOREIGN KEY (matricula)
REFERENCES alunos (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Essa restrição é usada para impedir que a coluna situação adicione valores diferentes de: Aprovado, Reprovado e Pendente;

ALTER TABLE certificados 	ADD CONSTRAINT situacao 					CHECK (situacao IN('Aprovado', 'Reprovado', 'Pendente'));

--Essa restrição é usada para indicar que os endereços dos alunos não podem ser nula;

ALTER TABLE alunos 		ADD CONSTRAINT endereco 					CHECK (endereco IS NOT NULL AND endereco <> '');

--Essa restrição é usada para indicar que os ids dos certificados não podem ser nulas;

ALTER TABLE certificados 	ADD CONSTRAINT check_certificado				CHECK (id_certificado > 0);

--Essa restrição é usada para indicar que os ids dos coordenadores não podem ser nulas;

ALTER TABLE coordenadores       ADD CONSTRAINT check_coordenador                     		CHECK (id_coordenador > 0);


