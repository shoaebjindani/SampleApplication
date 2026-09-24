package com.crystal.Login;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import Frameworkpackage.CommonFunctions;

public class LoginDaoImpl  extends CommonFunctions
{
	
	CommonFunctions cf=new CommonFunctions(); 
	
	public HashMap<String,String> validateLoginUSingJDBC(String Username,String Password,Connection con) throws SQLException, ClassNotFoundException
	{
		ArrayList<Object> parameters=new ArrayList<>();
		parameters.add(Username);
		parameters.add(cf.getSHA256String(Password));
		
		parameters.add(Username);
		parameters.add(cf.getSHA256String(Password));
		
		return getMap(parameters, "SELECT user.name,user.user_id,user.username FROM "
				+ " tbl_user_mst user  " +
				" where ((username=? and password=?) or (mobile=? and password=?)) and user.activate_flag=1 ", con);
	}

	public void changePassword(String username, String newPassword, Connection con) throws Exception 
	{
		 try
		 {				 
			String insertTableSQL = "UPDATE tbl_user_mst set password=?,updated_date=sysdate() WHERE username=?";
			
			PreparedStatement preparedStatement = con.prepareStatement(insertTableSQL);
			preparedStatement.setString(1, cf.getSHA256String(newPassword));
			preparedStatement.setString(2, username);
			preparedStatement.executeUpdate();
			
			if (preparedStatement != null) 
			{
				preparedStatement.close();
			}
			
		 }
		 catch(Exception e)
		 {
			 //write to error log
			 writeErrorToDB(e);
			 throw e;
		 }
	}
	

	
	
	public void changePasswordByEmailId(String emailid, String newPassword, Connection con) throws Exception 
	{
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(cf.getSHA256String(newPassword));		
		parameters.add(emailid);
		insertUpdateDuablDB("UPDATE tbl_user_mst set password=?,updated_date=sysdate() WHERE email=?", parameters,
				con);
	}
	


}


