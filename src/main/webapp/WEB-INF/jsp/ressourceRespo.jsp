<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="com.example.demo.entity.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Gestion des appels d'offres</title>
<%@  include file="links.jsp" %>

<style>
.bColor
{
    color:rgb(48, 96, 184);
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
                 
                <li class="menu-item">  <a href="/updateRessources"><i class="fas fa-link"></i> Consulter ressources</a></li>
                    <li class="menu-item">   <a href="/appelOffre"> <i class="fas fa-qrcode"></i>    Gestion de appel d'offre</a></li>
                        <li class="menu-item"> <a href="/appelOffreCode"><i class="fas fa-link"></i>     Gestion de ressource</a></li>
    <li class="menu-item"><a href="/Fournisseurs"><i class="fas fa-stream"></i>Fournisseurs</a></li>
     <li class="menu-item"><a href="/Propositions"><i class="fas fa-calendar-week"></i>Propositions</a></li>
     <li class="menu-item"><a href="/Liste_Panne"><i class="far fa-question-circle"></i>Panne</a></li>
         
        </ul>
        </nav>

                <section>
                    <div class="p-3">
                        <h2>Espace Responsable</h2>
                        
                        <!-- Affichage de la liste des appels d'offres -->
                        
                        <div class="card recent-sales overflow-auto">
                            <h5 class="card-title">Liste materiel <span>|Ordinateur </span></h5>
                            <% 
                                List<Ordinateur> listeOrdinateurs = (List<Ordinateur>) request.getAttribute("listeOrdinateurs");
                            %>
                            <% if (!listeOrdinateurs.isEmpty()) { %>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">CPU</th>
                                            <th scope="col">RAM</th>
                                            <th scope="col">Disque Dur</th>
                                            <th scope="col">Ecran</th>
                                        </tr>
                                    </thead> 
                                    <tbody>
                                        <% for (Ordinateur ordinateur : listeOrdinateurs) { %>
                                            <tr>
                                                <td><%= ordinateur.getId() %></td>
                                                <td><%= ordinateur.getCPU() %></td>
                                                <td><%= ordinateur.getRAM() %></td>
                                                <td><%= ordinateur.getDisqueDur() %></td>
                                                <td><%= ordinateur.getEcran() %></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            <% } else { %>
                                <div class="col text-center">
                                    <b class="bColor">Pas de materiel de type ordinateur</b>
                                </div>
                            <% } %>
                            <br><br>
                            
                            <!-- la table imprimante -->
                            <h5 class="card-title">Liste materiel | Imprimante </h5>
                            <% 
                                List<Imprimante> listeImprimantes = (List<Imprimante>) request.getAttribute("listeImprimantes");
                            %>
                            <% if (!listeImprimantes.isEmpty()) { %>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Resolution</th>
                                            <th scope="col">Vitesse d'impression</th>
                                        </tr>
                                    </thead> 
                                    <tbody>
                                        <% for (Imprimante imprimante : listeImprimantes) { %>
                                            <tr>
                                                <td><%= imprimante.getId() %></td>
                                                <td><%= imprimante.getResolution() %></td>
                                                <td><%= imprimante.getVitesseImpression() %></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            <% } else { %>
                                <div class="col text-center">
                                    <b class="bColor">Pas de materiel de type imprimante</b>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
    <!-- Liens vers les scripts Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
