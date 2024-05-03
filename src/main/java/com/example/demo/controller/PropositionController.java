package com.example.demo.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.*;
import com.example.demo.service.AppelOffreService;
import com.example.demo.service.FournisseurService;
import com.example.demo.service.ImprimanteService;
import com.example.demo.service.NotificationService;
import com.example.demo.service.OffreService;
import com.example.demo.service.OrdinateurService;
import com.example.demo.service.PropositionService;
import com.example.demo.service.RessourceService;
import com.example.demo.service.UserService;
import com.example.demo.serviceImplement.AppelOffreServiceImplement;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PropositionController {

	private final PropositionService  proposititonService;
	private final AppelOffreService  appelOffreService;
	private final RessourceService   ressourceService;
	private final FournisseurService  fourniseurService;
	private final OffreService   offreService;
	final NotificationService  notificationService ;
	int frn_Id=1 ;
	int appOffreId=1 ;
	private final UserService userService ;


	@Autowired
	public PropositionController(PropositionService  proposititonService, RessourceService ressourceService,
			 FournisseurService  fourniseurService,UserService userService, OffreService   offreService ,  NotificationService  notificationService ,AppelOffreService  appelOffreService ) {
		super();
		this.proposititonService = proposititonService;
		this.ressourceService = ressourceService;
		this.fourniseurService = fourniseurService;
		this.offreService = offreService;
		this.notificationService=notificationService ;
		this.appelOffreService= appelOffreService ;
		this.userService=userService ;
	}
	
	@PostMapping("/ajouterProposition")
    public String ajouterProposition(
    		Model model ,
            @RequestParam("RessourceId") int ressourceId,
            @RequestParam("marque") String marque,
            @RequestParam("prix") double prix,
            @RequestParam("AppelOffreId") int appeloffreId,
            @RequestParam("NombreGarantie") int dureeGarantie,
            @RequestParam("TypeGarantie") String typeGarantie) {

        // Créer une nouvelle proposition :
		
		//charger tous les propsiton :
		
		Ressource ressource = ressourceService.ChercherRessourceFrn(ressourceId) ;
        Proposition proposition = new Proposition();
        proposition.setMarque(marque) ;
        proposition.setPrix(prix) ;
       
        proposition.setRessource(ressource) ;
        
        // inserer la date :
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(System.currentTimeMillis())); // Date actuelle
        
        switch (typeGarantie) {
            case "Ans":
                calendar.add(Calendar.YEAR, dureeGarantie);
                break;
            case "Mois":
                calendar.add(Calendar.MONTH, dureeGarantie);
                break;
            case "Jours":
                calendar.add(Calendar.DAY_OF_MONTH, dureeGarantie);
                break;
           
        }

        Date dateFinGarantie = new Date(calendar.getTimeInMillis());
        proposition.setDureGarantie(dateFinGarantie);

        // Ajoutez des attributs au modèle pour maintenir l'état modifié
        
        
        // Insérer la proposition dans la base de données en utilisant le service approprié
        boolean ajoutReussi =   proposititonService.AjouterPropsition(proposition) ;
       
        if (ajoutReussi) {
        	
        	 List<Ressource> ListeRsAdd = new ArrayList<>();
     		List<Proposition> ListePropositionsAdd = proposititonService.recupererPropositionsAvecOffreNull();
     	    for (Proposition pr : ListePropositionsAdd) {
     	        Ressource rs = pr.getRessource() ;
     	        
     	        ListeRsAdd.add(rs);
     	    }
     	   model.addAttribute("listeRsAdd", ListeRsAdd);
     	   int count = ListeRsAdd.size()
;            return "redirect:/ConsulterRessources_Frn?id=" + appeloffreId + "&success=true";
        } else {
           
            return "redirect:/ConsulterRessources_Frn?id=" + appeloffreId + "&success=false";
        }
        // Redirection vers une autre page ou une vue
       
    }
	
	@PostMapping("/AjouterOffre")
	public String EnregitererOffre(
	        @RequestParam("total") double totalRqst ,
	        @RequestParam("DateLivraison") Date dateLivraison ,
	        @RequestParam("AppelOffreId") int appeloffreId,HttpServletRequest request)
	{ 	
    	HttpSession session = request.getSession();

	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = userService.findUser(userEmail);
       
        int userId=user.getId();
	
	    Offre offre = new Offre();
	    Fournisseur fournisseur = fourniseurService.ChercherFrn(user.getFournisseur().getId());
	    if (fournisseur.getListeNoire()==1) 
	        return "redirect:/ConsulterRessources_Frn?id=" + appeloffreId + "&successOffre=-1";
	    
	    List<Ressource> ListeRessources= ressourceService.listeRessourceFrn(appeloffreId) ;
	    List<Proposition> ListePropositions = proposititonService.recupererPropositionsAvecOffreNull();
	    
	   
        offre.setDateLivraison(dateLivraison);
	    offre.setTotal(totalRqst);
	    offre.setFournisseur(fournisseur);
	    if(ListeRessources.size() != ListePropositions.size())
	    {
	    	return "redirect:/ConsulterRessources_Frn?id=" + appeloffreId + "&successOffre=0";
	    }
	    boolean etatEnrg = offreService.AjouterOffre(offre);
	    if (etatEnrg) {
	        for (Proposition pr : ListePropositions) {
	            pr.setOffre(offre);
	            proposititonService.modifierProposition(pr);
	        }
	        return "redirect:/ConsulterRessources_Frn?id=" + appeloffreId + "&successOffre=1";
	    } else {
	        return "redirect:/ConsulterRessources_Frn?id=" + appeloffreId + "&successOffre=0";
	    }
	}
	
	@PostMapping("/ModifierOffre")
	public String ModifierOffre(
	        @RequestParam("total") double total ,
	        @RequestParam("DateLivraison") Date dateLivraison ,
	        @RequestParam("OffreId") Long OffreId) {
	   
	    Offre offre = offreService.getOffre(OffreId) ;
	   
	    
        offre.setDateLivraison(dateLivraison);
	    offre.setTotal(total);
	   
	    boolean etatEnrg = offreService.AjouterOffre(offre);
	    if (etatEnrg) {
	        return "redirect:/MesOffres?success=true";
	    } else {
	        return "redirect:/MesOffres?success=false";
	    }
	}
	@PostMapping("/SuprimerOffre")
	public String supprimerOffre(@RequestParam("idOffre") Long OffreId)
	{
		Offre offre =offreService.getOffre(OffreId) ;
		List<Proposition> listesProp =offre.getPropositions() ;
		for(Proposition prp : listesProp)
		{
			Proposition propositon = proposititonService.GetPropositionFrn(prp.getId()) ;
			proposititonService.SupprimerProp(prp);	
		}
		offreService.SupprimerOffre(offre);
		return "redirect:/MesOffres?successSup=true";
	}
	@GetMapping("/Propositions")
	public String GetOffreFr(Model model,HttpServletRequest request)
	{ 	
    	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = userService.findUser(userEmail);
        model.addAttribute("user", user);
        int userId=user.getId();
	    if ( userEmail != null ) {
	        

       
	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	    
	
		List<Offre> listeOffre1 = new ArrayList<Offre>() ;
		AppelOffre ao = appelOffreService.ChercherAOFr(appOffreId) ;
		List<Ressource> listeRs= ao.getRessources();
		Ressource rs = listeRs.get(1) ;
		
			List<Proposition> listePrp = rs.getPropositions() ;
			for(Proposition pr :listePrp)
			{
				
				 Offre offre =offreService.getOffre(pr.getOffre().getId());
				 listeOffre1.add(offre);
				 
			}
		
		int count=listeOffre1.size() ;
;		List<Offre> listeOffres = offreService.GetOffre() ; 
		model.addAttribute("listeOffre" ,listeOffre1) ;
		System.out.println(listeOffre1) ;
		return "OffreRespo" ;}
	    return "connexion";
	}
	
	
	
	
	
	@GetMapping("/ConsulterOffre")
	public String consulteroffre(@RequestParam("id") long offreId , Model  model,HttpServletRequest request)
	{ 	
    	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = userService.findUser(userEmail);
        model.addAttribute("user", user);
        int userId=user.getId();
	    if ( userEmail != null ) {
	        

       
	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	    


		List<Ressource> listeRessource = ressourceService.listeRessourceFrn(1) ;
		Offre offre =offreService.getOffre(offreId);
		List<Proposition> ListeProposition = offre.getPropositions() ;
		model.addAttribute("ListeProposition",ListeProposition) ;
		model.addAttribute("listeRessource" , listeRessource) ;
		return "ConsulterOffre" ;}
	    return "connexion";
	}
 

}
	
	
	

