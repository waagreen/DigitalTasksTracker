<%-- 
    Document   : Estatistica
    Created on : 16 de jun. de 2025, 13:40:54
    Author     : mvitoria
--%>

<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Estatísticas de Tempo</title>
        s<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    </head>
    
    <body class="bg-light">
        <div class="container mt-5">
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
                    <a href="Logout" class="btn btn-danger">Logout</a>
                </div>
            </header>
            <h1 class="text-center mb-4">Estatísticas</h1>

            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>Tarefa</th>
                        <th>Tempo Gasto (minutos)</th>
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

    </body>
</html>
