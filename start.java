import database.Database;
import simulation.Tag;

class start{
    public static void main(String[] args){
        Tag tag = new Tag();
        String[] id = tag.generateId(2);
        System.out.println(tag.generateId() + " " + tag.generateReaderNumber() + " " + tag.time());
        System.out.println("=====");
        for(int i=0; i<2; i++)
        System.out.println(id[i] + " " + tag.generateReaderNumber() + " " + tag.time());
        Database db = new Database();
        db.connect();
        //db.addUnallocatedTags(id);
        //db.addStudentRecord("5A", 25, "Legolas", "Wood Elves");
        db.assignTag("5A", "Legolas");
    }
}