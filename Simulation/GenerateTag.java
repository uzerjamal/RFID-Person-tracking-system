import java.util.Random;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.sql.*;

class Database{
    private String user = "uzerjamal";
    private String pass = "zxcvb321";   //TODO ask password at run time to increase security
    private String dbDriver = "jdbc:mysql://db4free.net:3306/rfidproj";
    private Connection conn = null;

    void connect(){
        try {
            conn = DriverManager.getConnection(dbDriver, user, pass);
            System.out.println("connected");
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
        }
    }

    void addUnallocatedTags(String[] tag){
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

    /*void addStudentRecord(String studentClass, int rollNo, String studentName, String parentName){
        Statement stmt = null;
        try {
            stmt = conn.createStatement();
            stmt.executeUpdate("INSERT INTO Student_Details (Class, Roll_no, Student_name, Tag_Id, Parent_name, Parent_Id) 
                                VALUES ('" + tag[i] + "')"); //TODO
        }
        catch (SQLException ex){
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
    }
    System.out.println("Inserted values into the table Student Details");
    }*/
}

class Tag{

    private String[] generateTags(int numOfId){
        String[] id = new String[numOfId];
        Random rn = new Random();
        String batchNumber = "E2005176806060261";
        int firstHalf;
        String secondHalf = "";
        for(int i=0; i<numOfId; i++){
            firstHalf = (int) (rn.nextInt(9999 - 1000) + 1000);
            for(int j=0; j<3; j++){
                secondHalf+= (char)((int) rn.nextInt(90 - 65) + 65);
            }
            id[i] = batchNumber + firstHalf + secondHalf;
            secondHalf = "";
        }
        return id;
    }

    String[] generateId(int numOfId){
        String[] id = new String[numOfId];
        id = generateTags(numOfId);
        return id;
    }

    String generateId(){
        return generateTags(1)[0];
    }

    int generateReaderNumber(){
        Random rn = new Random();
        return (int)(rn.nextInt(5));
    }

    String time(){
        Date objDate = new Date();
        String strDateFormat = "hh:mm:ss a dd-MM-yyyy";
        SimpleDateFormat objSDF = new SimpleDateFormat(strDateFormat);

        return objSDF.format(objDate);
    }
}

class GenerateTag{
    public static void main(String[] args){
        Tag tag = new Tag();
        String[] id = tag.generateId(2);
        System.out.println(tag.generateId() + " " + tag.generateReaderNumber() + " " + tag.time());
        System.out.println("=====");
        for(int i=0; i<5; i++)
            System.out.println(id[i] + " " + tag.generateReaderNumber() + " " + tag.time());

        Database db = new Database();
        db.connect();
        db.addUnallocatedTags(id);
    }
}