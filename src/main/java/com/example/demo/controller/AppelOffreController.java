package com.example.demo.controller;



import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.*;
import com.example.demo.service.*;
import com.example.demo.service.FournisseurService;
import com.example.demo.service.NotificationService;
import com.example.demo.service.UserService;
import com.example.demo.serviceImplement.AppelOffreServiceImplement;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
public class AppelOffreController {

	private final AppelOffreServiceImplement  appelOffreService;
	private final RessourceService   ressourceService;
	private final OrdinateurService  ordinateurService;
	private final ImprimanteService   imprimanteService;
	private final PropositionService  proposititonService;
	private final NotificationService notificationService;
	
	private final UserService userService;
	
	@Autowired
	public AppelOffreController(AppelOffreServiceImplement appelOffreService, RessourceService ressourceService,
			OrdinateurService ordinateurService,NotificationService notificationService,UserService userService, ImprimanteService imprimanteService ,PropositionService  proposititonService) {
		super();
		this.appelOffreService = appelOffreService;
		this.ressourceService = ressourceService;
		this.ordinateurService = ordinateurService;
		this.imprimanteService = imprimanteService;
		this.proposititonService = proposititonService;
		this.notificationService=notificationService;
		this.userService=userService;
	}
	@GetMapping({"/","/pageAccueil"})
	String listAppelOffres(Model model) {
		List<AppelOffre> appelOffres=appelOffreService.getAllService();
		model.addAttribute("appelOffres",appelOffres);
		return "index";
	}
	
	
	@GetMapping("/connexion")
	String pageCon() {
	
		return "connexion";
	}
	
	

	@GetMapping("/inscription")
	String pageInsc() {
		return "inscription";
	}
	
	@GetMapping("/ConsulterPanne")
	String consulterPanne(Model model, HttpServletRequest request) {
	    HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    System.err.printf("jefhjhezfjhzejhfjzhgfz"+"userEmail");
	    if ( userEmail != null ) {
	        User user = userService.findUser(userEmail);
	        model.addAttribute("user", user);
	        int userId=user.getId();

	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);

	        return "consulterPanneTechnicienPage";
	    } else {
	        // Handle case where user is not logged in
	        return "redirect:/connexion"; // Redirect to the login page
	    }
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	@GetMapping("/ListeAO")
	String listAppelOffresFrn(Model model,HttpServletRequest request)
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
	    


		
		List<AppelOffre> listeAppelOffres = appelOffreService.getAppelOffresFr();
	    Date currentDate = new Date(); // Obtient la date actuelle

	    List<AppelOffre> appelsOffresNonTerminees = new ArrayList<>();

	    // Parcours de la liste des appels d'offres
	    for (AppelOffre appelOffre : listeAppelOffres) {
	        if (appelOffre.getDateFin().after(currentDate) && (appelOffre.getEtat()==0)) {
	            // Si la date de fin n'est pas encore passée, ajoute à la nouvelle liste
	            appelsOffresNonTerminees.add(appelOffre);
	        }
	    }
		model.addAttribute("listeAppelOffres", appelsOffresNonTerminees);
		
		return "HomeFrn";}
	    
	    return "connexion";
	}
	
	@GetMapping("/ConsulterRessources_Frn")
	String ListeRessourcesFrn(@RequestParam("id") int idAppelOffre, Model model,HttpServletRequest request)
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
	    


		
		List<Ordinateur> ListeOrdinateur= new ArrayList<Ordinateur>() ;
		List<Imprimante> ListeImprimante= new ArrayList<Imprimante>() ;
		List<Ressource> ListeRessources= ressourceService.listeRessourceFrn(idAppelOffre) ;
		for (Ressource rs : ListeRessources) {
	        // Vérifier si la ressource est un ordinateur
	        Ordinateur ordinateur = ordinateurService.GetListeOrdinateurFrn(rs.getId());
	        if (ordinateur != null) {
	            ListeOrdinateur.add(ordinateur);
	        } else {
	            // Si la ressource n'est pas un ordinateur, vérifier si c'est une imprimante
	            Imprimante imprimante = imprimanteService.GetListeImprimanteFrn(rs.getId());
	            if (imprimante != null) {
	                ListeImprimante.add(imprimante);
	            }
	        }
	    }
	    double total=0 ;
		List<Proposition> ListePropositions = proposititonService.recupererPropositionsAvecOffreNull();
	    
	    if (ListePropositions!=null) {
	    	
	        model.addAttribute("listePropositions", ListePropositions);
	        List<Integer> ListeRsAdd = new ArrayList<>();
	        for (Proposition pr : ListePropositions) {
     	        Ressource rs = pr.getRessource() ;
     	        
     	        ListeRsAdd.add(rs.getId());
     	    }
     	   model.addAttribute("listeRsAdd", ListeRsAdd);
	    }
	    model.addAttribute("ListeOrdinateur", ListeOrdinateur);
	    model.addAttribute("ListeImprimante", ListeImprimante);
	    model.addAttribute("ListeRessources", ListeRessources);
	    model.addAttribute("idAppelOffre", idAppelOffre);
	    model.addAttribute("total", total);
	   
	    
		
		return "RessourcesFrn" ;}
	    return "connexion";
		
	}

}
