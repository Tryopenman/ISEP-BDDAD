-- Exercício 3
CREATE OR REPLACE FUNCTION fncTotalClientes
RETURN NUMBER
IS
    totalClientes NUMBER;
BEGIN
    SELECT COUNT(*) INTO totalClientes FROM CLIENTE;

    IF totalClientes = 0 THEN
        RETURN NULL;
    END IF;

    RETURN totalClientes;
END fncTotalClientes;
/
-- Bloco Anónimo
DECLARE 
    v_result NUMBER;
BEGIN
    v_result := fncTotalClientes;

    DBMS_OUTPUT.PUT_LINE('Número total de clientes: ' || v_result);
END;
/

-- Exercício 4
CREATE OR REPLACE FUNCTION fncTemLivrosLivraria(idEditoraInsert NUMBER)
RETURN BOOLEAN
IS
    idEditoraVerificacao NUMBER;
    stockVerificacao NUMBER;
    editoraNaoExiste EXCEPTION;

BEGIN

    SELECT COUNT(*) INTO idEditoraVerificacao FROM EdicaoLivro WHERE EdicaoLivro.idEditora = idEditoraInsert;

    IF idEditoraVerificacao = 0 THEN
        RAISE editoraNaoExiste;
    END IF;

    SELECT COUNT(*) INTO stockVerificacao FROM EdicaoLivro WHERE EdicaoLivro.idEditora = idEditoraInsert and EdicaoLivro.stock > 0;

    RETURN stockVerificacao > 0;


    EXCEPTION WHEN
        editoraNaoExiste THEN
            RETURN NULL;

END fncTemLivrosLivraria;
/
-- Bloco Anónimo
DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := fncTemLivrosLivraria(700);

    IF v_result = TRUE THEN
        DBMS_OUTPUT.PUT_LINE('Existem Livros da editora 1');
    ELSIF v_result = FALSE THEN
        DBMS_OUTPUT.PUT_LINE('Não existem Livros da editora 1');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro com a editora ou a editora não existe');
    END IF;
END;
/


--Exercício 5
CREATE OR REPLACE FUNCTION fncClienteInfo(nifClienteInfo Cliente.nifCliente%type)
RETURN Cliente%ROWTYPE
IS
    nifClienteVerificacao NUMBER;
    cliente_info Cliente%ROWTYPE;
    clienteNaoExiste EXCEPTION;

BEGIN

    SELECT COUNT(*) INTO nifClienteVerificacao FROM CLIENTE WHERE CLIENTE.nifCliente = nifClienteInfo;

    IF nifClienteVerificacao = 0 THEN
        RAISE clienteNaoExiste;
    END IF;

    SELECT * INTO cliente_info FROM CLIENTE WHERE CLIENTE.nifCliente = nifClienteInfo;

    RETURN cliente_info;

    EXCEPTION WHEN
        clienteNaoExiste THEN
            RETURN NULL;

END fncClienteInfo;
/
--Bloco Anónimo 
DECLARE
    cliente_info Cliente%ROWTYPE;

BEGIN
    cliente_info := fncClienteInfo(900800100);

    IF cliente_info.nifCliente IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('NIF: ' || cliente_info.nifCliente ||
                             ' CODIGO POSTAL: ' || cliente_info.codPostal ||
                             ' NOME: ' || cliente_info.nome ||
                             ' DATA NASCIMENTO: ' || TO_CHAR(cliente_info.dataNascimento, 'DD/MM/YYYY') ||
                             ' Morada: ' || cliente_info.morada ||
                             ' NumTelemovel: ' || cliente_info.NrTelemovel);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cliente não encontrado.');
    END IF;
END;
/
--Opcao B
CREATE OR REPLACE FUNCTION  fncClienteInfo(nifClienteInfo Cliente.nifCliente%type) 
RETURN VARCHAR2
IS
    info_cliente VARCHAR2(255);
    nifClienteVerificacao NUMBER;
    clienteNaoExiste EXCEPTION;
BEGIN

    SELECT COUNT(*) INTO nifClienteVerificacao FROM CLIENTE WHERE CLIENTE.nifCliente = nifCliente;

    IF nifClienteVerificacao = 0 THEN
        RAISE clienteNaoExiste;
    END IF;

    SELECT 'NIF: ' ||Cliente.nifCliente ||
                             ' CODIGO POSTAL: ' ||Cliente.codPostal ||
                             ' NOME: ' ||Cliente.nome ||
                             ' DATA NASCIMENTO: ' || TO_CHAR(Cliente.dataNascimento, 'DD/MM/YYYY') ||
                             ' Morada: ' ||Cliente.morada ||
                             ' NumTelemovel: ' ||Cliente.NrTelemovel INTO info_cliente FROM CLIENTE WHERE CLIENTE.nifCliente = nifClienteInfo;

    RETURN info_cliente;

    EXCEPTION WHEN 
        clienteNaoExiste THEN
            RETURN NULL;
END fncClienteInfo;
/
--Bloco Anónimo
DECLARE 
    cliente_info VARCHAR2(255);

BEGIN 
    cliente_info := fncClienteInfo(900800100);

    IF cliente_info IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE(cliente_info);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cliente não encontrado.');
    END IF;
END;
/


--Exercicio 6
CREATE OR REPLACE FUNCTION fncStockAnoEditora(idEditoraInsert EdicaoLivro.idEditora%type,yearInsert NUMBER DEFAULT NULL) RETURN NUMBER
IS
    countStock NUMBER;
    idEditoraVerificacao NUMBER;
    ano NUMBER;
    anoAtual NUMBER;
    parametrosInvalidos EXCEPTION;
BEGIN 
    anoAtual := EXTRACT(YEAR FROM CURRENT_TIMESTAMP);

    SELECT COUNT(*) INTO idEditoraVerificacao FROM EdicaoLivro WHERE EdicaoLivro.idEditora = idEditoraInsert;
    
    IF yearInsert IS NULL THEN
        ano := anoAtual;
    ELSE
        ano := yearInsert;
    END IF;
    
    IF ano < 0 OR ano > anoAtual THEN
        RAISE parametrosInvalidos;
    END IF;

    IF idEditoraVerificacao = 0 THEN
        RAISE parametrosInvalidos;
    END IF;

    SELECT NVL(SUM(stock),0) INTO countStock FROM EdicaoLivro WHERE EdicaoLivro.idEditora = idEditoraInsert AND anoEdicao = ano;

    RETURN countStock;

    EXCEPTION WHEN
        parametrosInvalidos THEN
            RETURN NULL;

END fncStockAnoEditora;
/

DECLARE
    v_resultado NUMBER;
BEGIN
    v_resultado := fncStockAnoEditora(1500,2015); 
    IF v_resultado IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Stock: ' || v_resultado);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Parâmetros inválidos ou editora não encontrada.');
    END IF;
END;
/

--Exercicio 7
CREATE OR REPLACE FUNCTION fncPrecoVenda(nrVendaInsert Venda.nrVenda%type)
RETURN NUMBER
IS
    precoVenda NUMBER(5,2);
    nrVendaVerificacao NUMBER;
    isbnVenda Venda.isbn%TYPE;
    quantidadeVenda Venda.quantidade%TYPE;
    dataHoraVenda Venda.dataHora%TYPE;
    parameterInvalid EXCEPTION;
BEGIN

    SELECT COUNT(*) INTO nrVendaVerificacao FROM Venda WHERE Venda.nrVenda = nrVendaInsert;

    IF nrVendaVerificacao = 0 THEN 
        RAISE parameterInvalid;
    END IF;

    SELECT isbn,quantidade,dataHora INTO isbnVenda,quantidadeVenda,dataHoraVenda FROM VENDA WHERE Venda.nrVenda = nrVendaInsert;

    SELECT preco INTO precoVenda FROM precoEdicaoLivro WHERE isbn = isbnVenda AND dataInicio <= dataHoraVenda ORDER BY dataInicio DESC FETCH FIRST 1 ROW ONLY;

    RETURN precoVenda * quantidadeVenda;

    EXCEPTION WHEN
        parameterInvalid THEN
            RETURN NULL;

END fncPrecoVenda;
/

DECLARE
    v_result NUMBER;

BEGIN 
    v_result := fncPrecoVenda(13);

	IF v_result IS NOT NULL THEN
    	DBMS_OUTPUT.PUT_LINE('PRECO: ' || v_result);

	ELSE
    	DBMS_OUTPUT.PUT_LINE('O parêmetro inserido é inválido');
	END IF;
END;
/


--Exercicio 8
CREATE OR REPLACE FUNCTION fncRegistarNovoCliente(nifInsert Cliente.nifCliente%TYPE, codPostalInsert Cliente.codPostal%TYPE, nomeInsert CLIENTE.nome%TYPE, dataNascimentoInsert VARCHAR2, moradaInsert CLIENTE.morada%TYPE, nrTmelemovelInsert CLIENTE.nrTelemovel%TYPE)
RETURN NUMBER
IS  
    codPostalVerificacao Cliente.codPostal%TYPE;
    parametrosInvalidos EXCEPTION;
BEGIN

    SELECT COUNT(*) INTO codPostalVerificacao FROM CODIGOPOSTAL WHERE CODIGOPOSTAL.codPostal = codPostalInsert;

    IF codPostalVerificacao = 0 OR LENGTH(TO_CHAR(nrTmelemovelInsert)) != 9 OR LENGTH(TO_CHAR(nifInsert)) != 9 OR TO_DATE(dataNascimentoInsert,'DD/MM/YYYY') > CURRENT_TIMESTAMP THEN 
        RAISE parametrosInvalidos;
    END IF;

    INSERT INTO CLIENTE(nifCliente, codPostal, nome, dataNascimento, morada, nrTelemovel) 
    VALUES (nifInsert, codPostalInsert, nomeInsert, TO_DATE(dataNascimentoInsert, 'DD/MM/YYYY'), moradaInsert, nrTmelemovelInsert);
    COMMIT;

    RETURN nifInsert;

    EXCEPTION 
        WHEN parametrosInvalidos THEN
            ROLLBACK;
            RETURN NULL;
        WHEN OTHERS THEN
            ROLLBACK;
            RETURN NULL;

END fncRegistarNovoCliente;
/

DECLARE
    v_nif Cliente.nifCliente%TYPE;
    v_codPostal Cliente.codPostal%TYPE;
    v_nome CLIENTE.nome%TYPE;
    v_dataNascimento VARCHAR2(10);
    v_morada CLIENTE.morada%TYPE;
    v_nrTelemovel CLIENTE.nrTelemovel%TYPE;
    v_resultado NUMBER;
BEGIN
    v_nif := 123456779;
    v_codPostal := '4460-393';
    v_nome := 'Francisco';
    v_dataNascimento := '01/01/2010';
    v_morada := 'Rua ABC, 123';
    v_nrTelemovel := '987654321';

    v_resultado := fncRegistarNovoCliente(v_nif, v_codPostal, v_nome, v_dataNascimento, v_morada, v_nrTelemovel);

    IF v_resultado IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Novo cliente registado com sucesso. Identificador: ' || v_resultado);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Parâmetros inválidos. Falha no registo do cliente.');
    END IF;
END;
/

--Exercicio 9
CREATE OR REPLACE FUNCTION fncLivrosEditora(idEditoraInsert EdicaoLivro.idEditora%TYPE)
RETURN SYS_REFCURSOR
IS
    livrosEditora SYS_REFCURSOR;
    idEditoraVerificacao NUMBER;
    parametrosInvalidos EXCEPTION;
BEGIN

    SELECT COUNT(*) INTO idEditoraVerificacao FROM EdicaoLivro WHERE EdicaoLivro.idEditora = idEditoraInsert;

    IF idEditoraVerificacao = 0 THEN
        RAISE parametrosInvalidos;
    END IF;
    
    OPEN livrosEditora FOR
        SELECT distinct titulo FROM Livro
        JOIN EdicaoLivro ON EdicaoLivro.idLivro = Livro.idLivro
        WHERE stock > 0 AND EdicaoLivro.idEditora = idEditoraInsert;

    RETURN livrosEditora;

    EXCEPTION WHEN
        parametrosInvalidos THEN
            RETURN livrosEditora;

END fncLivrosEditora;
/
DECLARE
    livrosCursor SYS_REFCURSOR;
    v_titulo Livro.titulo%TYPE;
BEGIN
    livrosCursor := fncLivrosEditora(1500);

    IF livrosCursor IS NOT NULL THEN
        LOOP
            FETCH livrosCursor INTO v_titulo;

            EXIT WHEN livrosCursor%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Livro: ' || v_titulo);
        END LOOP;

        IF livrosCursor%ISOPEN THEN
            CLOSE livrosCursor;
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados para os parâmetros que inseriu.');
    END IF;
END;
/

--Exercicio 10
CREATE OR REPLACE FUNCTION fncClientesAtivos(dataInicio VARCHAR2, dataFinal VARCHAR2)
RETURN SYS_REFCURSOR
IS
    clientesAtivos SYS_REFCURSOR;
    parametrosInvalidos EXCEPTION;

BEGIN
    IF TO_DATE(dataInicio,'DD/MM/YYYY') > TO_DATE(dataFinal,'DD/MM/YYYY') THEN
        RAISE parametrosInvalidos;
    END IF;

    IF TO_DATE(dataFinal,'DD/MM/YYYY') > CURRENT_TIMESTAMP THEN
        RAISE parametrosInvalidos;
    END IF;

    OPEN clientesAtivos FOR
        SELECT nome, preco*quantidade as valorTotal FROM CLIENTE
        JOIN Venda ON VENDA.nifCliente = Cliente.nifCliente AND dataHora BETWEEN TO_DATE(dataInicio,'DD/MM/YYYY') AND TO_DATE(dataFinal,'DD/MM/YYYY')
        JOIN EdicaoLivro ON EdicaoLivro.isbn = Venda.isbn
        JOIN precoEdicaoLivro ON PrecoEdicaoLivro.isbn = Venda.isbn AND dataInicio <= Venda.dataHora;

    RETURN clientesAtivos;

    EXCEPTION WHEN parametrosInvalidos THEN
        RETURN clientesAtivos;
END fncClientesAtivos;
/

DECLARE
    clientesCursor SYS_REFCURSOR;
    v_nome CLIENTE.nome%TYPE;
    v_valorTotal NUMBER;
BEGIN
    clientesCursor := fncClientesAtivos('01/01/2010', '31/01/2022'); 

    IF clientesCursor IS NOT NULL THEN
        LOOP
            FETCH clientesCursor INTO v_nome, v_valorTotal;

            EXIT WHEN clientesCursor%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_nome || ', Valor Total: ' || v_valorTotal);
        END LOOP;

        IF clientesCursor%ISOPEN THEN
            CLOSE clientesCursor;
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum cliente ativo encontrado para o período fornecido.');
    END IF;
END;
/


