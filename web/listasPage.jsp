<%@page import="DAOs.DAOLista"%>
<%@page import="DAOs.DAOItemLista"%>
<%@page import="DAOs.DAOUsuario"%>
<%@page import="Entidades.Lista"%>
<%@page import="Entidades.ItemLista"%>
<%@page import="Entidades.Usuario"%>
<%@page import="java.util.*"%>

<%
    DAOLista daoLista = new DAOLista();
    DAOItemLista daoItem = new DAOItemLista();
    DAOUsuario daoUsuario = new DAOUsuario();

    Cookie[] cookie = request.getCookies();
    Usuario usuario = null;
    List<Lista> listas = new ArrayList<>();

    for (int i = 0; cookie != null && i < cookie.length; i++) {
        if (cookie[i].getName().equals("user")) {
            listas = daoLista.listByUsuario(cookie[i].getValue());
            usuario = daoUsuario.obter(cookie[i].getValue());
        }
    }

    String acao = request.getParameter("acao");

    if (acao != null && usuario != null) {
        String id = request.getParameter("id");
        String nome = request.getParameter("nomeLista");

        if (acao.equals("cadastrar")) {
            Lista novaLista = new Lista();
            novaLista.setNomeLista(nome);
            novaLista.setUsuarioLista(usuario);
            daoLista.inserir(novaLista);

            // salvar os itens
            String[] itens = request.getParameterValues("itens[]");
            if (itens != null) {
                for (String desc : itens) {
                    if (!desc.trim().isEmpty()) {
                        ItemLista item = new ItemLista();
                        item.setDescricao(desc);
                        item.setConcluido(false);
                        item.setLista(novaLista);
                        daoItem.inserir(item);
                    }
                }
            }
        } else if (acao.equals("excluir")) {
            Lista listaExcluir = daoLista.obter(Integer.parseInt(id));
            // excluir os itens primeiro
            List<ItemLista> itens = daoItem.listByLista(listaExcluir.getIdLista());
            for (ItemLista item : itens) {
                daoItem.remover(item);
            }
            daoLista.remover(listaExcluir);
        } else if (acao.equals("alterar")) {
            Lista listaEditada = daoLista.obter(Integer.parseInt(id));
            listaEditada.setNomeLista(nome);
            daoLista.atualizar(listaEditada);
        }
        response.sendRedirect("listasPage.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Listas - Sistema To-Do</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <h1 class="text-primary p-2">Minuet</h1>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="mainPage.jsp"><i class="bi bi-clipboard"></i> Tarefas</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="notasPage.jsp"><i class="bi bi-sticky"></i> Notas</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listasPage.jsp"><i class="bi bi-list-ul"></i> Listas</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-4" style="max-width: 800px;">
            <h2 class="mb-4">Criar nova lista</h2>

            <form method="post" action="listasPage.jsp" class="mb-5">
                <input type="hidden" name="acao" value="cadastrar">
                <div class="mb-3">
                    <label for="nomeLista" class="form-label">Nome da Lista</label>
                    <input type="text" class="form-control" name="nomeLista" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Itens</label>
                    <div id="camposItens"></div>
                    <button type="button" class="btn btn-secondary btn-sm" onclick="adicionarItem()">+ Adicionar Item</button>
                </div>
                <button type="submit" class="btn btn-primary">Criar Lista</button>
            </form>

            <h3>Minhas Listas</h3>
            <% for (Lista l : listas) { 
                List<ItemLista> itens = daoItem.listByLista(l.getIdLista());
            %>
            <div class="card mb-3">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <strong><%= l.getNomeLista() %></strong>
                    <div>
                        <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modalEditar<%= l.getIdLista() %>">
                            Editar
                        </button>
                        <form method="post" action="listasPage.jsp" class="d-inline" onsubmit="return confirm('Deseja excluir esta lista?')">
                            <input type="hidden" name="acao" value="excluir">
                            <input type="hidden" name="id" value="<%= l.getIdLista() %>">
                            <button type="submit" class="btn btn-sm btn-danger">Excluir</button>
                        </form>
                    </div>
                </div>
                <% if (itens != null && !itens.isEmpty()) { %>
                <ul class="list-group list-group-flush">
                    <% for (ItemLista item : itens) { %>
                    <li class="list-group-item">
                        <%= item.getDescricao() %>
                    </li>
                    <% } %>
                </ul>
                <% } else { %>
                <div class="card-body text-muted">
                    Nenhum item cadastrado.
                </div>
                <% } %>
            </div>

            <!-- Modal de edição -->
            <div class="modal fade" id="modalEditar<%= l.getIdLista() %>" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form method="post" action="listasPage.jsp">
                            <input type="hidden" name="acao" value="alterar">
                            <input type="hidden" name="id" value="<%= l.getIdLista() %>">
                            <div class="modal-header">
                                <h5 class="modal-title">Editar Lista</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Nome da Lista</label>
                                    <input type="text" class="form-control" name="nomeLista" value="<%= l.getNomeLista() %>" required>
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
            <% } %>
            

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                function adicionarItem() {
                    const container = document.getElementById('camposItens');
                    const div = document.createElement('div');
                    div.className = 'input-group mb-2';
                    div.innerHTML = `
                    <input type="text" name="itens[]" class="form-control" required placeholder="Descrição do item">
                    <button class="btn btn-outline-danger" type="button" onclick="this.parentElement.remove()">X</button>
                `;
                    container.appendChild(div);
                }
        </script>
    </body>
</html>
