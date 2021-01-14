<%@page import="java.sql.*,java.util.*"%>
<%
String name = request.getParameter("name");
String contact = request.getParameter("contact");
String password = request.getParameter("password");
String p_mail = (String)session.getAttribute("p_mail");
try
{
  String s="null";
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rfid", "root", "root");
PreparedStatement st=conn.prepareStatement("insert into parent values(?,?,?,?,?)");
  st.setString(1,name);
    st.setString(2,p_mail);
    st.setString(3,password);
    st.setString(4,contact);
    st.setInt(5,1);

int i=st.executeUpdate();
if(i>0){
  session.setAttribute("new_parent","true");
}
else{
  session.setAttribute("new_parent","false");
}

    response.sendRedirect("../add_parent.jsp");
conn.close();
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>