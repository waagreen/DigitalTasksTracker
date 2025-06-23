<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Histórico - Sistema To-Do</title>
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
                <i class="bi bi-list"></i> Listas
            </a>
            </li>
            <li class="nav-item hover-grow">
            <a class="nav-link d-flex align-items-center gap-1" href="Estatistica.jsp">
                <i class="bi bi-graph-up"></i> Estatísticas
            </a>
            </li>
            <li class="nav-item hover-grow">
            <a class="nav-link d-flex align-items-center gap-1" href="Historico.jsp">
                <i class="bi bi-clock-fill"></i> Histórico
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

<div class="historico-container">
    <h2 class="text-center mb-4">Histórico de Atividades</h2>

    <div class="registro">
        <div class="data">13/06/2025</div>
        <div class="descricao">Finalizou 5 tarefas. XP ganho: 75.</div>
    </div>

    <div class="registro">
        <div class="data">12/06/2025</div>
        <div class="descricao">Finalizou 3 tarefas. XP ganho: 45.</div>
    </div>

    <div class="registro">
        <div class="data">11/06/2025</div>
        <div class="descricao">Finalizou 4 tarefas. XP ganho: 60.</div>
    </div>

</div>
</body>
</html>
