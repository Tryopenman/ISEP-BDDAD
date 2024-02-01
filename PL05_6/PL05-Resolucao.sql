--Exercicio 5 - 1
SELECT localCompra, COUNT(*) as "QUANTIDADE_CD" FROM CD GROUP BY localCompra;

--Exercicio 5 - 2
SELECT localCompra, COUNT(*) as "QUANTIDADE_CD" FROM CD GROUP BY localCompra ORDER BY QUANTIDADE_CD;

--Exercicio 5 - 3
SELECT COUNT(DISTINCT idEditora) as QUANTIDADE_EDITORA,localCompra FROM CD GROUP BY localCompra ORDER BY QUANTIDADE_EDITORA ASC;

--Exercicio 5 - 4
SELECT COUNT (DISTINCT idEditora) as QUANTIDADE_EDITORA, localCompra, SUM(valorPago) as TOTAL, MAX(valorPago) as MAIOR FROM CD WHERE localCompra IS NOT NULL GROUP BY localCompra ORDER BY QUANTIDADE_EDITORA DESC;

--Exercicio 5 - 5
SELECT codCD,interprete,COUNT(interprete) AS QUANTIDADE_MUSICAS FROM MUSICA GROUP BY codCD,interprete ORDER BY codCD;

--Exercicio 5 - 6
SELECT localCompra, COUNT(*) as "QUANTIDADE_CD" FROM CD GROUP BY localCompra HAVING COUNT(*) > 2;

--Exercicio 5 - 7
SELECT localCompra, SUM(valorPago) as TOTAL FROM CD GROUP BY localCompra HAVING AVG(valorPago) < 10;

--Exercicio 5 - 8
SELECT localCompra, SUM(valorPago) as TOTAL FROM CD GROUP BY localCompra HAVING COUNT(*) > 2;

--Exercicio 5 - 9
SELECT codCD, interprete FROM MUSICA GROUP BY codCD, interprete HAVING COUNT(interprete) = 1 ORDER BY codCD, interprete;

--Exercicio 5 - 10
SELECT distinct interprete FROM MUSICA WHERE UPPER(interprete) LIKE UPPER('L%')OR UPPER(interprete) LIKE UPPER('E%') GROUP BY codCD, interprete HAVING COUNT(interprete) = 1 
    ORDER BY interprete;

--Exercicio 5 - 11
SELECT TO_CHAR(dataCompra,'DAY') AS DIASEMANA, COUNT(*) AS QUANTIDADE_CDs FROM CD WHERE localCompra IS NOT NULL GROUP BY TO_CHAR(dataCompra,'DAY') HAVING COUNT(*) >=2;

--Exercicio 5 - 12
SELECT titulo,(SELECT COUNT(*) FROM MUSICA WHERE MUSICA.codCD = CD.codCD) as QUANTIDADE_MUSICAS FROM CD GROUP BY codCD,titulo ORDER BY QUANTIDADE_MUSICAS DESC;
--OU
SELECT CD.titulo AS titulo, COUNT(*) AS quantidade_musicas FROM cd
JOIN Musica ON Musica.codCD = CD.codCD
GROUP BY cd.titulo ORDER BY quantidade_musicas DESC;

--Exercicio 5 - 13
SELECT codCD,titulo,(SELECT COUNT(*) FROM MUSICA WHERE MUSICA.codCD = CD.codCD) as QUANTIDADE_MUSICAS FROM CD GROUP BY codCD,titulo ORDER BY QUANTIDADE_MUSICAS DESC;
--OU
SELECT CD.codCD,CD.titulo, COUNT(*) AS quantidade_musicas FROM cd
JOIN Musica ON Musica.codCD = CD.codCD
GROUP BY CD.codCD,cd.titulo ORDER BY quantidade_musicas DESC;

--Exercicio 5 - 14
SELECT codCD, titulo,
  (SELECT COUNT(*) FROM MUSICA WHERE MUSICA.codCD = CD.codCD AND MUSICA.duracao > 5) AS QUANTIDADE_MUSICAS
FROM CD
GROUP BY codCD, titulo
HAVING (SELECT COUNT(*) FROM MUSICA WHERE MUSICA.codCD = CD.codCD AND MUSICA.duracao > 5) > 0
ORDER BY QUANTIDADE_MUSICAS DESC;
--OU
SELECT cd.codCD AS codcd, cd.titulo AS titulo, COUNT(musica.codCD) AS quantidade_musicas
FROM cd
JOIN musica ON cd.codCD = musica.codCD
WHERE musica.duracao > 5
GROUP BY cd.codCD, cd.titulo ORDER BY quantidade_musicas;

--Exercicio 5 - 15
SELECT CD.codCD, CD.titulo,(SELECT COUNT(*) FROM MUSICA WHERE Musica.codCD = CD.codCD) AS QUANTIDADE_MUSICAS FROM CD GROUP BY CD.codCD,CD.titulo HAVING (SELECT COUNT(*) FROM MUSICA WHERE Musica.codCD = CD.codCD) < 6 AND (SELECT COUNT(*) FROM MUSICA WHERE Musica.codCD = CD.codCD) > 0 ORDER BY QUANTIDADE_MUSICAS DESC;
--OU
SELECT CD.codCD,CD.titulo, COUNT(*) AS QUANTIDADE_MUSICAS FROM CD 
JOIN MUSICA ON CD.codCD = MUSICA.codCD GROUP BY CD.codCD, CD.titulo HAVING COUNT(*) < 6
ORDER BY QUANTIDADE_MUSICAS DESC;

--Exercicio 5 - 16
SELECT CD.codCD, CD.titulo,(SELECT COUNT(*) FROM MUSICA WHERE Musica.codCD = CD.codCD) AS QUANTIDADE_MUSICAS FROM CD WHERE (SELECT AVG(duracao) FROM MUSICA WHERE Musica.codCD = CD.codCD) > 4 GROUP BY CD.codCD,CD.titulo ORDER BY QUANTIDADE_MUSICAS DESC;
--OU
SELECT CD.codCD,CD.titulo, COUNT(*) AS QUANTIDADE_MUSICAS FROM CD 
JOIN MUSICA ON CD.codCD = MUSICA.codCD GROUP BY CD.codCD, CD.titulo
HAVING AVG(MUSICA.duracao) > 4
ORDER BY QUANTIDADE_MUSICAS DESC;

--Exercicio 5 - 17
SELECT DISTINCT Musica.titulo || ' : ' || CD.titulo AS Titulos FROM MUSICA,CD
WHERE Musica.codCd = CD.codCd AND CD.codCd IN (SELECT codCd FROM Musica GROUP BY codCd HAVING COUNT(interprete) >= 3);

--Exercicio 5 - 18
SELECT DISTINCT Musica.titulo || ' : ' || CD.titulo AS Titulos FROM MUSICA,CD
WHERE Musica.codCd = CD.codCd AND CD.codCd IN (SELECT codCd FROM Musica GROUP BY codCd HAVING COUNT(interprete) >= 3);

--Exercicio 5 - 19
SELECT DISTINCT Musica.titulo || ' : ' || CD.titulo AS Titulos,LENGTH(Musica.titulo || ' : ' || CD.titulo) AS Comprimento FROM MUSICA, CD WHERE Musica.codCd = CD.codCd AND CD.codCd IN (SELECT codCd FROM Musica GROUP BY codCd HAVING COUNT(interprete) >= 3) ORDER BY Comprimento DESC;

--Exercicio 5 - 20
SELECT DISTINCT cd.titulo FROM cd, musica WHERE cd.codCd = musica.codCd AND cd.titulo = musica.titulo AND (SELECT SUM(duracao) FROM musica WHERE codCd = cd.codCd) > 35;
--OU
SELECT DISTINCT cd.titulo FROM cd
JOIN musica ON cd.codCd = musica.codCd WHERE cd.titulo = musica.titulo AND (SELECT SUM(duracao) FROM musica musica WHERE musica.codCd = cd.codCd)> 35;



