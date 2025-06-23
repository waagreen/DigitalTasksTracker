
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
                    <li class="nav-item"><a class="nav-link" href="mainPage.jsp">Tarefas</a></li>
                    <li class="nav-item"><a class="nav-link" href="notasPage.jsp">Notas</a></li>
                    <li class="nav-item"><a class="nav-link" href="listasPage.jsp">Listas</a></li>
                    <li class="nav-item"><a class="nav-link" href="Estatistica.jsp">Estatísticas</a></li>
                    <li class="nav-item"><a class="nav-link" href="Historico.jsp">Histórico</a></li>
                    <li class="nav-item"><a class="nav-link" href="Perfil.jsp">Perfil</a></li>
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
            <!-- SVG Pessoa -->
            <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
            </svg>
        </div>

        <div class="ms-3">
            <h4>Nome do Usuário</h4>
            <!-- Streak -->
            <div class="d-flex align-items-center gap-2 hover-grow hover-follow clean-hover" title="Multiplicador: 2.62" style="padding: 0;">
                <!-- SVG Foguinho -->
                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill=#FFA500 class="bi bi-fire" viewBox="0 0 16 16">
                    <path d="M8 16c3.314 0 6-2 6-5.5 0-1.5-.5-4-2.5-6 .25 1.5-1.25 2-1.25 2C11 4 9 .5 6 0c.357 2 .5 4-2 6-1.25 1-2 2.729-2 4.5C2 14 4.686 16 8 16m0-1c-1.657 0-3-1-3-2.75 0-.75.25-2 1.25-3C6.125 10 7 10.5 7 10.5c-.375-1.25.5-3.25 2-3.5-.179 1-.25 2 1 3 .625.5 1 1.364 1 2.25C11 14 9.657 15 8 15"/>
                </svg>
                <span style="font-size: 1.5rem; user-select: none;">12</span> <!-- placeholder -->
            </div>
            <!-- Nivel -->
            <div class="mt-3 hover-grow hover-follow clean-hover">
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