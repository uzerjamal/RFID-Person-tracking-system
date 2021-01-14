<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
String username = (String)session.getAttribute("user");
String update = (String)session.getAttribute("update_profile");
if(update=="true"){
%>

<script>
  alert("Profile updated!");
</script>

<%
}
else if(update == "false"){
 
%>
<script>
  alert("Profile not updated!");
</script>
<% 
}

%>

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
String prev_name=null , prev_contact=null,prev_address=null,prev_pwd=null;
String name = request.getParameter("name");
String address = request.getParameter("address");
String contact = request.getParameter("contact");
String new_password = request.getParameter("password");
if(!(new_password==null && name==null && address==null && contact==null)){
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
    PreparedStatement ps = connection.prepareStatement("SELECT * FROM admin WHERE email=?");
    ps.setString(1,username);
    ResultSet rs = ps.executeQuery();
    while(rs.next()){
      prev_name = rs.getString(1);
      prev_address = rs.getString(2);
      prev_pwd = rs.getString(5);
      prev_contact = rs.getString(3);
    }
    PreparedStatement ps2 = connection.prepareStatement("UPDATE admin SET name=?,address=?,contact=?,password=?  WHERE email = ?");
    if(name==null){
      ps2.setString(1,prev_name);
    }else{
    ps2.setString(1,name);
  }
    if(address==null){
      ps2.setString(2,prev_address);
    }else{
    ps2.setString(2,address);
  }
    if(contact==null){
      ps2.setString(3,prev_contact);
    }else{
    ps2.setString(3,contact);
  }
    if(new_password==null){
      ps2.setString(4,prev_pwd);
    }else{
    ps2.setString(4,new_password);
  }
    ps2.setString(5,username);
    int i = ps.executeUpdate();
    if(i>0){
    session.setAttribute("update_profile","true");
}
else{
session.setAttribute("update_profile","false");
}
    connection.close();
  } catch (Exception e) {
      e.printStackTrace();
      out.println(e);
    }
  }
%>

    <br>
<form method="post" action="update_profile.jsp">
  <div class="container">
    <h1><u>Update Profile</u></h1>
    <hr>  
         
      <label for="name"><b>Name</b></label>
    <input type="text" placeholder="Enter name"  name="name" >

    <label for="address"><b>Address</b></label>
    <input type="text" placeholder="Enter address"  name="address" >

    <label for="contact"><b>Contact no.</b></label>
    <input type="text" placeholder="Enter contact number"  name="contact">

    <label for="password"><b>Password</b></label>
    <input type="password" placeholder="Enter password" name="password">
    <p>** Fill only those fields which are needed to be update </p>
         <button type="submit" class="registerbtn">Update</button>

  </div>
  </form>

<%@ include file="footer.jsp" %>


</body>
</html>
