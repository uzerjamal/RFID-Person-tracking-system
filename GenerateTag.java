import java.util.Random;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
class Generate{
    String generateId(){
        Random rn = new Random();
        String batchNumber = "E2005176806060261";
        int firstHalf = (int) (rn.nextInt(9999 - 1000) + 1000);
        String secondHalf = "";
        for(int i=0; i<3; i++){
            secondHalf+= (char)((int) rn.nextInt(90 - 65) + 65);
        }
        String id = batchNumber + firstHalf + secondHalf;
        return id;
    }
    int readerNumber(){
        Random rn = new Random();
        return (int)(rn.nextInt(5));
    }
    String time(){
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
        Generate tag = new Generate();
        for(int i=0; i<20; i++){
            String generatedTag = tag.generateId();
            int readerNum = tag.readerNumber();
            String time = tag.time();
            System.out.println(generatedTag + "\t" + readerNum + "\t" + time);
        }
    }
}