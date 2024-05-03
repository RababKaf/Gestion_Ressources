<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <%@ page import="java.util.*" %>
   <%@ page import="com.example.demo.entity.*" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Espace Enseignant</title>
  <%@  include file="links.jsp"%>
  
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <meta charset="UTF-8">
      

<style>
.bColor
{
color:rgb(48, 96, 184)  ;
}

</style>

</head>



<body>

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
                <a href="/myressources_Ens"><i class="fas fa-qrcode"></i>Mes ressources</a>
            </li>
            <li class="menu-item">
               <a href="/myBesoins_ENS"><i class="fas fa-link"></i>Mes besoins</a> 
            </li>
         
        </ul>
        </nav>
<section>

    <!-- Contenu de la page -->
  
                        <h2>Espace enseignant</h2>
                        
                        <!-- Affichage de la liste des appels d'offres -->
                        
                            <% 
                            
                               List<Ressource> listeRessources = (List<Ressource>)request.getAttribute("ListeRessources");
                               List<Ordinateur> listeOrdinateur = (List<Ordinateur>)request.getAttribute("ListeOrdinateur");
                               List<Imprimante> listeImprimante = (List<Imprimante>)request.getAttribute("ListeImprimante");
                            
                            %>
                           
                           
                             <div class="card recent-sales overflow-auto">
                             
                             
                             <h5 class="card-title">Liste matériel <span>|Ordinateur </span></h5>
                             <%  if (!listeOrdinateur.isEmpty()) {  %>
				              <table class="table  ">
				              <thead>
				                <tr>
				                  <th scope="col">#</th>
				                  <th scope="col" >CPU</th>
				                  <th scope="col">RAM </th>
				                  <th scope="col">disque Dur</th>
				                  <th scope="col">Ecran</th>
				                  <th scope="col">code barre</th>
				                   <th scope="col">Etat</th>
				                  <th scope="col">Action</th>
				                
				                 
				                </tr>
				              </thead> 
				              <tbody>
				              
				              <% for (Ordinateur or : listeOrdinateur) { %>
				                                 <tr>
				                                      <td><%= or.getId() %></td>
				                                      <td><%= or.getCPU() %></td>
				                                      <td><%= or.getRAM() %></td>
				                                      <td><%= or.getDisqueDur() %></td>
				                                      <td><%= or.getEcran() %></td>
				                                      <td><%= or.getRessource().getCodeBarre() %></td>
				                                     <td><%= (or.getRessource().getEtat() == 6) ? "en panne" : "en marche" %></td>
				                                      
				                                      <td>
             <a href="#" data-bs-toggle="modal"  
    <% if (or.getRessource().getEtat() == 6) { %>
        style="pointer-events: none; 
        opacity: 0.5;" data-bs-target="#modalSignalerOrd<%=or.getId() %>" disabled>
        <i class="bi bi-ban-fill" style="color:red;font-size:25px;" data-bs-toggle="tooltip" title="Signaler une panne" data-bs-placement="top"></i>
    <% } else { %>
        data-bs-target="#modalSignalerOrd<%=or.getId() %>">
        <i class="bi bi-ban-fill" style="color:red;font-size:25px;" data-bs-toggle="tooltip" title="Signaler une panne" data-bs-placement="top"></i>
    <% } %>
</a>

														</td>
              	
                     </tr>
				                            <% } %>
                                        
				               
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
						                    <th scope="col">Résolution</th>
						                    <th scope="col">Vitesse d'impression</th>
						                    <th scope="col">code barre</th>
						                     <th scope="col">etat</th>
						                     <th scope="col">Action</th>
						                </tr>
						            </thead> 
						            <tbody>
						                <% for (Imprimante imp : listeImprimante) { %>
						                    <tr>
						                        <td><%= imp.getId() %></td>
						                        <td><%= imp.getResolution() %></td>
						                        <td><%= imp.getVitesseImpression() %></td>
						                         <td><%= imp.getRessource().getCodeBarre() %></td>
						                         <td><%= (imp.getRessource().getEtat() == 6) ? "en panne" : "en marche" %></td>
				                                      
						                        <td>
             	
					    <a href="#" data-bs-toggle="modal"  
					    <% if (imp.getRessource().getEtat() == 6) { %>
					        style="pointer-events: none; 
					        opacity: 0.5;" data-bs-target="#modalSignalerImp<%=imp.getId() %>" disabled>
					        <i class="bi bi-ban-fill" style="color:red;font-size:25px;" data-bs-toggle="tooltip" title="Signaler une panne" data-bs-placement="top"></i>
					    <% } else { %>
					        data-bs-target="#modalSignalerImp<%=imp.getId() %>" >
					        <i class="bi bi-ban-fill" style="color:red;font-size:25px;" data-bs-toggle="tooltip" title="Signaler une panne" data-bs-placement="top"></i>
					    <% } %>
					</a>
              									</td>
              								</tr>
						                <% } %>
						            </tbody>
						        </table>
						    <% } else { %>
						        <div class="col text-center">
						            <b class="bColor">Pas de matériel de type imprimante</b>
						        </div>
						    <% } %>
										    
				          </div>
      
    
     <%                           
    List<Ordinateur> listeOrdinateur1 = (List<Ordinateur>)request.getAttribute("ListeOrdinateur");
	
for (Ordinateur or : listeOrdinateur1) { 
                 
                            %>

<div class="modal modalStyle" id="modalSignalerOrd<%=or.getId() %>" tabindex="-1">
  <div class="modal-dialog" style="max-width: 50%;">
      <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel" style="color:#0f63b8f1">Signaler une panne:</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <div class="modal-body">
              <div class="data-panel">
                  <h5 class="mb-4" style="color:rgb(18, 46, 108);">Metionner une description sur la panne</h5>

                  <form method="post" action="/enregistrerPanne">
                      <div class="mb-3">
                          <label for="descriptionPanne" class="form-label">Description </label>
                          <textarea class="form-control" id="descriptionPanne" name="descriptionPanne" rows="3" required></textarea>
                      </div>
						<input type="hidden" id="idRessource" name="idRessource" value="<%= or.getRessource().getId() %>">
						<input type="hidden" id="idEns" name="idEns" value="<%= or.getRessource().getEnseignant().getId() %>">
					
                      <div class="modal-footer">
                          <input type="submit" class="btn btn-primary" value="Signaler">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                      </div>
                  </form>
              </div>
          </div>
      </div>
  </div>
</div>

 <%
						}
   				%>
   				
   				<%                           
   			 List<Imprimante> listeImprimante1 = (List<Imprimante>)request.getAttribute("ListeImprimante");
                
                        		  for (Imprimante imp : listeImprimante1) {
                 
                            %>

<div class="modal modalStyle" id="modalSignalerImp<%=imp.getId() %>" tabindex="-1">
  <div class="modal-dialog" style="max-width: 50%;">
      <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel" style="color:#0f63b8f1">mes ressources :</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <div class="modal-body">
              <div class="data-panel">
                  <h5 class="mb-4" style="color:rgb(18, 46, 108);">Signaler une panne</h5>

                  <form method="post" action="/enregistrerPanne">
                      <div class="mb-3">
                          <label for="descriptionPanne" class="form-label">Description de la panne</label>
                          <textarea class="form-control" id="descriptionPanne" name="descriptionPanne" rows="3" required></textarea>
                      </div>
						<input type="hidden" id="idRessource" name="idRessource" value="<%= imp.getRessource().getId() %>">
						<input type="hidden" id="idEns" name="idEns" value="<%= imp.getRessource().getEnseignant().getId() %>">
                     
                      <div class="modal-footer">
                          <input type="submit" class="btn btn-primary" value="Signaler">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                      </div>
                  </form>
              </div>
          </div>
      </div>
  </div>
</div>

 <%
						}
   				%>
   				</section>
   				
   
    <!-- Liens vers les scripts Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    
    // Récupérer le paramètre de l'URL
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('pantest');

    // Vérifier si l'ajout a réussi
    if (successParam === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "La ressource a été marqué en panne avec succès!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de l'envoie des deonnees.", "error");
    }
    </script>
</body>

</html>