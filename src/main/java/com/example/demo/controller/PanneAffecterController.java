package com.example.demo.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.*;
import com.example.demo.service.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
@Controller
public class PanneAffecterController {

	
	@Autowired
    private RessourceService ressourceService;
	  private final UserService userService;
	    private final NotificationService notificationService;
	    private final TechnicienService technicienService;
	    private final PanneService panneService;
	    private final ConstatService constatService;
	    
	    
	    
	    

    public PanneAffecterController(RessourceService ressourceService, UserService userService,
				NotificationService notificationService,TechnicienService technicienService,PanneService panneService,ConstatService constatService) {
			super();
			this.ressourceService = ressourceService;
			this.userService = userService;
			this.notificationService = notificationService;
			this.technicienService=technicienService;
			this.panneService=panneService;
			this.constatService=constatService;
		}









	@GetMapping("/affecterPanne")
    public String listeCaracteristiques(Model model, HttpServletRequest request) {
    	
    	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    System.err.printf("jefhjhezfjhzejhfjzhgfz"+"userEmail");
	    if ( userEmail != null ) {
	        User user = userService.findUser(userEmail);
	        model.addAttribute("user", user);
	        int userId=user.getId();
            List<Technicien> techniciens=technicienService.getTech();
            model.addAttribute("tech",techniciens);
	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	    }
	    List<Panne> pannes=panneService.getALLPanne();
        List<Ressource> imprimantes = ressourceService.findCaracteristiquesImprimanteByEtat(6);
        List<Ressource> ordinateurs = ressourceService.findCaracteristiquesOrdinateurByEtat(6);

        model.addAttribute("imprimantes", imprimantes);
        model.addAttribute("ordinateurs", ordinateurs);
        model.addAttribute("pannes", pannes);
        
    

        return "serviceMaintenanceIndex";
    }
	
	@PostMapping("/savePanne")
    public void savePanne(@RequestParam Integer ressourceId,
    		              @RequestParam Long technicienId, 
                          
                          @RequestParam Integer panneId) {
	System.err.print("----------------------------------------    "+ panneId)  ;

Ressource ressource=ressourceService.findRessource(ressourceId);
Panne panne=panneService.getPanne(panneId);
Technicien tech=technicienService.findTech(technicienId);
ressource.setEtat(7);
panne.setRessource(ressource);
panne.setTechnicien(tech);
panneService.enregPanne(panne);
       
     
    }
	
	@GetMapping("/consulterPanneTechnicien")
	public String ConsulterPanneTech(Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	
	  
	    if ( userEmail != null ) {
	        User user = userService.findUser(userEmail);
	        model.addAttribute("user", user);
	       int userId=user.getId();
            List<Technicien> techniciens=technicienService.getTech();
            model.addAttribute("tech",techniciens);
	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	        Technicien tech=technicienService.getTechnicienByUserId(userId);
	        
	        
	        
	        List<Panne> pannes=panneService.getPannesByTechnicienWithNullConstat7(tech);
	        model.addAttribute("pannes", pannes);
	        return "consulterPanneTechnicienPage";
	    }
	 
	    else   
		return "redirect:/connexion";
	}

	
	@GetMapping("/consulterConstat")
	public String ConsulterConstats(Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	
	  
	    if ( userEmail != null ) {
	        User user = userService.findUser(userEmail);
	        model.addAttribute("user", user);
	       int userId=user.getId();
            List<Technicien> techniciens=technicienService.getTech();
            model.addAttribute("tech",techniciens);
	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	        Technicien tech=technicienService.getTechnicienByUserId(userId);
	       
	        
	        List<Constat> constats=constatService.getAllConstats();
	        model.addAttribute("constats", constats);
	        return "consulterConstat";
	    }
	 
	    else   
		return "redirect:/connexion";
	}
	
	

	
	

	
	@PostMapping("/modifier-constat")
    public String modifierConstat(@RequestParam("panneIdModal") Integer constatId,@RequestParam("explicationPanne") String explicationPanne,
            @RequestParam("frequencePanne") String frequencePanne,
            @RequestParam("ordreLogiciel") String ordre
                                    ) {
     // traitement d'enregistrement du constat 
        
        Constat constat =constatService.getconstat(constatId);
        constat.setExplication_Panne(explicationPanne);
        constat.setFrequence_Panne(frequencePanne);
        constat.setOrdre(ordre);
       
        constatService.saveConstat(constat);
        
    
   

  
        return "redirect:/consulterConstat?success=true";
    }
	
	
	 @PostMapping("/modifier-panne")
	    public String modifierPanne(@RequestParam("panneIdModal") Integer panneId,@RequestParam("etatPanne") String etatPanne,
	    		@RequestParam("dateIntervention") String dateIntervention,@RequestParam("explicationPanne") String explicationPanne,
	            @RequestParam("frequencePanne") String frequencePanne,
	            @RequestParam("ordreLogiciel") String ordre
	                                   ) {
		 
		 Panne panne = panneService.getPanne(panneId);
		 String pattern = "yyyy-MM-dd";
		 String typePanne="sévère";
		
		 SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
		
	        try {
	            // Conversion de la chaîne en objet Date
	            Date date = dateFormat.parse(dateIntervention);
	         
	   		 panne.setDateIntervention(date);
	   		
	            
	        } catch (ParseException e) {
	            // En cas d'erreur de conversion
	            System.out.println("Erreur de conversion : " + e.getMessage());
	            e.printStackTrace();}
	        panne.setEtat(etatPanne);
	        if(!(etatPanne.equals(typePanne))) {
	        panne.getRessource().setEtat(4);
	        panneService.enregPanne(panne);
	       
	        return "redirect:/consulterPanneTechnicien?success=true";
	   		 
		    } else {
		    	 panne.getRessource().setEtat(8);
		    	 panneService.enregPanne(panne);
		    	 
		    	Constat constat = new Constat();
	         constat.setExplication_Panne(explicationPanne);
	         constat.setFrequence_Panne(frequencePanne);
	         constat.setOrdre(ordre);
	         constat.setPanne(panne);
	         constatService.saveConstat(constat);
	         
	         
	      // traitement d'envoi de notification au responsable    
	       List<User> user=userService.findUserByRole(5);
	       Notification not=new Notification();
	       LocalDateTime currentDateTime = LocalDateTime.now();
	       Date currentDate = Date.from(currentDateTime.atZone(ZoneId.systemDefault()).toInstant());
	       not.setDate_envoi(currentDate);
	       not.setMessage("Constat Du Panne n°"+constat.getId()+" à été rédiger consulter la pour plus d'informations");
	       not.setUser(user.get(0));
	       notificationService.saveNot(not);
	    

	   
	         return "redirect:/consulterConstat?success=true";}
		   
	   			
			
		 
             
		 
		 }
}
