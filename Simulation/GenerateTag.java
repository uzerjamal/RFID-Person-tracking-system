import java.util.Random;
import java.util.Date;
import java.text.SimpleDateFormat;

class Generate{
    private String[] generateTagId(int numOfId){
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
        id = generateTagId(numOfId);
        return id;
    }

    String generateId(){
        return generateId(1)[0];
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
        String[] id = tag.generateId(5);
        System.out.println(tag.generateId() + " " + tag.readerNumber() + " " + tag.time());
        System.out.println("=====");
        for(int i=0; i<5; i++)
            System.out.println(id[i] + " " + tag.readerNumber() + " " + tag.time());
        
        //for(int i=0; i<20; i++){
            //String generatedTag = tag.generateId();
            //int readerNum = tag.readerNumber();
            //String time = tag.time();
            //System.out.println(generatedTag + "\t" + readerNum + "\t" + time);
        //}
    }
}