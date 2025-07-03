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
import javax.validation.constraints.Size;

/**
 *
 * @author mvitoria
 */
@Entity
@Table(name = "nota")
@NamedQueries({
    @NamedQuery(name = "Nota.findAll", query = "SELECT n FROM Nota n"),
    @NamedQuery(name = "Nota.findByIdNota", query = "SELECT n FROM Nota n WHERE n.idNota = :idNota"),
    @NamedQuery(name = "Nota.findByTituloNota", query = "SELECT n FROM Nota n WHERE n.tituloNota = :tituloNota")})
public class Nota implements Serializable {

    @Size(max = 45)
    @Column(name = "tituloNota")
    private String tituloNota;
    @Lob
    @Size(max = 65535)
    @Column(name = "conteudoNota")
    private String conteudoNota;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idNota", nullable = false)
    private Integer idNota;
    @JoinColumn(name = "usuarioNota", referencedColumnName = "usuario", nullable = false)
    @ManyToOne(optional = false)
    private Usuario usuarioNota;

    public Nota() {
    }

    public Nota(Integer idNota) {
        this.idNota = idNota;
    }

    public Integer getIdNota() {
        return idNota;
    }

    public void setIdNota(Integer idNota) {
        this.idNota = idNota;
    }


    public Usuario getUsuarioNota() {
        return usuarioNota;
    }

    public void setUsuarioNota(Usuario usuarioNota) {
        this.usuarioNota = usuarioNota;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idNota != null ? idNota.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Nota)) {
            return false;
        }
        Nota other = (Nota) object;
        if ((this.idNota == null && other.idNota != null) || (this.idNota != null && !this.idNota.equals(other.idNota))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Nota[ idNota=" + idNota + " ]";
    }

    public String getTituloNota() {
        return tituloNota;
    }

    public void setTituloNota(String tituloNota) {
        this.tituloNota = tituloNota;
    }

    public String getConteudoNota() {
        return conteudoNota;
    }

    public void setConteudoNota(String conteudoNota) {
        this.conteudoNota = conteudoNota;
    }
    
}
