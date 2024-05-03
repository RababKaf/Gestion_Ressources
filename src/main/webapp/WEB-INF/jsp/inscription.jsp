<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <link rel="stylesheet" href="../styles/global.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>S'inscrire</title>
    <script src="/js/jquery.js"></script>
    <link rel="icon" href="/images/logo.png" type="image/icon type">
   <style>
        #smessage {
            background-color: rgba(255, 0, 0, 0.5); /* Rouge transparent */
            color: red;
            padding: 5px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
   <%@ include file="navbar.jsp" %>
    <div id="navbarcontainer"></div>
    <div id="connectioncontainer">
        <img class="biglogo" src="/images/logo.png"/>
        <span id="textcontainer">
            Join us for an amazing adventure
        </span>
        <span id="inputcontainer">
         
         <form id="inscriptionform" autocomplete="off" action="/register" method="post" enctype="multipart/form-data">
                <span class="logonamespan">
                    <img src="/images/logo.png"/>
                    <article>NetRessources</article>
                </span>

                <span class="nomprenomcontainer">
                    <div class="inpluslab">
                        <input required class="deezinputsname" id="nom" name="nom" placeholder="nom" type="text"/>
                        <label class="deezlabels" for="nom">nom</label>
                    </div>
    
                    <div class="inpluslab">
                        <input required class="deezinputsname" id="prenom" name="prenom" placeholder="prenom" type="text"/>
                        <label class="deezlabels" for="prenom">prenom</label>
                    </div>
                </span>

                <span class="emailtelimageholder">
                    <span class="emailtelholder">

                        <div class="inpluslab">
                            <input required class="deezinputsname" id="email" name="email" type="email" placeholder="email"></input>
                            <label class="deezlabels" for="email">email</label>
                        </div>

                        <div class="inpluslab">
                            <input required class="deezinputsname" name="telephone" placeholder="telephone" id="telephone" type="tel"></input>
                            <label class="deezlabels" for="telephone">telephone</label>
                        </div>

                    </span>
                    <span class="imginput">
                        <input required id="imageinput" class="imageinput" name="imageinput" type="file" accept="image/*" onchange="document.getElementById('imgdisplay').src = window.URL.createObjectURL(this.files[0]); document.getElementById('imgdisplay').style.display = 'block'" ></input>
                        <img id="imgdisplay" src="#" alt=" " />
                        <label id="imglabel" for="imageinput" class="imageinputlabel">select image</label>
                    </span>
                </span>

                <span class="nomprenomcontainer">
                    <div class="inpluslab">
                        <input required class="deezinputsname" name="motdepasse" id="motdepasse" placeholder="mot de passe" type="password"/>
                        <label class="deezlabels" for="motdepasse">mot de passe</label>
                    </div>
    
                    <div class="inpluslab">
                      <span id="message"></span>
                        <input required class="deezinputsname" name="confirmermotdepasse" id="confirmermotdepasse" placeholder="confirmer mot de passe" type="password"/>
                        <label class="deezlabels" for="confirmer mot de passe">confirmer mot de passe</label>
                   
                    </div>
                </span>

                <button class="navbuttons" type="submit">se connecter</button>
              
                        <% String message = (String) request.getAttribute("message");
                        		
                           if (message != null && !message.isEmpty()) {%>
                           <span id="smessage">
                                 <%  out.println(message);
                           }
                        %>
                      </span>
            </form>
        </span>
    </div>
</body>
  <script>
        const motDePasseInput = document.getElementById('motdepasse');
        const confirmerMotDePasseInput = document.getElementById('confirmermotdepasse');
        const message = document.getElementById('message');

        confirmerMotDePasseInput.addEventListener('input', () => {
            if (confirmerMotDePasseInput.value === motDePasseInput.value) {
                message.textContent = 'Les mots de passe correspondent.';
                message.style.color = 'green';
            } else {
                message.textContent = 'Les mots de passe ne correspondent pas.';
                message.style.color = 'red';
            }
        });
    </script>
</html>
