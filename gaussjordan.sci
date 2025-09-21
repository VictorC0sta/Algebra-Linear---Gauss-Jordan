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
