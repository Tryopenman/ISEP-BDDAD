
-- Exercício 5 - 1
SELECT * FROM CD;

-- Exercício 5 - 2
SELECT * FROM MUSICA;

-- Exercício 5 - A - 1
SELECT titulo,dataCompra FROM CD;

-- Exercicio 5 - A - 2 
SELECT DISTINCT dataCompra FROM CD;

-- Exercicio 5 - A - 3
SELECT DISTINCT codCD,interprete FROM MUSICA;

-- Exercicio 5 - A - 4
SELECT DISTINCT codCD as "Código do CD",interprete FROM MUSICA;

-- Exercicio 5 - A - 5
SELECT titulo,valorPago, TRUNC((valorPago*0.23)/1.23,2) as "IVA_Pago" FROM CD;

-- Exercicio 5 - B - 1
SELECT * FROM MUSICA WHERE codCD = 2;

-- Exercicio 5 - B - 2
SELECT * FROM MUSICA WHERE codCD != 2;

-- Exercicio 5 - B - 3
SELECT * FROM MUSICA WHERE codCD = 2 AND duracao BETWEEN 4 AND 6;

-- Exercicio 5 - B - 4
SELECT * FROM MUSICA WHERE codCD = 2 AND (duracao < 4 OR duracao > 6);

-- Exercicio 5 - B - 5
SELECT * FROM MUSICA WHERE CODCD = 1 OR CODCD = 3 OR CODCD = 5 OR CODCD = 6;
-- OU
SELECT * FROM MUSICA WHERE codCD IN (1, 3, 5, 6);

-- Exercicio 5 - B - 6
SELECT * FROM MUSICA WHERE nrMusica != 1 AND nrMusica != 3 AND nrMusica != 5 AND nrMusica != 6;
-- OU
SELECT * FROM MUSICA WHERE nrMusica NOT IN (1, 3, 5, 6);

-- Exercicio 5 - B - 7
SELECT * FROM MUSICA WHERE interprete LIKE 'Orquestra%';
-- Utilizar o UPPER para garantir
SELECT * FROM MUSICA WHERE UPPER(interprete) LIKE UPPER('Orquestra%');

-- Exercicio 5 - B - 8
SELECT * FROM MUSICA WHERE UPPER(interprete) LIKE UPPER('%y%');

-- Exercicio 5 - B - 9
SELECT * FROM MUSICA WHERE UPPER(TITULO) LIKE UPPER('%DAL_');

-- Exercicio 5 - B - 10
SELECT * FROM MUSICA WHERE titulo LIKE '%\%%' ESCAPE '\';

-- Exercicio 5 - B - 11
SELECT * FROM MUSICA WHERE UPPER(titulo) LIKE UPPER ('B%') OR UPPER(titulo) LIKE UPPER ('D%') OR UPPER(titulo) LIKE UPPER ('H%');

-- Exercicio 5 - B - 12
SELECT * FROM CD WHERE localCompra IS NULL;

-- Exercicio 5 - B - 13
SELECT * FROM CD WHERE localCompra IS NOT NULL;

-- Exercicio 5 - C - 1
SELECT TITULO FROM CD WHERE UPPER(localCompra) LIKE UPPER('FNAC');

-- Exercicio 5 - C - 2
SELECT TITULO FROM CD WHERE UPPER(localCompra) NOT LIKE UPPER('FNAC') or localCompra IS NULL;
-- OU
SELECT TITULO FROM CD WHERE UPPER(localCompra) != UPPER('FNAC') or localCompra IS NULL;

-- Exercicio 5 - D - 1 
SELECT TITULO FROM CD WHERE UPPER(localCompra) NOT LIKE UPPER('FNAC') or localCompra IS NULL ORDER BY titulo DESC;

-- Exercicio 5 - D - 2
SELECT titulo, dataCompra FROM CD ORDER BY dataCompra DESC;

-- Exercicio 5 - D - 3
SELECT titulo, dataCompra FROM CD ORDER BY dataCompra ASC; -- Pode nao ter o ASC pois o padrao ja ordena.

-- Exercicio 5 - D - 4
SELECT titulo,valorPago, TRUNC((valorPago*0.23)/1.23,2) as "IVA_PAGO" FROM CD ORDER BY IVA_PAGO DESC;

-- Exercicio 5 - D - 5
SELECT TITULO, DATACOMPRA FROM CD ORDER BY DATACOMPRA DESC, TITULO;

-- Exercicio 5 - E - 1
SELECT COUNT(DISTINCT LOCALCOMPRA) AS "QuantidadeLocaisCompra" FROM CD;

-- Exercicio 5 - E - 2
SELECT SUM(valorPago) as "TOTAL", MAX(valorPago) as "MAIOR", MIN(valorPago) as "MENOR" FROM CD;

-- Exercicio 5 - E - 3
SELECT TRUNC(AVG(duracao),2) as "DURACAO_MEDIA" FROM MUSICA;

-- Exercicio 5 - E - 4
SELECT SUM(valorPago) as "TOTAL_FNAC" FROM CD WHERE UPPER(localCompra) = UPPER('FNAC');

-- Exercicio 5 - E - 5
SELECT MAX(valorPago)-MIN(valorPago) as "DIFERENCA_FNAC" FROM CD WHERE UPPER(localCompra) = UPPER('FNAC');




