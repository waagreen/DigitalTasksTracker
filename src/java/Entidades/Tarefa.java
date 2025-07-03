/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author mvitoria
 */
@Entity
@Table(name = "tarefa")
@NamedQueries({
    @NamedQuery(name = "Tarefa.findAll", query = "SELECT t FROM Tarefa t"),
    @NamedQuery(name = "Tarefa.findByIdTarefa", query = "SELECT t FROM Tarefa t WHERE t.idTarefa = :idTarefa"),
    @NamedQuery(name = "Tarefa.findByTituloTarefa", query = "SELECT t FROM Tarefa t WHERE t.tituloTarefa = :tituloTarefa"),
    @NamedQuery(name = "Tarefa.findByDataFinalizarTarefa", query = "SELECT t FROM Tarefa t WHERE t.dataFinalizarTarefa = :dataFinalizarTarefa"),
    @NamedQuery(name = "Tarefa.findByConcluidaTarefa", query = "SELECT t FROM Tarefa t WHERE t.concluidaTarefa = :concluidaTarefa"),
    @NamedQuery(name = "Tarefa.findByTempoGasto", query = "SELECT t FROM Tarefa t WHERE t.tempoGasto = :tempoGasto"),
    @NamedQuery(name = "Tarefa.findByTagTarefa", query = "SELECT t FROM Tarefa t WHERE t.tagTarefa = :tagTarefa")})
public class Tarefa implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idTarefa", nullable = false)
    private Integer idTarefa;
    @Size(max = 45)
    @Column(name = "tituloTarefa", length = 45)
    private String tituloTarefa;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "descricaoTarefa", nullable = false, length = 65535)
    private String descricaoTarefa;
    @Column(name = "dataFinalizarTarefa")
    @Temporal(TemporalType.DATE)
    private Date dataFinalizarTarefa;
    @Column(name = "concluidaTarefa")
    private Boolean concluidaTarefa;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "tempoGasto", precision = 12)
    private Float tempoGasto;
    @Size(max = 45)
    @Column(name = "tagTarefa", length = 45)
    private String tagTarefa;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tarefa")
    private List<TarefaHasTags> tarefaHasTagsList;
    @JoinColumn(name = "usuarioTarefa", referencedColumnName = "usuario", nullable = false)
    @ManyToOne(optional = false)
    private Usuario usuarioTarefa;

    public Tarefa() {
    }

    public Tarefa(Integer idTarefa) {
        this.idTarefa = idTarefa;
    }

    public Tarefa(Integer idTarefa, String descricaoTarefa) {
        this.idTarefa = idTarefa;
        this.descricaoTarefa = descricaoTarefa;
    }

    public Integer getIdTarefa() {
        return idTarefa;
    }

    public void setIdTarefa(Integer idTarefa) {
        this.idTarefa = idTarefa;
    }

    public String getTituloTarefa() {
        return tituloTarefa;
    }

    public void setTituloTarefa(String tituloTarefa) {
        this.tituloTarefa = tituloTarefa;
    }

    public String getDescricaoTarefa() {
        return descricaoTarefa;
    }

    public void setDescricaoTarefa(String descricaoTarefa) {
        this.descricaoTarefa = descricaoTarefa;
    }

    public Date getDataFinalizarTarefa() {
        return dataFinalizarTarefa;
    }

    public void setDataFinalizarTarefa(Date dataFinalizarTarefa) {
        this.dataFinalizarTarefa = dataFinalizarTarefa;
    }

    public Boolean getConcluidaTarefa() {
        return concluidaTarefa;
    }

    public void setConcluidaTarefa(Boolean concluidaTarefa) {
        this.concluidaTarefa = concluidaTarefa;
    }

    public Float getTempoGasto() {
        return tempoGasto;
    }

    public void setTempoGasto(Float tempoGasto) {
        this.tempoGasto = tempoGasto;
    }

    public String getTagTarefa() {
        return tagTarefa;
    }

    public void setTagTarefa(String tagTarefa) {
        this.tagTarefa = tagTarefa;
    }

    public List<TarefaHasTags> getTarefaHasTagsList() {
        return tarefaHasTagsList;
    }

    public void setTarefaHasTagsList(List<TarefaHasTags> tarefaHasTagsList) {
        this.tarefaHasTagsList = tarefaHasTagsList;
    }

    public Usuario getUsuarioTarefa() {
        return usuarioTarefa;
    }

    public void setUsuarioTarefa(Usuario usuarioTarefa) {
        this.usuarioTarefa = usuarioTarefa;
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
        if (!(object instanceof Tarefa)) {
            return false;
        }
        Tarefa other = (Tarefa) object;
        if ((this.idTarefa == null && other.idTarefa != null) || (this.idTarefa != null && !this.idTarefa.equals(other.idTarefa))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Tarefa[ idTarefa=" + idTarefa + " ]";
    }
    
}
