package DAOs;

import Entidades.Lista;
import java.util.List;

/**
 *
 * @author mvitoria
 */
public class DAOLista extends DAOGenerico<Lista> {

    public DAOLista() {
        super(Lista.class);
    }

    public int autoIdLista() {
        Integer a = (Integer) em.createQuery("SELECT MAX(e.idLista) FROM Lista e").getSingleResult();
        if (a != null) {
            return a + 1;
        } else {
            return 1;
        }
    }

    public List<Lista> listByTitulo(String titulo) {
        return em.createQuery("SELECT e FROM Lista e WHERE e.tituloLista LIKE :tituloLista", Lista.class)
                .setParameter("titulo", "%" + titulo + "%")
                .getResultList();
    }

    public List<Lista> listByUsuario(int usuarioId) {
        return em.createQuery("SELECT e FROM Lista e WHERE e.usuario.id = :usuarioLista", Lista.class)
                .setParameter("id", usuarioId)
                .getResultList();
    }

    public List<Lista> listByUsuario(String usuarioId) {
        return em.createQuery("SELECT e FROM Lista e WHERE e.usuarioLista.usuario = :usuario", Lista.class)
                .setParameter("usuario", usuarioId)
                .getResultList();
    }
    
    public List<Lista> listByUsuario(String usuarioId, Boolean concluidaLista) {
        return em.createQuery("SELECT e FROM Lista e WHERE e.usuarioLista.usuario = :usuario AND e.concluidaLista = :concluida", Lista.class)
                .setParameter("usuario", usuarioId)
                .setParameter("concluida", concluidaLista)
                .getResultList();
    }

    public List<Lista> listInOrderTitulo() {
        return em.createQuery("SELECT e FROM Lista e ORDER BY e.tituloLista", Lista.class).getResultList();
    }

    public List<Lista> listInOrderId() {
        return em.createQuery("SELECT e FROM Lista e ORDER BY e.idLista", Lista.class).getResultList();
    }

    public List<Object[]> tempoGastoPorTag() {
        return em.createQuery("SELECT t.tagLista, SUM(t.tempoGasto) FROM Lista t GROUP BY t.tagLista").getResultList();
    }

    public List<String> listInOrderTituloStrings(String qualOrdem) {
        List<Lista> lt;
        if (qualOrdem.equals("idLista")) {
            lt = listInOrderId();
        } else {
            lt = listInOrderTitulo();
        }

        List<String> ls = new java.util.ArrayList<>();
        for (Lista t : lt) {
            ls.add(t.getNomeLista());
        }
        return ls;
    }

    public static void main(String[] args) {
        DAOLista daoLista = new DAOLista();
        List<Lista> listas = daoLista.list();
        for (Lista t : listas) {
            System.out.println(t.getNomeLista());
        }
    }
}
