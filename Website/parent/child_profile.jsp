<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="../css/style1.css">
  <script src="../css/script1.js"></script>
  <script src="../css/script3.js"></script>
  <script src="../css/script4.js"></script>
 <style>
body {
  font-family: Arial, Helvetica, sans-serif;
  background-color: black;
}

* {
  box-sizing: border-box;
}

/* Add padding to containers */
.container {
  padding: 16px;
  background-color: white;
}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

/* Overwrite default styles of hr */
hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}

/* Set a style for the submit button */
.registerbtn {
  background-color: #4CAF50;
  color: white;
  padding: 16px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  opacity: 0.9;
}

.registerbtn:hover {
  opacity: 1;
}

/* Add a blue text color to links */
a {
  color: dodgerblue;
}

/* Set a grey background color and center the text of the "sign in" section */
.signin {
  background-color: #f1f1f1;
  text-align: center;
}
</style>
</head>
<body>
<%@ include file="logout_header.jsp" %>
<%@ include file="sidebar.jsp" %>
    <br><br>
    <h1>&emsp;&emsp;&emsp;<u>Child Profile</u></h1>

    <form>
    <%
    String tag=null,location=null;
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
Statement statement2 = null;
ResultSet rs = null;
ResultSet rs2= null;
try{
  connection = DriverManager.getConnection(connectionUrl, userid, password);
  statement = connection.createStatement();
statement2 = connection.createStatement();
  %>

  <%
  rs = statement.executeQuery("select * from student");
  while(rs.next()){
    if(rs.getString(5).equals(username)){
    tag = rs.getString(1);
    

  %>

    <div class="container">
    <hr>
    <label for="name"><b>Name</b></label>
    <input type="text" placeholder="<% out.println(rs.getString(2)); %>" name="name" readonly>

    <label for="roll_no"><b>Roll no.</b></label>
    <input type="text" placeholder="<% out.println(rs.getInt(9)); %>" name="roll" readonly>

    <label for="class"><b>Class and section</b></label>
    <input type="text" placeholder="<% out.println(rs.getString(7)); %>" name="class" readonly>
    
    <label for="location"><b>Last location</b></label>
    <input type="text" placeholder="
    <% 
    rs2 = statement2.executeQuery("select * from location");
    while(rs2.next()){
      if(rs2.getString(1).equals(tag)){
        out.println(rs2.getString(2)); 
      }
    }
    rs2.close();
  %>
  " name="location" readonly>       
 
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
}
rs.close();
  connection.close();
} catch (Exception e) {
  e.printStackTrace();
  out.println(e);
}
%>

    </form>

   <%@ include file="footer.jsp" %>
</body>
</html>
