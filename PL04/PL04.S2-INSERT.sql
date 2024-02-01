
-- ** tabela cd **

INSERT INTO cd VALUES (1, 'Punkzilla', TO_DATE('22/April/2013','DD/MON/YY'), 55.00 , 'FNAC');
INSERT INTO cd VALUES (2, 'Classic Duets', TO_DATE('21/May/2019','DD/MON/YY'), 30.50, 'Worten');
INSERT INTO cd VALUES (3, 'The Wall', TO_DATE('22/April/2013','DD/MON/YY'), 25.80, 'FNAC');
INSERT INTO cd VALUES (4, 'Hits 4', TO_DATE('10/September/2019','DD/MON/YY'), 42.30, 'Worten');
INSERT INTO cd VALUES (5, 'Songs of Experience', TO_DATE('1/January/2020','DD/MON/YY'), 10.99, NULL);
INSERT INTO cd VALUES (6, 'Giesta 2', TO_DATE('15/June/2019','DD/MON/YY'), 9.10, NULL);

-- ** tabela musica **

INSERT INTO musica VALUES (1, 1, 'Dream of Waking', 'AFI', 3.05);
INSERT INTO musica VALUES (2, 1, 'Still', 'Rufio', 3.02);
INSERT INTO musica VALUES (3, 1, 'Behind the Music', 'The Vandals', 2.41);
INSERT INTO musica VALUES (4, 1, 'Why Are You Alive', 'The Vandals', 2.34);
INSERT INTO musica VALUES (5, 1, 'Vandals', 'The Vandals', 4.01);
INSERT INTO musica VALUES (6, 1, 'Days of the Phoenix', 'AFI', 3.28);
INSERT INTO musica VALUES (7, 1, 'Wester', 'AFI', 3.02);

INSERT INTO musica VALUES (1, 2, 'Bizet: Les p�cheurs de perles...', 'Orquestra Filarm�nica Real', 5.24);
INSERT INTO musica VALUES (2, 2, 'Verdi: Otello/Act 2', 'Orquestra Sinf�nica Chicago', 6.47);
INSERT INTO musica VALUES (3, 2, 'Verdi: Aida/Act 4', 'Loring Maazel', 4.38);
INSERT INTO musica VALUES (4, 2, 'Puccini: Turandot', 'Zubin Mehta', 3.08);

INSERT INTO musica VALUES (1, 3, 'In the Flesh', 'Pink Floyd', 3.20);
INSERT INTO musica VALUES (2, 3, 'The Thin Lee', 'Pink Floyd', 2.30);
INSERT INTO musica VALUES (3, 3, 'Mother', 'Pink Floyd', 5.34);
INSERT INTO musica VALUES (4, 3, 'Don''t Leave Me Now', 'Pink Floyd', 4.17);
INSERT INTO musica VALUES (5, 3, 'Young Lust', 'Pink Floyd', 3.33);

INSERT INTO musica VALUES (1, 4, 'It''s Alright(Baby''s Coming Back)', 'Eurythmics', 3.05);
INSERT INTO musica VALUES (2, 4, 'Hounds of Love' , 'Kate Bush', 3.02);
INSERT INTO musica VALUES (3, 4, 'Calling America', 'Electric Light Orchestra', 2.41);
INSERT INTO musica VALUES (4, 4, 'Suspicious Minds', 'Fine Young Cannibals', 2.34);
INSERT INTO musica VALUES (5, 4, 'I''m Your Man', 'Wham!', 3.28);

INSERT INTO musica VALUES (1, 5, 'Love is All We Have Left', 'U2', 2.41);
INSERT INTO musica VALUES (2, 5, 'Lights of Home' , 'U2', 4.16);
INSERT INTO musica VALUES (3, 5, 'You''re the Best Thing About Me', 'U2', 3.45);
INSERT INTO musica VALUES (4, 5, 'Get Out of Your Own Way', 'U2', 3.58);
INSERT INTO musica VALUES (5, 5, 'American Soul', 'U2', 4.21);
INSERT INTO musica VALUES (6, 5, 'Summer of Love', 'U2', 3.24);
INSERT INTO musica VALUES (7, 5, 'Red Flag Day', 'U2', 3.19);
INSERT INTO musica VALUES (8, 5, 'The Showman', 'U2', 3.23);

INSERT INTO musica VALUES (1, 6, 'Valsa em Espiral', 'Miguel Ara�jo', 3.34);
INSERT INTO musica VALUES (2, 6, '1987' , 'Miguel Ara�jo', 4.12);
INSERT INTO musica VALUES (3, 6, 'Meio Conto', 'Miguel Ara�jo', 3.13);
INSERT INTO musica VALUES (4, 6, 'Via Norte', 'Miguel Ara�jo', 3.35);
INSERT INTO musica VALUES (5, 6, 'Sangemil', 'Miguel Ara�jo', 4.03);
INSERT INTO musica VALUES (6, 6, 'Lurdes Valsa Lenta', 'Miguel Ara�jo', 4.41);
INSERT INTO musica VALUES (7, 6, 'Axl Rose', 'Miguel Ara�jo', 5.03);
INSERT INTO musica VALUES (8, 6, '20% Mais', 'Miguel Ara�jo', 1.20);
INSERT INTO musica VALUES (9, 6, 'V�ndalo', 'Miguel Ara�jo', 4.45);
INSERT INTO musica VALUES (10, 6, 'Aqui Dali', 'Miguel Ara�jo', 4.45);

-- ** guardar em DEFINITIVO as altera��es na base de dados, se a op��o Autocommit do SQL Developer n�o estiver ativada **
-- COMMIT;
