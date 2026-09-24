package com.crystal.basecontroller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import Frameworkpackage.CommonFunctions;

public class sqlSlowQueriesEmailer {

	public static void main(String[] args) throws AddressException, MessagingException, InterruptedException, ClassNotFoundException, SQLException, IOException 
	{
		
			    

		
		
	        
	        
		Properties configProperties = new Properties();
		System.out.println("Current Working Directory is "+System.getProperty("user.dir"));
		System.out.println("configuration file should be  "+System.getProperty("user.dir")+"/Configuration.properties");
		
        InputStream inputStream =new FileInputStream(System.getProperty("user.dir")+"/Configuration.properties");
        configProperties.load(inputStream);
		
		
		System.out.println("Applcation Started");
		

		int ScanInterval=Integer.parseInt(configProperties.get("ScanInterval").toString());//repeated scans after every 60 seconds
		int maxAllowedTimeForQuery=Integer.parseInt(configProperties.get("maxAllowedTimeForQuery").toString());;  //any query that runs for more than 300 seconds will be slow Query
		
		
		
		
		CommonFunctions com=new CommonFunctions();
		CommonFunctions.queryLogEnabled=false;
		Connection con=com.getConnectionJDBC();
		//Connection con=com.getConnectionJDBC(host,mysqlUsername,mysqlPassword,port);
		
		
		ArrayList<Object> param=new ArrayList<>();
		
			while(true)
			{
				System.out.print("Application Waiting for "+ScanInterval+ " Seconds");
				Thread.sleep(ScanInterval*1000);				
				System.out.println("Firing this query");
				System.out.println("select * from information_schema.processlist where  COMMAND!='sleep' and  time > "+maxAllowedTimeForQuery);
				List<LinkedHashMap<String, Object>> i=com.getListOfLinkedHashHashMap(param, "select * from information_schema.processlist where COMMAND!='sleep' and time > "+maxAllowedTimeForQuery, con);
				System.out.println("Number Of Queries Found"+i.size());
				for(LinkedHashMap<String, Object> hm: i)
				{
					System.out.println("Sending Email for " +hm.get("INFO")+ " " + hm.get("TIME") + new Date() ); 
					//com.sendMessage(toAddress,hm.get("INFO").toString(), "Slow Query at "+new Date(),fromAddress,fromPassword);
				}
				
						
			}
		
		


	}

}
