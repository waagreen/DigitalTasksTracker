<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Calendário - Sistema To-Do</title>
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
            <a class="nav-link d-flex align-items-center gap-1" href="calendarioPage.jsp">
                <i class="bi bi-calendar"></i> Calendário
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
<div class="container mt-4">
    <div class="calendar-nav mb-3">
        <button onclick="mudarMes(-1)">&lt; Mês Anterior</button>
        <h3 id="mesAno"></h3>
        <button onclick="mudarMes(1)">Próximo Mês &gt;</button>
    </div>
    <div class="calendar" id="calendario"></div>
</div>

<script>
    const calendario = document.getElementById('calendario');
    const mesAno = document.getElementById('mesAno');
    const hoje = new Date();
    let mesAtual = hoje.getMonth();
    let anoAtual = hoje.getFullYear();

    const eventos = {
        '2025-06-10': ['Reunião importante'],
        '2025-06-15': ['Entrega de trabalho'],
        '2025-06-30': ['Apresentação do projeto']
    };

    function renderizarCalendario() {
        calendario.innerHTML = '';
        const primeiroDia = new Date(anoAtual, mesAtual, 1).getDay();
        const diasNoMes = new Date(anoAtual, mesAtual + 1, 0).getDate();
        mesAno.textContent = new Date(anoAtual, mesAtual).toLocaleString('pt-BR', { month: 'long', year: 'numeric' });

        for (let i = 0; i < primeiroDia; i++) {
            calendario.innerHTML += '<div></div>';
        }

        for (let dia = 1; dia <= diasNoMes; dia++) {
            const dataAtual = new Date(anoAtual, mesAtual, dia);
            const dataChave = `${anoAtual}-${(mesAtual + 1).toString().padStart(2, '0')}-${dia.toString().padStart(2, '0')}`;
            const classeHoje = (dataAtual.toDateString() === hoje.toDateString()) ? 'today' : '';

            const div = document.createElement('div');
            div.className = `day ${classeHoje}`;
            div.textContent = dia;

            if (eventos[dataChave]) {
                eventos[dataChave].forEach(ev => {
                    const span = document.createElement('span');
                    span.className = 'evento';
                    span.textContent = ev;
                    div.appendChild(document.createElement('br'));
                    div.appendChild(span);
                });
            }

            div.onclick = () => alert(`Você clicou em ${dia}/${mesAtual + 1}/${anoAtual}`);
            calendario.appendChild(div);
        }
    }

    function mudarMes(delta) {
        mesAtual += delta;
        if (mesAtual < 0) {
            mesAtual = 11;
            anoAtual--;
        } else if (mesAtual > 11) {
            mesAtual = 0;
            anoAtual++;
        }
        renderizarCalendario();
    }

    renderizarCalendario();
</script>
</body>
</html>
