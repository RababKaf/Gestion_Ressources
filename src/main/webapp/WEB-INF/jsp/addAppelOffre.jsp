<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.example.demo.entity.*" %>






<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion des appels d'offres</title>
<%@ include file="links.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.bColor {
    color: rgb(48, 96, 184);
}
</style>

</head>

<body>

<script>
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');

    if (successParam === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "L'opération a été effectuée avec succès!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de l'opération.", "error");
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
         
            <li class="menu-item">  <a href="/updateRessources"><i class="fas fa-link"></i> Consulter ressources</a></li>
                <li class="menu-item">   <a href="/appelOffre"> </a><i class="fas fa-qrcode"></i>    Gestion de appel d'offre</a></li>
                    <li class="menu-item"> <a href="/appelOffreCode"></a><i class="fas fa-link"></i>     Gestion de ressource</a></li>
<li class="menu-item"><a href="/Fournisseurs"><i class="fas fa-stream"></i>Fournisseurs</a></li>
 <li class="menu-item"><a href="/Propositions"><i class="fas fa-calendar-week"></i>Propositions</a></li>
 <li class="menu-item"><a href="/Liste_Panne"><i class="far fa-question-circle"></i>Panne</a></li>
     
     
    </ul>
    </nav>

                <section>
                    <div class="p-3">
                        <h2>Espace Responsable</h2>
                        
                        <!-- Affichage de la liste des ressources -->
                        <div class="card recent-sales overflow-auto">
                            <!-- la table des ressources -->
                            <h5 class="card-title">Liste des ressources</h5>
                            <% 
                                List<Ordinateur> listeOrdinateurs = (List<Ordinateur>) request.getAttribute("listeOrdinateurs");
                                List<Imprimante> listeImprimantes = (List<Imprimante>) request.getAttribute("listeImprimantes");
                                List<Ressource> listeRessources = (List<Ressource>) request.getAttribute("listeRessources");
                            %>
                            <% if (!listeOrdinateurs.isEmpty() || !listeImprimantes.isEmpty()) { %>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Nom du département</th>
                                            <th scope="col">Type de ressource</th>
                                            <th scope="col">Caractéristiques</th>
                                        </tr>
                                    </thead> 
                                    <tbody>
                                        <% int count = 1; %>
                                        <% for (Ordinateur ordinateur : listeOrdinateurs) { %>
                                            <tr>
                                                <td><%= count %></td>
                                                <td><%= ordinateur.getRessource().getEnseignant().getDepartement().getNomDepartement() %></td>
                                                <td>Ordinateur</td>
                                                <td>
                                                    CPU: <%= ordinateur.getCPU() %><br>
                                                    RAM: <%= ordinateur.getRAM() %><br>
                                                    Disque Dur: <%= ordinateur.getDisqueDur() %><br>
                                                    Ecran: <%= ordinateur.getEcran() %><br>
                                                </td>
                                            </tr>
                                            <% count++; %>
                                        <% } %>
                                        <% for (Imprimante imprimante : listeImprimantes) { %>
                                            <tr>
                                                <td><%= count %></td>
                                                <td><%= imprimante.getRessource().getEnseignant().getDepartement().getNomDepartement() %></td>
                                                <td>Imprimante</td>
                                                <td>
                                                    Resolution: <%= imprimante.getResolution() %><br>
                                                    Vitesse d'impression: <%= imprimante.getVitesseImpression() %><br>
                                                </td>
                                            </tr>
                                            <% count++; %>
                                        <% } %>
                                    </tbody>
                                </table>
                            <% } else { %>
                                <div class="col text-center">
                                    <b class="bColor">Pas de besoin est disponible</b>
                                </div>
                            <% } %>
                        </div>
                    </div>
          
                
             <!-- Bouton pour ouvrir le modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal">
  Confirmer
</button>

<!-- Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmModalLabel">Confirmer</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
       <form action="/insert-appel-offre" method="post">
	      <div class="modal-body">
	       <label for="description">Description :</label>
                    <input type="text" id="description" name="description">
                    <br>
                    <br>
	        <label for="startDate">Date de début :</label>
	        <input type="date" id="startDate" name="startDate">
	        <br>
	        <br>
	        <label for="endDate">Date de fin :</label>
	        <input type="date" id="endDate" name="endDate">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
	        <button type="submit" class="btn btn-primary" id="confirmButton">Confirmer</button>
	        
	      </div>
      </form>
      
    </div>
  </div>
</div>
            </div>
        </div>
    </div>
</section>
    <!-- Liens vers les scripts Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
