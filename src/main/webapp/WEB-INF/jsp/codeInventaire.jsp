<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="com.example.demo.entity.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Gestion des ressources</title>
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
<!-- Inclure la bibliothéque SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%@ include file="links.jsp" %>




<script>
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');

    if (successParam === 'true') {
        // Afficher une alerte de succés avec SweetAlert
        Swal.fire("Succés!", "L'opération a été effectuée avec succés!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        Swal.fire("Erreur!", "Une erreur s'est produite lors de l'opération.", "error");
    }
</script>



<title>Gestion des appels d'offres</title>
<%@ include file="links.jsp" %>

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
        // Afficher une alerte de succÃ¨s avec SweetAlert
        swal("SuccÃ¨s!", "L'opÃ©ration a Ã©tÃ© effectuÃ©e avec succÃ¨s!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'Ã©chec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de l'opÃ©ration.", "error");
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
                    <li class="menu-item">   <a href="/appelOffre"> <i class="fas fa-qrcode"></i>    Gestion de appel d'offre</a></li>
                        <li class="menu-item"> <a href="/appelOffreCode"><i class="fas fa-link"></i>     Gestion de ressource</a></li>
    <li class="menu-item"><a href="/Fournisseurs"><i class="fas fa-stream"></i>Fournisseurs</a></li>
     <li class="menu-item"><a href="/Propositions"><i class="fas fa-calendar-week"></i>Propositions</a></li>
     <li class="menu-item"><a href="/Liste_Panne"><i class="far fa-question-circle"></i>Panne</a></li>
         
     
    </ul>
    </nav>

                <section>
            <div class="card recent-sales overflow-auto">
                <!-- la table des ressources -->
                <h1 class="card-title">Liste des ressources</h1>
                <% 
                    List<Ordinateur> listeOrdinateurs = (List<Ordinateur>) request.getAttribute("listeOrdinateurs");
                    List<Imprimante> listeImprimantes = (List<Imprimante>) request.getAttribute("listeImprimantes");
                    List<Ressource> listeRessources = (List<Ressource>) request.getAttribute("listeRessources");
                %>
                <% if (!listeOrdinateurs.isEmpty() || !listeImprimantes.isEmpty()) { %>
                    <table class="table">
                        <!-- Formulaire pour saisir les codes inventaire -->
                        <form action="/add-inventaire" method="post" onsubmit="return confirm('Confirmer l\'ajout des inventaires ?');">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nom du département</th>
                                        <th scope="col">Type de ressource</th>
                                        <th scope="col">Caractéristiques</th>
                                        <th scope="col">Ajouter code inventaire</th>
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
                                            <td>
                                                <input type="hidden" name="idRessource" value="<%= ordinateur.getRessource().getId() %>">
                                                
                                                <%
                                                    String codeBarreValue = ordinateur.getRessource().getCodeBarre();
                                                    String inputType = (codeBarreValue != null && !codeBarreValue.isEmpty()) ? "text" : "text";
                                                    String inputDisabled = (codeBarreValue != null && !codeBarreValue.isEmpty()) ? "disabled" : "";
                                                %>
                                                <input type="<%= inputType %>" name="codeInventaire_<%= ordinateur.getRessource().getId() %>" value="<%= codeBarreValue %>" placeholder="Code inventaire" <%= inputDisabled %> required>
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
                                          
                                                                            <td>
                                     	           <input type="hidden" name="idRessource" value="<%= imprimante.getRessource().getId() %>">
                                                
                                                <%
                                                    String codeBarreValue = imprimante.getRessource().getCodeBarre();
                                                    String inputType = (codeBarreValue != null && !codeBarreValue.isEmpty()) ? "text" : "text";
                                                    String inputDisabled = (codeBarreValue != null && !codeBarreValue.isEmpty()) ? "disabled" : "";
                                                %>
                                                <input type="<%= inputType %>" name="codeInventaire_<%= imprimante.getRessource().getId() %>" value="<%= codeBarreValue %>" placeholder="Code inventaire" <%= inputDisabled %> required>
                                            </td>
                                            
                                        </tr>
                                        <% count++; %>
                                    <% } %>
                                </tbody>
                            </table>
                            <br><br>
                            <button type="submit" class="btn btn-primary">Confirmer</button>
                        </form>
                    </table>
                <% } %>
            </div>
 
</section>

</body>
</html>
