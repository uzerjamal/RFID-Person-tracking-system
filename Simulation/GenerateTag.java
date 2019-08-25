import java.util.Random;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

class Tag
{
   private String[] generateTags(int numOfId)
   {
        String[] id = new String[numOfId];
        Random rn = new Random();
        String batchNumber = "E2005176806060261";
        int firstHalf;
        String secondHalf = "";
        for(int i=0; i<numOfId; i++){
            firstHalf = (int) ( rn.nextInt(9999 - 1000) + 1000);
            for(int j=0; j<3; j++){
                secondHalf+= (char)((int) rn.nextInt(90 - 65) + 65);            }
            id[i] = batchNumber + firstHalf + secondHalf;
            secondHalf = "";
          }
        return id; 
}

 String[] generateId(int numOfId)
        {
            String[] id = new String[numOfId];
            id = generateTags(numOfId);
            return id; 
       }
String generateId()
        {
            return generateTags(1)[0];    
        }

int generateReaderNumber()
      {
        Random rn = new Random();
        return (int)(rn.nextInt(5));  
      }
String time()
      {
         String i="null";
      String j ="null";
      String k ="null";
      Random r2 = new Random();
      int h = r2.nextInt((13-8)+1)+8;
      int min = r2.nextInt((60-0)+1)+0;
      int sec = r2.nextInt((60-0)+1)+0;
      j = String.valueOf(sec);
      k =  String.valueOf(min);
      i = String.valueOf(h);
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
  LocalDateTime localDate = LocalDateTime.now();
         
      return (i+":"+j+":"+k+"  "+dtf.format(localDate));

      }
    }
class GenerateTag{
    public static void main(String[] args){
        Tag tag = new Tag();
        String[] id = tag.generateId(5);
        System.out.println(tag.generateId() + " " + tag.generateReaderNumber() + " " + tag.time());
        System.out.println("=====");
        for(int i=0; i<5; i++)
            System.out.println(id[i] + " " + tag.generateReaderNumber() + " " + tag.time());
        /*Database db = new Database(); / 
        db.connect();//
                db.addUnallocatedTags(id);*/    }}
