<%@ page import="aad.b2c.AuthManager" %>
<%@ page import="java.util.Enumeration" %>

<%--
  Created by IntelliJ IDEA.
  User: brise
  Date: 2/16/2016
  Time: 1:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
  <head>
    <title>Hello Azure Active Directory</title>
  </head>
  <body>
  <h1>https://javab2c2.alexandrebrisebois.com</h1>
    <%
      AuthManager manager = new AuthManager("alexandrebriseboisb2c","6a80440d-6c63-412e-80ed-2470d1d48046","https://javab2c2.alexandrebrisebois.com");
      manager.Load(request);
    %>
    <div>
    <% if(manager.IsSignedSin()){ %>
    You are Logged in - <a href="<%=manager.getEditProfileUri()%>">Edit Profile</a>
    <% }else{ %>
    <a href="<%=manager.getSignInUri()%>">Sign In</a> -  <a href="<%=manager.getSignUpUri()%>">Sign Up</a>
    <% }  %></div>
    <div>
     <%
         Enumeration params = request.getParameterNames();
         while(params.hasMoreElements()){
             String paramName = (String)params.nextElement();
             %>
    <p><%=(paramName + " = " + request.getParameter(paramName))%></p>
    <% } %>
    </div>
    <div>
        <%= manager.getJwtJson()%>
    </div>

  </body>
</html>