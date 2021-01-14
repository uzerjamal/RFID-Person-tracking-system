<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="../css/script1.js"></script>
  <script src="../css/script3.js"></script>
  <script src="../css/script4.js"></script>
</head>
<body>
<%@ include file="logout_header.jsp" %>
<%@ include file="sidebar.jsp" %>
    <br>
    <%
    String tag=null;
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
try{
  Connection connection = DriverManager.getConnection(connectionUrl, userid, password);
  PreparedStatement ps = connection.prepareStatement("SELECT * FROM student WHERE p_email = ?"); 
  ps.setString(1,username);
%>
<h1>&emsp;&emsp;&emsp;<u>Child recent activity</u></h1>
    
      <%
  ResultSet rs = ps.executeQuery();
  while(rs.next()){
    tag = rs.getString(1);
   PreparedStatement ps2 = connection.prepareStatement("SELECT * FROM log WHERE tag_id = ?");
   ps2.setString(1,tag);
    ResultSet rs2 = ps2.executeQuery();
    %>
    <div class="container mt-3">
    <br>
  <br>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th>Child Name</th>
        <th>Place</th>
        <th>Date &amp; Time</th>
      </tr>
    </thead>
    <tbody id="myTable">
    <%
    while(rs2.next()){
    
  %>
  
      <tr>
        <td><% out.println(rs.getString(2)); %></td>
        <td><% out.println(rs2.getString(2)); %> </td>
        <td><% out.println(rs2.getString(3)); %>  </td>
      </tr>

      <% }
      rs2.close();%>
      </tbody>
  </table>
    <hr style="display: block;
  margin-top: 0.5em;
  margin-bottom: 0.5em;
  margin-left: auto;
  margin-right: auto;
  border-style: inset;
  border-width: 5px;">
</div>
<%
}

rs.close();
  connection.close();
} catch (Exception e) {
  e.printStackTrace();
  out.println(e);
}

 %>
   
<script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
</script>
<%@ include file="footer.jsp" %>
</body>
</html>
