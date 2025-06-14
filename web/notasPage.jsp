<%@page import="DAOs.DAOUsuario"%>
<%@page import="Entidades.Usuario"%>
<%@page import="Entidades.Nota"%>
<%@page import="DAOs.DAONota"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
    DAONota daoNota = new DAONota();
    DAOUsuario daoUsuario = new DAOUsuario();
    Cookie[] cookie = request.getCookies();

    List<Nota> listaNotas = null;
    Usuario usuario = null;
    for (int i = 0; i < cookie.length; i++) {
        if (cookie[i].getName().equals("user")) {
            listaNotas = daoNota.listByUsuario(cookie[i].getValue());
            usuario = daoUsuario.obter(cookie[i].getValue());
        }
    }

    String mensagem = "";

    if (request.getParameter("acao") != null) {
        String acao = request.getParameter("acao");
        String id = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String conteudo = request.getParameter("conteudo");

        if (acao.equals("cadastrar")) {
            Nota nota = new Nota();
            nota.setTituloNota(titulo);
            nota.setConteudoNota(conteudo);
            nota.setUsuarioNota(usuario);

            daoNota.inserir(nota);
            mensagem = "Nota cadastrada com sucesso!";
        } else if (acao.equals("excluir")) {
            daoNota.remover(daoNota.obter(id));
            mensagem = "Nota excluída com sucesso!";
        } else if (acao.equals("editar")) {
            Nota nota = new Nota();
            nota.setTituloNota(titulo);
            nota.setConteudoNota(conteudo);
            nota.setUsuarioNota(usuario);
            daoNota.atualizar(nota);
            mensagem = "Nota editada com sucesso!";
        }

        response.sendRedirect("notas.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Minhas Notas</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <div class="container py-5">
            <h1 class="mb-4">Minhas Notas</h1>

            <!-- Formulário de cadastro -->
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    Criar Nova Nota
                </div>
                <div class="card-body">
                    <form method="post" action="notas.jsp">
                        <input type="hidden" name="acao" value="cadastrar">
                        <div class="mb-3">
                            <label class="form-label">Título</label>
                            <input type="text" class="form-control" name="titulo" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Conteúdo</label>
                            <textarea class="form-control" name="conteudo" rows="3" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-success">Salvar Nota</button>
                    </form>
                </div>
            </div>

            <!-- Lista de notas -->
            <div class="row">
                <% for (Nota nota : listaNotas) {%>
                <div class="col-md-4">
                    <div class="card mb-4">
                        <div class="card-header bg-secondary text-white d-flex justify-content-between align-items-center">
                            <strong><%= nota.getTituloNota()%></strong>
                            <small class="text-light">ID: <%= nota.getIdNota()%></small>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><%= nota.getConteudoNota()%></p>
                        </div>
                        <div class="card-footer d-flex justify-content-between">
                            <button class="btn btn-sm btn-primary" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#editarModal<%=nota.getIdNota()%>">
                                Editar
                            </button>
                            <form method="post" action="notas.jsp" onsubmit="return confirm('Deseja excluir esta nota?')">
                                <input type="hidden" name="acao" value="excluir">
                                <input type="hidden" name="id" value="<%=nota.getIdNota()%>">
                                <button type="submit" class="btn btn-sm btn-danger">Excluir</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Modal de edição -->
                <div class="modal fade" id="editarModal<%=nota.getIdNota()%>" tabindex="-1" aria-labelledby="editarModalLabel<%=nota.getIdNota()%>" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="notas.jsp">
                                <input type="hidden" name="acao" value="editar">
                                <input type="hidden" name="id" value="<%=nota.getIdNota()%>">

                                <div class="modal-header">
                                    <h5 class="modal-title" id="editarModalLabel<%=nota.getIdNota()%>">Editar Nota</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                                </div>

                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label class="form-label">Título</label>
                                        <input type="text" class="form-control" name="titulo" value="<%=nota.getTituloNota()%>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Conteúdo</label>
                                        <textarea class="form-control" name="conteudo" rows="3" required><%=nota.getConteudoNota()%></textarea>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    <button type="submit" class="btn btn-success">Salvar Alterações</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <% }%>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
