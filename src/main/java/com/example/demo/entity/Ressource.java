package com.example.demo.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
public class Ressource {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected int id;

    @Column(name = "code_barre")
    protected String codeBarre;

    @Column(name = "duree_garantie")
    private String dureeGarantie;

    @Column(name = "etat")
    private Integer etat;

    @Column(name = "marque")
    protected String marque;

    @OneToOne(mappedBy = "ressource")
    private Affectation affectation;

    @OneToMany(mappedBy = "ressource", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Panne> pannes = new ArrayList<>();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "enseignant_id")
    private Enseignant enseignant;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "appel_offre_id")
    private AppelOffre appelOffre;

    @OneToMany(mappedBy = "ressource", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Proposition> propositions = new ArrayList<>();

    @OneToOne(mappedBy = "ressource")
    private Imprimante imprimante;

    @OneToOne(mappedBy = "ressource")
    private Ordinateur ordinateur;

    public Ressource() {
    }

	public Ressource(Integer etat, Enseignant enseignant) {
		super();
		this.etat = etat;
		this.enseignant = enseignant;
	}

	public Ressource(int id, String codeBarre, String dureeGarantie, String marque) {
		super();
		this.id = id;
		this.codeBarre = codeBarre;
		this.dureeGarantie = dureeGarantie;
		this.marque = marque;
	}

	public List<Panne> getPannes() {
		return pannes;
	}

	public AppelOffre getAppelOffre() {
		return appelOffre;
	}

	public List<Proposition> getPropositions() {
		return propositions;
	}

	public void setAffectation(Affectation affectation) {
		this.affectation = affectation;
	}

	public void setPannes(List<Panne> pannes) {
		this.pannes = pannes;
	}

	public void setAppelOffre(AppelOffre appelOffre) {
		this.appelOffre = appelOffre;
	}

	public void setPropositions(List<Proposition> propositions) {
		this.propositions = propositions;
	}

	public String getCodeBarre() {
		return codeBarre;
	}

	public Imprimante getImprimante() {
		return imprimante;
	}

	public Ordinateur getOrdinateur() {
		return ordinateur;
	}

	public void setImprimante(Imprimante imprimante) {
		this.imprimante = imprimante;
	}

	public void setOrdinateur(Ordinateur ordinateur) {
		this.ordinateur = ordinateur;
	}

	public void setCodeBarre(String codeBarre) {
		this.codeBarre = codeBarre;
	}

	public String getDureeGarantie() {
		return dureeGarantie;
	}

	public void setDureeGarantie(String dureeGarantie) {
		this.dureeGarantie = dureeGarantie;
	}

	public String getMarque() {
		return marque;
	}

	public void setMarque(String marque) {
		this.marque = marque;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getEtat() {
		return etat;
	}

	public void setEtat(Integer etat) {
		this.etat = etat;
	}

	public Enseignant getEnseignant() {
		return enseignant;
	}

	public void setEnseignant(Enseignant enseignant) {
		this.enseignant = enseignant;
	}

	public Affectation getAffectation() {
		// TODO Auto-generated method stub
		return affectation;
	}

	public Ressource(Integer etat) {
		super();
		this.etat = etat;
	}
    

	
	
   
}