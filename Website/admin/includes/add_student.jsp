<%@page import="java.sql.*,java.util.*"%>
<%
String name = request.getParameter("name");
int r=Integer.valueOf(request.getParameter("roll"));
String s_class = request.getParameter("class");
String p_mail = request.getParameter("p_email");
String add = request.getParameter("address");
String gender = request.getParameter("gender");
String dob = request.getParameter("dob");
String[] blval = request.getParameterValues("bl");
String bl = "";
for (int i = 0; i < blval.length; i++) {
  bl += blval[i] + ","; 
}
session.setAttribute("p_mail",p_mail);
try
{
  String s="null";
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rfid", "root", "root");
 Statement stmt=conn.createStatement();
      ResultSet resultSet = stmt.executeQuery("select * from tags  limit 1");
      while(resultSet.next())
      {
        s = resultSet.getString(1);
      }

PreparedStatement st=conn.prepareStatement("insert into student values(?,?,?,?,?,?,?,?,?,?)");
    st.setString(1,s);
    st.setString(2,name);
    st.setInt(3,0);
    st.setString(4,add);
    st.setString(5,p_mail);
    st.setString(6,dob);
    st.setString(7,s_class);
    st.setString(8,gender);
    st.setInt(9,r);
    st.setString(10,bl);

int i=st.executeUpdate();
if(i>0){
  session.setAttribute("new_student","true");
}
else{
  session.setAttribute("new_student","false");
}

PreparedStatement st2=conn.prepareStatement("DELETE FROM tags WHERE tag_id = ? ");
  st2.setString(1,s);
i=st2.executeUpdate();

int n_child=0;
PreparedStatement st3=conn.prepareStatement("SELECT n_child FROM parent WHERE email = ?");
  st3.setString(1,p_mail);
ResultSet rs3=st3.executeQuery();
if(rs3.next()==true)
{
    n_child = rs3.getInt(1);
  PreparedStatement st4=conn.prepareStatement("UPDATE parent SET n_child=? WHERE email = ? ");
  st4.setInt(1,n_child+1);
  st4.setString(2,p_mail);
  i=st4.executeUpdate();
}
PreparedStatement st5=conn.prepareStatement("SELECT * FROM parent WHERE email = ?");
st5.setString(1,p_mail);
ResultSet rs5 = st5.executeQuery();
if(rs5.next()==false)
{
    response.sendRedirect("../add_parent.jsp");
}

conn.close();
response.sendRedirect("../add_student.jsp");
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>