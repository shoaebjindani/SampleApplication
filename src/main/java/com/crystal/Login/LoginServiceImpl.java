package com.crystal.Login;

import java.math.BigDecimal;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileUploadException;

import com.crystal.customizedpos.Configuration.ConfigurationDaoImpl;

import Frameworkpackage.CommonFunctions;
import Frameworkpackage.CustomResultObject;

public class LoginServiceImpl extends CommonFunctions {

	public LoginServiceImpl() {

	}

	public CustomResultObject validateLogin(HttpServletRequest request, Connection con) {
		CustomResultObject rs = new CustomResultObject();
		String returnString = "";

		try {
			String Username = request.getParameter("txtusername");
			String projectName = CommonFunctions.projectName;
			String Password = request.getParameter("txtpassword");
			LoginDaoImpl lObjLoginDao = new LoginDaoImpl();
			HashMap<String, String> loginDetails = lObjLoginDao.validateLoginUSingJDBC(Username, Password, con);
			if (loginDetails != null && !loginDetails.isEmpty() ) {
				Long user_id = Long.valueOf(loginDetails.get("user_id").toString());				
				List<String> roleIds = lObjLoginDao.getRoleIds(user_id, con);
				request.getSession().setAttribute("username", Username);
				request.getSession().setAttribute("userdetails", loginDetails);
				request.getSession().setAttribute("listOfRoles", roles);
				request.getSession().setAttribute("projectName", projectName);				
				
				returnString = "Succesfully Logged In";
			} else {
				returnString = "Invaid Username or password";
			}
		} catch (Exception e) {
			writeErrorToDB(e);
			rs.setHasError(true);
		}
		rs.setAjaxData(returnString);
		return rs;
	}

	



	public CustomResultObject Logout(HttpServletRequest request, Connection con) {
		CustomResultObject rs = new CustomResultObject();
		HashMap<String, Object> outputMap = new HashMap<>();
		try {
			request.getSession().invalidate();
			request.getSession().setAttribute("username", null);
			rs.setAjaxData("Logged Out Succesfully");
		} catch (Exception e) {
			writeErrorToDB(e);
			rs.setHasError(true);
		}
		rs.setReturnObject(outputMap);
		return rs;
	}
	ConfigurationDaoImpl lObjConfiguration = new ConfigurationDaoImpl();
	
	public CustomResultObject showHomePage(HttpServletRequest request, Connection con) {
		CustomResultObject rs = new CustomResultObject();
		HashMap<String, Object> outputMap = new HashMap<String, Object>();
		
		try {
			
			
		
			
			
			
			
			
			
				outputMap.putAll(getRetailDashboardData(request, con,outputMap));
				outputMap.put("lstVehicles",lObjConfiguration.getVehicleMaster(outputMap, con));

				rs.setViewName("../TradingDashboard.jsp");
		
			
		}
		catch(Exception e)
		{
			writeErrorToDB(e);
			e.printStackTrace();
		}
			rs.setReturnObject(outputMap);
			return rs;
				
			
	}
	
	public HashMap<String, Object> getRetailDashboardData(HttpServletRequest request, Connection con,HashMap<String, Object> outputMap) throws SQLException, ClassNotFoundException, ParseException
	{
		
		
			
			outputMap.putAll(lObjConfiguration.getDataForHomepage(outputMap,con));

			

			outputMap.put("todaysDate", getDateFromDB(con));
			
		
	return outputMap;

	}

	private HashMap<String, Object> calculateTotal(List<LinkedHashMap<String, Object>> paymentData,
			String[] columnNames) {
		HashMap<String, Object> calculatedDetails = new HashMap<>();
		for (HashMap<String, Object> hm : paymentData) {
			for (String s : columnNames) {
				if (calculatedDetails.get(s) == null) {
					calculatedDetails.put(s, hm.get(s));
				} else {
					BigDecimal Existingvalue = new BigDecimal(calculatedDetails.get(s).toString());
					
					String m=hm.get(s)==null?"0":hm.get(s).toString();
					BigDecimal newValue = new BigDecimal(m);
					newValue=newValue.add(Existingvalue) ;
					calculatedDetails.put(s, newValue);
				}
			}
		}
		return calculatedDetails;
	}

	public CustomResultObject showChangePassword(HttpServletRequest request, Connection con) {
		CustomResultObject rs = new CustomResultObject();
		HashMap<String, Object> outputMap = new HashMap<>();
		try {

			rs.setViewName("changePassword.jsp");
			rs.setReturnObject(outputMap);

		} catch (Exception e) {
			writeErrorToDB(e);
			rs.setHasError(true);
		}
		return rs;
	}

	public CustomResultObject changePassword(HttpServletRequest request, Connection con) throws FileUploadException {
		CustomResultObject rs = new CustomResultObject();
		HashMap<String, Object> outputMap = new HashMap<>();
		try {

			String oldPassword = URLDecoder.decode(request.getParameter("oldPassword"), "UTF-8");
			String newPassword = URLDecoder.decode(request.getParameter("newPassword"), "UTF-8");

			String username = request.getSession().getAttribute("username").toString();
			LoginDaoImpl loginDao = new LoginDaoImpl();
			HashMap<String, String> loginDetails = loginDao.validateLoginUSingJDBC(username, oldPassword, con);
			String message = "";
			if (loginDetails != null) {
				loginDao.changePassword(username, newPassword, con);
				message = "Password Changed Succesfully ";
			} else {
				message = "Invalid Old Password";
			}

			rs.setReturnObject(outputMap);
			rs.setAjaxData(message);

		} catch (Exception e) {
			writeErrorToDB(e);
			rs.setHasError(true);
		}
		return rs;
	}

}
