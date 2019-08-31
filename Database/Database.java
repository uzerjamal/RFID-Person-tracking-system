package database;

import java.util.Calendar;
import java.util.Random;
import java.sql.*;

public class Database{
    private String user = "uzerjamal";
    private String pass = "zxcvb321";   //TODO ask password at run time(in constructor) to increase security
    private String dbDriver = "jdbc:mysql://db4free.net:3306/rfidproj";
    private Connection conn = null;

    public void connect(){
        try {
            conn = DriverManager.getConnection(dbDriver, user, pass);
            System.out.println("connected");
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
        }
    }

    public void addUnallocatedTags(String[] tag){
        Statement stmt = null;
        for(int i = 0; i<tag.length; i++){
            try {
                stmt = conn.createStatement();
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
    
    public void addStudentRecord(String studentClass, int rollNo, String studentName, String parentName){
        Statement stmt = null;
        String insertQuery = String.format("INSERT INTO Student_Details " +
        "(Class, Roll_no, Student_name, Parent_name, Parent_Id) " +
        "VALUES ('%s', %s, '%s', '%s', '%s');", studentClass, rollNo, studentName, parentName, generateParentId());
        try {
            stmt = conn.createStatement();
            stmt.executeUpdate(insertQuery);
        }
        catch (SQLException ex){
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
    }
}