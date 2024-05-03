<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/styles/global.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Se connecter</title>
    <script src="/js/jquery.js"></script>
    <link rel="icon" href="/images/logo.png" type="image/icon type">
</head>
<body>
   <%@ include file="navbar.jsp" %>
    <div id="connectioncontainer">
        <img class="biglogo" src="/images/logo.png"/>
        <span id="textcontainer">
            Welcome to NetRessourcesFaculty
        </span>
        <span id="inputcontainer">
            <form id="connectionform" autocomplete="off" action="/login" method="post">
         
                <span class="logonamespan">
                    <img src="/images/logo.png"/>
                    <article>NetRessources</article>
                </span>

                <div class="inpluslab">
                    <input required class="deezinputs"  name="email" id="email" placeholder="email" type="email"/>
                    <label class="deezlabels" for="email">email</label>
                </div>

                <div class="inpluslab">
                    <input required class="deezinputs" id="password" name="password" placeholder="mot de passe" type="password"/>
                    <label class="deezlabels" for="password">mot de passe</label>
                </div>

                <button class="navbuttons" type="submit">se connecter</button>
            </form>
        </span>
    </div>
</body>
</html>
