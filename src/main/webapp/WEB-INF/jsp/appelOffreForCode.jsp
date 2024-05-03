<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.example.demo.entity.*" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Gestion des ressources</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%@ include file="links.jsp" %>

<style>
.bColor {
    color: rgb(48, 96, 184);
}
</style>
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
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
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
<%
    List<AppelOffre> listeAppelOffres = (List<AppelOffre>) request.getAttribute("listeAO");
%>




</head>

<body>
<script>
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');

    if (successParam === 'true') {
        // Afficher une alerte de succÃ¨s avec SweetAlert
        swal("SuccÃ¨s!", "L'opération a été effectué avec succés!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'Ã©chec avec SweetAlert
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
          
                <li class="menu-item">  <a href="/updateRessources"><i class="fas fa-link"></i> Consulter ressources</a></li>
                    <li class="menu-item">   <a href="/appelOffre"> <i class="fas fa-qrcode"></i>    Gestion de appel d'offre</a></li>
                        <li class="menu-item"> <a href="/appelOffreCode"><i class="fas fa-link"></i>     Gestion de ressource</a></li>
    <li class="menu-item"><a href="/Fournisseurs"><i class="fas fa-stream"></i>Fournisseurs</a></li>
     <li class="menu-item"><a href="/Propositions"><i class="fas fa-calendar-week"></i>Propositions</a></li>
     <li class="menu-item"><a href="/Liste_Panne"><i class="far fa-question-circle"></i>Panne</a></li>
         
     
    </ul>
    </nav>

                <section>

<table id="appelOffreTable">
    <thead>
    <tr>
        <th>Appel d'Offre</th>
        <th>Date Début</th>
        <th>Date Fin</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <% for (AppelOffre appelOffre : listeAppelOffres) { %>
    <tr>
        <td><%= appelOffre.getDescription() %></td>
        <td><%= appelOffre.getDateDebut() %></td>
        <td><%= appelOffre.getDateFin() %></td>
        <td>
            <a href="/verifierFournisseur?id=<%=appelOffre.getId() %>" class="btn btn-primary" title="Vérifier fournisseur">
                <i class="bi bi-box-arrow-in-right"></i>
            </a>
            <span class="mx-2"></span> <!-- Ajout de l'espace -->
            <a href="/ressourcesLivres?id=<%=appelOffre.getId() %>" class="btn btn-primary" title=" Consulter Ressources livrées">
                <i class="bi bi-file-earmark-check"></i>
            </a>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
 </section>
</body>
</html>