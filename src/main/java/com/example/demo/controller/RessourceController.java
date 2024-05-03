package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.*;
import com.example.demo.service.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class RessourceController {

	private RessourceService ressourceService;
	private AppelOffreService AOservice ;
	private OrdinateurService ordinateurService;
	private ImprimanteService imprimanteService;
	private FournisseurService fournisseurService;
	private PropositionService propositionService;
	private OffreService offreService;
	private EnseignantService enseignantService;
	private DepartementService departementService;
	private AffectationService affectationService;
	private UserService userService;
	private PanneService panneService;
	private ConstatService constatService;
	private final NotificationService notificationService;

	
	public RessourceController(AppelOffreService aoService,RessourceService ressourceService,
			OrdinateurService ordinateurService,ImprimanteService imprimanteService,
			FournisseurService fournisseurService,PropositionService propositionService,
			OffreService offreService,EnseignantService enseignantService,
			DepartementService departementService,AffectationService affectationService,
			UserService userService,PanneService panneService,
			ConstatService constatService,NotificationService notificationService) {
		
		this.ressourceService = ressourceService;
		this.AOservice=aoService;
		this.imprimanteService=imprimanteService;
		this.ordinateurService=ordinateurService;
		this.fournisseurService=fournisseurService;
		this.propositionService=propositionService;
		this.offreService=offreService;
		this.enseignantService=enseignantService;
		this.departementService=departementService;
		this.affectationService=affectationService;
		this.userService=userService;
		this.panneService=panneService;
		this.constatService=constatService;
		this.notificationService=notificationService;
		
	}
	
	
	//fonction Responsable
		@GetMapping("/appelOffreCode")
		String listeAppelesOffresFctForCode(Model model,HttpServletRequest request)
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
			return "appelOffreForCode";}
		    return "connexion";
		}
		
		
		@GetMapping("/verifierFournisseur")
		public String verifierFournisseur(@RequestParam("id") int idAppelOffre, Model model,HttpServletRequest request)
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
		    
		    // Récupérer les ressources de l'appel d'offre sélectionné
		    List<Ressource> ressources = ressourceService.listeRessourceRespo(idAppelOffre);

		    // Vérifier pour une seule ressource
		    if (!ressources.isEmpty()) {
		        Ressource ressource = ressources.get(0);

		        // Récupérer la proposition pour cette ressource
		        List<Proposition> propositions = propositionService.getPropositionByIdRessource(ressource.getId());
		        	

		        if (propositions != null) {
		        	   for(Proposition proposition:propositions) {
		        		   
		        	   
		            // Récupérer l'offre pour cette proposition
		            Offre offre = offreService.getOffreByIdAndEtat(proposition.getOffre().getId(),1);

		            if (offre != null) {
		                // Récupérer le fournisseur de cette offre
		                Fournisseur fournisseur = offre.getFournisseur();

		                if (fournisseur != null &&
		                    fournisseur.getAdresse() != null && !fournisseur.getAdresse().isEmpty() &&
		                    fournisseur.getNomCompletGerant() != null && !fournisseur.getNomCompletGerant().isEmpty() &&
		                    fournisseur.getSiteInternet() != null && !fournisseur.getSiteInternet().isEmpty() &&
		                    fournisseur.getNomSociete() != null && !fournisseur.getNomSociete().isEmpty()) {
		                    // Le fournisseur existe et remplit les critères, retourner "consulterAppelOffre"
		                	return "redirect:/consulterAppelOffre?id=" + idAppelOffre;

		                }else {
		                    // Le fournisseur ne remplit pas les critères, passer l'ID de l'appel d'offre à la page addFournisseur
		                    model.addAttribute("idFournisseur", fournisseur.getId());
		                    model.addAttribute("idAppelOffre", idAppelOffre);
		                    return "addFournisseur";
		                }
		            }
		        }
		        
		        
		        }
		    }

		    // Aucun fournisseur ne remplit les critères, retourner "addFournisseur"
		
		    return "redirect:/appelOffreCode?success=false";}return "connexion";
		}

		
		@PostMapping("/enregistrerFournisseur")
		public String enregistrerFournisseur(@RequestParam("adresse") String adresse,
		                                     @RequestParam("nomSociete") String nomSociete,
		                                     @RequestParam("nomCompletGerant") String nomCompletGerant,
		                                     @RequestParam("siteInternet") String siteInternet,
		                                     @RequestParam(value = "idFournisseur", required = false) Integer idFournisseur,
		                                     @RequestParam(value = "idAppelOffre", required = false) Integer idAppelOffre) {
		    Fournisseur fournisseur = new Fournisseur();
		    fournisseur.setAdresse(adresse);
		    fournisseur.setNomSociete(nomSociete);
		    fournisseur.setNomCompletGerant(nomCompletGerant);
		    fournisseur.setSiteInternet(siteInternet);
		    if (idFournisseur != null) {
		        fournisseur.setId(idFournisseur);
		    }

		    // Enregistrer le fournisseur en base de données 
		    fournisseurService.enregistrerFournisseur(fournisseur);

		    // Rediriger vers la page appropriée en fonction de idAppelOffre
		    if (idAppelOffre != null) {
		        return "redirect:/consulterAppelOffre?id=" + idAppelOffre;
		    } else {
		        return "redirect:/autrePage"; // Modifier l'URL de redirection selon votre application
		    }
		}

		
		
		

		@GetMapping("/consulterAppelOffre")
		String listeRessouces(@RequestParam("id") int idAppelOffre, Model model) {
			
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
			return "codeInventaire";
			
		}
	
		
		@PostMapping("/add-inventaire")
		String addInventaire(HttpServletRequest request) {
		    // Récupérer les paramètres du formulaire
		    Enumeration<String> parameterNames = request.getParameterNames();
		    while (parameterNames.hasMoreElements()) {
		        String paramName = parameterNames.nextElement();
		        if (paramName.startsWith("codeInventaire_")) {
		            int idRessource = Integer.parseInt(paramName.substring("codeInventaire_".length()));
		            String codeInventaire = request.getParameter(paramName);
		            // Appeler la méthode updateCodeInventaire du RessourceService
		            ressourceService.updateCodeInventaire(idRessource, codeInventaire);
		        }
		    }
		    
		    // Afficher la SweetAlert et rediriger après le délai
		    return "redirect:/appelOffreCode?success=true"; // Rediriger vers la page d'origine
		}

	
		@GetMapping("/ressourcesLivres")
		public String ressourcesLivres(@RequestParam("id") int idAppelOffre, Model model,HttpServletRequest request)
		{ 	
	    	HttpSession session = request.getSession();

		    TraitementImage t =new TraitementImage();
		    String userEmail = (String) session.getAttribute("userEmail");
		   // Integer userRole = (Integer) session.getAttribute("userRole");
		    User user1 = userService.findUser(userEmail);
	        model.addAttribute("user", user1);
	        int userId=user1.getId();
		    if ( userEmail != null ) {
		        

	       
		        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
		        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
		        model.addAttribute("readNotifications", readNotifications);
		        model.addAttribute("unreadNotifications", unreadNotifications);
		        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
		        String image = t.convertBlobToBase64(user1.getImage());
		        model.addAttribute("nom", user1.getNom_complet());
		        model.addAttribute("image", image);
		    
		    List<Ressource> ressourcesLivres = ressourceService.getRessourcesLivres(idAppelOffre);
		  

		    for (Ressource ressource : ressourcesLivres) {
		        Affectation affectation = affectationService.getAffectationByressourceId(ressource.getId());
		    
		        Enseignant enseignant = null;
		        Departement departement = null;

		        if (affectation != null) {
		            if (affectation.getDepartement() == null || affectation.getDepartement().getId() == 0) {
		                enseignant = enseignantService.getEnseignantRespo(affectation.getEnseignant().getId());
		            
		                
		                User user = userService.getUserById(enseignant.getUser().getId());
		                enseignant.setUser(user);
		            } else {
		                departement = departementService.getDepartementRespo(affectation.getDepartement().getId());
		            }
		        }

		        // Ajouter les enseignants et départements à l'affectation
		        affectation.setEnseignant(enseignant);
		        affectation.setDepartement(departement);

		        // Récupérer les ordinateurs et imprimantes correspondant à la ressource
		        Ordinateur ordinateur = ordinateurService.GetListeOrdinateurRespo(ressource.getId());
		        Imprimante imprimante = imprimanteService.GetListeImprimanteRespo(ressource.getId());
		        ressource.setOrdinateur(ordinateur);
		        ressource.setImprimante(imprimante);
		        ressource.setAffectation(affectation);
		    }

		  
		    model.addAttribute("ressourcesLivres", ressourcesLivres);
		    model.addAttribute("idAppelOffre", idAppelOffre);

		    return "/gestionAffectation";}
		    return "connexion";
		}

		@PostMapping("/confirmAffectation")
		public String confirmAffectationRespo(HttpServletRequest request) {
		    String[] ressourceIdsStr = request.getParameterValues("ressourcesid");
		    String appelOffreIdstr = request.getParameter("id_appel_offre");
		    int appelOffreId = Integer.parseInt(appelOffreIdstr);
		    
		    List<Integer> ressourceIds = new ArrayList<>();
		    if (ressourceIdsStr != null) {
		        for (String ids : ressourceIdsStr) {
		            String[] idsArray = ids.replace("[", "").replace("]", "").split(", ");
		            for (String id : idsArray) {
		                try {
		                    int resourceId = Integer.parseInt(id.trim());
		                    ressourceIds.add(resourceId);
		                    ressourceService.updateEtatRessourceTo4Byid(resourceId);
		                    //System.out.println("Ressource ID: " + resourceId);
		                } catch (NumberFormatException e) {
		                    //System.err.println("Invalid resource ID: " + id);
		                }
		            }
		        }
		    } else {
		        //System.err.println("No resources selected");
		    }
		    
		    return "redirect:/ressourcesLivres?id=" + appelOffreId +"&success=true";
		}

   @GetMapping("/updateRessources")
   String update_ressources(Model model,HttpServletRequest request)
	{ 	
   	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user1 = userService.findUser(userEmail);
       model.addAttribute("user", user1);
       int userId=user1.getId();
	    if ( userEmail != null ) {
	        

      
	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user1.getImage());
	        model.addAttribute("nom", user1.getNom_complet());
	        model.addAttribute("image", image);
	    
	   List<Ressource> ressources=ressourceService.getAllRessources();
	   List<Ordinateur> ordinateurs=new ArrayList<>();
	   List<Imprimante> imprimantes=new ArrayList<>();
	   List<User> enseignants=userService.getAllEnseignants(2);
	   List<Departement> departements=departementService.getAll();
	   
	   for (Ressource ressource : ressources) {
		   Ordinateur ordinateur=ordinateurService.GetListeOrdinateurRespo(ressource.getId());
		   Imprimante imprimante=imprimanteService.GetListeImprimanteRespo(ressource.getId());
		   ordinateurs.add(ordinateur);
		   imprimantes.add(imprimante);
		   Affectation affectation = affectationService.getAffectationByressourceId(ressource.getId());
		    
	        Enseignant enseignant = null;
	        Departement departement = null;

	        if (affectation != null) {
	            if ((affectation.getDepartement() == null )&&
	            (affectation.getEnseignant() != null )) {
	                enseignant = enseignantService.getEnseignantRespo(affectation.getEnseignant().getId());
	            
	                
	                User user = userService.getUserById(enseignant.getUser().getId());
	                enseignant.setUser(user);
	            } else if ((affectation.getDepartement() != null )&&
	    	            (affectation.getEnseignant() == null )){
	                departement = departementService.getDepartementRespo(affectation.getDepartement().getId());
	            }else {
	            	enseignant=null;
	            	departement=null;
	            }
	        }

	        // Ajouter les enseignants et départements à l'affectation
	        affectation.setEnseignant(enseignant);
	        affectation.setDepartement(departement);

	        // Récupérer les ordinateurs et imprimantes correspondant à la ressource
	        ressource.setOrdinateur(ordinateur);
	        ressource.setImprimante(imprimante);
	        ressource.setAffectation(affectation);
		   
		   
	   }
	   model.addAttribute("departements", departements);
	   model.addAttribute("enseignants", enseignants);
	   model.addAttribute("ordinateur", ordinateurs);
	   model.addAttribute("imprimantes", imprimantes);
	   model.addAttribute("ressources", ressources);
	   return "/updateRessources";}
	    return "connexion";
   }
   
   @PostMapping("/modifierRessource")
   public String modifierRessource(@ModelAttribute("ressource") Ressource ressource,
                                   @RequestParam("id") int id,
                                   @RequestParam("type") String type,
                                   @RequestParam(value = "cpu", required = false) String cpu,
                                   @RequestParam(value = "disqueDur", required = false) String disqueDur,
                                   @RequestParam(value = "ecran", required = false) String ecran,
                                   @RequestParam(value = "ram", required = false) String ram,
                                   @RequestParam(value = "resolution", required = false) String resolution,
                                   @RequestParam(value = "vitesseImpression", required = false) String vitesseImpression) {

       if ("Ordinateur".equals(type)) {
           Ordinateur ordinateur = ordinateurService.GetListeOrdinateurRespo(id);
           if (ordinateur != null) {
               ordinateur.setCPU(cpu);
               ordinateur.setDisqueDur(disqueDur);
               ordinateur.setEcran(ecran);
               ordinateur.setRAM(ram);
               ordinateurService.updateOrdinateur(ordinateur);
           }
       } else if ("Imprimante".equals(type)) {
           Imprimante imprimante = imprimanteService.GetListeImprimanteRespo(id);
           if (imprimante != null) {
               imprimante.setResolution(resolution);
               imprimante.setVitesseImpression(vitesseImpression);
               imprimanteService.updateImprimante(imprimante);
           }
       }
       return "redirect:/updateRessources?success=true"; 
   }


   @RequestMapping(value = "/supprimerRessource", method = RequestMethod.GET)
   public String supprimerRessource(@RequestParam("id") int id) {
       // Supprimer la ressource avec l'ID spécifié
       Ordinateur ordinateur = ordinateurService.GetListeOrdinateurRespo(id);
       Imprimante imprimante = imprimanteService.GetListeImprimanteRespo(id);
       List<Panne> pannes = panneService.getPanneByRessource(id);

       for (Panne panne : pannes) {
           constatService.deleteConstatByPanneId(panne.getId());
           panneService.deletePanne(panne.getId());
       }

       propositionService.deleteProposition(id);
       ressourceService.deleteRessource(id);
       if (imprimante != null)
         imprimanteService.deleteImprimante(imprimante.getId());
       if( ordinateur != null)
         ordinateurService.deleteOrdinateur(ordinateur.getId());
       affectationService.deleteAffectation(id);

       return "redirect:/updateRessources?success=true";
   }

   @PostMapping("/modifierAffectation")
   public String modifierAffectation(@RequestParam("ressourceId") int ressourceId, @RequestParam("affectationId") String affectationId) {
      
	   if (affectationId.equals("0"))
		      affectationService.updateAffectationNULL(ressourceId);
	   else{
	   String[] parts = affectationId.split(",");
	   System.out.println("id "+ parts[0]);
	   String type=parts[0];
	   Integer id=Integer.parseInt(parts[1]);
	   if (type.equals("ens"))
		   affectationService.updateAffectationEns(ressourceId,id);
	   else if (type.equals("ens"))
		   affectationService.updateAffectationDep(ressourceId,id);
	   }
       return "redirect:/updateRessources?success=true";
   }

}
