package com.rfid.Demo;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import javax.swing.*;
import java.awt.event.*;
import java.sql.*;

public class App{
    JFrame frame;
    JLabel background;
    ImageIcon backGroundImage;
    JButton s1, s2, s3, s4;
    JButton mess, ground, classRoom, college, bus;
    int selectedStudentTag;
    ActionHandler handler;
    Statement statement;
    String lastLocation;
    
    //ChromeDriver driver;
	//ChromeOptions options;

	
    public App(){
        String driver = "com.mysql.jdbc.Driver";
        String connectionUrl = "jdbc:mysql://localhost:3306/rfid";
        String userid = "root";
        String password = "root";
        lastLocation = "";
        try {
            Class.forName(driver);
        } 
        catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Connection connection = null;
        try{
        connection = DriverManager.getConnection(connectionUrl, userid, password);
        statement = connection.createStatement();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        
        //initBrowser();

        frame = new JFrame();
        frame.setSize(1280,720);
        frame.setLayout(null);
        frame.setResizable(false);
        backGroundImage = new ImageIcon("D:/Background.png");
        background = new JLabel("", backGroundImage, JLabel.CENTER);
        background.setBounds(0,0,1280,720);
        frame.add(background);
        handler = new ActionHandler();
        
        s1 = new JButton(new ImageIcon("D:/StudentIcon.png"));
        s1.setBounds(1215, 630, 50, 50);
        s1.addActionListener(handler);
        frame.add(s1);

        s2 = new JButton(new ImageIcon("D:/StudentIcon.png"));
        s2.setBounds(1160, 630, 50, 50);
        s2.addActionListener(handler);
        frame.add(s2);

        s3 = new JButton(new ImageIcon("D:/StudentIcon.png"));
        s3.setBounds(1105, 630, 50, 50);
        s3.addActionListener(handler);
        frame.add(s3);

        s4 = new JButton(new ImageIcon("D:/StudentIcon.png"));
        s4.setBounds(1050, 630, 50, 50);
        s4.addActionListener(handler);
        frame.add(s4);

        mess = new JButton("");
        mess.setBounds(430,105,50,50);
        mess.addActionListener(handler);
        mess.setOpaque(false);
        frame.add(mess);

        ground = new JButton("");
        ground.setBounds(490,260,50,50);
        ground.addActionListener(handler);
        ground.setOpaque(false);
        frame.add(ground);

        classRoom = new JButton("");
        classRoom.setBounds(490,340,50,50);
        classRoom.addActionListener(handler);
        classRoom.setOpaque(false);
        frame.add(classRoom);

        college = new JButton("");
        college.setBounds(426,433,50,50);
        college.addActionListener(handler);
        college.setOpaque(false);
        frame.add(college);

        bus = new JButton("");
        bus.setBounds(843,512,50,50);
        bus.addActionListener(handler);
        bus.setOpaque(false);
        frame.add(bus);
        
        frame.setVisible(true);
    }

    class ActionHandler implements ActionListener{
        public void actionPerformed(ActionEvent event){
            if(event.getSource() == s1){
                selectedStudentTag = 84523;
            }

            if(event.getSource() == s2){
                selectedStudentTag = 84562;
            }
             if(event.getSource() == s3){
                selectedStudentTag = 8951;
            }
             if(event.getSource() == s4){
                selectedStudentTag = 44;
            }

            if(event.getSource() == mess){
                updateDB("Mess");
                
            }
            
            if(event.getSource() == ground){
                updateDB("Ground");
                //initNotification("Ground");
            }
            if(event.getSource() == classRoom){
                updateDB("Class Room");
                //initNotification("Class Room");
            }
            if(event.getSource() == college){
                updateDB("College");
                //initNotification("College");
            }
            if(event.getSource() == bus){
                updateDB("Bus");
                //initNotification("Bus");
            }
        }
    }
    
    public void updateDB(String loc){
    	ResultSet rs;
    	String blacklist = "";
    	String[] blacklistArr;
    	try {
    		rs = statement.executeQuery("SELECT blacklist FROM student WHERE tag_id='" + selectedStudentTag + "'");
    		while(rs.next()) {
    			blacklist = rs.getString("blacklist");
    		}
    	} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    	
    	if(!(blacklist == null)) {
    		System.out.println(blacklist);
    		blacklistArr = blacklist.split(",");
    		for(int i=0; i<blacklistArr.length; i++) {
    			blacklistArr[i] = blacklistArr[i].replace("_", " ");
        		if(blacklistArr[i].equals(loc)) {
        			System.out.println("Entered blacklisted location!!!");
        			//TODO Send notification to admin
        		}
        	}
    	}
    	
    	
    	
        try{
            statement.executeUpdate("UPDATE location SET place = '" + loc + "' WHERE tag_id = '" + selectedStudentTag + "'");
        }
        catch(Exception e){
            System.out.println(e);
        }
        System.out.println("Updated location of tag: " + selectedStudentTag + " to: " + loc);
    }

    /*public void initBrowser() {
    	System.setProperty("webdriver.chrome.driver","D:\\RfidDemo\\chromedriver.exe");
		options = new ChromeOptions();
		options.addArguments("user-data-dir=C:\\Users\\uzerj\\AppData\\Local\\Google\\Chrome\\User Data");
		options.setHeadless(false);
    	driver = new ChromeDriver(options);
    }*/
    
    /*public void initNotification(String location) {
    	if (selectedStudentTag == 84523){
    		sendNotification("Amit", location);
    	}
    	else if (selectedStudentTag == 84562){
    		sendNotification("Rohan", location);
    	}
    	else if (selectedStudentTag == 8951){
    		sendNotification("Manu", location);
    	}
    	else if (selectedStudentTag == 55){
    		sendNotification("Akash", location);
    	}
    }
    
    public void sendNotification(String name, String location) {
		
    	driver.get("https://console.firebase.google.com/u/1/project/notification-a2513/notification/compose?campaignId=388902872500726054&dupe=true");
		try {
			Thread.sleep(7500);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		WebElement textBox = driver.findElementByClassName("message-text");
		if(location.equals(lastLocation)) {
			textBox.sendKeys(name + " has left " + location + ".");
		}
		else{
			textBox.sendKeys(name + " has entered " + location + ".");
		}
		lastLocation = location;
		
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.findElementByCssSelector("Button[data-test-id=\"review-button\"]").click();
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.findElementByXPath("/html/body/div[4]/div[5]/div/mat-dialog-container/fcm-review-dialog/fire-review-dialog/fire-dialog/div[3]/div/button[2]").click();
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    */
    
    public static void main(String[] args){
        new App();
    }
}