// =============================
// Função Gauss-Jordan
// =============================
// Essa função implementa o método de Gauss-Jordan
// para resolver sistemas lineares A*x = b.
// Ela trata pivotamento parcial, casos singulares,
// infinitas soluções e inconsistências.
function [x,status] = gaussjordan(A,b)
    [n,m] = size(A);
    // Verificação: a matriz A precisa ser quadrada
    if n<>m then
        error("A matriz A deve ser quadrada.");
    end
    // Verificação: o vetor b deve ter número de linhas igual a A
    if size(b,1)<>n then
        error("Dimensões incompatíveis entre A e b.");
    end

    // Construímos a matriz aumentada [A|b]
    Ab = [A b];

    // Percorremos cada coluna da matriz
    for k=1:n
        // Fazemos pivotamento parcial para evitar divisão por zero
        [piv, p] = max(abs(Ab(k:n,k))); // procura maior pivô
        p = p + k - 1;
        if piv < %eps then
            // Se pivô muito pequeno, pulamos (possível singularidade)
            continue;
        end

        // Troca de linhas caso o maior pivô não esteja na linha atual
        if p <> k then
            temp = Ab(k,:);
            Ab(k,:) = Ab(p,:);
            Ab(p,:) = temp;
        end

        // Normaliza a linha pivô (transforma pivô em 1)
        Ab(k,:) = Ab(k,:) / Ab(k,k);

        // Elimina os outros elementos da coluna k
        for i=1:n
            if i<>k then
                Ab(i,:) = Ab(i,:) - Ab(i,k)*Ab(k,:);
            end
        end
    end

    // Depois da eliminação, analisamos a consistência do sistema
    Ared = Ab(:,1:n);     // matriz reduzida
    bred = Ab(:,n+1);     // vetor resultado

    rkA = rank(A);        // posto da matriz original
    rkAb = rank([A b]);   // posto da matriz aumentada

    // Se posto(A) < posto([A|b]) -> sistema inconsistente (sem solução)
    if rkA < rkAb then
        status = "inconsistente";
        x = [];
        return;

    // Se posto(A) < n -> sistema com infinitas soluções
    elseif rkA < n then
        status = "infinitas";
        x = [];
        return;

    // Se determinante muito próximo de zero -> matriz singular
    elseif abs(det(A)) < %eps then
        status = "singular";
        x = [];
        return;

    // Caso contrário, temos solução única
    else
        status = "ok";
        x = bred;
    end
endfunction


// =============================
// Testes obrigatórios
// =============================
// Função auxiliar para rodar os casos de teste
// definidos no enunciado. Isso ajuda a validar
// o código automaticamente.
function run_tests()
    disp("=== Teste 1: Pequeno e simples (única solução) ===");
    A = [2 1; 1 3]; b = [5; 6];
    [x,status] = gaussjordan(A,b); disp(x); disp(status);

    disp("=== Teste 2: 3x3 com solução única ===");
    A = [1 2 3; 0 1 4; 5 6 0]; b = [14; 15; 23];
    [x,status] = gaussjordan(A,b); disp(x); disp(status);

    disp("=== Teste 3: Matriz singular (infinitas soluções) ===");
    A = [1 2 3; 2 4 6; 3 6 9]; b = [6; 12; 18];
    [x,status] = gaussjordan(A,b); disp(x); disp(status);

    disp("=== Teste 4: Matriz singular (inconsistente) ===");
    A = [1 2 3; 2 4 6; 3 6 9]; b = [6; 12; 19];
    [x,status] = gaussjordan(A,b); disp(x); disp(status);

    disp("=== Teste 5: Pivô nulo (troca de linhas) ===");
    A = [0 2 3; 1 5 6; 4 7 8]; b = [5;10;19];
    [x,status] = gaussjordan(A,b); disp(x); disp(status);
endfunction


// =============================
// Menu interativo
// =============================
// Essa função cria um menu simples para o usuário.
// Ele pode escolher rodar os testes ou inserir uma matriz
// e vetor manualmente.
function menu_interativo()
    while %t
        disp("==================================");
        disp("     MÉTODO DE GAUSS-JORDAN       ");
        disp("==================================");
        disp("1 - Rodar testes obrigatórios");
        disp("2 - Inserir minha própria matriz");
        disp("0 - Sair");
        opcao = input("Escolha uma opção: ");

        select opcao
        case 1 then
            run_tests(); // executa os testes prontos
        case 2 then
            // Usuário define o tamanho da matriz
            n = input("Digite a dimensão da matriz quadrada A (n): ");
            A = zeros(n,n);
            // Preenche a matriz A elemento por elemento
            for i=1:n
                for j=1:n
                    A(i,j) = input("A("+string(i)+","+string(j)+") = ");
                end
            end
            // Preenche o vetor b
            b = zeros(n,1);
            for i=1:n
                b(i) = input("b("+string(i)+") = ");
            end
            disp("Matriz A = "), disp(A);
            disp("Vetor b = "), disp(b);
            // Chama a função principal
            [x,status] = gaussjordan(A,b);
            disp("Status: "+status);
            if status=="ok" then
                disp("Solução encontrada: ");
                disp(x);
            end
        case 0 then
            break; // sai do menu
        else
            disp("Opção inválida!");
        end
    end
endfunction


// =============================
// Executar menu
// =============================
// Ao rodar o script, já abre o menu para o usuário
menu_interativo();
