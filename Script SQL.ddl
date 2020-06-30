-- Gerado por Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   em:        2020-06-30 19:05:19 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE t_cfh_agenda CASCADE CONSTRAINTS;

DROP TABLE t_cfh_bairro CASCADE CONSTRAINTS;

DROP TABLE t_cfh_cidade CASCADE CONSTRAINTS;

DROP TABLE t_cfh_colaborador CASCADE CONSTRAINTS;

DROP TABLE t_cfh_compromisso CASCADE CONSTRAINTS;

DROP TABLE t_cfh_doacao CASCADE CONSTRAINTS;

DROP TABLE t_cfh_doacao_foto CASCADE CONSTRAINTS;

DROP TABLE t_cfh_endereco CASCADE CONSTRAINTS;

DROP TABLE t_cfh_estado CASCADE CONSTRAINTS;

DROP TABLE t_cfh_foto_usuario CASCADE CONSTRAINTS;

DROP TABLE t_cfh_interesse_usuario CASCADE CONSTRAINTS;

DROP TABLE t_cfh_metas CASCADE CONSTRAINTS;

DROP TABLE t_cfh_projeto CASCADE CONSTRAINTS;

DROP TABLE t_cfh_projeto_criterio CASCADE CONSTRAINTS;

DROP TABLE t_cfh_ranking CASCADE CONSTRAINTS;

DROP TABLE t_cfh_recebimento CASCADE CONSTRAINTS;

DROP TABLE t_cfh_tipo_colaborador CASCADE CONSTRAINTS;

DROP TABLE t_cfh_tipo_logradouro CASCADE CONSTRAINTS;

DROP TABLE t_cfh_tipo_projeto CASCADE CONSTRAINTS;

DROP TABLE t_cfh_tipo_ranking CASCADE CONSTRAINTS;

DROP TABLE t_cfh_tipo_recebimento CASCADE CONSTRAINTS;

DROP TABLE t_cfh_usuario CASCADE CONSTRAINTS;

-- predefined type, no DDL - SDO_GEOMETRYv2

-- predefined type, no DDL - XMLTYPEv2

CREATE TABLE t_cfh_agenda (
    id_agenda  NUMBER(5) NOT NULL,
    dt_agenda  DATE NOT NULL,
    ds_agenda  VARCHAR2(30) NOT NULL
);

ALTER TABLE t_cfh_agenda ADD CONSTRAINT t_cfh_agenda_pk PRIMARY KEY ( id_agenda );

CREATE TABLE t_cfh_bairro (
    t_cfh_cidade_id_cidade  NUMBER(4) NOT NULL,
    id_bairro               NUMBER(5) NOT NULL,
    ds_bairro               VARCHAR2(20) NOT NULL
);

ALTER TABLE t_cfh_bairro ADD CONSTRAINT t_cfh_bairro_pk PRIMARY KEY ( id_bairro );

CREATE TABLE t_cfh_cidade (
    id_cidade               NUMBER(4) NOT NULL,
    t_cfh_estado_id_estado  NUMBER(2) NOT NULL,
    ds_cidade               VARCHAR2(20) NOT NULL
);

ALTER TABLE t_cfh_cidade ADD CONSTRAINT t_cfh_cidade_pk PRIMARY KEY ( id_cidade );

CREATE TABLE t_cfh_colaborador (
    id_colaborador                  NUMBER(4) NOT NULL,
    t_cfh_tipo_colab_id_tipo_colab  NUMBER(1) NOT NULL,
    nm_colaborador                  VARCHAR2(30) NOT NULL,
    dt_nascimento                   DATE NOT NULL,
    ds_email                        VARCHAR2(30) NOT NULL,
    ds_senha                        VARCHAR2(10) NOT NULL
);

COMMENT ON TABLE t_cfh_colaborador IS
    'Os voluntário são aqueles que prestam algum tipo de seviço a ONG. Podem ter acesso ou não ao sistema.';

CREATE UNIQUE INDEX t_cfh_colaborador__idx ON
    t_cfh_colaborador (
        t_cfh_tipo_colab_id_tipo_colab
    ASC );

ALTER TABLE t_cfh_colaborador ADD CONSTRAINT t_cfh_colaborador_pk PRIMARY KEY ( id_colaborador );

CREATE TABLE t_cfh_compromisso (
    id_compromisso          NUMBER(5) NOT NULL,
    t_cfh_colab_id_colab    NUMBER(4),
    t_cfh_agenda_id_agenda  NUMBER(5) NOT NULL
);

ALTER TABLE t_cfh_compromisso ADD CONSTRAINT t_cfh_compromisso_pk PRIMARY KEY ( id_compromisso );

CREATE TABLE t_cfh_doacao (
    id_doacao                 NUMBER(6) NOT NULL,
    t_cfh_usuario_id_usuario  NUMBER(5) NOT NULL,
    ds_doacaoa                VARCHAR2(30) NOT NULL,
    vl_aquisicao              NUMBER(7, 2)
);

COMMENT ON COLUMN t_cfh_doacao.vl_aquisicao IS
    'Qual o valor para que alguém possa comprar o item doado.';

ALTER TABLE t_cfh_doacao ADD CONSTRAINT t_cfh_doacao_pk PRIMARY KEY ( id_doacao );

CREATE TABLE t_cfh_doacao_foto (
    id_doacao_foto          NUMBER(7) NOT NULL,
    t_cfh_doacao_id_doacao  NUMBER(6),
    im_foto                 BLOB NOT NULL
);

ALTER TABLE t_cfh_doacao_foto ADD CONSTRAINT t_cfh_doacao_foto_pk PRIMARY KEY ( id_doacao_foto );

CREATE TABLE t_cfh_endereco (
    id_endereco                   NUMBER(5) NOT NULL,
    t_cfh_tipo_logr_id_tipo_logr  NUMBER(2) NOT NULL,
    t_cfh_usuario_id_usuario      NUMBER(5) NOT NULL,
    t_cfh_bairro_id_bairro        NUMBER(5) NOT NULL,
    ds_logradouro                 VARCHAR2(30) NOT NULL,
    nr_logradouro                 NUMBER(4) NOT NULL,
    ds_cep                        NUMBER(8) NOT NULL
);

ALTER TABLE t_cfh_endereco ADD CONSTRAINT t_cfh_endereco_pk PRIMARY KEY ( id_endereco );

CREATE TABLE t_cfh_estado (
    id_estado   NUMBER(2) NOT NULL,
    cod_estado  CHAR(2) NOT NULL,
    ds_estado   VARCHAR2(15) NOT NULL
);

ALTER TABLE t_cfh_estado ADD CONSTRAINT t_cfh_estado_pk PRIMARY KEY ( id_estado );

CREATE TABLE t_cfh_foto_usuario (
    id_foto                   NUMBER(5) NOT NULL,
    t_cfh_usuario_id_usuario  NUMBER(5) NOT NULL,
    im_foto                   BLOB NOT NULL
);

COMMENT ON COLUMN t_cfh_foto_usuario.im_foto IS
    'im = Imagem.';

ALTER TABLE t_cfh_foto_usuario ADD CONSTRAINT t_cfh_foto_usuario_pk PRIMARY KEY ( id_foto );

CREATE TABLE t_cfh_interesse_usuario (
    id_interesse              NUMBER(5) NOT NULL,
    t_cfh_usuario_id_usuario  NUMBER(5) NOT NULL,
    ds_interesse              VARCHAR2(60) NOT NULL
);

ALTER TABLE t_cfh_interesse_usuario ADD CONSTRAINT t_cfh_interesse_usuario_pk PRIMARY KEY ( id_interesse );

CREATE TABLE t_cfh_metas (
    id_meta               NUMBER(5) NOT NULL,
    t_cfh_colab_id_colab  NUMBER(4) NOT NULL,
    dt_inicio             DATE NOT NULL,
    ds_meta               VARCHAR2(60) NOT NULL,
    dt_conclusao          DATE NOT NULL
);

ALTER TABLE t_cfh_metas ADD CONSTRAINT t_cfh_metas_pk PRIMARY KEY ( id_meta,
                                                                    t_cfh_colab_id_colab );

CREATE TABLE t_cfh_projeto (
    id_projeto                    NUMBER(5) NOT NULL,
    t_cfh_tipo_proj_id_tipo_proj  NUMBER(3) NOT NULL,
    t_cfh_colab_id_colab          NUMBER(4) NOT NULL,
    ds_projeto                    VARCHAR2(60) NOT NULL,
    dt_inicio_projeto             DATE NOT NULL
);

ALTER TABLE t_cfh_projeto ADD CONSTRAINT t_cfh_projeto_pk PRIMARY KEY ( id_projeto );

CREATE TABLE t_cfh_projeto_criterio (
    id_projeto_criterio  NUMBER(5) NOT NULL,
    t_cfh_proj_id_proj   NUMBER(5),
    ds_criterio          VARCHAR2(60) NOT NULL
);

ALTER TABLE t_cfh_projeto_criterio ADD CONSTRAINT t_cfh_projeto_criterio_pk PRIMARY KEY ( id_projeto_criterio );

CREATE TABLE t_cfh_ranking (
    id_ranking              NUMBER(3) NOT NULL,
    t_cfh_tp_rnk_id_tp_rnk  NUMBER(2) NOT NULL,
    nm_pontuacao_atual      NUMBER(5)
);

ALTER TABLE t_cfh_ranking ADD CONSTRAINT t_cfh_ranking_pk PRIMARY KEY ( id_ranking );

CREATE TABLE t_cfh_recebimento (
    id_recebimento              NUMBER(6) NOT NULL,
    t_cfh_usuario_id_usuario    NUMBER(5),
    t_cfh_tp_receb_id_to_receb  NUMBER(1) NOT NULL,
    dt_recebimento              DATE NOT NULL,
    vl_recebimento              NUMBER(10, 2) NOT NULL
);

ALTER TABLE t_cfh_recebimento ADD CONSTRAINT t_cfh_recebimento_pk PRIMARY KEY ( id_recebimento );

CREATE TABLE t_cfh_tipo_colaborador (
    id_tipo_colaborador  NUMBER(1) NOT NULL,
    ds_tipo_colaborador  CHAR(3) NOT NULL
);

COMMENT ON COLUMN t_cfh_tipo_colaborador.ds_tipo_colaborador IS
    'ADM - Administrador
USU - Usuário';

ALTER TABLE t_cfh_tipo_colaborador ADD CONSTRAINT t_cfh_tipo_colaborador_pk PRIMARY KEY ( id_tipo_colaborador );

CREATE TABLE t_cfh_tipo_logradouro (
    id_tipo_logradouro  NUMBER(2) NOT NULL,
    ds_tipo_lograouro   VARCHAR2(20) NOT NULL
);

ALTER TABLE t_cfh_tipo_logradouro ADD CONSTRAINT t_cfh_tipo_logradouro_pk PRIMARY KEY ( id_tipo_logradouro );

CREATE TABLE t_cfh_tipo_projeto (
    id_tipo_projeto  NUMBER(3) NOT NULL,
    ds_tipo_projeto  VARCHAR2(20) NOT NULL
);

ALTER TABLE t_cfh_tipo_projeto ADD CONSTRAINT t_cfh_tipo_projeto_pk PRIMARY KEY ( id_tipo_projeto );

CREATE TABLE t_cfh_tipo_ranking (
    id_tipo_ranking  NUMBER(2) NOT NULL,
    ds_ranking       VARCHAR2(10) NOT NULL,
    nm_pontos        NUMBER(5) NOT NULL
);

ALTER TABLE t_cfh_tipo_ranking ADD CONSTRAINT t_cfh_tipo_ranking_pk PRIMARY KEY ( id_tipo_ranking );

CREATE TABLE t_cfh_tipo_recebimento (
    id_tipo_recebimento  NUMBER(1) NOT NULL,
    ds_tipo_recebimento  VARCHAR2(20) NOT NULL
);

ALTER TABLE t_cfh_tipo_recebimento ADD CONSTRAINT t_cfh_tipo_recebimento_pk PRIMARY KEY ( id_tipo_recebimento );

CREATE TABLE t_cfh_usuario (
    id_usuario                NUMBER(5) NOT NULL,
    t_cfh_ranking_id_ranking  NUMBER(3),
    nm_usuario                VARCHAR2(30) NOT NULL,
    dt_nascimento             DATE NOT NULL,
    ds_cpf                    NUMBER(11) NOT NULL,
    ds_email                  VARCHAR2(15) NOT NULL,
    ds_senha                  VARCHAR2(8) NOT NULL
);

ALTER TABLE t_cfh_usuario ADD CONSTRAINT t_cfh_usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE t_cfh_bairro
    ADD CONSTRAINT t_cfh_bairro_t_cfh_cidade_fk FOREIGN KEY ( t_cfh_cidade_id_cidade )
        REFERENCES t_cfh_cidade ( id_cidade );

ALTER TABLE t_cfh_cidade
    ADD CONSTRAINT t_cfh_cid_t_cfh_est_fk FOREIGN KEY ( t_cfh_estado_id_estado )
        REFERENCES t_cfh_estado ( id_estado );

ALTER TABLE t_cfh_colaborador
    ADD CONSTRAINT t_cfh_clbd_t_cfh_tp_clbd_fk FOREIGN KEY ( t_cfh_tipo_colab_id_tipo_colab )
        REFERENCES t_cfh_tipo_colaborador ( id_tipo_colaborador );

ALTER TABLE t_cfh_compromisso
    ADD CONSTRAINT t_cfh_cmp_t_cfh_agnd_fk FOREIGN KEY ( t_cfh_agenda_id_agenda )
        REFERENCES t_cfh_agenda ( id_agenda );

ALTER TABLE t_cfh_compromisso
    ADD CONSTRAINT t_cfh_cmp_t_cfh_cl_fk FOREIGN KEY ( t_cfh_colab_id_colab )
        REFERENCES t_cfh_colaborador ( id_colaborador );

ALTER TABLE t_cfh_doacao_foto
    ADD CONSTRAINT t_cfh_doa_ft_t_cfh_doa_fk FOREIGN KEY ( t_cfh_doacao_id_doacao )
        REFERENCES t_cfh_doacao ( id_doacao );

ALTER TABLE t_cfh_doacao
    ADD CONSTRAINT t_cfh_doacao_t_cfh_usuario_fk FOREIGN KEY ( t_cfh_usuario_id_usuario )
        REFERENCES t_cfh_usuario ( id_usuario );

ALTER TABLE t_cfh_endereco
    ADD CONSTRAINT t_cfh_end_t_cfh_tipo_logr_fk FOREIGN KEY ( t_cfh_tipo_logr_id_tipo_logr )
        REFERENCES t_cfh_tipo_logradouro ( id_tipo_logradouro );

ALTER TABLE t_cfh_endereco
    ADD CONSTRAINT t_cfh_end_t_cfh_usuario_fk FOREIGN KEY ( t_cfh_usuario_id_usuario )
        REFERENCES t_cfh_usuario ( id_usuario );

ALTER TABLE t_cfh_endereco
    ADD CONSTRAINT t_cfh_endereco_t_cfh_bairro_fk FOREIGN KEY ( t_cfh_bairro_id_bairro )
        REFERENCES t_cfh_bairro ( id_bairro );

ALTER TABLE t_cfh_foto_usuario
    ADD CONSTRAINT t_cfh_ft_usu_t_cfh_usu_fk FOREIGN KEY ( t_cfh_usuario_id_usuario )
        REFERENCES t_cfh_usuario ( id_usuario );

ALTER TABLE t_cfh_interesse_usuario
    ADD CONSTRAINT t_cfh_int_usu_t_cfh_usu_fk FOREIGN KEY ( t_cfh_usuario_id_usuario )
        REFERENCES t_cfh_usuario ( id_usuario );

ALTER TABLE t_cfh_metas
    ADD CONSTRAINT t_cfh_metas_t_cfh_colab_fk FOREIGN KEY ( t_cfh_colab_id_colab )
        REFERENCES t_cfh_colaborador ( id_colaborador );

ALTER TABLE t_cfh_projeto_criterio
    ADD CONSTRAINT t_cfh_proj_crit_t_cfh_proj_fk FOREIGN KEY ( t_cfh_proj_id_proj )
        REFERENCES t_cfh_projeto ( id_projeto );

ALTER TABLE t_cfh_projeto
    ADD CONSTRAINT t_cfh_proj_t_cfh_colab_fk FOREIGN KEY ( t_cfh_colab_id_colab )
        REFERENCES t_cfh_colaborador ( id_colaborador );

ALTER TABLE t_cfh_projeto
    ADD CONSTRAINT t_cfh_proj_t_cfh_tipo_proj_fk FOREIGN KEY ( t_cfh_tipo_proj_id_tipo_proj )
        REFERENCES t_cfh_tipo_projeto ( id_tipo_projeto );

ALTER TABLE t_cfh_recebimento
    ADD CONSTRAINT t_cfh_rcb_t_cfh_tp_rcb_fk FOREIGN KEY ( t_cfh_tp_receb_id_to_receb )
        REFERENCES t_cfh_tipo_recebimento ( id_tipo_recebimento );

ALTER TABLE t_cfh_recebimento
    ADD CONSTRAINT t_cfh_receb_t_cfh_usu_fk FOREIGN KEY ( t_cfh_usuario_id_usuario )
        REFERENCES t_cfh_usuario ( id_usuario );

ALTER TABLE t_cfh_ranking
    ADD CONSTRAINT t_cfh_rnk_t_cfh_tp_rnk_fk FOREIGN KEY ( t_cfh_tp_rnk_id_tp_rnk )
        REFERENCES t_cfh_tipo_ranking ( id_tipo_ranking );

ALTER TABLE t_cfh_usuario
    ADD CONSTRAINT t_cfh_usuario_t_cfh_ranking_fk FOREIGN KEY ( t_cfh_ranking_id_ranking )
        REFERENCES t_cfh_ranking ( id_ranking );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            22
-- CREATE INDEX                             1
-- ALTER TABLE                             42
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
