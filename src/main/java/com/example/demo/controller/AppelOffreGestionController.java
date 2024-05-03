package com.example.demo.controller;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.*;
import com.example.demo.service.*;
import com.example.demo.serviceImplement.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AppelOffreGestionController {
  
	private AppelOffreService AOservice ;
	private ImprimanteService imprimanteService;
	private RessourceService ressourceService;
	private OrdinateurService ordinateurService;
	private EnseignantService enseignantService;
	private DepartementService departementService;
	private final NotificationService notificationService;
	
	private final UserService userService;
	
	 @Autowired
	    public AppelOffreGestionController(AppelOffreService aoService, RessourceService ressourceService,
				OrdinateurService ordinateurService, ImprimanteService imprimanteService
				,EnseignantService enseignantService,DepartementService departementService,NotificationService notificationService,UserService userService) {
	        this.AOservice = aoService;
	        this.ressourceService = ressourceService;
			this.ordinateurService = ordinateurService;
			this.imprimanteService = imprimanteService;
			this.enseignantService=enseignantService;
			this.departementService=departementService;
			this.notificationService=notificationService;
			this.userService=userService;
	    }

	

	
	
	
	
	@GetMapping("/appelOffre")
	String listeAppelesOffresFctRespo(Model model,HttpServletRequest request)
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
	    
		List<AppelOffre> listeAO = AOservice.getListeAppelesOffres();
		model.addAttribute("listeAO", listeAO);
		return "appelOffre";}
	    return "connexion";
	}
	
	@GetMapping("/ModifierAppelOffreRespo")
	String modifierAppelOffreRespo(@RequestParam("id") int idAppelOffre, Model model,HttpServletRequest request)
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
	    
	    List<Ordinateur> listeOrdinateurs = new ArrayList<>();
	    List<Imprimante> listeImprimantes = new ArrayList<>();
	    List<Ressource> listeRessources = ressourceService.listeRessourceRespo(idAppelOffre);

	    if (listeRessources != null) {
	        for (Ressource ressource : listeRessources) {
	            Ordinateur ordinateur = ordinateurService.GetListeOrdinateurRespo(ressource.getId());
	            if (ordinateur != null) {
	                listeOrdinateurs.add(ordinateur);
	            } 
	                Imprimante imprimante = imprimanteService.GetListeImprimanteRespo(ressource.getId());
	                if (imprimante != null) {
	                    listeImprimantes.add(imprimante);
	                }
	            
	        }
	    }

	    model.addAttribute("listeOrdinateurs", listeOrdinateurs);
	    model.addAttribute("listeImprimantes", listeImprimantes);
	    model.addAttribute("listeRessources", listeRessources);

	    return "ressourceRespo";}return "connexion";
	}

	@GetMapping("/add-appel-offre")
	String addAppelOffre(Model model,HttpServletRequest request)
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
	    
	    List<Ressource> listeRessources = ressourceService.listeRessourceEtatRespo(2);
	    List<Ordinateur> listeOrdinateurs = new ArrayList<>();
	    List<Imprimante> listeImprimantes = new ArrayList<>();
	    List<Departement> listeDepartements = new ArrayList<>();
	    System.out.println("Le controller : add appel offre" );
	    if (listeRessources != null) {
	        for (Ressource ressource : listeRessources) {
	            Ordinateur ordinateur = ordinateurService.GetListeOrdinateurRespo(ressource.getId());
	            if (ordinateur != null) {
	                listeOrdinateurs.add(ordinateur);
	            }

	            Imprimante imprimante = imprimanteService.GetListeImprimanteRespo(ressource.getId());
	            if (imprimante != null) {
	                listeImprimantes.add(imprimante);
	            }

	            Enseignant enseignant = enseignantService.getEnseignantRespo(ressource.getId());
	            if (enseignant != null) {
	                listeDepartements.add(departementService.getDepartementRespo(enseignant.getId()));
	            }
	        }
	    }

	    model.addAttribute("listeRessources", listeRessources);
	    model.addAttribute("listeOrdinateurs", listeOrdinateurs);
	    model.addAttribute("listeImprimantes", listeImprimantes);
	    model.addAttribute("listeDepartements", listeDepartements);

	    return "addAppelOffre";}return "connexion";
	}

	@PostMapping("/insert-appel-offre")
    public String insertAppelOffre(@RequestParam("startDate") String startDatee,
            @RequestParam("endDate") String endDatee,@RequestParam("description") String description
            ,Model model) {
	    System.out.println("Le controller : " + startDatee + " " + endDatee);
        String startDateStr = startDatee;
        String endDateStr =endDatee;
        List<Ressource> listeRessources = ressourceService.listeRessourceEtatRespo(2);
        
        List<Integer> resourceIds = listeRessources.stream()
                .map(Ressource::getId)
                .collect(Collectors.toList());
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate;
        Date endDate;
        try {
            startDate = new Date(dateFormat.parse(startDateStr).getTime());
            endDate = new Date(dateFormat.parse(endDateStr).getTime());
        } catch (ParseException e) {
            // Handle the exception appropriately
        	return "redirect:/add-appel-offre?success=false";
        }
        AOservice.insertAppelOffre(startDate, endDate,description);
        int idAO=AOservice.getLastInsertId();
        for (Integer resourceId : resourceIds) {
        		ressourceService.updateAppelOffreId(resourceId, idAO);
        		ressourceService.updateEtatRessourceTo3Byid(resourceId);
        }
        return "redirect:/add-appel-offre?success=true";
       
    }

	 @PostMapping("/update-appel-offre")
	 public String updateAppelOffre(@RequestParam("startDate") String startDatee,
	                                 @RequestParam("endDate") String endDatee,
	                                 @RequestParam("idAppelOffre") String idAppelOffre,
	                                 Model model) {
	     int id = Integer.parseInt(idAppelOffre);
	     Date startDate = Date.valueOf(startDatee);
	     Date endDate = Date.valueOf(endDatee);

	     AppelOffre appelOffre = AOservice.getAppelOffreById(id);
	     appelOffre.setDateDebut(startDate);
	     appelOffre.setDateFin(endDate);

	     AppelOffre updatedAppelOffre = AOservice.updateAppelOffre(appelOffre);

	     if (updatedAppelOffre != null) {
	         return "redirect:/appelOffre?success=true";
	     } else {
	         return "redirect:/appelOffre?success=false";
	     }
	 }

}
