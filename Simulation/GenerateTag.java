import java.util.Random;
import java.util.Arrays;
import java.util.Date;
import java.text.SimpleDateFormat;

class Generate{
    String generateId(){
        Random rn = new Random();
        String batchNumber = "E2005176806060261";
        int firstHalf = (int) (rn.nextInt(9999 - 1000) + 1000);
        String secondHalf = "";
        secondHalf+= (char)((int) rn.nextInt(90 - 65) + 65);
        String id = batchNumber + firstHalf + secondHalf;
        return id;}
    String[] generateId(int u){
        String id[] = new String[u];
        Random rn = new Random();
        String batchNumber = "E2005176806060261";
        String secondHalf = "";
        for(int i=0; i<id.length; i++){
            int firstHalf = (int) (rn.nextInt(9999 - 1000) + 1000);
            for(int h = 0 ; h  <= id.length;h++){
                secondHalf+= (char)((int) rn.nextInt(90 - 65) + 65);}
                id[i] = batchNumber + firstHalf + secondHalf;
                secondHalf="";
        }
   
        return id;
    }
}
class java{
    public static void main(String[] args){
        Generate tag = new Generate();
       String generatedTag1[]=new String[5];
       String[] id = tag.generateId(5);
for(int l = 0 ; l <5 ; l ++){
            System.out.println(id[l] );}
}        }
    
