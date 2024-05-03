<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="businessLayer.UserNotificationManager " %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.sql.*" %>



<%
    HttpSession jsession = request.getSession(false);
    String authenticatedUser = (jsession != null) ? (String) jsession.getAttribute("authenticatedUser") : null;
    String nomcomplet=null;
    String image=null;
    int id=0;
    // If the user is not authenticated, redirect to the login page
    if (authenticatedUser == null) {
        response.sendRedirect("/TPl/PageAuthentificationUser.jsp");
    }
    else{
    	   nomcomplet = (jsession != null) ? (String) jsession.getAttribute("nomcomplet") : null;
    	   image = (jsession != null) ? (String) jsession.getAttribute("image") : null;
    	   id = (jsession != null) ? (int) jsession.getAttribute("id") : null;
    	int sessionTimeoutInSeconds =1800; 
    jsession.setMaxInactiveInterval(sessionTimeoutInSeconds);}
%>
<% 
UserNotificationManager managerNot=new UserNotificationManager();
ArrayList<User_Notifications> not=new ArrayList<User_Notifications>();
not= managerNot.getNot(id);
Hashtable<Integer,String> notifications= new Hashtable<Integer,String>();
for(int i=0;i<not.size();i++) 
{
 notifications.put(not.get(i).getId(),not.get(i).getNotification());
 System.out.println(not.get(i).getNotification());
 
 }

int unreadCount = notifications.size(); %>

<%     
ArrayList<User_Notifications> not2=new ArrayList<User_Notifications>();
not2= managerNot.getNotReaded(id);
Hashtable<Integer,String> notreaded= new Hashtable<Integer,String>();
for(int i=0;i<not2.size();i++) 
{
	notreaded.put(not2.get(i).getId(),not2.get(i).getNotification());

 }

 %>