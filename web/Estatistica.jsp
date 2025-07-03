<%-- 
    Document   : Estatistica
    Created on : 16 de jun. de 2025, 13:40:54
    Author     : mvitoria
--%>

<%@page import="java.util.HashMap"%>
<%@page import="Entidades.Tarefa"%>
<%@page import="DAOs.DAOTarefa"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    DAOTarefa dao = new DAOTarefa();
    List<Tarefa> tarefas = dao.listInOrderId();

    Map<String, Float> tempoPorTag = new HashMap<>();

    for (Tarefa t : tarefas) {
        String tagsStr = t.getTagTarefa();
        Float tempoGasto = t.getTempoGasto(); // wrapper Float

        if (tagsStr != null && !tagsStr.trim().isEmpty() && tempoGasto != null) {
            String[] tags = tagsStr.split(",");

            for (String tag : tags) {
                tag = tag.trim();
                if (!tag.isEmpty()) {
                    tempoPorTag.put(
                            tag,
                            tempoPorTag.getOrDefault(tag, 0.0f) + tempoGasto
                    );
                }
            }
        }
    }

    List<List<String>> estatisticas = new ArrayList<>();
    for (Map.Entry<String, Float> entry : tempoPorTag.entrySet()) {
        List<String> linha = new ArrayList<>();
        linha.add(entry.getKey());
        linha.add(String.format("%.1f", entry.getValue())); // em horas
        estatisticas.add(linha);
    }

    request.setAttribute("estatisticas", estatisticas);
%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Estatísticas de Tempo</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    </head>

    <body class="bg-light">
        <!--        <div id="cronometro-flutuante" class="position-fixed small bg-light border border-primary shadow rounded d-none"
                     style="bottom: 20px; right: 20px; width: auto; max-width: 250px; z-index: 1050; padding: 10px;">
                    <div>
                        <strong class="d-block mb-1 text-primary">Tarefa em andamento:</strong>
                        <span id="cronometro-tarefa-titulo" class="fw-bold"></span><br>
                        <span id="cronometro-flutuante-tempo" class="text-success"></span>
                        <button class="btn btn-sm btn-danger ms-2 mt-2" onclick="pararTimerFlutuante()">Parar</button>
                    </div>
                </div> -->

        <div class="container mt-5">
            <header class="bg-light p-2 mb-2 d-flex justify-content-between align-items-center">
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
                                        <i class="bi bi-graph-up-arrow"></i> Estatísticas
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
            </header>
            <h1 class="text-center mb-4">Estatísticas</h1>

            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>Tarefa</th>
                        <th>Tempo Gasto (horas)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="linha" items="${estatisticas}">
                        <tr>
                            <td>${linha[0]}</td>
                            <td>${linha[1]}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <a href="mainPage.jsp" class="btn btn-primary">Voltar</a>
        </div>

        <div class="container mt-4">
            <h2>Desempenho</h2>
            <!-- Botões -->
            <div class="d-flex justify-content-center mt-3">
                <button class="btn btn-outline-primary me-2" onclick="renderChart('semana', event)">Semana</button>
                <button class="btn btn-outline-primary" onclick="renderChart('mes', event)">Mês</button>
            </div>

            <!-- Canvas -->
            <canvas id="graficoEstatisticas" width="400" height="200"></canvas>
        </div>
        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
                    const ctx = document.getElementById('graficoEstatisticas').getContext('2d');

                    const dadosSemana = {
                        labels: ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
                        tarefas: [3, 5, 4, 6, 2, 1, 4],
                        xp: [50, 80, 65, 90, 30, 10, 60]
                    };

                    const dadosMes = {
                        labels: Array.from({length: 30}, (_, i) => `Dia ${i + 1}`),
                        tarefas: Array.from({length: 30}, () => Math.floor(Math.random() * 6) + 1),
                        xp: Array.from({length: 30}, () => Math.floor(Math.random() * 100) + 10)
                    };

                    let grafico;

                    function renderChart(tipo, event) {
                        if (event)
                            event.preventDefault();

                        const dados = tipo === 'semana' ? dadosSemana : dadosMes;

                        if (grafico)
                            grafico.destroy();

                        grafico = new Chart(ctx, {
                            data: {
                                labels: dados.labels,
                                datasets: [
                                    {
                                        label: 'Tarefas Concluídas',
                                        data: dados.tarefas,
                                        type: 'bar',
                                        backgroundColor: 'rgba(0, 123, 255, 0.7)',
                                        borderRadius: 5,
                                        yAxisID: 'tarefasY'
                                    },
                                    {
                                        label: 'XP Ganha',
                                        data: dados.xp,
                                        type: 'line',
                                        borderColor: 'orange',
                                        backgroundColor: 'transparent',
                                        yAxisID: 'xpY',
                                        pointRadius: 6,
                                        pointHoverRadius: 8,
                                        tension: 0.4
                                    }
                                ]
                            },
                            options: {
                                responsive: true,
                                interaction: {
                                    mode: 'index',
                                    intersect: false
                                },
                                plugins: {
                                    legend: {position: 'bottom'},
                                    tooltip: {
                                        callbacks: {
                                            label: function (context) {
                                                const datasetLabel = context.dataset.label;
                                                const value = context.parsed.y;
                                                return datasetLabel + ': ' + (datasetLabel.includes('Tarefa') ? value + ' tarefas' : value + ' XP');
                                            }
                                        }
                                    }
                                },
                                scales: {
                                    tarefasY: {
                                        type: 'linear',
                                        position: 'left',
                                        beginAtZero: true,
                                        title: {
                                            display: true,
                                            text: 'Tarefas Concluídas'
                                        },
                                        ticks: {
                                            stepSize: 1
                                        }
                                    },
                                    xpY: {
                                        type: 'linear',
                                        position: 'right',
                                        beginAtZero: true,
                                        title: {
                                            display: true,
                                            text: 'XP Ganha'
                                        }
                                    }
                                }
                            }
                        });
                    }

                    renderChart('semana');
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
        </script>
-->
</html>