<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.example.demo.entity.Notification" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <meta charset="UTF-8">
      <link rel="stylesheet" type="text/css" href="/styles/NavBar.css">
        <link rel="stylesheet" type="text/css" href="css/cssJEE/modal.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">     
       <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
       <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
       <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
       
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.5/dist/sweetalert2.min.css">
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.5/dist/sweetalert2.min.js"></script>
  
 </head>

 
<body>
<body>

    <header>
        <img src="data:image/png;base64, <%=request.getAttribute("image") %>" alt="Picture" id="profile-pic">
        
        <h2>${nom}</h2>
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
                <a href="/ConsulterPanne">
                    <i class="fas fa-home"></i> Accueil
                </a>
            </li>
            <li class="menu-item">
                <a href="/TPl/AjouterProjetServlet">
                    <i class="fas fa-plus"></i> Consulter Constat
                </a>
            </li>
            <li class="menu-item">
                <a href="/TPl/ConsulterProjet">
                    <i class="fas fa-folder-open"></i>ntg 
                </a>
            </li>
        </ul>
        </nav>
 <section>TechTech    <%-- <% int unreadCount = (int) request.getAttribute("unreadCount"); %><%= unreadCount %> --%></section>
 
 
 
 
</body>
</body>
<script>
function toggleNotifications() {
    var notifications = document.getElementById("notificationMessages");
    notifications.style.display = (notifications.style.display === "none") ? "block" : "none";
}

function markAsRead(notificationId) {
    // Check if the notification has already been marked as read
var shortMessage = document.getElementById(notificationId).getElementsByClassName('short-message')[0];
var fullMessage = document.getElementById(notificationId).getElementsByClassName('full-message')[0];

if (fullMessage.style.display === 'none') {
    shortMessage.style.display = 'none';
    fullMessage.style.display = 'block';
} else {
    shortMessage.style.display = 'block';
    fullMessage.style.display = 'none';
}
    var notificationCard = document.getElementById(notificationId);
    if (notificationCard.classList.contains("read-notification")) {
        return; // Do nothing if already read
    }

    MODIFYDataBase(notificationId);


    

    // Update the notification count (you may want to fetch it from the server)
    var notificationCount = parseInt(document.getElementById("notificationCount").innerHTML);
    if (notificationCount > 0) {
        notificationCount--;
        document.getElementById("notificationCount").innerHTML = notificationCount;

        // Hide the badge if there are no more notifications
        document.getElementById("notificationCount").style.display = (notificationCount > 0) ? "block" : "none";
    }

    // Toggle background color to indicate the notification has been read
    notificationCard.classList.add("read-notification");
}
function MODIFYDataBase(notificationId) {
    $.ajax({
        type: 'POST',
        url: '/notifications/markAsRead',
        data: {
            notificationId: notificationId
        },
        success: function(response) {
            console.log('Notification marked as read successfully');
            // Optionally, update the UI to reflect the change
        },
        error: function(xhr, status, error) {
            console.error('Error marking notification as read:', error);
            // Handle error scenario
        }
    });




}
</script>
</html>