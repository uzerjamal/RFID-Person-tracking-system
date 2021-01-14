<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>

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
<%
int confirm_update = 0;
String tag = request.getParameter("tag");
if(tag!=null){
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
try{
  connection = DriverManager.getConnection(connectionUrl, userid, password);
  PreparedStatement ps = connection.prepareStatement("DELETE FROM tags where tag_id = ?");
  ps.setString(1,tag);
  int i = ps.executeUpdate();
  if(i>0){
  confirm_update=1;
%>
<script>
  alert("Tag deleted successfully!");
</script>
<%
}
else{
%>
<script>
  alert("Tag cannot be deleted!");
</script>
<%

}
  connection.close();

} catch (Exception e) {
  e.printStackTrace();
  out.println(e);
}
}
  %>

    <br>
<form method="post" action="delete_tag.jsp">
  <div class="container">
    <h1><u>Delete Tags</u></h1>
    <hr>  
         
      <label for="tag"><b>Tag id</b></label>
    <input type="text" placeholder="Enter tag id"  name="tag" >

         <button type="submit" class="registerbtn">Delete</button>


  </div>
  </form>
<%@ include file="footer.jsp" %>
</body>
</html>
