/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author mvitoria
 */
@Entity
@Table(name = "lista")
@NamedQueries({
    @NamedQuery(name = "Lista.findAll", query = "SELECT l FROM Lista l"),
    @NamedQuery(name = "Lista.findByIdLista", query = "SELECT l FROM Lista l WHERE l.idLista = :idLista"),
    @NamedQuery(name = "Lista.findByNomeLista", query = "SELECT l FROM Lista l WHERE l.nomeLista = :nomeLista")})
public class Lista implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "nomeLista")
    private String nomeLista;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idLista")
    private List<TarefaLista> tarefaListaList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idLista", nullable = false)
    private Integer idLista;
    @JoinColumn(name = "usuarioLista", referencedColumnName = "usuario", nullable = false)
    @ManyToOne(optional = false)
    private Usuario usuarioLista;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "lista")
    private List<ItemLista> itemListaList;

    public Lista() {
    }

    public Lista(Integer idLista) {
        this.idLista = idLista;
    }

    public Lista(Integer idLista, String nomeLista) {
        this.idLista = idLista;
        this.nomeLista = nomeLista;
    }

    public Integer getIdLista() {
        return idLista;
    }

    public void setIdLista(Integer idLista) {
        this.idLista = idLista;
    }


    public Usuario getUsuarioLista() {
        return usuarioLista;
    }

    public void setUsuarioLista(Usuario usuarioLista) {
        this.usuarioLista = usuarioLista;
    }

    public List<ItemLista> getItemListaList() {
        return itemListaList;
    }

    public void setItemListaList(List<ItemLista> itemListaList) {
        this.itemListaList = itemListaList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idLista != null ? idLista.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Lista)) {
            return false;
        }
        Lista other = (Lista) object;
        if ((this.idLista == null && other.idLista != null) || (this.idLista != null && !this.idLista.equals(other.idLista))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Lista[ idLista=" + idLista + " ]";
    }

    public String getNomeLista() {
        return nomeLista;
    }

    public void setNomeLista(String nomeLista) {
        this.nomeLista = nomeLista;
    }

    public List<TarefaLista> getTarefaListaList() {
        return tarefaListaList;
    }

    public void setTarefaListaList(List<TarefaLista> tarefaListaList) {
        this.tarefaListaList = tarefaListaList;
    }
    
}
