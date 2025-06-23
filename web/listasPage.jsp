<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Listas - Sistema To-Do</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/estilo.css">
    <link rel="stylesheet" href="css/pagesCSS.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
<div class="container">
    <h1 class="text-primary p-2">Minuet</h1>
    <div class="collapse navbar-collapse">
    <ul class="navbar-nav mr-auto">
        <li class="nav-item hover-grow">
        <a class="nav-link d-flex align-items-center gap-1" href="mainPage.jsp">
            <i class="bi bi-clipboard"></i> Tarefas
        </a>
        </li>
        <li class="nav-item hover-grow">
        <a class="nav-link d-flex align-items-center gap-1" href="notasPage.jsp">
            <i class="bi bi-sticky"></i> Notas
        </a>
        </li>
        <li class="nav-item hover-grow">
        <a class="nav-link d-flex align-items-center gap-1" href="listasPage.jsp">
            <i class="bi bi-list-ul"></i> Listas
        </a>
        </li>
        <li class="nav-item hover-grow">
        <a class="nav-link d-flex align-items-center gap-1" href="Estatistica.jsp">
            <i class="bi bi-graph-up"></i> Estatísticas
        </a>
        </li>
        <li class="nav-item hover-grow">
        <a class="nav-link d-flex align-items-center gap-1" href="Historico.jsp">
            <i class="bi bi-clock-history"></i> Histórico
        </a>
        </li>
        <li class="nav-item hover-grow">
        <a class="nav-link d-flex align-items-center gap-1" href="Perfil.jsp">
            <i class="bi bi-person"></i> Perfil
        </a>
        </li>
    </ul>
    </div>
</div>
</nav>
<!-- Conteudo -->
<div class="container mt-4" style="max-width: 800px;">
    <h2 class="mb-4">Criar nova lista</h2>

    <form class="mb-5" onsubmit="event.preventDefault(); criarLista()">
        <div class="mb-3">
            <label for="nomeLista" class="form-label">Nome da Lista</label>
            <input type="text" class="form-control" id="nomeLista" placeholder="Digite o nome da Lista">
        </div>

        <!-- Lista de tarefas criadas -->
        <ul class="list-group mb-3" id="listaTarefas"></ul>

        <div class="mb-3">
            <label class="form-label">Adicionar Tarefa</label>
            <div class="input-group">
                <input type="text" class="form-control" id="novaTarefa" placeholder="Digite uma tarefa">
                <button type="button" class="btn btn-outline-secondary" onclick="adicionarTarefa()">+</button>
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Criar Lista</button>
    </form>

    <!-- Listas de exemplo -->
    <div class="hover-grow clean-hover">
        <h3 class="mb-3">Prova de Matemática</h3>

        <!-- Tags -->
        <div class="mt-2">
            <span class="badge bg-info text-dark">Matemática</span>
            <button class="btn btn-sm btn-outline-info" onclick="alert('Funcionalidade de Tags futura')">+ Tag</button>
        </div>

        <!-- Itens -->
        <ul class="list-group mb-4">
            <li class="list-group-item">
                <input class="form-check-input me-2" type="checkbox" value=""> Capítulo 5 - Função quadrada
            </li>
            <li class="list-group-item">
                <input class="form-check-input me-2" type="checkbox" value=""> Exercícios página 54
            </li>
            <li class="list-group-item">
                <input class="form-check-input me-2" type="checkbox" value=""> Fazer resumo
            </li>
        </ul>
    </div>

    <div class="hover-grow clean-hover">
        <h3 class="mb-3">Trabalho de portguês</h3>

        <!-- Tags -->
        <div class="mt-2">
            <span class="badge bg-info text-dark">Português</span>
            <button class="btn btn-sm btn-outline-info" onclick="alert('Funcionalidade de Tags futura')">+ Tag</button>
        </div>

        <!-- Itens -->
        <ul class="list-group">
            <li class="list-group-item">
                <input class="form-check-input me-2" type="checkbox" value=""> Comprar materiais
            </li>
            <li class="list-group-item">
                <input class="form-check-input me-2" type="checkbox" value=""> Organizar cronograma
            </li>
            <li class="list-group-item">
                <input class="form-check-input me-2" type="checkbox" value=""> Enviar e-mail para o grupo
            </li>
        </ul>
    </div>

</div>
<!-- Script para criar tarefas superficiais -->
<script>
    const listaTarefas = document.getElementById('listaTarefas');
    const inputTarefa = document.getElementById('novaTarefa');

    function adicionarTarefa() {
        const texto = inputTarefa.value.trim();
        if (texto.length === 0) return;

        const item = document.createElement('li');
        item.className = 'list-group-item';
        item.textContent = texto;
        listaTarefas.appendChild(item);
        inputTarefa.value = '';
    }

    function criarLista() {
        const nome = document.getElementById('nomeLista').value.trim();
        if (listaTarefas.children.length === 0) {
            alert("Adicione pelo menos uma tarefa para criar a lista.");
            return;
        }
        if (nome.length === 0) {
            alert("Informe um nome para a lista.");
            return;
        }
        alert("Lista '" + nome + "' criada com " + listaTarefas.children.length + " tarefa(s)." );
        document.getElementById('nomeLista').value = '';
        listaTarefas.innerHTML = '';
    }
</script>
</body>
</html>
