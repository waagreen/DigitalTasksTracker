<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sistema To-Do</title>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/pagesCSS.css" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>

    <body>
        <header class="bg-light p-3 mb-4">
            <div class="container">
                <h1 class="text-primary">Tarefas</h1>
                <button class="btn btn-success" data-toggle="modal" data-target="#novaTarefaModal">+ Nova Tarefa</button>
            </div>
        </header>

        <main class="container">
            <h4 class="mb-4">Organize suas tarefas:</h4>

            <div class="row row-cols-1 row-cols-md-3">
                   <c:forEach var="tarefa" items="${tarefa}">
                         <div class="col mb-4">
                           <div class="card h-100">
                               <div class="card-body">
                                   <h5 class="card-title">${tarefa.tituloTarefa}</h5>
                                   <h6 class="card-subtitle mb-2 text-muted">${tarefa.dataFinalizarTarefa}</h6>
                                   <p class="card-text">${tarefa.descricaoTarefa}</p>
                     <form action="ExcluirTarefa" method="post">
                         <input type="hidden" name="idTarefa" value="${tarefa.idTarefa}">
                         <button class="btn btn-danger btn-sm">Excluir</button>
                     </form> 
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
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Salvar Tarefa</button>
                    </div>
                </form>
            </div>
        </div>

        <footer class="text-center mt-5">
            <blockquote class="blockquote">
                <p>Frase motivacional aleatória. Lorem ipsum :)</p>
                <footer class="blockquote-footer">Quem disse foi <cite title="Fonte">nome do autor</cite></footer>
            </blockquote>
        </footer>
    </body>
</html>
