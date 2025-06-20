package Servlets;

import DAOs.DAONota;
import DAOs.DAOUsuario;
import Entidades.Nota;
import Entidades.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tools.CaixaDeFerramentas;

@WebServlet(name = "CadastrarNota", urlPatterns = {"/CadastrarNota"})
public class EditarNota extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CaixaDeFerramentas cdf = new CaixaDeFerramentas();
        DAOUsuario daoUsuario = new DAOUsuario();
        DAONota daoNota = new DAONota();
        
        String idNotaStr = request.getParameter("idNota");

        Cookie[] cookie = request.getCookies();
        System.out.println("========================================================================================");
        for (int i = 0; i < cookie.length; i++) {
            System.out.println("Cookie NAME" + cookie[i].getName());
            System.out.println("Cookie VALUE" + cookie[i].getValue());
        }
        System.out.println("COOKIE LENGTH - 1 : " + cookie[cookie.length - 1].getValue());
        System.out.println("========================================================================================");
        
        if (idNotaStr != null) {
            int idNota = Integer.parseInt(idNotaStr);
            Entidades.Nota nota = daoNota.obter(idNota);
            if (nota != null) {
                String tituloNota = request.getParameter("tituloNota");
                String descricaoNota = request.getParameter("descricaoNota");
                
                nota.setTituloNota(tituloNota);
                nota.setConteudoNota(descricaoNota);
                
                daoNota.atualizar(nota);
                System.out.println("Nota atualizada com sucesso.");
            }else {
                System.out.println("Entidade Nota " + idNota + " não encontrada.");
            }
        } else {
            System.out.println("Parâmetro 'idNota' não foi enviado.");
        }

        response.sendRedirect("mainPage.jsp"); // redireciona após salvar
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAONota daoNota = new DAONota();

        List<Nota> todas = daoNota.list();
        System.out.println("TOTAL DE NOTAS NO BANCO: " + todas.size());
        for (Nota t : todas) {
            System.out.println(t.getTituloNota());
        }

    }

    @Override
    public String getServletInfo() {
        return "Servlet que cadastra uma nota";
    }
}
