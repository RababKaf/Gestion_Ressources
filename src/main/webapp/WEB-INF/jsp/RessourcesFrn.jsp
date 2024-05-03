<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="java.util.*" %>
   <%@ page import="com.example.demo.entity.*" %>
    <%@ page import="com.example.demo.entity.*" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Espace fournisseur</title>
  <%@  include file="links.jsp"%>

<style>
.bColor
{
color:rgb(48, 96, 184)  ;
}
.link-unstyled {
    text-decoration: none;
    color: white;
}

.link-unstyled:hover {
    color: inherit;
}

</style>

</head>



<body>


<script>
    // Récupérer le paramètre de l'URL
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');
    const successOffre = parseInt(urlParams.get('successOffre')); // Convertir en entier pour la comparaison

    // Vérifier si l'ajout de proposition a réussi
    if (successParam === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "La proposition a été ajoutée avec succès!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de l'ajout de la proposition.", "error");
    }

    // Vérifier si l'envoi d'offre a réussi
    if (successOffre === 1) {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "L'offre a été envoyée avec succès!", "success");
    } else if (successOffre === 0) {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Vous devez répondre sur tous les matériels de la demande.", "error");
    } else if (successOffre === -1) {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Désolé, vous avez été placé sur la liste noire, donc vous ne pouvez pas envoyer cette offre.", "error");
    }
</script>

<header>
        <img src="data:image/png;base64, <%=request.getAttribute("image") %>" alt="Picture" id="profile-pic">
        
        <h4>${nom}</h4>
<div class="notification-container">
    <i class="fas fa-bell" style="font-size: 24px;" onclick="toggleNotifications()"></i>
    <span class="notification-badge" id="notificationCount">${unreadCount}</span>
    <div class="notification-messages" id="notificationMessages">
         <%     List<Notification> unreadNotifications = (List<Notification>) request.getAttribute("unreadNotifications");
        if (unreadNotifications != null && !unreadNotifications.isEmpty()) 
        for (Notification notification : unreadNotifications) { %> 
        <div class="notification-card" id="<%= notification.getId() %>" onclick="markAsRead('<%= notification.getId() %>')">
            <p class="short-message"><%= notification.getMessage().substring(0, Math.min(notification.getMessage().length(), 20)) + "..." %></p>
            <p class="full-message" style="display: none;"><%= notification.getMessage() %></p>
        </div>
        <% } %>
        
    <%
        List<Notification> readNotifications = (List<Notification>) request.getAttribute("readNotifications");
        if (readNotifications != null && !readNotifications.isEmpty()) 
        	for (Notification notification : readNotifications) { %>
        <div class="notification-card" style="background-color: #fff;" id="<%= notification.getId() %>" onclick="markAsRead('<%= notification.getId() %>')">
            <p><%= notification.getMessage() %></p>
        </div>
        <% } %>
    </div>
</div>

    <a href="/Déconnexion" class="logout-link">
        <i class="fas fa-sign-out-alt" style="font-size: 24px;"></i>
        <span>Déconnexion</span>
    </a>

    </header>
    

    <nav>
         <ul>
            <li class="menu-item">
                 <a href="/ListeAO"><i class="fas fa-qrcode"></i>Appels d'offre</a></li>
       <li class="menu-item"><a href="/MesOffres"><i class="fas fa-stream"></i>Mes Offes</a></li>
         
        </ul>
        </nav>
<section>

                    <div class="p-3">
                        <h2>Espace fournisseur</h2>
                        
                        <!-- Affichage de la liste des appels d'offres -->
                        
                            <% 
                            double total =0 ;
                            
                            	 if(request.getAttribute("listePropositions")!=null ) ;
                            {
                            	
                            	List<Proposition> listeProposition= (List<Proposition>)request.getAttribute("listePropositions");
                            	for(Proposition pr : listeProposition)
                            	{
                            		total +=pr.getPrix() ;
                            	}
                            }
                            
                               int appelOffreId=(int) request.getAttribute("idAppelOffre");
                               List<Ressource> listeRessources = (List<Ressource>)request.getAttribute("ListeRessources");
                               List<Ordinateur> listeOrdinateur = (List<Ordinateur>)request.getAttribute("ListeOrdinateur");
                               List<Imprimante> listeImprimante = (List<Imprimante>)request.getAttribute("ListeImprimante");
                               
                               
                            
                            %>
                           
                           
                             <div class="card recent-sales overflow-auto  ">
                            
                            
					<div class="d-grid gap-2 mb-3 d-md-flex justify-content-md-end">
						    <button class="btn btn-primary  me-md-2" style="background: rgb(52, 103, 127) ; type="button">
						        <a class="link-unstyled " href="#" data-bs-toggle="modal" data-bs-target="#EnvoyerOffreModal">Envoyer l'offre</a>
						    </button>
						</div>
                             
                              <h5 class="card-title ">Liste matériel <span>|Ordinateur </span></h5>
                            
                             
                             <%  if (!listeOrdinateur.isEmpty()) {  %>
				              <table class="table" >
				              <thead>
				                <tr>
				                  <th scope="col">#</th>
				                  <th scope="col" >CPU</th>
				                  <th scope="col">RAM </th>
				                  <th scope="col">disque Dur</th>
				                  <th scope="col">Ecran</th>
				                   <th scope="col" style="width: 130px;">Action</th>
				                
				                 
				                </tr>
				              </thead> 
				              <tbody>
				              
				              <% for (Ordinateur or : listeOrdinateur) { %>
				                                 <tr>
				                                      <td><%= or.getId() %></td>
				                                      <td><%= or.getCPU() %></td>
				                                      <td><%= or.getRAM() %>  </td>
				                                      <td><%= or.getDisqueDur() %> </td>
				                                      <td><%= or.getEcran() %></td>
				                                         <td>                  
				                                      <%if(request.getAttribute("listeRsAdd")!=null )
				                                      {
				                                   	   List<Integer> listeRsAdd = (List<Integer>)request.getAttribute("listeRsAdd") ;
				                                    	  if(listeRsAdd.contains(or.getRessource().getId())){
				                                       %>
				                                       
				                                       <a  href="#" data-bs-toggle="modal" data-bs-target="#AjouterPropositionModal1<%=or.getRessource().getId() %>" >
				                                      <span  id="proposerBadge<%=or.getRessource().getId() %>" style=" background-color: gray;" class="badge">Proposer</span></a>
				                                      <%} else { %>
				                                      <a  href="#" data-bs-toggle="modal" data-bs-target="#AjouterPropositionModal<%=or.getRessource().getId()%>" >
				                                      <span  id="proposerBadge<%=or.getRessource().getId() %>"  class="badge">Proposer</span></a>
				                                      
				                                    <% }} else {%>
				                                    
				                                     <a  href="#" data-bs-toggle="modal" data-bs-target="#AjouterPropositionModal<%=or.getRessource().getId()%>" >
				                                      <span  id="proposerBadge<%=or.getRessource().getId() %>"  class="badge">Proposer</span>
				                                      
				                                      </a>
				                                      </td> 
				                                    
				                               </tr>
				                            <% }} %>
                                        
				               
				              </tbody>
				            </table>
				            <% } else { %>
				                <div class="col text-center">
                                          <b class="bColor">Pas de matériel de type ordinateur</b>
                                </div>
				                <%} %>
				            <br><br>
				            
				              <!-- la table imprimante -->
				             <h5 class="card-title">Liste matériel | Imprimante </h5>
						    <%  if (!listeImprimante.isEmpty()) {  %>
						        <table class="table">
						            <thead>
						                <tr>
						                    <th scope="col">#</th>
						                    <th scope="col">Résolution </th>
						                    <th scope="col">Vitesse d'impression</th>
						                     <th scope="col" style="width: 130px;">Action</th>
						                </tr>
						            </thead> 
						            <tbody>
						                <% for (Imprimante imp : listeImprimante) { %>
						                    <tr>
						                        <td><%= imp.getId() %></td>
						                        <td><%= imp.getResolution() %> </td>
						                        <td><%= imp.getVitesseImpression() %> </td>
						                        <td>
						                         <%if(request.getAttribute("listeRsAdd")!=null )
				                                      {
				                                   	   List<Integer> listeRsAdd = (List<Integer>)request.getAttribute("listeRsAdd") ;
				                                    	  if(listeRsAdd.contains(imp.getRessource().getId())){
				                                       %>
						                        <a   href="#"  data-bs-toggle="modal" data-bs-target="#AjouterPropositionModal1<%=imp.getRessource().getId() %>" >
						                        <span id="proposerBadge<%=imp.getRessource().getId() %>" style=" background-color: gray;" class="badge">Proposer</span></a>
						                         <%} else { %>
						                         
						                         <a   href="#" data-bs-toggle="modal" data-bs-target="#AjouterPropositionModal<%=imp.getRessource().getId() %>" >
						                        <span id="proposerBadge<%=imp.getRessource().getId() %>" class="badge">Proposer</span></a>
						                         <% }} else {%>
						                         <a   href="#" data-bs-toggle="modal" data-bs-target="#AjouterPropositionModal<%=imp.getRessource().getId() %>" >
						                        <span id="proposerBadge<%=imp.getRessource().getId() %>" class="badge">Proposer</span></a>
						                        
						                        </td>
						                    </tr>
						                <% }} %>
						            </tbody>
						        </table>
						    <% } else { %>
						        <div class="col text-center">
						            <b class="bColor">Pas de matériel de type imprimante</b>
						        </div>
						    <% } %>
						    
										    
				          </div>
				           
                            
              
                    </div>
                    
 <%                     /**********  les modaaaal **********/ 

//******************* modal Ajouter proposition*********************************//  %>

 <% for(Ressource rs : listeRessources){%>

<div class="modal modalStyle" id="AjouterPropositionModal<%=rs.getId() %>" tabindex="-1">
  <div class="modal-dialog" style="max-width: 50%;text-align:center">
    <div class="modal-content">
       <div class="modal-header">
     
       <h4 class="modal-title" id="exampleModalLabel" style="color:rgb(91, 140, 160)">Ajouter une proposition :</h4>
     
      </div>
      <div class="modal-body">
      <form action="/ajouterProposition" method="post">
      <input type="hidden" name="RessourceId" value="<%=rs.getId() %>">
         <input type="hidden" name="AppelOffreId" value="<%=appelOffreId %>">
       
       
     
      <div class="row mb-5 ">
		  <label class="col-sm-3 col-form-label"><b>La marque:</b></label>
		  <div class="col-sm-9">
		    <input type="text" name="marque" class="form-control" placeholder="Saisir la marque" required>
		  </div>
		</div>
		
		   <div class="row  mb-5">
		  <label class="col-sm-3 col-form-label"><b>Le prix:</b></label>
		  <div class="col-sm-9">
		    <input type="number" name="prix" class="form-control" placeholder="Saisir le prix" required>
		  </div>
		</div>
		
		<div class="row  mb-5">
		  <label class="col-sm-3 col-form-label"><b>durée de garantie:</b></label>
		  <div class="col-sm-4">
		    <input type="number" name="NombreGarantie" class="form-control" placeholder="Saisir la duree " required>
		  </div>
		  <div class="col-sm-5">
		  <select name="TypeGarantie" class="form-select" aria-label="Default select example">
		        <option value="Ans">Ans</option>
		         <option value="Mois"> Mois</option>
		          <option value="Jours">Jours</option>
		     </select>
		    
		  </div>
		</div>
      
      <div class="modal-footer">
        <button style="background-color:rgb(133, 185, 196) ;" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
         <input style="background-color:rgb(133, 185, 196) ;" type="submit" class="btn btn-primary" value="Ajouter" />
      </div>
        </form>
    
       
       
      </div>
    </div>
  </div>
</div>

 <% } %>
 
 <% /******** Modal envoyer offre ************/ %>
 
 <div class="modal modalStyle" id="EnvoyerOffreModal" tabindex="-1">
  <div class="modal-dialog" style="max-width: 50%;text-align:center">
    <div class="modal-content">
       <div class="modal-header">
       <h4 class="modal-title" id="exampleModalLabel" style="color:rgb(91, 140, 160)">Envoyer offre  :</h4>
      </div>
      <div class="modal-body">
      <form action="/AjouterOffre" method="post">
      <input type="hidden" name="AppelOffreId" value="<%=appelOffreId %>">
         
      <div class="row mb-5 ">
		  <label class="col-sm-3 col-form-label"><b>Total:</b></label>
		  <div class="col-sm-9">
		    <input type="text" name="total" class="form-control"  value ="<%= total%> " required>
		  </div>
		</div>
		
		   <div class="row  mb-5">
		  <label class="col-sm-3 col-form-label"><b>Date de livraison :</b></label>
		  <div class="col-sm-9">
		    <input type="date" name="DateLivraison" class="form-control" placeholder="Saisir le prix" required>
		  </div>
		</div>
		
 
      
      <div class="modal-footer">
        <button style="background-color:rgb(133, 185, 196) ;" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
         <input style="background-color:rgb(133, 185, 196) ;" type="submit" class="btn btn-primary" value="Envoyer" />
      </div>
        </form>
    
       
       
      </div>
    </div>
  </div>
</div>



                     
                </section>
       
    <script>
    // Utiliser un objet pour stocker l'état des liens proposer
    var alreadyClicked = {};

    function disableLinkAndChangeBadgeColor(resourceId) {
        // Vérifier si le lien a déjà été cliqué
        if (alreadyClicked[resourceId]) {
            // Si oui, ne rien faire
            return;
        }

        // Désactiver le lien
        var proposerLink = document.getElementById('proposerLink' + resourceId);
        proposerLink.onclick = function(event) {
            event.preventDefault(); // Empêcher le comportement par défaut du lien
        };

        // Modifier la couleur du badge
        var proposerBadge = document.getElementById('proposerBadge' + resourceId);
        proposerBadge.style.backgroundColor = 'gray';

        // Marquer le lien comme déjà cliqué
        alreadyClicked[resourceId] = true;
        
        
    }
</script>
    
</body>
</html>