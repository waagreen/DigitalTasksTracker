<%-- 
    Document   : Estatistica
    Created on : 16 de jun. de 2025, 13:40:54
    Author     : mvitoria
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Estatísticas de Tempo</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>

        <div class="container mt-5">
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
