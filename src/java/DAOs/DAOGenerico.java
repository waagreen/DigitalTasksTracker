package DAOs;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Persistence;

public class DAOGenerico<T> {

    public static EntityManager em = Persistence.createEntityManagerFactory("UP").createEntityManager();
    private Class clazz;

    public DAOGenerico(Class clazz) {
        this.clazz = clazz;
    }

    public void inserir(T e) {
        em.getTransaction().begin();
        em.persist(e);
        em.getTransaction().commit();
    }

    public void atualizar(T e) {
        em.getTransaction().begin();
        em.merge(e);
        em.getTransaction().commit();
    }

    public void remover(T e) {
        em.getTransaction().begin();
        em.remove(e);
        em.getTransaction().commit();
    }

    public T obter(Long id) {
        return (T) em.find(clazz, id);
    }

    public T obter(Integer id) {
        return (T) em.find(clazz, id);
    }

    public T obter(String id) {

        return (T) em.find(clazz, id);
    
    }

    public List<T> list() {
        return em.createQuery("SELECT e FROM " + clazz.getSimpleName() + " e").getResultList();
    }
}
