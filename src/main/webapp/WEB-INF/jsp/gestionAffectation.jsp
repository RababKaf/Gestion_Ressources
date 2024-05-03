<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.entity.*" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion des affectations</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
        
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin-bottom: 20px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .search-container {
            text-align: left;
            margin-bottom: 20px;
        }
        .search-container input[type=text] {
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
    </style>


<%@ include file="links.jsp" %>

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

<%
int idAppelOffre=(int)request.getAttribute("idAppelOffre");

List<Ressource> ressourcesLivres = (List<Ressource>) request.getAttribute("ressourcesLivres");
List<Integer> idsRessources = new ArrayList<>();
if (ressourcesLivres != null) {
    for (Ressource ressource : ressourcesLivres) {
        idsRessources.add(ressource.getId());
    }
}
%>



<style>
.bColor {
    color: rgb(48, 96, 184);
}
</style>

</head>

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
    <h1>Liste des ressources</h1>
    <table border="1">
        <tr>
            <th>Ressource</th>
            <th>Type</th>
            <th>Caractéristiques</th>
            <th>Affectation</th>
        </tr>
        <% for (int i = 0; i < ressourcesLivres.size(); i++) { %>
            <% Ressource ressource = ressourcesLivres.get(i); %>
            <tr>
                <td><%= ressource.getId() %></td>
                <td>
                    <% if (ressource.getOrdinateur() != null) { %>
                        Ordinateur
                    <% } else if (ressource.getImprimante() != null) { %>
                        Imprimante
                    <% } else { %>
                        Inconnu
                    <% } %>
                </td>
                <td>
                    <% if (ressource.getOrdinateur() != null) { %>
                        CPU: <%= ressource.getOrdinateur().getCPU() %><br/>
                        Disque dur: <%= ressource.getOrdinateur().getDisqueDur() %> Go<br/>
                        Écran: <%= ressource.getOrdinateur().getEcran() %><br/>
                        RAM: <%= ressource.getOrdinateur().getRAM() %> Go<br/>
                    <% } else if (ressource.getImprimante() != null) { %>
                        Résolution: <%= ressource.getImprimante().getResolution() %> dpi<br/>
                        Vitesse d'impression: <%= ressource.getImprimante().getVitesseImpression() %> ppm<br/>
                    <% } else { %>
                        N/A
                    <% } %>
                </td>
                <td>
                    <% if (ressource.getAffectation() != null &&
                          ressource.getAffectation().getEnseignant() != null &&
                          ressource.getAffectation().getEnseignant().getUser() != null) { %>
                        <%= ressource.getAffectation().getEnseignant().getUser().getNom_complet() %>
                    <% } else if (ressource.getAffectation() != null &&
                               ressource.getAffectation().getDepartement() != null) { %>
                        <%= ressource.getAffectation().getDepartement().getNomDepartement() %>
                    <% } else { %>
                        Aucune affectation
                    <% } %>
                </td>
            </tr>
        <% } %>
    </table>
<form action="/confirmAffectation" method="post">
    <input type="hidden" name="ressourcesid" value="<%= idsRessources %>">
    <input type="hidden" name="id_appel_offre" value="<%= idAppelOffre %>">
    
    <button type="submit" name="action" value="confirmer">Confirmer</button>
    <button type="submit" name="action" value="envoyer">Envoyer</button>
</form>

</body></section>
</html>