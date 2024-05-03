package com.example.demo.controller;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.Fournisseur;
import com.example.demo.entity.Notification;
import com.example.demo.entity.User;

import com.example.demo.service.*;

import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UserController {

    private final UserService userService;
    private final NotificationService notificationService;
    private final FournisseurService fournisseurService;

    @Autowired
    public UserController(UserService userService,NotificationService notificationService,FournisseurService fournisseurService) {
        this.userService = userService;
		this.notificationService =notificationService;
		this.fournisseurService=fournisseurService;
    }

  
   



	@PostMapping("/login")
    public String loginUser(Model model,
            @RequestParam("email") String email,
            @RequestParam("password") String password, HttpSession session) {
 
boolean isValidUser = userService.validateUser(email, password);
        if (isValidUser) {
        	TraitementImage t =new TraitementImage();;
        	 User user=userService.findUser(email);
        	 int userId=user.getId();
        	 List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
        	    List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
        	    
        	    model.addAttribute("readNotifications", readNotifications);
        	    model.addAttribute("unreadNotifications", unreadNotifications);
        	   
        	   String image=t.convertBlobToBase64(user.getImage());
        	   model.addAttribute("nom", user.getNom_complet());
        	   model.addAttribute("image", image);
        	// Set user details in session
        	   session.setAttribute("userEmail", user.getEmail());
        	 //  session.setAttribute("userRole", userRole);

               model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
             int userRole = user.getRole();
             switch (userRole) {
                 case 1:
                     return "ChefChoix";
                 case 2:
                     return "redirect:/myressources_Ens";
                 case 3:
                     return "redirect:/ListeAO";
                 case 4:
                     return "redirect:/consulterPanneTechnicien";//Technicien
                 case 5:
                     return "redirect:/Fournisseurs";
                 case 6:
                	 return "redirect:/affecterPanne";// Service de Maintenance 
                 default:
                     return "Error404";
             } 
        		 
        } else {
     
            return "Error404"; 
        }
    }
    
    @PostMapping("/notifications/markAsRead")
    public void markNotificationAsRead(@RequestParam("notificationId") int notificationId) {
        notificationService.markNotificationAsRead(notificationId);
    }
    

    
    @PostMapping("/register")
    public String registerUser(@RequestParam("nom") String nom,
                               @RequestParam("prenom") String prenom,
                               @RequestParam("email") String email,
                               @RequestParam("telephone") String telephone,
                               @RequestParam("motdepasse") String motdepasse,
                               @RequestParam("confirmermotdepasse") String confirmermotdepasse,
                               @RequestParam("imageinput") MultipartFile imageFile,
                               Model model) throws IOException, SQLException {
       int ver= userService.verifyUser(email);
       if(ver==0) {
    	TraitementImage t =new TraitementImage();;
    	 System.err.printf("jefhjhezfjhzejhfjzhgfz"+prenom);
        // Create a new User object and set the attributes
        User user = new User();
        user.setNom_complet(nom + " " + prenom);
        user.setEmail(email);
        user.setTel(telephone);
        user.setMot_de_passe(motdepasse);
        user.setImage(t.multipartFileToBlob(imageFile));
        user.setRole(3);
       // user.setFournisseur(null);
        // Set other attributes as needed
        User savedUser = userService.saveUser(user);

        // Create a new Fournisseur object and set its properties
        Fournisseur fournisseur = new Fournisseur();
        fournisseur.setUser(savedUser); 

      
        fournisseurService.saveFournisseur(fournisseur);
       
    
        return "redirect:/registration-success";}
       if(ver==1) {
    	   String message="Cet utilisateur est déja inscrit";
    	   model.addAttribute("message", message);
       }
       return "inscription";
}
    
    
   
    
  @GetMapping("/registration-success")
  public String sucessPage() {
	  return "sucessRegist";
  }

    
    
    
    @GetMapping("/Déconnexion")
	String deCon(HttpSession session) {
    	 session.invalidate();

		return "connexion";
	}

}
