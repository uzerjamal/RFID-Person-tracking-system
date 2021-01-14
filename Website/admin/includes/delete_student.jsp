<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
int confirm_update = 0;
String tag = request.getParameter("tag");
String email = request.getParameter("email");
try{
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rfid", "root", "root");
  PreparedStatement ps = conn.prepareStatement("DELETE FROM student where tag_id = ?");
  ps.setString(1,tag);
  int i = ps.executeUpdate();
  if(i>0){
session.setAttribute("delete_student","true");
}
else{
session.setAttribute("delete_student","true");
}
int n_child=0;
PreparedStatement st3=conn.prepareStatement("SELECT n_child FROM parent WHERE email = ?");
  st3.setString(1,email);
ResultSet rs3=st3.executeQuery();
  while(rs3.next())
  {
    n_child = rs3.getInt(1);
  }
  if(n_child>=2)
    {
      n_child = n_child - 1;
      PreparedStatement st4=conn.prepareStatement("UPDATE parent SET n_child=? WHERE email = ? ");
      st4.setInt(1,n_child);
      st4.setString(2,email);
      i=st4.executeUpdate();
    }
    else{
    PreparedStatement st5=conn.prepareStatement("DELETE FROM parent WHERE email = ? ");
  st5.setString(1,email);
i=st5.executeUpdate();
  }
  conn.close();
response.sendRedirect("../delete_student.jsp");
} catch (Exception e) {
  e.printStackTrace();
  out.println(e);
}
  %>