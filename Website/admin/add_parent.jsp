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
String s = (String)session.getAttribute("new_parent");
if(s == "true"){
  session.setAttribute("new_parent",null);
  %>
<script type="text/javascript">
  alert("New parent added successfully!");
</script>
  <%
}else if(s=="false"){
   session.setAttribute("new_parent",null);
   %>
<script type="text/javascript">
  alert("New parent added failed!");
</script>

  <%
}
%>
    <br><br>
<form action="includes/add_parent.jsp">
  <div class="container">
    <h1>Add Parent</h1>
    <hr>
    <label for="name"><b>Name</b></label>
    <input type="text" placeholder="Enter name" name="name" required>
      
    <label for="contact"><b>Contact no.</b></label>
    <input type="text" placeholder="Enter contact no." name="contact" required>

    <label for="pwd"><b>Password</b></label>
    <input type="text" placeholder="Enter password" name="password" required>

    <button type="submit" class="registerbtn">Submit</button>
  </div>
  
  </form>
<%@ include file="footer.jsp" %>
</body>
</html>
