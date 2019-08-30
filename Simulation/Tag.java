package simulation;

import java.util.Random;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

public class Tag{
    private String[] generateTags(int numOfId){
        String[] id = new String[numOfId];
        Random rn = new Random();
        String batchNumber = "E2005176806060261";
        int firstHalf;
        String secondHalf = "";
        for(int i=0; i<numOfId; i++){
            firstHalf = (int) ( rn.nextInt(9999 - 1000) + 1000);
            for(int j=0; j<3; j++){
                secondHalf+= (char)((int) rn.nextInt(90 - 65) + 65);            
            }
            id[i] = batchNumber + firstHalf + secondHalf;
            secondHalf = "";
          }
        return id; 
}

    public String[] generateId(int numOfId){
        String[] id = new String[numOfId];
        id = generateTags(numOfId);
        return id; 
    }

    public String generateId(){
        return generateTags(1)[0];    
    }

    public int generateReaderNumber(){
        Random rn = new Random();
        return (int)(rn.nextInt(5));  
    }
  
    public String time(){
        String hour="";
        String minute ="";
        String second ="";
        Random rand = new Random();
        second = String.valueOf(rand.nextInt((60-0)+1)+0);
        minute =  String.valueOf(rand.nextInt((60-0)+1)+0);
        hour= String.valueOf(rand.nextInt((13-8)+1)+8);
        String toTimeString = hour+":"+minute+":"+second;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        LocalDateTime localDate = LocalDateTime.now();
        return (toTimeString+ " " + dtf.format(localDate));
    }
}

