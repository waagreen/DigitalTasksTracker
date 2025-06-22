<%@page import="tools.CaixaDeFerramentas"%>
<%@page import="Entidades.Tarefa"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.DAOTarefa"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sistema To-Do</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/pagesCSS.css" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>

    <!DOCTYPE html>
    <html lang="pt-br">
        <head>
        </head>

        <%
            Cookie[] cookie = request.getCookies();
            DAOTarefa daoTarefa = new DAOTarefa();
            List<Tarefa> tarefas = null;
            for (int i = 0; i < cookie.length; i++) {
                if (cookie[i].getName().equals("user")) {
                    tarefas = daoTarefa.listByUsuario(cookie[i].getValue(), Boolean.FALSE);
                }
            }
            request.setAttribute("tarefas", tarefas);
        %>

        <body class="bg-light">
            <header class="bg-light p-2 mb-2 d-flex justify-content-between align-items-center">
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <div class="container">
                        <h1 class="text-primary p-2">Minuet</h1>
                        <div class="collapse navbar-collapse">
                            <ul class="navbar-nav mr-auto">
                                <li class="nav-item"><a class="nav-link" href="mainPage.jsp">Tarefas</a></li>
                                <li class="nav-item"><a class="nav-link" href="notasPage.jsp">Notas</a></li>
                                <li class="nav-item"><a class="nav-link" href="Estatistica.jsp">Estatísticas</a></li>
                                <li class="nav-item"><a class="nav-link" href="Historico.jsp">Histórico</a></li>
                                <li class="nav-item"><a class="nav-link" href="Perfil.jsp">Perfil</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div>
                    <button class="btn btn-success" data-toggle="modal" data-target="#novaTarefaModal">+ Nova Tarefa</button>
                    <a href="Logout" class="btn btn-danger">Logout</a>
                </div>
            </header>

            <main class="container">
                <h4 class="mb-4">Organize suas tarefas:</h4>
                <div class="row row-cols-1 row-cols-md-3">
                    <c:forEach var="tarefa" items="<%=tarefas%>">
                        <div class="col mb-4">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">${tarefa.tituloTarefa}</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">
                                        <fmt:formatDate value="${tarefa.dataFinalizarTarefa}" pattern="dd/MM/yyyy"/>
                                    </h6>
                                    <p class="card-text">${tarefa.descricaoTarefa}</p>

                                    <!-- Timer -->
                                    <div>
                                        <span id="timer-${tarefa.idTarefa}">00:00:00</span><br>
                                        <button id="start-${tarefa.idTarefa}" class="btn btn-sm btn-outline-primary" onclick="startTimer(${tarefa.idTarefa})">Iniciar Timer</button>
                                        <button id="stop-${tarefa.idTarefa}" class="btn btn-sm btn-outline-secondary" onclick="stopTimer(${tarefa.idTarefa})" disabled>Parar Timer</button>
                                    </div>

                                    <!-- Tags -->
                                    <div class="mt-2">
                                        <span class="badge badge-info">ExemploTag</span>
                                        <button class="btn btn-sm btn-outline-info" onclick="alert('Funcionalidade de Tags futura')">+ Tag</button>
                                    </div>

                                    <!-- Ações -->
                                    <div class="mt-3">
                                        <form action="ConcluirTarefa" method="post" style="display:inline;">
                                            <input type="hidden" name="idTarefa" value="${tarefa.idTarefa}">
                                            <button class="btn btn-success btn-sm">Concluir</button>
                                        </form> 

                                        <form action="ExcluirTarefa" method="post" style="display:inline;" onsubmit="return confirm('Tem certeza que deseja excluir esta tarefa?');">
                                            <input type="hidden" name="idTarefa" value="${tarefa.idTarefa}">
                                            <button class="btn btn-danger btn-sm">Excluir</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div> 
                    </c:forEach>
                </div>
            </main>

            <!-- Modal para nova tarefa -->
            <div class="modal fade" id="novaTarefaModal" tabindex="-1" aria-labelledby="novaTarefaModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <form class="modal-content" action="CadastrarTarefa" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">Nova Tarefa</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <div class="form-group">
                                <label for="tituloTarefa">Título</label>
                                <input type="text" class="form-control" id="tituloTarefa" name="tituloTarefa" required>
                            </div>
                            <div class="form-group">
                                <label for="descricaoTarefa">Descrição</label>
                                <textarea class="form-control" id="descricaoTarefa" name="descricaoTarefa" rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="dataFinalizarTarefa">Data</label>
                                <input type="date" class="form-control" id="dataFinalizarTarefa" name="dataFinalizarTarefa" required>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Salvar Tarefa</button>
                        </div>
                    </form>
                </div>
            </div>

            <footer class="text-center mt-5">
                <blockquote class="blockquote">
                    <p>“Bora bora leonardo”</p>
                    <footer class="blockquote-footer">Maria</footer>
                </blockquote>
            </footer>

            <!-- Script de Timer -->
            <script>
                // Variável global para armazenar os intervalos dos timers
                var timerIntervals = {};
                var timerSeconds = {}; // Armazena os segundos decorridos para cada tarefa
                var activeTimers = {}; // Armazena o estado dos timers (ativo/inativo)

                function startTimer(taskId)
                {
                    // Desabilita o botão de start imediatamente
                    $('[onclick="startTimer(' + taskId + ')"]').prop('disabled', true);
                    // Habilita o botão de stop
                    $('[onclick="stopTimer(' + taskId + ')"]').prop('disabled', false);

                    // Primeiro obtém o tempo acumulado do servidor
                    $.post('TimerControl',
                    {
                        action: 'get',
                        taskId: taskId
                    },
                    function(response)
                    {
                        if (response.status === 'success')
                        {
                            // Converte horas acumuladas para segundos
                            let horasAcumuladas = response.tempoAcumulado || 0;
                            let segundosAcumulados = Math.round(horasAcumuladas * 3600);

                            // Inicia o timer no servidor
                            $.post('TimerControl',
                            {
                                action: 'start',
                                taskId: taskId
                            },
                            function(startResponse)
                            {
                                console.log("Timer started for task: " + taskId);
                                activeTimers[taskId] = true;

                                // Inicia o timer visual no cliente
                                if (timerIntervals[taskId])
                                {
                                    clearInterval(timerIntervals[taskId]);
                                }

                                timerSeconds[taskId] = segundosAcumulados;
                                updateTimerDisplay(taskId); // Mostra o tempo acumulado imediatamente

                                timerIntervals[taskId] = setInterval(function()
                                {
                                    timerSeconds[taskId]++;
                                    updateTimerDisplay(taskId);
                                }, 1000);
                            }, 'json');
                        }
                    }, 'json');
                }

                function stopTimer(taskId)
                {
                    // Habilita o botão de start imediatamente
                    $('[onclick="startTimer(' + taskId + ')"]').prop('disabled', false);
                    // Desabilita o botão de stop
                    $('[onclick="stopTimer(' + taskId + ')"]').prop('disabled', true);

                    // Envia requisição para parar o timer no servidor
                    $.post('TimerControl',
                    {
                        action: 'stop',
                        taskId: taskId
                    }, 
                    function(response)
                    {
                        console.log("Timer stopped for task: " + taskId);
                        activeTimers[taskId] = false;

                        // Para o timer visual no cliente
                        if (timerIntervals[taskId])
                        {
                            clearInterval(timerIntervals[taskId]);
                            delete timerIntervals[taskId];

                            // Mantém os segundos para mostrar o tempo final
                            updateTimerDisplay(taskId);
                        }
                    }, 'json');
                }

                function updateTimerDisplay(taskId)
                {
                    let seconds = timerSeconds[taskId] || 0;
                    let hours = Math.floor(seconds / 3600);
                    let minutes = Math.floor((seconds % 3600) / 60);
                    let secs = seconds % 60;

                    // Formata para HH:MM:SS
                    let timeString = 
                        (hours < 10 ? "0" + hours : hours) + ":" +
                        (minutes < 10 ? "0" + minutes : minutes) + ":" +
                        (secs < 10 ? "0" + secs : secs);

                    document.getElementById('timer-' + taskId).textContent = timeString;
                }

                // Ao carregar a página, atualiza todos os timers com o tempo acumulado
                $(document).ready(function()
                {
                    $('[id^="timer-"]').each(function()
                    {
                        let taskId = this.id.split('-')[1];
                        $.post('TimerControl',
                        {
                            action: 'get',
                            taskId: taskId
                        },
                        function(response)
                        {
                            if (response.status === 'success')
                            {
                                let horasAcumuladas = response.tempoAcumulado || 0;
                                let segundosAcumulados = Math.round(horasAcumuladas * 3600);
                                timerSeconds[taskId] = segundosAcumulados;
                                updateTimerDisplay(taskId);

                                // Verifica se há um timer ativo para esta tarefa
                                if (activeTimers[taskId])
                                {
                                    $('[onclick="startTimer(' + taskId + ')"]').prop('disabled', true);
                                    $('[onclick="stopTimer(' + taskId + ')"]').prop('disabled', false);
                                } 
                                else
                                {
                                    $('[onclick="startTimer(' + taskId + ')"]').prop('disabled', false);
                                    $('[onclick="stopTimer(' + taskId + ')"]').prop('disabled', true);
                                }
                            }
                        }, 'json');
                    });
                });
            </script>
        </body>
    </html>
