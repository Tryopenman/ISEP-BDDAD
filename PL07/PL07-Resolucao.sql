--Exercicio 5 - A - 1 - a
SELECT idMarinheiro,nome,classificacao FROM Marinheiro WHERE classificacao = (SELECT MAX(classificacao) FROM MARINHEIRO) ORDER BY idMarinheiro;

--Exercicio 5 - A - 1 - b
SELECT idMarinheiro,nome,classificacao FROM Marinheiro WHERE classificacao >= ALL(SELECT classificacao FROM MARINHEIRO) ORDER BY idMarinheiro;

--Exercicio 5 - A - 1 - c
SELECT idMarinheiro, nome, classificacao FROM marinheiro 
JOIN (SELECT MAX(classificacao) AS melhorClassificacao FROM marinheiro) subquery ON classificacao = subquery.melhorClassificacao;

--Exercicio 5 - A - 2 - a
SELECT idMarinheiro,nome FROM Marinheiro WHERE idMarinheiro NOT IN (SELECT idMarinheiro FROM Reserva) ORDER BY idMarinheiro;

--Exercicio 5 - A - 2 - b
SELECT idMarinheiro,nome FROM Marinheiro WHERE NOT idMarinheiro  =ANY (SELECT idMarinheiro FROM Reserva) ORDER BY idMarinheiro;

--Exercicio 5 - A - 2 - c
SELECT idMarinheiro,nome FROM Marinheiro
MINUS
SELECT Reserva.idMarinheiro, Marinheiro.nome FROM RESERVA
JOIN marinheiro ON Reserva.idMarinheiro = Marinheiro.idMarinheiro;

--Exercicio 5 - A - 3
SELECT COUNT(DISTINCT idMarinheiro) AS QTD_MARINHEIRO
FROM RESERVA
WHERE idMarinheiro IN (
    SELECT idMarinheiro FROM RESERVA WHERE idBarco IN (SELECT idBarco FROM BARCO WHERE cor = 'vermelho')
    INTERSECT
    SELECT idMarinheiro FROM RESERVA WHERE idBarco IN (SELECT idBarco FROM BARCO WHERE cor = 'verde')
);


--Exercicio 5 - A - 4
SELECT idMarinheiro,nome, (SELECT COUNT(*) FROM RESERVA WHERE MARINHEIRO.idMarinheiro = RESERVA.idMarinheiro) AS QTD_RESERVAS FROM MARINHEIRO ORDER BY QTD_RESERVAS DESC;

--Exercicio 5 - A - 5
SELECT idMarinheiro, idBarco, COUNT(*) AS QTD_RESERVASFROM FROM RESERVA r1
GROUP BY idMarinheiro, idBarco 
HAVING COUNT(*) > (SELECT AVG(COUNTS) FROM (SELECT COUNT(*) AS COUNTS FROM RESERVA r2 WHERE r2.idBarco = r1.idBarco GROUP BY r2.idBarco, r2.idMarinheiro));

