<%@page import="tools.CaixaDeFerramentas"%>
<%@page import="Entidades.Tarefa"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.DAOTarefa"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sistema To-Do</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/pagesCSS.css" type="text/css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
<!--
        <div id="cronometro-flutuante" class="position-fixed small bg-light border border-primary shadow rounded d-none"
             style="bottom: 20px; right: 20px; width: auto; max-width: 250px; z-index: 1050; padding: 10px;">
            <div>
                <strong class="d-block mb-1 text-primary">Tarefa em andamento:</strong>
                <span id="cronometro-tarefa-titulo" class="fw-bold"></span><br>
                <span id="cronometro-flutuante-tempo" class="text-success"></span>
                <button class="btn btn-sm btn-danger ms-2 mt-2" onclick="pararTimerFlutuante()">Parar</button>
            </div>
        </div>
-->

        <header class="bg-light p-2 mb-2 d-flex justify-content-between align-items-center">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container">
                    <h1 class="text-primary p-2">Minuet</h1>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item hover-grow">
                                <a class="nav-link d-flex align-items-center gap-1" href="mainPage.jsp">
                                    <i class="bi bi-clipboard-fill"></i> Tarefas
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
                                    <i class="bi bi-person"></i> Perfil
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div>
                <button class="btn btn-success" data-toggle="modal" data-target="#novaTarefaModal">+ Nova Tarefa</button>
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
                                <!-- Tags -->
                                <div class="mt-2">
                                    <div id="tags-list-${tarefa.idTarefa}" class="mb-2">
                                        <c:forEach var="tag" items="${fn:split(tarefa.tagTarefa, ',')}">
                                            <c:if test="${not empty tag}">
                                                <span class="badge badge-info mr-1">
                                                    ${tag}
                                                    <button type="button"
                                                            class="btn btn-sm btn-light btn-remove-tag"
                                                            onclick="removerTag('${tarefa.idTarefa}', '${tag.trim()}')">
                                                        &times;
                                                    </button>
                                                </span>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <button class="btn btn-sm btn-outline-info"
                                            data-toggle="modal"
                                            data-target="#modalAddTag"
                                            onclick="abrirModalAddTag(${tarefa.idTarefa})">
                                        + Tag
                                    </button>
                                </div>


                                <!-- Ações -->
                                <div class="mt-3">
                                    <form action="ConcluirTarefa" method="post" style="display:inline;">
                                        <input type="hidden" name="idTarefa" value="${tarefa.idTarefa}">
                                        <button class="btn btn-success btn-sm">Concluir</button>
                                    </form> 

                                    <form action="#" method="post" style="display:inline;">
                                        <button type="button"
                                                class="btn btn-warning btn-sm"
                                                data-toggle="modal"
                                                data-target="#editarTarefaModal"
                                                onclick="abrirModalEdicao(${tarefa.idTarefa}, '${tarefa.tituloTarefa}', '${tarefa.descricaoTarefa}', '${tarefa.dataFinalizarTarefa}')">
                                            Editar
                                        </button>
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

        <!-- Modal para editar tarefa -->
        <div class="modal fade" id="editarTarefaModal" tabindex="-1" aria-labelledby="editarTarefaModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form class="modal-content" action="EditarTarefa" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Editar Tarefa</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <input type="hidden" id="edit-idTarefa" name="idTarefa">
                        <div class="form-group">
                            <label for="edit-tituloTarefa">Título</label>
                            <input type="text" class="form-control" id="edit-tituloTarefa" name="tituloTarefa" required>
                        </div>
                        <div class="form-group">
                            <label for="edit-descricaoTarefa">Descrição</label>
                            <textarea class="form-control" id="edit-descricaoTarefa" name="descricaoTarefa" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="edit-dataFinalizarTarefa">Data</label>
                            <input type="date" class="form-control" id="edit-dataFinalizarTarefa" name="dataFinalizarTarefa" required>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal para adicionar tag -->
        <div class="modal fade" id="modalAddTag" tabindex="-1" role="dialog" aria-labelledby="modalAddTagLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <form id="formAddTag" class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Adicionar Tag</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="idTarefa" id="addTag-idTarefa">
                        <div class="form-group">
                            <label for="tagNome">Nome da Tag</label>
                            <input type="text" class="form-control" name="tagNome" id="tagNome" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Adicionar Tag</button>
                    </div>
                </form>
            </div>
        </div>



        <footer class="text-center mt-5">
            <blockquote class="blockquote">
                <p>“Não importa o quão devagar você vá, desde que não pare”</p>
                <footer class="blockquote-footer">Confúcio</footer>
            </blockquote>
        </footer>

        <!-- Script de Timer -->
        <script>
            // Variáveis globais para timers
            var timerIntervals = {};
            var timerSeconds = {};
            var activeTimers = {};

// Iniciar timer de uma tarefa
            function startTimer(taskId) {
                // Salva no sessionStorage
                sessionStorage.setItem('timerAtivo', taskId);
                sessionStorage.setItem('timerStartTimestamp', Date.now());

                // Desativa botão iniciar, ativa botão parar
                $('[onclick="startTimer(' + taskId + ')"]').prop('disabled', true);
                $('[onclick="stopTimer(' + taskId + ')"]').prop('disabled', false);

                // Busca tempo acumulado do servidor
                $.post('TimerControl', {action: 'get', taskId: taskId}, function (response) {
                    if (response.status === 'success') {
                        let horasAcumuladas = response.tempoAcumulado || 0;
                        let segundosAcumulados = Math.round(horasAcumuladas * 3600);

                        // Inicia timer no servidor
                        $.post('TimerControl', {action: 'start', taskId: taskId}, function (startResponse) {
                            console.log("Timer started for task: " + taskId);
                            activeTimers[taskId] = true;

                            // Zera e inicia contagem visual
                            if (timerIntervals[taskId]) {
                                clearInterval(timerIntervals[taskId]);
                            }
                            timerSeconds[taskId] = segundosAcumulados;
                            updateTimerDisplay(taskId);

                            timerIntervals[taskId] = setInterval(function () {
                                timerSeconds[taskId]++;
                                updateTimerDisplay(taskId);
                            }, 1000);
                        }, 'json');
                    }
                }, 'json');
            }

// Parar timer
            function stopTimer(taskId) {
                // Ativa botão iniciar, desativa botão parar
                $('[onclick="startTimer(' + taskId + ')"]').prop('disabled', false);
                $('[onclick="stopTimer(' + taskId + ')"]').prop('disabled', true);

                $.post('TimerControl', {action: 'stop', taskId: taskId}, function (response) {
                    console.log("Timer stopped for task: " + taskId);
                    activeTimers[taskId] = false;

                    if (timerIntervals[taskId]) {
                        clearInterval(timerIntervals[taskId]);
                        delete timerIntervals[taskId];
                        updateTimerDisplay(taskId);
                    }
                }, 'json');
            }

// Atualiza display do timer
            function updateTimerDisplay(taskId) {
                let seconds = timerSeconds[taskId] || 0;
                let hours = Math.floor(seconds / 3600);
                let minutes = Math.floor((seconds % 3600) / 60);
                let secs = seconds % 60;

                let timeString =
                        (hours < 10 ? "0" + hours : hours) + ":" +
                        (minutes < 10 ? "0" + minutes : minutes) + ":" +
                        (secs < 10 ? "0" + secs : secs);

                document.getElementById('timer-' + taskId).textContent = timeString;
            }

// Ao carregar página, exibe tempos acumulados
            $(document).ready(function () {
                var idAtivo = sessionStorage.getItem('timerAtivo');
                if (idAtivo) {
                    // Reativa o botão de parar, desativa o start
                    $('[onclick="startTimer(' + idAtivo + ')"]').prop('disabled', true);
                    $('[onclick="stopTimer(' + idAtivo + ')"]').prop('disabled', false);

                    // E reinicia a contagem visual
                    startTimer(idAtivo);
                }
            });


        </script>

        <script>
            function abrirModalEdicao(id, titulo, descricao, data) {
                document.getElementById('edit-idTarefa').value = id;
                document.getElementById('edit-tituloTarefa').value = titulo;
                document.getElementById('edit-descricaoTarefa').value = descricao;
                // Converte a data de timestamp ou string completa para formato YYYY-MM-DD
                const dataFormatada = new Date(data).toISOString().split('T')[0];
                document.getElementById('edit-dataFinalizarTarefa').value = dataFormatada;
            }
        </script>

        <script>
            function abrirModalAddTag(idTarefa) {
                document.getElementById('addTag-idTarefa').value = idTarefa;
                document.getElementById('tagNome').value = '';
            }
        </script>

        <script>
            $("#formAddTag").submit(function (event) {
                event.preventDefault();
                var idTarefa = $("#addTag-idTarefa").val();
                var novaTag = $("#tagNome").val().trim();
                if (novaTag === "") {
                    alert("Digite o nome da tag.");
                    return;
                }

                $.post("GerenciarTags", {
                    action: "add",
                    idTarefa: idTarefa,
                    tagNome: novaTag
                }, function (response) {
                    if (response.status === "success") {
                        // Fecha modal
                        $("#modalAddTag").modal("hide");
                        // Atualiza as tags na tela
                        atualizarTagsNaTela(idTarefa, response.tags);
                    } else {
                        alert("Erro ao adicionar tag.");
                    }
                }, "json");
            });
            function removerTag(idTarefa, tagNome) {
                if (confirm("Deseja remover a tag \"" + tagNome + "\"?")) {
                    $.post("GerenciarTags", {
                        action: "remove",
                        idTarefa: idTarefa,
                        tagNome: tagNome
                    }, function (response) {
                        if (response.status === "success") {
                            atualizarTagsNaTela(idTarefa, response.tags);
                        } else {
                            alert("Erro ao remover tag.");
                        }
                    }, "json");
                }
            }

            function atualizarTagsNaTela(idTarefa, tagsString) {
                var tags = tagsString.split(',');
                var html = "";
                tags.forEach(function (tag) {
                    tag = tag.trim();
                    if (tag !== "") {
                        html += "<span class='badge badge-info mr-1'>" +
                                tag +
                                "<button type='button' class='btn btn-sm btn-light btn-remove-tag' " +
                                "onclick=\"removerTag('" + idTarefa + "', '" + tag + "')\">&times;</button>" +
                                "</span>";
                    }
                });
                $("#tags-list-" + idTarefa).html(html);
            }

        </script>
<!--
        <script>
            var timerInterval = null;
            var tempoDecorridoSegundos = 0;
            var idTarefaAtiva = sessionStorage.getItem('timerAtivo');

            if (idTarefaAtiva) {
                iniciarCronometroFlutuante(idTarefaAtiva);
            }

            function iniciarCronometroFlutuante(taskId) {
                document.getElementById('cronometro-flutuante').classList.remove('d-none');

                let startTimestamp = sessionStorage.getItem('timerStartTimestamp');
                let segundosDesdeStart = 0;

                if (startTimestamp) {
                    segundosDesdeStart = Math.floor((Date.now() - parseInt(startTimestamp)) / 1000);
                }

                // Busca o tempo acumulado
                $.post("TimerControl", {action: "get", taskId: taskId}, function (response) {
                    if (response && response.status === 'success') {
                        let acumulado = Math.round((response.tempoAcumulado || 0) * 3600);
                        tempoDecorridoSegundos = acumulado + segundosDesdeStart;

                        atualizarTempoFlutuante();

                        if (timerInterval)
                            clearInterval(timerInterval);

                        timerInterval = setInterval(function () {
                            tempoDecorridoSegundos++;
                            atualizarTempoFlutuante();
                        }, 1000);
                    } else {
                        console.error("Erro ao buscar tempo acumulado:", response);
                        document.getElementById("cronometro-flutuante-tempo").textContent = "--:--:--";
                    }
                }, "json");

                // Busca o título da tarefa
                $.get("GetTituloTarefa", {idTarefa: taskId}, function (titulo) {
                    if (titulo) {
                        document.getElementById("cronometro-tarefa-titulo").innerText = titulo;
                    } else {
                        document.getElementById("cronometro-tarefa-titulo").innerText = "(Sem Título)";
                    }
                }).fail(function () {
                    console.error("Erro ao buscar título da tarefa");
                    document.getElementById("cronometro-tarefa-titulo").innerText = "(Erro)";
                });
            }

            function atualizarTempoFlutuante() {
                let h = Math.floor(tempoDecorridoSegundos / 3600);
                let m = Math.floor((tempoDecorridoSegundos % 3600) / 60);
                let s = tempoDecorridoSegundos % 60;

                let tempo = `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
                        document.getElementById("cronometro-flutuante-tempo").textContent = tempo;
                    }

                    function pararTimerFlutuante() {
                        if (!idTarefaAtiva)
                            return;

                        $.post("TimerControl", {action: "stop", taskId: idTarefaAtiva}, function (response) {
                            if (response && response.status === "stopped") {
                                clearInterval(timerInterval);
                                document.getElementById("cronometro-flutuante").classList.add("d-none");
                                sessionStorage.removeItem("timerAtivo");
                                sessionStorage.removeItem("timerStartTimestamp");
                                idTarefaAtiva = null;
                            }
                        }, "json");
                    }

                    window.addEventListener("beforeunload", function () {
                        if (idTarefaAtiva) {
                            // Salva o tempo acumulado antes de sair
                            $.ajax({
                                url: "TimerControl",
                                method: "POST",
                                async: false, // precisa ser síncrono para garantir salvar antes de fechar
                                data: {
                                    action: "save",
                                    taskId: idTarefaAtiva,
                                    segundos: tempoDecorridoSegundos
                                }
                            });
                        }
                    });
        </script> -->

    </body>
</html>