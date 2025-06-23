
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil - Sistema To-Do</title>
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
                <i class="bi bi-clock-history"></i> Histórico
            </a>
            </li>
            <li class="nav-item hover-grow">
            <a class="nav-link d-flex align-items-center gap-1" href="Perfil.jsp">
                <i class="bi bi-person-fill"></i> Perfil
            </a>
            </li>
        </ul>
        </div>
    </div>
    </nav>


<!-- Conteudo perfil -->
<div class="container mt-4" style="max-width: 600px;">
    <h2 class="mb-4">Meu Perfil</h2>

    <!-- Foto de perfil -->
    <div class="d-flex align-items-center mb-3 hover-grow">
        <div class="perfil-foto hover-follow" style="width: 120px; height: 120px; font-size: 60px;">

            <i class="bi bi-person-fill" style="font-size: 70px;"></i>
        </div>

        <div class="ms-3">
            <h4>Nome do Usuário</h4>
            <!-- Streak -->
            <div class="d-flex align-items-center gap-2 hover-grow hover-follow clean-hover" title="Multiplicador: 2.62" style="padding: 0;">
                <i class="bi bi-fire" style="color: #FFA500; font-size: 30px;"></i>
                <span style="font-size: 1.5rem; user-select: none;">12</span> <!-- placeholder -->
            </div>
            <!-- Nivel -->
            <div class="mt-3 hover-grow hover-follow clean-hover" title="60/100">
                <label class="form-label" style="font-weight: bold;">NÍVEL: 5</label>
                <div class="progress" style="height: 20px;">
                    <div class="progress-bar bg-success" role="progressbar" style="width: 60%;" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
            </div>
        </div>
    </div>

    <!--Area de distintivos -->
    <div class="mb-3">
        <label for="distintivo" class="form-label">Distintivos:</label>
        <div class="distintivo-container">
            <!-- Campos individuais -->
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy-fill" style="color: #d7b126;"></i>
            </div>
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy" style="color: #779399"></i>
            </div>
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy" style="color: #779399"></i>
            </div>
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy" style="color: #779399"></i>
            </div>
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy" style="color: #779399"></i>
            </div>
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy" style="color: #779399"></i>
            </div>
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy" style="color: #779399"></i>
            </div>
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy" style="color: #779399"></i>
            </div>
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy" style="color: #779399"></i>
            </div>
            <div class="distintivo hover-grow hover-follow">
                <i class="bi bi-trophy" style="color: #779399"></i>
            </div>
        </div>
    </div>

    <div class="mt-5">
        <a href="Logout" class="btn btn-outline-danger">Logout</a>
    </div>
</div>
</body>

<!-- Script pra funcionar animacaoinha -->
<script>
    document.querySelectorAll('.hover-follow').forEach(el => {
        el.addEventListener('mousemove', e => {
            const rect = el.getBoundingClientRect();
            const offsetX = ((e.clientX - rect.left) - rect.width / 2) / 10;
            const offsetY = ((e.clientY - rect.top) - rect.height / 2) / 10;
            el.style.transform = `scale(1.05) translate(${offsetX}px, ${offsetY}px)`;
        });

        el.addEventListener('mouseleave', () => {
            el.style.transform = 'scale(1)';
        });
    });
</script>
</html>