import java.util.Random;
import java.util.Date;
import java.text.SimpleDateFormat;

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
        Date objDate = new Date();
        String strDateFormat = "hh:mm:ss a dd-MM-yyyy";
        SimpleDateFormat objSDF = new SimpleDateFormat(strDateFormat);

        return objSDF.format(objDate);
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