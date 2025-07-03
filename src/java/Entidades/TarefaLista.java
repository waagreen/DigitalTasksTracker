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
 * @author 04144
 */
@Entity
@Table(name = "tarefa_lista")
@NamedQueries({
    @NamedQuery(name = "TarefaLista.findAll", query = "SELECT t FROM TarefaLista t"),
    @NamedQuery(name = "TarefaLista.findByIdTarefa", query = "SELECT t FROM TarefaLista t WHERE t.idTarefa = :idTarefa"),
    @NamedQuery(name = "TarefaLista.findByStatus", query = "SELECT t FROM TarefaLista t WHERE t.status = :status")})
public class TarefaLista implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idTarefa")
    private Integer idTarefa;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "titulo")
    private String titulo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "status")
    private short status;
    @JoinColumn(name = "idLista", referencedColumnName = "idLista")
    @ManyToOne(optional = false)
    private Lista idLista;

    public TarefaLista() {
    }

    public TarefaLista(Integer idTarefa) {
        this.idTarefa = idTarefa;
    }

    public TarefaLista(Integer idTarefa, String titulo, short status) {
        this.idTarefa = idTarefa;
        this.titulo = titulo;
        this.status = status;
    }

    public Integer getIdTarefa() {
        return idTarefa;
    }

    public void setIdTarefa(Integer idTarefa) {
        this.idTarefa = idTarefa;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public short getStatus() {
        return status;
    }

    public void setStatus(short status) {
        this.status = status;
    }

    public Lista getIdLista() {
        return idLista;
    }

    public void setIdLista(Lista idLista) {
        this.idLista = idLista;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTarefa != null ? idTarefa.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TarefaLista)) {
            return false;
        }
        TarefaLista other = (TarefaLista) object;
        if ((this.idTarefa == null && other.idTarefa != null) || (this.idTarefa != null && !this.idTarefa.equals(other.idTarefa))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.TarefaLista[ idTarefa=" + idTarefa + " ]";
    }
    
}
