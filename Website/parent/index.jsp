<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
    <style>
.card {
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
  transition: 0.3s;
    margin-left: auto;
    margin-right: auto;
    height: 300px;
  width: 300px;
}

.card:hover {
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
}

.container {
  padding: 2px 16px;
}
</style></head>
    <body>
    
<%@ include file="logout_header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%
String name=null;
int contact=0;
String username = (String)session.getAttribute("user");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/rfid";
String userid = "root";
String password = "root";
try {
  Class.forName(driver);
} catch (ClassNotFoundException e) {
  e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet rs = null;
try{
  connection = DriverManager.getConnection(connectionUrl, userid, password);
  statement = connection.createStatement();
  rs = statement.executeQuery("select * from parent");
  while(rs.next()){
    if(rs.getString(2).equals(username)){
      name = rs.getString(1);
      contact = rs.getInt(4);
    }
  }
  connection.close();
} catch (Exception e) {
  e.printStackTrace();
  out.println(e);
}
%>
        <div class="card">
  <img src="../profile.png" alt="Avatar" style="width:100%">
  <div class="container">
    <h4><b><% out.println(name); %></b></h4> 
    <p>Contact : <% out.println(contact); %></p> 
  </div>
</div>
        <br><br>
        
       <%@ include file="footer.jsp" %>
    </body>
</html>
