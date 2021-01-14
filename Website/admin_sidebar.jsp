<!DOCTYPE html>
<html>
<title>W3.CSS</title>
<meta name="viewport" content="width=device-width, initial-scale=1"><style>
body {
  font-family: "Lato", sans-serif;
}

.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

.sidenav a:hover {
  color: #f1f1f1;
}

.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>
<body>
<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="admin/index.jsp">Home</a>
    <hr>
  <a>Students</a>
  <a href="admin/add_student.jsp"> - Add student</a>
      <a href="admin/delete_student.jsp"> - Delete student</a>
    <hr>
    <a>Tags</a>
  <a href="admin/add_tag.jsp"> - Add Tag</a>
      <a href="admin/delete_tag.jsp"> - Delete Tag</a>
 <hr>
    <a href="admin/search.jsp">Search</a>
</div>
<!-- Page Content -->
<div class="w3-teal">
 <span style="font-size:30px;cursor:pointer" onclick="openNav()">&nbsp; &#9776; </span>
</div>

<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>
     
</body>
</html> 
