<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>README – Método de Gauss-Jordan</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 40px; line-height: 1.6; background: #fdfdfd; color: #333; }
    h1, h2, h3 { color: #004080; }
    code { background: #eee; padding: 2px 4px; border-radius: 4px; }
    pre { background: #f4f4f4; padding: 10px; border-radius: 6px; }
    ul { margin-left: 20px; }
    .footer { margin-top: 40px; font-size: 0.9em; color: #555; }
  </style>
</head>
<body>

<h1>README – Método de Gauss-Jordan em Scilab</h1>

<h2>📌 Descrição</h2>
<p>
Este projeto implementa o <b>método de Gauss-Jordan</b> em Scilab, permitindo resolver sistemas lineares da forma 
<b>Ax = b</b>.
O código trata casos práticos, como:
</p>
<ul>
  <li>Pivôs nulos (pivotamento parcial por linha).</li>
  <li>Matrizes singulares (infinitas soluções).</li>
  <li>Sistemas inconsistentes (sem solução).</li>
  <li>Instabilidades numéricas.</li>
</ul>
<p>
Foi desenvolvido como exercício de fixação para a disciplina de <b>Álgebra Linear</b>, utilizando modularização, menu interativo e testes automatizados.
</p>

<h2>📂 Estrutura dos Arquivos</h2>
<ul>
  <li><b>gaussjordan.sci</b> → Função reutilizável <code>gaussjordan(A,b)</code> que resolve sistemas lineares.</li>
  <li><b>main_gaussjordan.sce</b> → Script principal com menu interativo e testes obrigatórios.</li>
</ul>

<h2>▶️ Como Executar</h2>
<h3>1. Abrir o Scilab</h3>
<p>Inicie o <b>Scilab</b> e abra o console.</p>

<h3>2. Carregar os arquivos</h3>
<p>Salve os arquivos <code>gaussjordan.sci</code> e <code>main_gaussjordan.sce</code> na mesma pasta.<br>
No console, vá até a pasta:</p>
<pre><code>cd 'C:\caminho\da\pasta';
</code></pre>

<h3>3. Executar o programa principal</h3>
<pre><code>exec('main_gaussjordan.sce', -1);
</code></pre>

<h3>4. Utilização</h3>
<p>O programa abre um <b>menu interativo</b>:</p>
<ul>
  <li><b>Opção 1</b> → Roda automaticamente os testes obrigatórios.</li>
  <li><b>Opção 2</b> → Permite inserir manualmente uma matriz <b>A</b> e um vetor <b>b</b> de qualquer dimensão.</li>
  <li><b>Opção 0</b> → Sai do programa.</li>
</ul>

<h2>✅ Casos de Teste Obrigatórios</h2>
<ol>
  <li>Sistema 2×2 simples (solução única).</li>
  <li>Sistema 3×3 com solução única.</li>
  <li>Matriz singular (infinitas soluções).</li>
  <li>Matriz singular (inconsistente).</li>
  <li>Sistema que exige pivotamento (pivô inicial nulo).</li>
</ol>

<h2>📖 Observações</h2>
<ul>
  <li>O algoritmo implementa <b>pivotamento parcial por linha</b> (não pivotamento completo).</li>
  <li>O status do sistema pode ser:
    <ul>
      <li><code>"ok"</code> → solução única encontrada.</li>
      <li><code>"infinitas"</code> → infinitas soluções.</li>
      <li><code>"inconsistente"</code> → sistema sem solução.</li>
      <li><code>"singular"</code> → matriz singular detectada.</li>
    </ul>
  </li>
</ul>

<div class="footer">
📌 <b>Disciplina:</b> Álgebra Linear<br>
📌 <b>Alunos:</b> João Victor da Costa Cerqueira e Lucas Guerra – Eng. de Computação – 4º semestre
</div>

</body>
</html>
