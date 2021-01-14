<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
String name = request.getParameter("name");
String address = request.getParameter("address");
String contact = request.getParameter("contact");
String email = request.getParameter("username");
String pass = request.getParameter("password");
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
try{
  connection = DriverManager.getConnection(connectionUrl, userid, password);
  PreparedStatement ps = connection.prepareStatement("INSERT INTO admin VALUES(?,?,?,?,?)");
  ps.setString(1,name);
  ps.setString(2,address);
  ps.setString(3,contact);
  ps.setString(4,email);
  ps.setString(5,pass);
  int i = ps.executeUpdate();
  if(i>0){
  session.setAttribute("new_admin","true");
}
else{
  session.setAttribute("new_admin","false");
}
  connection.close();
   response.sendRedirect("../new_admin.jsp");
} catch (Exception e) {
  e.printStackTrace();
  out.println(e);
}
  %>