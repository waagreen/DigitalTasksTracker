<%-- 
    Document   : Cadastrar
    Created on : 11 de abr. de 2025, 13:22:40
    Author     : mvitoria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head lang="pt-br">
        <title>Cadastrar</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/estilo.css">
    </head>
    
    <body>
        <h2 class="container-sm text-center">Cadastro</h2>
        <div class="container-sm">
            <form action = "Cadastrar" method = "post">
                <div class="m-3">
                    <label fid="usuario" for="formGroupExampleInput" class="form-label">Usuario:</label><br>
                    <input class="form-control" id="usuario" type="text" name="usuario" min="1" maxlength="11" required><br>
                </div>
                <div class="m-3">
                    <label id="senha" for="formGroupExampleInput" class="form-label">Senha:</label><br>
                    <input class="form-control" type="password" name="senha" id="senha" required maxlength="16"><br>
                </div>
                <input type="submit" class="btn btn-outline-secondary" value="Cadastrar">
            </form>
        </div>
    </body>
</html>
