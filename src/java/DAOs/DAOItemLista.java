package DAOs;

import Entidades.ItemLista;
import java.util.List;

/**
 *
 * @author mvitoria
 */
public class DAOItemLista extends DAOGenerico<ItemLista> {

    public DAOItemLista() {
        super(ItemLista.class);
    }

    public int autoIdItemLista() {
        Integer a = (Integer) em.createQuery("SELECT MAX(e.idItemLista) FROM ItemLista e").getSingleResult();
        if (a != null) {
            return a + 1;
        } else {
            return 1;
        }
    }

    public List<ItemLista> listByTitulo(String titulo) {
        return em.createQuery("SELECT e FROM ItemLista e WHERE e.tituloItemLista LIKE :tituloItemLista", ItemLista.class)
                .setParameter("titulo", "%" + titulo + "%")
                .getResultList();
    }

    public List<ItemLista> listByUsuario(int usuarioId) {
        return em.createQuery("SELECT e FROM ItemLista e WHERE e.usuario.id = :usuarioItemLista", ItemLista.class)
                .setParameter("id", usuarioId)
                .getResultList();
    }

    public List<ItemLista> listByUsuario(String usuarioId) {
        return em.createQuery("SELECT e FROM ItemLista e WHERE e.usuarioItemLista.usuario = :usuario", ItemLista.class)
                .setParameter("usuario", usuarioId)
                .getResultList();
    }

    public List<ItemLista> listByUsuario(String usuarioId, Boolean concluidaItemLista) {
        return em.createQuery("SELECT e FROM ItemLista e WHERE e.usuarioItemLista.usuario = :usuario AND e.concluidaItemLista = :concluida", ItemLista.class)
                .setParameter("usuario", usuarioId)
                .setParameter("concluida", concluidaItemLista)
                .getResultList();
    }

    public List<ItemLista> listInOrderTitulo() {
        return em.createQuery("SELECT e FROM ItemLista e ORDER BY e.tituloItemLista", ItemLista.class).getResultList();
    }

    public List<String> listInOrderTituloStrings(String qualOrdem) {
        List<ItemLista> lt;
        if (qualOrdem.equals("idItemLista")) {
            lt = listInOrderId();
        } else {
            lt = listInOrderTitulo();
        }

        List<String> ls = new java.util.ArrayList<>();
        for (ItemLista t : lt) {
            ls.add(t.getDescricao());
        }
        return ls;
    }

    public List<ItemLista> listInOrderId() {
        return em.createQuery("SELECT e FROM ItemLista e ORDER BY e.idItem", ItemLista.class)
                .getResultList();
    }

    public List<ItemLista> listByLista(Integer idLista) {
        return em.createQuery("SELECT e FROM ItemLista e WHERE e.lista.idLista = :id", ItemLista.class)
                .setParameter("id", idLista)
                .getResultList();
    }

    public static void main(String[] args) {
        DAOItemLista daoItemLista = new DAOItemLista();
        List<ItemLista> itemListas = daoItemLista.list();
        for (ItemLista t : itemListas) {
            System.out.println(t.getDescricao());
        }
    }
}
