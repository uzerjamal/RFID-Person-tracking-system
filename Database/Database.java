package database;

import java.util.Calendar;
import java.util.Random;
import java.sql.*;

public class Database{
    private String user = "uzerjamal";
    private String pass = "zxcvb321";   //TODO ask password at run time(in constructor) to increase security
    private String dbDriver = "jdbc:mysql://db4free.net:3306/rfidproj";
    private Connection conn = null;
    private Statement stmt = null;

    public void connect(){
        try {
            conn = DriverManager.getConnection(dbDriver, user, pass);
            System.out.println("connected");
            stmt = conn.createStatement();
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
        }
    }

    public void addUnallocatedTags(String[] tag){
        for(int i = 0; i<tag.length; i++){
            try {
                stmt.executeUpdate("INSERT INTO Unallocated_Tags (TagID) VALUES ('" + tag[i] + "')");
            }
            catch (SQLException ex){
                System.out.println("SQLException: " + ex.getMessage());
                System.out.println("SQLState: " + ex.getSQLState());
                System.out.println("VendorError: " + ex.getErrorCode());
            }
        }
        System.out.println("Inserted values into the table Unallocated_Tags");
    }

    //TODO: Ensure that the generated ID doesn't already exist.
    public String generateParentId(){
        Random rn = new Random();
        return Calendar.getInstance().get(Calendar.YEAR) + String.valueOf(rn.nextInt(99999));
    }

    public void assignTag(String studentClass, String studentName){
        String sql = "SELECT TagID FROM Unallocated_Tags LIMIT 1";
        String tag = "TEST";
        ResultSet tagQuery = null;
        try{
            tagQuery = stmt.executeQuery(sql);
            tagQuery.next();
            tag = tagQuery.getString("TagID");
        }
        catch(Exception e){System.out.println(e);}
        sql = "UPDATE Student_Details SET Tag_Id='" + tag +"' WHERE Student_name='"+ studentName +"' AND Class='"+ studentClass + "'";
        try{
            stmt.executeUpdate(sql);
        }
        catch(SQLException ex){
            System.out.println(ex);
        }
        System.out.println(tag);
    }
    
    public void addStudentRecord(String studentClass, int rollNo, String studentName, String parentName){
        Statement stmt = null;
        String insertQuery = String.format("INSERT INTO Student_Details " +
        "(Class, Roll_no, Student_name, Parent_name, Parent_Id) " +
        "VALUES ('%s', %s, '%s', '%s', '%s');", studentClass, rollNo, studentName, parentName, generateParentId());
        try {

            stmt.executeUpdate(insertQuery);
        }
        catch (SQLException ex){
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
    }
}