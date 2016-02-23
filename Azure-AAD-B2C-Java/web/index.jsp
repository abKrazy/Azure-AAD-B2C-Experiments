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
    <%
      AuthManager manager = new AuthManager("alexandrebriseboisb2c","434c374e-d772-49e5-923e-26c870850098","http://localhost:8080/");
      manager.Load(request);
    %>
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
    <% if(manager.IsSignedSin()){ %>
    Logged in
    <% }else{ %>
        <a href="<%=manager.getSignInUri()%>">Sign In</a>
    <% }  %>
  </body>
</html>