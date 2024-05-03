<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.example.demo.entity.*" %>
<%@ page import="java.util.List" %>
<%@ include file="links.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Update Ressources</title>
    <
     rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const successParam = urlParams.get('success');

        if (successParam === 'true') {
            // Afficher une alerte de succ�s avec SweetAlert
            Swal.fire("Succ�s!", "L'op�ration a �t� effectu�e avec succ�s!", "success");
        } else if (successParam === 'false') {
            // Afficher une alerte d'�chec avec SweetAlert
            Swal.fire("Erreur!", "Une erreur s'est produite lors de l'op�ration.", "error");
        }

        // Fonction pour remplir les champs du formulaire du modal en fonction du type de ressource
        function fillEditModal(type, id, cpu, disqueDur, ecran, ram, resolution, vitesseImpression) {
            if (type === 'Ordinateur') {
                document.getElementById('editComputerId').value = id;
                document.getElementById('editComputerCPU').value = cpu;
                document.getElementById('editComputerDisqueDur').value = disqueDur;
                document.getElementById('editComputerEcran').value = ecran;
                document.getElementById('editComputerRAM').value = ram;
            } else if (type === 'Imprimante') {
                document.getElementById('editPrinterId').value = id;
                document.getElementById('editPrinterResolution').value = resolution;
                document.getElementById('editPrinterVitesseImpression').value = vitesseImpression;
            }
        }
    </script>
    
      <% 
                                List<Ordinateur> ordinateur = (List<Ordinateur>) request.getAttribute("ordinateur");
                                List<Imprimante> imprimantes = (List<Imprimante>) request.getAttribute("imprimantes");
                                List<Ressource> ressources = (List<Ressource>) request.getAttribute("ressources");
                                List<User> enseignants=(List<User>)request.getAttribute("enseignants");
                                List<Departement> departements=(List<Departement>)request.getAttribute("departements");
                                
                            %>
    <!-- Ajoutez les scripts Bootstrap et Font Awesome pour les ic�nes -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
    <!-- Modal pour modifier les caract�ristiques d'un ordinateur -->
    <div class="modal fade" id="editComputerModal" tabindex="-1" role="dialog" aria-labelledby="editComputerModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editComputerModalLabel">Modifier les caract�ristiques de l'ordinateur</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Formulaire pour modifier les caract�ristiques d'un ordinateur -->
                    <form action="/modifierRessource" method="POST">
                        <input type="hidden" id="editComputerId" name="id">
                        <input type="hidden" id="editComputerType" name="type" value="Ordinateur">
                        <label for="editComputerCPU">CPU:</label>
                        <input type="text" id="editComputerCPU" name="cpu" class="form-control" required>
                        <label for="editComputerDisqueDur">Disque dur :</label>
                        <input type="text" id="editComputerDisqueDur" name="disqueDur" class="form-control" required>
                        <label for="editComputerEcran">�cran:</label>
                        <input type="text" id="editComputerEcran" name="ecran" class="form-control" required>
                        <label for="editComputerRAM">RAM :</label>
                        <input type="text" id="editComputerRAM" name="ram" class="form-control" required>
                        <button type="submit" class="btn btn-primary">Enregistrer</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal pour modifier les caract�ristiques d'une imprimante -->
    <div class="modal fade" id="editPrinterModal" tabindex="-1" role="dialog" aria-labelledby="editPrinterModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editPrinterModalLabel">Modifier les caract�ristiques de l'imprimante</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Formulaire pour modifier les caract�ristiques d'une imprimante -->
                    <form action="/modifierRessource" method="POST">
                        <input type="hidden" id="editPrinterId" name="id">
                        <input type="hidden" id="editPrinterType" name="type" value="Imprimante">
                        <label for="editPrinterResolution">R�solution:</label>
                        <input type="text" id="editPrinterResolution" name="resolution" class="form-control" required>
                        <label for="editPrinterVitesseImpression">Vitesse d'impression :</label>
                        <input type="text" id="editPrinterVitesseImpression" name="vitesseImpression" class="form-control" required>
                        <button type="submit" class="btn btn-primary">Enregistrer</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
<% for (int i = 0; i < ressources.size(); i++) { %>
    <% Ressource ressource = ressources.get(i); %>
    <!-- Modal pour modifier l'affectation de la ressource -->
    <div class="modal fade" id="editAffectationModal<%= ressource.getId() %>" tabindex="-1" role="dialog" aria-labelledby="editAffectationModalLabel<%= ressource.getId() %>" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editAffectationModalLabel<%= ressource.getId() %>">Modifier l'affectation de la ressource</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Formulaire pour modifier l'affectation de la ressource -->
                    <!-- Formulaire pour modifier l'affectation de la ressource -->
<form action="/modifierAffectation" method="POST">
    <input type="hidden" name="ressourceId" value="<%= ressource.getId() %>">
    <div class="form-group">
        <label for="affectationSelect<%= ressource.getId() %>">Affectation:</label>
        <select class="form-control" id="affectationSelect<%= ressource.getId() %>" name="affectationId">
            <!-- Option pour aucune affectation -->
            <option value="0" <% if (ressource.getAffectation() == null) { %>selected<% } %>>Aucune affectation</option>
            <!-- Options pour les affectations possibles -->
            <% for (User enseignant : enseignants) { %>
                <option value="ens,<%= enseignant.getId() %>" <% if (ressource.getAffectation() != null &&
                                                                  ressource.getAffectation().getEnseignant() != null &&
                                                                  ressource.getAffectation().getEnseignant().getId() == enseignant.getId()) { %>selected<% } %>>
                    <%= enseignant.getNom_complet() %>
                </option>
            <% } %>
            <% for (Departement departement : departements) { %>
                <option value="dep,<%= departement.getId() %>" <% if (ressource.getAffectation() != null &&
                                                                   ressource.getAffectation().getDepartement() != null &&
                                                                   ressource.getAffectation().getDepartement().getId() == departement.getId()) { %>selected<% } %>>
                    <%= departement.getNomDepartement() %>
                </option>
            <% } %>
        </select>
    </div>
    <button type="submit" class="btn btn-primary">Enregistrer</button>
</form>



                </div>
            </div>
        </div>
    </div>
<% } %>


    <h1>Liste des ressources</h1>
    
    <table class="table">
        <thead>
            <tr>
                <th>Ressource</th>
                <th>Caract�ristiques</th>
                <th>Affectation</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (int i = 0; i < ressources.size(); i++) { %>
                <% Ressource ressource = ressources.get(i); %>
                <tr>
                    <td>
                        <% if (ordinateur != null && ordinateur.get(i) != null) { %>
                            Ordinateur
                        <% } else if (imprimantes != null && imprimantes.get(i) != null) { %>
                            Imprimante
                        <% } %>
                    </td>
                    <td>
                        <% if (ordinateur != null && ordinateur.get(i) != null) { %>
                            CPU: <%= ordinateur.get(i).getCPU() %><br/>
                            Disque dur: <%= ordinateur.get(i).getDisqueDur() %> <br/>
                            �cran: <%= ordinateur.get(i).getEcran() %><br/>
                            RAM: <%= ordinateur.get(i).getRAM() %> <br/>
                        <% } else if (imprimantes != null && imprimantes.get(i) != null) { %>
                            R�solution: <%= imprimantes.get(i).getResolution() %> <br/>
                            Vitesse d'impression: <%= imprimantes.get(i).getVitesseImpression() %> <br/>
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
                     <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editAffectationModal<%= ressource.getId() %>"title="modifier affectation">
        <i class="fas fa-edit"></i>
    </button>                 
                </td>
                    <t
                        <% if (ordinateur != null && ordinateur.get(i) != null) { %>
                            <!-- Bouton pour ouvrir le modal de modification d'un ordinateur -->
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editComputerModal" onclick="fillEditModal('Ordinateur', '<%= ressource.getId() %>', '<%= ordinateur.get(i).getCPU() %>', '<%= ordinateur.get(i).getDisqueDur() %>', '<%= ordinateur.get(i).getEcran() %>', '<%= ordinateur.get(i).getRAM() %>')" title="modifier ressource">
                                <i class="fas fa-edit"></i>
                            </button>
                        <% } else if (imprimantes != null && imprimantes.get(i) != null) { %>
                            <!-- Bouton pour ouvrir le modal de modification d'une imprimante -->
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editPrinterModal" onclick="fillEditModal('Imprimante', '<%= ressource.getId() %>', '', '', '', '', '<%= imprimantes.get(i).getResolution() %>', '<%= imprimantes.get(i).getVitesseImpression() %>')" title="modifier ressource" >
                                <i class="fas fa-edit"></i>
                            </button>
                        <% } %>
                        <a href="/supprimerRessource?id=<%= ressource.getId() %>" class="btn btn-danger" title="supprimer"><i class="fas fa-trash-alt"></i></a>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table></section>
</body>

</html>
