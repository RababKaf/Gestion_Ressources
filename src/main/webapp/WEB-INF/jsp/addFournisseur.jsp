<%@ page import="com.example.demo.entity.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Formulaire Fournisseur</title>
    <%@ include file="links.jsp" %>
    <style>
        
        h1 {
            color: #333;
            text-align: center;
        }
        form {
            width: 50%;
            margin: 0 auto;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="tel"],
        input[type="file"],
        button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #0056b3;
        }
        button[type="button"] {
            background-color: #dc3545;
            color: white;
            border: none;
            cursor: pointer;
        }
        button[type="button"]:hover {
            background-color: #c82333;
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
<h1>Formulaire Fournisseur</h1>

<form action="/enregistrerFournisseur" method="post">
    <!-- Champ cachï¿½ pour passer l'ID du fournisseur -->
    <input type="hidden" name="idFournisseur" id="idFournisseur" value="${idFournisseur}">
    <input type="hidden" name="idAppelOffre" id="idAppelOffre" value="${idAppelOffre}">
        
    <label for="adresse">Adresse :</label><br>
    <input type="text" id="adresse" name="adresse" required><br><br>
    
    <label for="nomSociete">Nom de la sociï¿½tï¿½ :</label><br>
    <input type="text" id="nomSociete" name="nomSociete" required><br><br>
    
    <label for="nomCompletGerant">Nom complet du gï¿½rant :</label><br>
    <input type="text" id="nomCompletGerant" name="nomCompletGerant" required><br><br>
    
    <label for="siteInternet">Site internet :</label><br>
    <input type="text" id="siteInternet" name="siteInternet" required><br><br>
    
    <button type="submit">Confirmer</button>
    <button type="button" onclick="window.history.back()">Annuler</button>
</form>
</section>
</body>
</html>
