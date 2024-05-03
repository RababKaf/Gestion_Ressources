<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <%@ page import="java.util.*" %>
   <%@ page import="com.example.demo.entity.*" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Espace chef de départementt</title>
  <%@  include file="links.jsp"%>

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
                <a href="/myressources_CHD"><i class="fas fa-qrcode"></i>Les besoins</a>
            </li>
            <li class="menu-item">
              <a href="/communiquer_CHD"><i class="fas fa-link"></i>Demmander des besoins</a>
            </li>
         
        </ul>
        </nav>
<section>

 
                        <h2>Espace chef de département</h2>
               
    
    <form action="/notifier_CHD" method="post" class="my-4">
    <h5>Envoyer un Message</h5>
    <div class="mb-3">
        <label for="destinataire" class="form-label">Destinataire:</label>
        <select name="destinataire" id="destinataire" class="form-select mb-3">
            <% 
            List<Enseignant> ListeEnseignants = (List<Enseignant>) request.getAttribute("ListeEnseignants");
            for (Enseignant ens : ListeEnseignants) { 
            %>
            <option value="<%= ens.getId() %>"><%= ens.getUser().getNom_complet() %></option>
            <% 
            } 
            %>
            <option value="tout">Tous les enseignants du département</option>
        </select>
        <label for="message" class="form-label">Message:</label>
        <textarea name="message" id="message" rows="4" cols="50" class="form-control mb-3"></textarea>
        <input type="submit" value="Envoyer" class="btn btn-primary">
    </div>
</form>



   </section>
   
   <script>
    // Récupérer le paramètre de l'URL
    const urlParams = new URLSearchParams(window.location.search);
    const testNotif = urlParams.get('testNotif');

    // Vérifier si l'ajout a réussi
    if (testNotif === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "La notifiation a été envoyé avec succès!", "success");
    } else if (testNotif === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de l'envoie des deonnees.", "error");
    }
    </script>

</body>

</html>