<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String user = request.getParameter("username");
String pass = request.getParameter("password");
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
ResultSet rs1 = null;
ResultSet rs2 = null;
try{
	int flag=0;
	connection = DriverManager.getConnection(connectionUrl, userid, password);
	statement = connection.createStatement();
	rs1 = statement.executeQuery("select * from parent");
	while(rs1.next()){
		if(rs1.getString(2).equals(user) && rs1.getString(3).equals(pass)){
			flag=1;
			session.setAttribute("user",user);
			session.setAttribute("type","parent");
			response.sendRedirect("parent/index.jsp");
		}
	}
	rs2 = statement.executeQuery("select * from admin");
	while(rs2.next()){
		if(rs2.getString(4).equals(user) && rs2.getString(5).equals(pass)){
			flag=2;
			session.setAttribute("user",user);
			session.setAttribute("type","admin");
			response.sendRedirect("admin/index.jsp");
		}
	}
	if(flag==0){
		response.sendRedirect("index.jsp");
	}
	connection.close();
} catch (Exception e) {
	e.printStackTrace();
	out.println(e);
}
%>
