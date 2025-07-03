/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author mvitoria
 */
@Entity
@Table(name = "item_lista")
@NamedQueries({
    @NamedQuery(name = "ItemLista.findAll", query = "SELECT i FROM ItemLista i"),
    @NamedQuery(name = "ItemLista.findByIdItem", query = "SELECT i FROM ItemLista i WHERE i.idItem = :idItem"),
    @NamedQuery(name = "ItemLista.findByConcluido", query = "SELECT i FROM ItemLista i WHERE i.concluido = :concluido")})
public class ItemLista implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "descricao")
    private String descricao;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idItem", nullable = false)
    private Integer idItem;
    @Column(name = "concluido")
    private Boolean concluido;
    @JoinColumn(name = "lista", referencedColumnName = "idLista", nullable = false)
    @ManyToOne(optional = false)
    private Lista lista;

    public ItemLista() {
    }

    public ItemLista(Integer idItem) {
        this.idItem = idItem;
    }

    public ItemLista(Integer idItem, String descricao) {
        this.idItem = idItem;
        this.descricao = descricao;
    }

    public Integer getIdItem() {
        return idItem;
    }

    public void setIdItem(Integer idItem) {
        this.idItem = idItem;
    }


    public Boolean getConcluido() {
        return concluido;
    }

    public void setConcluido(Boolean concluido) {
        this.concluido = concluido;
    }

    public Lista getLista() {
        return lista;
    }

    public void setLista(Lista lista) {
        this.lista = lista;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idItem != null ? idItem.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ItemLista)) {
            return false;
        }
        ItemLista other = (ItemLista) object;
        if ((this.idItem == null && other.idItem != null) || (this.idItem != null && !this.idItem.equals(other.idItem))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.ItemLista[ idItem=" + idItem + " ]";
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    
}
