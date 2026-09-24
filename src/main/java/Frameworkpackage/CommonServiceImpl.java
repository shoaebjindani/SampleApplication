package Frameworkpackage;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.SQLException;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;



public class CommonServiceImpl extends CommonFunctions {

    CommonDaoImpl lobjCommonDaoImpl=new CommonDaoImpl();
    public CustomResultObject showReport(HttpServletRequest request,Connection con) throws SQLException
	{
	 	CustomResultObject rs=new CustomResultObject();
		
	 	HashMap<String, Object> outputMap=new HashMap<>();			
		
		String report_id=request.getParameter("report_id")==null?"":request.getParameter("report_id");
		String exportFlag= request.getParameter("exportFlag")==null?"":request.getParameter("exportFlag");
		String DestinationPath=request.getServletContext().getRealPath("BufferedImagesFolder")+"/";	
		String userId=((HashMap<String, String>) request.getSession().getAttribute("userdetails")).get("user_id");
		String appId=((HashMap<String, String>) request.getSession().getAttribute("userdetails")).get("app_id");
		

		try
	 	{   
			LinkedHashMap reportDetails=lobjCommonDaoImpl.getReportdetails(report_id,con);
			outputMap.put("app_id", appId);

		LinkedHashMap<String, Object> defaultParameterValues=new LinkedHashMap<>();

		for(LinkedHashMap<String, Object> param:(List<LinkedHashMap<String,Object>>) reportDetails.get("paramtersWithOptions"))
		{
			var parameterValue=request.getParameter(param.get("parameter_form_id").toString());
			if(parameterValue==null &&  param.get("parameter_type").equals("date") && param.get("default_value").equals("~todaysdate"))
			{
				String dateFromDB=getDateFromDB(con);
				outputMap.put(param.get("parameter_form_id").toString(),dateFromDB);	
				defaultParameterValues.put(param.get("parameter_form_id").toString(),dateFromDB);
			}
			else if(parameterValue==null &&  param.get("parameter_type").equals("select"))
			{
				outputMap.put(param.get("parameter_form_id").toString(),param.get("default_value").toString());	
				defaultParameterValues.put(param.get("parameter_form_id").toString(), param.get("default_value").toString());
			}
			else
			{
				outputMap.put(param.get("parameter_form_id").toString(), request.getParameter(param.get("parameter_form_id").toString()));
			}
		}

		

		
		Class<?>[] paramString = new Class[2];
			paramString[0] = HashMap.class;
			paramString[1] = Connection.class;

		Class<?> cls = Class.forName(reportDetails.get("class_name").toString());
			Object obj = cls.newInstance();
			//Thread.sleep(4000);
			Method method = cls.getDeclaredMethod(reportDetails.get("method_name").toString(), paramString);
			
			
			
			List<LinkedHashMap<String, Object>> reportData =  (List<LinkedHashMap<String, Object>>) method.invoke(obj,outputMap, con);

		 //lObjConfigDao.getWPOStatistics(outputMap,con);


		
		
		reportDetails.put("reportData", reportData);
		outputMap.put("defaultParameterValues", defaultParameterValues);
		
		if(!exportFlag.isEmpty())
				{				
					List<String> columnNames=lobjCommonDaoImpl.getListOfColumns(report_id,con);
					outputMap = getCommonFileGenerator(columnNames.toArray(new String[0]),reportData,exportFlag,DestinationPath,userId,reportDetails.get("report_name").toString(),reportDetails.get("report_name").toString());
				}
				else
				{			
					outputMap.put("reportDetails", reportDetails);
					rs.setViewName("Reports.jsp");		
				}
		rs.setReturnObject(outputMap);

	 	}
	 	catch (Exception e)
	 	{
			writeErrorToDB(e);
			rs.setHasError(true);
		}		
		return rs;
	}


	public CustomResultObject showReportWithoutLogin(HttpServletRequest request,Connection con) throws SQLException
	{
	 	CustomResultObject rs=new CustomResultObject();
		
	 	HashMap<String, Object> outputMap=new HashMap<>();			
		
		String report_id=request.getParameter("report_id")==null?"":request.getParameter("report_id");
		String exportFlag= request.getParameter("exportFlag")==null?"":request.getParameter("exportFlag");
		String DestinationPath=request.getServletContext().getRealPath("BufferedImagesFolder")+"/";	
		//String userId=((HashMap<String, String>) request.getSession().getAttribute("userdetails")).get("user_id");
		//String appId=((HashMap<String, String>) request.getSession().getAttribute("userdetails")).get("app_id");
		

		try
	 	{   
			LinkedHashMap reportDetails=lobjCommonDaoImpl.getReportdetails(report_id,con);
			//outputMap.put("app_id", appId);

		LinkedHashMap<String, Object> defaultParameterValues=new LinkedHashMap<>();

		for(LinkedHashMap<String, Object> param:(List<LinkedHashMap<String,Object>>) reportDetails.get("paramtersWithOptions"))
		{
			var parameterValue=request.getParameter(param.get("parameter_form_id").toString());
			if(parameterValue==null &&  param.get("parameter_type").equals("date") && param.get("default_value").equals("~todaysdate"))
			{
				String dateFromDB=getDateFromDB(con);
				outputMap.put(param.get("parameter_form_id").toString(),dateFromDB);	
				defaultParameterValues.put(param.get("parameter_form_id").toString(),dateFromDB);
			}
			else if(parameterValue==null &&  param.get("parameter_type").equals("select"))
			{
				outputMap.put(param.get("parameter_form_id").toString(),param.get("default_value").toString());	
				defaultParameterValues.put(param.get("parameter_form_id").toString(), param.get("default_value").toString());
			}
			else
			{
				outputMap.put(param.get("parameter_form_id").toString(), request.getParameter(param.get("parameter_form_id").toString()));
			}
		}

		

		
		Class<?>[] paramString = new Class[2];
			paramString[0] = HashMap.class;
			paramString[1] = Connection.class;

		Class<?> cls = Class.forName(reportDetails.get("class_name").toString());
			Object obj = cls.newInstance();
			//Thread.sleep(4000);
			Method method = cls.getDeclaredMethod(reportDetails.get("method_name").toString(), paramString);
			
			
			
			List<LinkedHashMap<String, Object>> reportData =  (List<LinkedHashMap<String, Object>>) method.invoke(obj,outputMap, con);

		 //lObjConfigDao.getWPOStatistics(outputMap,con);


		
		
		reportDetails.put("reportData", reportData);
		outputMap.put("defaultParameterValues", defaultParameterValues);
		
		if(!exportFlag.isEmpty())
				{				
					List<String> columnNames=lobjCommonDaoImpl.getListOfColumns(report_id,con);
					outputMap = getCommonFileGenerator(columnNames.toArray(new String[0]),reportData,exportFlag,DestinationPath,"Guest",reportDetails.get("report_name").toString(),reportDetails.get("report_name").toString());
				}
				else
				{			
					outputMap.put("reportDetails", reportDetails);
					rs.setViewName("ReportsWithoutLogin.jsp");		
				}
		rs.setReturnObject(outputMap);

	 	}
	 	catch (Exception e)
	 	{
			writeErrorToDB(e);
			rs.setHasError(true);
		}		
		return rs;
	}

	public CustomResultObject showUserRoleMapping(HttpServletRequest request,Connection con)
	{
		CustomResultObject rs=new CustomResultObject();			
		HashMap<String, Object> outputMap=new HashMap<>();
		String appId=((HashMap<String, String>) request.getSession().getAttribute("userdetails")).get("app_id");
		
		
		try
		{	
			
			outputMap.put("userList", lobjCommonDaoImpl.getEmployeeMaster(appId,con));
			String app_type = ((HashMap<String, String>) request.getSession().getAttribute("userdetails")).get("app_type");
			if(app_type==null)
			{
				app_type="Master";
			}
			HashMap<Long, Role> listRoles= getRoleMasterForThisAppType(app_type);

			listRoles.remove(100L);

			outputMap.put("roleList", listRoles);
			
			// Put all available system actions sorted alphabetically
			if (CommonFunctions.actions != null) {
				outputMap.put("actionList", new java.util.TreeSet<>(CommonFunctions.actions.keySet()));
			} else {
				outputMap.put("actionList", new java.util.TreeSet<>());
			}
			
			rs.setViewName("UserRoleMapping.jsp");	
			rs.setReturnObject(outputMap);		
		}
		catch (Exception e)
		{
				writeErrorToDB(e);
				rs.setHasError(true);
		}		
		return rs;
	}

	public CustomResultObject addRemoveRole(HttpServletRequest request,Connection con)
	{
		CustomResultObject rs=new CustomResultObject();
		long userId=Long.parseLong(request.getParameter("userId"));		
		String listOFRolesParam = request.getParameter("listOFRoles");
		String[] listOfRoles = (listOFRolesParam != null && !listOFRolesParam.trim().isEmpty()) ? listOFRolesParam.split(",") : new String[0];
		
		String listOfActionsParam = request.getParameter("listOfActions");
		String[] listOfActions = (listOfActionsParam != null && !listOfActionsParam.trim().isEmpty()) ? listOfActionsParam.split(",") : new String[0];
		
		try
		{			

			lobjCommonDaoImpl.removeAllExistingRoles(userId,con);
			for(String roleId:listOfRoles)
			{			
				if (!roleId.trim().isEmpty()) {
					lobjCommonDaoImpl.addUserRoleMapping(userId, Long.valueOf(roleId),roles.get(Long.valueOf(roleId)).getRoleName(), con);
				}
			}							

			lobjCommonDaoImpl.removeAllCustomActionsForUser(userId, con);
			for(String actionName:listOfActions)
			{			
				if (!actionName.trim().isEmpty()) {
					lobjCommonDaoImpl.addUserActionMapping(userId, actionName, con);
				}
			}							

		}
		catch (Exception e)
		{
			writeErrorToDB(e);
			rs.setHasError(true);
		}	
		rs.setAjaxData("Roles and Actions Updated Succesfully");
		return rs;
	}
	
	public CustomResultObject showShortcuts(HttpServletRequest request, Connection con) {
		CustomResultObject rs = new CustomResultObject();
		HashMap<String, Object> outputMap = new HashMap<>();
		try {

			rs.setViewName("shortcuts.jsp");
			rs.setReturnObject(outputMap);

		} catch (Exception e) {
			writeErrorToDB(e);
			rs.setHasError(true);
		}
		return rs;
	}

	public CustomResultObject getAppDetails(HttpServletRequest request, Connection con) throws SQLException {
    CustomResultObject rs = new CustomResultObject();
 
    String appCode = request.getParameter("app_code");
 
    try {
        HashMap<String, String> appDetails = lobjCommonDaoImpl.getAppDetailsByShortCode(appCode, con);
 
        if (appDetails == null || appDetails.get("app_name") == null) {
            rs.setAjaxData("Invalid App Code");
        } else {
            rs.setAjaxData(appDetails.get("app_name"));
        }
 
    } catch (Exception e) {
        request.setAttribute("error_id", writeErrorToDB(e) + "-" + getDateTimeWithSeconds(con));
        rs.setHasError(true);
    }
 
    return rs;
}
    
}
	
    
