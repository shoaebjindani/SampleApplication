package com.crystal.customizedpos.Configuration;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.stream.Collectors;

import Frameworkpackage.CommonFunctions;
import Frameworkpackage.Query;

public class ConfigurationDaoImpl extends CommonFunctions {

	public List<LinkedHashMap<String, Object>> getCategoryMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select category_id categoryId,category_name categoryName from mst_category where activate_flag=1 and app_id=?",
				con);
	}

	public HashMap<String, String> getNozzles(HashMap<String, Object> hm, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));

		return getMap(parameters, "select count(*) from nozzle_master where activate_flag=1 and app_id=?", con);
	}

	public HashMap<String, String> getDispensers(HashMap<String, Object> hm, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));

		return getMap(parameters, "select count(*) from dispenser_master dm where activate_flag=1 and app_id=?", con);
	}

	public HashMap<String, String> getCustomers(HashMap<String, Object> hm, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));

		return getMap(parameters, "select count(*) from mst_customer mc where activate_flag=1 and app_id=?", con);
	}

	public HashMap<String, String> getSalesInvoices(HashMap<String, Object> hm, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));

		return getMap(parameters, "select count(*) from trn_invoice_register tir where activate_flag=1 and app_id=?",
				con);
	}

	public HashMap<String, String> getVehicles(HashMap<String, Object> hm, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));

		return getMap(parameters, "select count(*) from mst_vehicle mv where activate_flag=1 and app_id=?", con);
	}

	public HashMap<String, String> getCategoryCount(HashMap<String, Object> hm, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));

		return getMap(parameters, "select count(*) from mst_category mc where activate_flag=1 and app_id=?", con);
	}

	public HashMap<String, String> getItems(HashMap<String, Object> hm, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));

		return getMap(parameters, "select count(*) from mst_items mi where activate_flag=1 and app_id=?", con);
	}

	public List<LinkedHashMap<String, Object>> getCategoryMasterWithItemsCount(HashMap<String, Object> hm,
			Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select\r\n"
						+ "	category_id categoryId,\r\n"
						+ "	category_name categoryName,\r\n"
						+ "	count(item_name) cnt, cat.order_no \r\n"
						+ "from\r\n"
						+ "mst_category cat left outer join mst_items mi	 on cat.category_id =mi.parent_category_id  and mi.activate_flag =1 \r\n"
						+ "and mi.app_id=? \r\n"
						+ "where\r\n"
						+ "	cat.activate_flag = 1 and 		\r\n"
						+ "	cat.app_id =? \r\n"
						+ "	group by cat.category_id ;",
				con);
	}

	public List<LinkedHashMap<String, Object>> getBookingRegister(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));

		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));

		String query = "select\r\n"
				+ "	*,date_format(from_date,'%d/%m/%Y %H:%i') as FormattedFromDate,date_format(to_date,'%d/%m/%Y %H:%i') as FormattedToDate \r\n"
				+ "from\r\n"
				+ "	trn_booking_register tbr ,\r\n"
				+ "	mst_customer mc,tbl_user_mst tum ,mst_store store \r\n"
				+ "where\r\n"
				+ "	tbr.customer_id = mc.customer_id\r\n"
				+ "	and tbr.activate_flag = 1  and tum.user_id =tbr.preffered_employee \r\n"
				+ "	and tbr.app_id = ? and date(tbr.from_date) between ? and ? and store.store_id=tbr.store_id ";

		if (hm.get("store_id") != null) {
			parameters.add(hm.get("store_id"));
			query += " and tbr.store_id=?";
		}

		return getListOfLinkedHashHashMap(parameters,
				query,
				con);
	}

	public List<LinkedHashMap<String, Object>> getItemDetailsStock(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		List<HashMap<String, Object>> itemDetailsList = (List<HashMap<String, Object>>) hm.get("itemDetails");
		String questionMarks = "";
		for (HashMap<String, Object> item : itemDetailsList) {
			parameters.add(Long.parseLong(item.get("item_id").toString()));
			questionMarks += "?,";
		}
		questionMarks = questionMarks.substring(0, questionMarks.length() - 1);

		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("app_id"));

		return getListOfLinkedHashHashMap(parameters,
				"select item_id,qty_available from stock_status where item_id in (" + questionMarks
						+ ") and store_id=? and app_id=? for update",
				con);
	}

	public List<LinkedHashMap<String, Object>> getUserRoleDetails(long customerId, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(customerId);
		return getListOfLinkedHashHashMap(parameters,
				"select  * from tbl_user_mst user,acl_user_role_rlt "
						+ " userrole where user.user_id=? "
						+ " and user.user_id=userrole.user_id and userrole.activate_flag=1",
				con);
	}

	public List<LinkedHashMap<String, Object>> getCustomerList(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add("%" + hm.get("searchString") + "%");
		parameters.add("%" + hm.get("searchString") + "%");

		parameters.add(hm.get("app_id"));

		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_customer where activate_flag=1 and (customer_name like ? or mobile_number like ?) and app_id=?",
				con);
	}

	public List<LinkedHashMap<String, Object>> getItemMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select item.*,cat.*,stock.*,"
				+ " case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as ImagePath "
				+ "from mst_items item inner join mst_category cat on cat.category_id=item.parent_category_id left outer join "
				+ " tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image' "
				+ " left outer join stock_status stock on stock.item_id=item.item_id and stock.store_id=? "
				+ " where item.activate_flag=1 and item.app_id=? and cat.app_id=item.app_id ";

		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("app_id"));

		if (hm.get("searchInput") != null && !hm.get("searchInput").equals("")) {
			parameters.add("%" + hm.get("searchInput") + "%");
			parameters.add("%" + hm.get("searchInput") + "%");
			query += " and (product_code like ? or item_name like ?)";
		}

		if (hm.get("categoryId") != null && !hm.get("categoryId").equals("-1") && !hm.get("categoryId").equals("")) {
			parameters.add(hm.get("categoryId"));
			query += " and parent_category_id=? ";
		}
		query += " group by item.item_id";
		query += " order by item_name";
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getItemMasterOrderCategory(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select item.item_id,\r\n"
				+ "item.parent_category_id,\r\n"
				+ "item.debit_in,\r\n"
				+ "item.item_name,\r\n"
				+ "item.price,\r\n"
				+ "item.wholesale_price,\r\n"
				+ "item.franchise_rate,\r\n"
				+ "item.loyalcustomerrate1,\r\n"
				+ "item.loyalcustomerrate2,\r\n"
				+ "item.loyalcustomerrate3,\r\n"
				+ "item.activate_flag,\r\n"
				+ "item.updated_by,\r\n"
				+ "item.updated_date,\r\n"
				+ "item.product_code,\r\n"
				+ "item.average_cost,\r\n"
				+ "item.distributor_rate,\r\n"
				+ "item.b2b_rate,\r\n"
				+ "item.shrikhand,\r\n"
				+ "item.app_id,\r\n"
				+ "item.sgst,item.cgst,\r\n"
				+ "item.hsn_code,\r\n"
				+ "item.catalog_no,\r\n"
				+ "item.order_no"
				+ ",cat.*,replace(cat.category_name,' ','') catNameTrimmed,"
				+ " case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as ImagePath "
				+ "from mst_items item inner join mst_category cat on cat.category_id=item.parent_category_id left outer join "
				+ " tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image' "
				+ " where item.activate_flag=1 and item.app_id=? and cat.app_id=item.app_id ";

		parameters.add(hm.get("app_id"));

		if (hm.get("searchInput") != null && !hm.get("searchInput").equals("")) {
			parameters.add("%" + hm.get("searchInput") + "%");
			parameters.add("%" + hm.get("searchInput") + "%");
			query += " and (product_code like ? or item_name like ?)";
		}

		if (hm.get("categoryId") != null && !hm.get("categoryId").equals("-1") && !hm.get("categoryId").equals("")) {
			parameters.add(hm.get("categoryId"));
			query += " and parent_category_id=? ";
		}
		query += " group by item.item_id";
		query += " order by cat.order_no,cat.category_name,item.order_no";
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public LinkedHashMap<String, String> getItemDetailsById(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("item_id"));
		parameters.add(hm.get("app_id"));

		return getMap(parameters, "select item.*,cat.*,stock.*,coalesce(qty_available,0) as AvailableQty from \r\n"
				+ "				 \r\n" + "					mst_category cat,mst_items item left outer join \r\n"
				+ "					stock_status stock  on stock.item_id=item.item_id and stock.store_id=?  \r\n"
				+ "				where \r\n" + "					item.item_id =? \r\n"
				+ "					and item.parent_category_id=cat.category_id and stock.app_id=? and stock.app_id=item.app_id and stock.app_id=cat.app_id",
				con);

	}

	public List<LinkedHashMap<String, Object>> getItemsByCategoryId(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("category_id"));
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_items where activate_flag=1 and parent_category_id=? and app_id=?", con);
	}

	public List<LinkedHashMap<String, Object>> getItemsByCategorynName(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("category_name"));
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_items items, mst_category cat where items.activate_flag=1 and items.parent_category_id=cat.category_id and cat.category_name=? and items.app_id=? order by items.order_no ",
				con);
	}

	public LinkedHashMap<String, Object> getItemdetailsById(HashMap<String, Object> hm, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("item_id"));
		parameters.add(hm.get("app_id"));
		LinkedHashMap<String, String> itemDetails = getMap(parameters, "select item.*,cat.*,"
				+ "case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as ImagePath "
				+ " from mst_items item left outer join mst_category cat on cat.category_id=item.parent_category_id left outer join  tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image'"
				+ " where item.activate_flag=1 and item.item_id=? and item.app_id=? limit 1", con);
		LinkedHashMap<String, Object> newHm = new LinkedHashMap<>();
		newHm.putAll(itemDetails);
		newHm.put("listOfItemImages", getListofItemImages(hm, con));
		return newHm;
	}

	public LinkedHashMap<String, String> getItemdetailsByIdForStore(String customerId, String itemId, String storeId,
			String destinationStoreId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(storeId);
		parameters.add(destinationStoreId);
		parameters.add(customerId);
		parameters.add(itemId);
		return getMap(parameters, "select \r\n" + "cat1.*,item.*,cust.customer_type,\r\n"
				+ "case when cust.customer_type='LoyalCustomer1' then item.loyalcustomerrate1\r\n"
				+ "when cust.customer_type='LoyalCustomer2' then item.loyalcustomerrate2\r\n"
				+ "when cust.customer_type='LoyalCustomer3' then item.loyalcustomerrate3\r\n"
				+ "when cust.customer_type='Franchise' then item.franchise_rate\r\n"
				+ "when cust.customer_type='WholeSeller' then item.wholesale_price\r\n"
				+ "when cust.customer_type='Distributor' then item.distributor_rate \r\n"
				+ "when cust.customer_type='shrikhand' then item.shrikhand \r\n"
				+ "when cust.customer_type='Business2Business' then item.b2b_rate \r\n" + "else item.price\r\n"
				+ "end CustomersPrice,"
				+ "case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as ImagePath,\r\n"
				+ "coalesce(stock.qty_available,0)  as stockAvailable ,\r\n"
				+ "coalesce(stock2.qty_available,0)  as destinationStockAvailable \r\n"
				+ "from mst_category cat1 inner join \r\n"
				+ "mst_items item  on cat1.category_id=item.parent_category_id left outer join \r\n"
				+ "stock_status stock on stock.item_id=item.item_id and stock.store_id=? left outer join \r\n"
				+ "stock_status stock2 on stock2.item_id=item.item_id  and stock2.store_id=? left outer join tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image'"
				+ " left outer join mst_customer cust on cust.customer_id=? \r\n"
				+ "where item.activate_flag=1 and item.item_id= ?  ", con);
	}

	public List<LinkedHashMap<String, Object>> getListofItemImages(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("item_id"));
		parameters.add(hm.get("app_id"));

		return getListOfLinkedHashHashMap(parameters,
				"select\r\n" + "	concat(attachment_id, file_name) fileName,\r\n" + "	attachment_id\r\n" + "from\r\n"
						+ "	mst_items item,\r\n" + "	tbl_attachment_mst attach\r\n" + "where\r\n"
						+ "	item_id = ? \r\n" + "	and type = 'Image'\r\n"
						+ "	and item.item_id=attach.file_id and item.app_id=?",
				con);
	}

	public long saveItem(HashMap<String, Object> itemDetails, Connection con)
			throws Exception {

		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("item_id", "~default");
		valuesMap.put("parent_category_id", itemDetails.get("drpcategoryId"));
		valuesMap.put("debit_in", itemDetails.get("drpdebitin"));
		valuesMap.put("item_name", itemDetails.get("itemname"));
		valuesMap.put("price", itemDetails.get("itemsaleprice"));
		valuesMap.put("wholesale_price", itemDetails.get("wholesaleprice"));
		valuesMap.put("franchise_rate", itemDetails.get("franchise_price"));
		valuesMap.put("loyalcustomerrate1", itemDetails.get("loyalcustomer1price"));
		valuesMap.put("loyalcustomerrate2", itemDetails.get("loyalcustomer2price"));
		valuesMap.put("loyalcustomerrate3", itemDetails.get("loyalcustomer3price"));
		valuesMap.put("activate_flag", "1");
		valuesMap.put("updated_by", itemDetails.get("userId"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("product_code", itemDetails.get("product_code"));
		valuesMap.put("average_cost", itemDetails.get("txtaveragecost"));
		valuesMap.put("distributor_rate", itemDetails.get("distributor_rate"));
		valuesMap.put("b2b_rate", itemDetails.get("b2b_rate"));
		valuesMap.put("shrikhand", itemDetails.get("shrikhand"));
		valuesMap.put("app_id", itemDetails.get("app_id"));
		valuesMap.put("sgst", itemDetails.get("sgst"));
		valuesMap.put("product_details", itemDetails.get("productdetails"));
		valuesMap.put("hsn_code", itemDetails.get("hsn_code"));
		valuesMap.put("catalog_no", itemDetails.get("catalog_no"));
		valuesMap.put("order_no", itemDetails.get("order_no"));
		valuesMap.put("cgst", itemDetails.get("cgst"));

		Query q = new Query("mst_items", "insert", valuesMap);
		return insertUpdateEnhanced(q, con);

	}

	public long updateItem(HashMap<String, Object> itemDetails, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemDetails.get("drpcategoryId"));
		parameters.add(itemDetails.get("drpdebitin"));
		parameters.add(itemDetails.get("itemname"));
		parameters.add(itemDetails.get("itemsaleprice"));
		parameters.add(itemDetails.get("wholesaleprice"));
		parameters.add(itemDetails.get("franchise_price"));
		parameters.add(itemDetails.get("loyalcustomer1price"));
		parameters.add(itemDetails.get("loyalcustomer2price"));
		parameters.add(itemDetails.get("loyalcustomer3price"));
		parameters.add(itemDetails.get("userId"));
		parameters.add(itemDetails.get("product_code"));
		parameters.add(itemDetails.get("txtaveragecost"));
		parameters.add(itemDetails.get("distributor_rate"));
		parameters.add(itemDetails.get("b2b_rate"));
		parameters.add(itemDetails.get("shrikhand"));
		parameters.add(itemDetails.get("sgst"));
		parameters.add(itemDetails.get("productdetails"));
		parameters.add(itemDetails.get("hsn_code"));
		parameters.add(itemDetails.get("catalog_no"));
		parameters.add(itemDetails.get("order_no"));
		parameters.add(itemDetails.get("cgst"));

		parameters.add(Long.parseLong(itemDetails.get("hdnItemId").toString()));

		String insertQuery = "UPDATE mst_items \r\n"
				+ "SET parent_category_id=?, debit_in=?, item_name=?, price=?, wholesale_price=?, franchise_rate=?, loyalcustomerrate1=?, loyalcustomerrate2=?, loyalcustomerrate3=?,updated_by=?, updated_date=sysdate(),product_code=?,average_cost=?,distributor_rate=?,b2b_rate=?,shrikhand=?,sgst=?,product_details=?,hsn_code=?,catalog_no=?,order_no=?,cgst=? \r\n"
				+ "WHERE item_id=?";
		return insertUpdateDuablDB(insertQuery, parameters, con);
	}

	public List<LinkedHashMap<String, Object>> showItems(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"SELECT item_name itemname, category_name categoryname , price,item_id itemId FROM  mst_items item, mst_category cat"
						+ " WHERE  item.parent_category_id=cat.category_id  AND item.`activate_flag`=1 and item.app_id=? and cat.app_id=item.app_id ",
				con);
	}

	public List<LinkedHashMap<String, Object>> getStockStatus(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("app_id"));
		String query = " select mc.category_name,mi.item_name,Purchase.qty-COALESCE (Sales.qty,0) availableQty,Purchase.details_id,Purchase.purchasePrice from (\r\n"
				+ "select tpid.details_id,tpid.qty qty,tpid.rate purchasePrice,tpid.item_id  from	trn_purchase_invoice_register tpir inner join trn_purchase_invoice_details tpid on\r\n"
				+ "tpir.invoice_id = tpid.invoice_id where	tpir.activate_flag = 1 and tpir.app_id = ? group by tpid.details_id) as Purchase\r\n"
				+ "\r\n"
				+ "left outer join \r\n"
				+ "\r\n"
				+ "(select tid.purchase_details_id ,tid.details_id ,tid.item_id,sum(tid.qty) qty  from trn_invoice_register tir \r\n"
				+ "inner join trn_invoice_details tid on tir.invoice_id = tid.invoice_id \r\n"
				+ "where tir.activate_flag = 1 and tir.app_id = ? and tid.purchase_details_id is not null group by tid.purchase_details_id) as Sales\r\n"
				+ "\r\n"
				+ "on Purchase.details_id=Sales.purchase_details_id\r\n"
				+ "inner join mst_items mi on mi.item_id =Purchase.item_id\r\n"
				+ "inner join mst_category mc on mc.category_id =mi.parent_category_id \r\n";

		if (hm.get("categoryId") != null && !hm.get("categoryId").equals("") && !hm.get("categoryId").equals("-1")) {
			query += " where mi.parent_category_id=?";
			parameters.add(hm.get("categoryId"));
		}
		query += " having availableQty >0";

		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public boolean ProductExistForThisCategory(long categoryId, Connection con)
			throws SQLException {
		boolean returnvalue = true;
		int count = 0;

		PreparedStatement stmnt = con.prepareStatement(
				"SELECT COUNT(1) AS cnt FROM mst_items WHERE parent_category_id=? AND activate_flag=1");
		stmnt.setLong(1, categoryId);

		ResultSet rs = stmnt.executeQuery();
		while (rs.next()) {
			count = rs.getInt(1);
		}
		if (count == 0) {
			returnvalue = false;
		}
		stmnt.close();
		rs.close();

		return returnvalue;
	}

	public String deleteCategory(long categoryId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(categoryId);
		insertUpdateDuablDB("UPDATE mst_category  SET activate_flag=0,updated_date=SYSDATE() WHERE category_id=?",
				parameters, conWithF);
		return "Category updated Succesfully";
	}

	public String deleteBooking(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("user_Id"));
		parameters.add(hm.get("booking_id"));

		insertUpdateDuablDB(
				"update trn_booking_register set activate_flag=0,updated_by=?,updated_date=sysdate() where booking_id=?",
				parameters, conWithF);
		return "Booking Deleted Succesfully";
	}

	public String updateMobileBookingStatus(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("acceptFlag"));

		parameters.add(hm.get("mobile_booking_id"));

		insertUpdateDuablDB(
				"update trn_order_register_frommobileapp set curr_status=?,updated_date=sysdate() where order_id=?",
				parameters, conWithF);
		return "Booking Updated Succesfully";
	}

	public String updateFuel(long fuelId, Connection con, String fuelName) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(fuelName);
		parameters.add(fuelId);
		insertUpdateDuablDB("update mst_items set item_name=? where item_id=?", parameters, con);
		return "Booking Updated Succesfully";
	}

	public long removeRoleFromUser(long userId, long roleId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(roleId);
		return insertUpdateDuablDB(
				"update acl_user_role_rlt set activate_flag=0,updated_date=sysdate() where user_id=? and role_id=?",
				parameters, conWithF);
	}

	public boolean isItemComposite(long itemId, Connection conWithF) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select count(1) cnt from rlt_composite_item_mpg rcim  where item_id =?";
		parameters.add(itemId);
		int count = Integer.parseInt(getMap(parameters, query, conWithF).get("cnt"));
		return count != 0;
	}

	public String debtiStockAgainstInvoice(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		long storeId = Long.parseLong(hm.get("store_id").toString());
		List<HashMap<String, Object>> itemDetailsList = (List<HashMap<String, Object>>) hm.get("itemDetails");

		for (HashMap<String, Object> item : itemDetailsList) {
			long itemId = Long.parseLong(item.get("item_id").toString());
			String stockId = checkifStockAlreadyExist(storeId, itemId, conWithF);
			if (stockId.equals("0")) {
				HashMap<String, Object> stockDetails = new HashMap<>();
				stockDetails.put("drpstoreId", storeId);
				stockDetails.put("drpitems", itemId);
				stockDetails.put("qty", 0);
				stockDetails.put("app_id", hm.get("app_id"));
				stockId = String.valueOf(addStockMaster(stockDetails, conWithF));

			}

			ArrayList<Object> parameters = new ArrayList<>();
			parameters.add(item.get("qty"));
			parameters.add(item.get("item_id"));
			parameters.add(storeId);

			hm.put("stock_id", stockId);
			String previousQty = getStockDetailsbyId(hm, conWithF).get("qty_available");
			Double newQty = Double.valueOf(previousQty) - Double.valueOf(item.get("qty").toString());
			insertUpdateDuablDB("UPDATE stock_status  SET qty_available=qty_available-? WHERE item_id=? and store_id=?",
					parameters, conWithF); // for update issue

			parameters = new ArrayList<>();
			parameters.add(hm.get("store_id")); // to be validated
			parameters.add(item.get("item_id"));
			parameters.add(Double.parseDouble(item.get("qty").toString()) * -1);
			parameters.add("Sales");
			parameters.add(hm.get("user_id"));
			parameters.add(hm.get("invoice_id"));
			parameters.add(getDateASYYYYMMDD(hm.get("invoice_date").toString()));
			parameters.add(newQty);
			parameters.add(hm.get("app_id"));

			insertUpdateDuablDB(
					"insert into trn_stock_register values (default,?,?,?,?,?,sysdate(),'Against Invoice',?,?,?,?)",
					parameters, conWithF);

		}
		return "Stock Debited Succesfully";

	}

	public String debitStockItem(HashMap<String, Object> item, Connection conWithF) throws Exception {
		long storeId = Long.parseLong(item.get("store_id").toString());
		long itemId = Long.parseLong(item.get("item_id").toString());
		String stockId = checkifStockAlreadyExist(storeId, itemId, conWithF);

		if (stockId.equals("0")) {
			HashMap<String, Object> stockDetails = new HashMap<>();
			stockDetails.put("drpstoreId", storeId);
			stockDetails.put("drpitems", itemId);
			stockDetails.put("qty", 0);
			stockDetails.put("app_id", item.get("app_id"));
			stockId = String.valueOf(addStockMaster(stockDetails, conWithF));
		}
		item.put("stock_id", stockId);

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(item.get("qty"));
		parameters.add(item.get("item_id"));
		parameters.add(storeId);

		// Double newQty = Double.valueOf(previousQty) -
		// Double.valueOf(item.get("qty").toString());

		parameters = new ArrayList<>();
		parameters.add(item.get("store_id")); // to be validated
		parameters.add(item.get("item_id"));
		parameters.add(Double.parseDouble(item.get("qty").toString()) * -1);
		parameters.add("Sales");
		parameters.add(item.get("user_id"));
		parameters.add(item.get("invoice_id"));
		parameters.add(getDateASYYYYMMDD(item.get("invoice_date").toString()));
		// parameters.add(newQty);
		parameters.add(item.get("app_id"));

		// insertUpdateDuablDB("insert into trn_stock_register values
		// (default,?,?,?,?,?,sysdate(),'Against Invoice',?,?,?,?)",parameters,
		// conWithF);

		return "Stock Debited Succesfully";

	}

	public String addStockAgainstCorrection(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		long storeId = Long.parseLong(hm.get("store_id").toString());
		List<HashMap<String, Object>> itemDetailsList = (List<HashMap<String, Object>>) hm.get("itemDetails");

		for (HashMap<String, Object> item : itemDetailsList) {
			long itemId = Long.parseLong(item.get("item_id").toString());
			if (item.get("debit_in").equals("S")) {
				continue;
			}
			String stockId = checkifStockAlreadyExist(storeId, itemId, conWithF);
			if (stockId.equals("0")) {
				HashMap<String, Object> stockDetails = new HashMap<>();
				stockDetails.put("drpstoreId", storeId);
				stockDetails.put("drpitems", itemId);
				stockDetails.put("qty", 0);
				stockDetails.put("app_id", hm.get("app_id"));
				stockId = String.valueOf(addStockMaster(stockDetails, conWithF));

			}

			ArrayList<Object> parameters = new ArrayList<>();
			parameters.add((Double.valueOf(item.get("qty").toString()) * -1));
			parameters.add(item.get("item_id"));
			parameters.add(storeId);

			hm.put("stock_id", stockId);
			String previousQty = getStockDetailsbyId(hm, conWithF).get("qty_available");
			Double newQty = Double.valueOf(previousQty) - (Double.valueOf(item.get("qty").toString()) * -1);
			insertUpdateDuablDB("UPDATE stock_status  SET qty_available=qty_available-? WHERE item_id=? and store_id=?",
					parameters, conWithF); // for update issue

			parameters = new ArrayList<>();
			parameters.add(hm.get("store_id")); // to be validated
			parameters.add(item.get("item_id"));
			parameters.add(Double.parseDouble(item.get("qty").toString()));
			parameters.add("AddAgainstDeleteInvoice");
			parameters.add(hm.get("user_id"));
			parameters.add(hm.get("invoice_id"));
			parameters.add(getDateASYYYYMMDD(getDateFromDB(conWithF)));
			parameters.add(newQty);
			parameters.add(hm.get("app_id"));

			insertUpdateDuablDB(
					"insert into trn_stock_register values (default,?,?,?,?,?,sysdate(),'AddAgainstDeleteInvoice',?,?,?,?)",
					parameters, conWithF);

		}
		return "Stock Reverted";

	}

	public String removeStockAgainstReturn(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		long storeId = Long.parseLong(hm.get("store_id").toString());
		List<HashMap<String, Object>> itemDetailsList = (List<HashMap<String, Object>>) hm.get("itemDetails");

		for (HashMap<String, Object> item : itemDetailsList) {
			if (item.get("ReturnedQty").toString().equals("0.00")) {
				continue;
			}
			long itemId = Long.parseLong(item.get("item_id").toString());
			String stockId = checkifStockAlreadyExist(storeId, itemId, conWithF);
			if (stockId.equals("0")) {
				HashMap<String, Object> stockDetails = new HashMap<>();
				stockDetails.put("drpstoreId", storeId);
				stockDetails.put("drpitems", itemId);
				stockDetails.put("qty", 0);
				stockDetails.put("app_id", hm.get("app_id"));
				stockId = String.valueOf(addStockMaster(stockDetails, conWithF));

			}

			ArrayList<Object> parameters = new ArrayList<>();
			parameters.add((Double.valueOf(item.get("ReturnedQty").toString())));
			parameters.add(item.get("item_id"));
			parameters.add(storeId);

			hm.put("stock_id", stockId);
			String previousQty = getStockDetailsbyId(hm, conWithF).get("qty_available");
			Double newQty = Double.valueOf(previousQty) - (Double.valueOf(item.get("ReturnedQty").toString()));
			insertUpdateDuablDB("UPDATE stock_status  SET qty_available=qty_available-? WHERE item_id=? and store_id=?",
					parameters, conWithF); // for update issue

			parameters = new ArrayList<>();
			parameters.add(hm.get("store_id")); // to be validated
			parameters.add(item.get("item_id"));
			parameters.add(Double.parseDouble(item.get("ReturnedQty").toString()) * -1);
			parameters.add("removeAgainstReturnDeleteInvoice");
			parameters.add(hm.get("user_id"));
			parameters.add(hm.get("invoice_id"));
			parameters.add(getDateASYYYYMMDD(getDateFromDB(conWithF)));
			parameters.add(newQty);
			parameters.add(hm.get("app_id"));

			insertUpdateDuablDB(
					"insert into trn_stock_register values (default,?,?,?,?,?,sysdate(),'removeAgainstReturnDeleteInvoice',?,?,?,?)",
					parameters, conWithF);

		}
		return "Stock Reverted";

	}

	public void addStockRegister(HashMap<String, Object> hm, Connection conWithF)
			throws Exception {
		String stockId = checkifStockAlreadyExist(Long.valueOf(hm.get("drpstoreId").toString()),
				Long.valueOf(hm.get("drpitems").toString()), conWithF);
		hm.put("stock_id", stockId);
		String previousQty = getStockDetailsbyId(hm, conWithF).get("qty_available");
		previousQty = previousQty == null ? "0" : previousQty;
		Double newQty = Double.valueOf(previousQty) + Double.valueOf(hm.get("qty").toString());
		ArrayList<Object> parameters = new ArrayList<>();
		parameters = new ArrayList<>();
		parameters.add(hm.get("drpstoreId")); // to be validated
		parameters.add(hm.get("drpitems"));
		parameters.add(Double.parseDouble(hm.get("qty").toString()));
		parameters.add(hm.get("type"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("remarks"));
		parameters.add(hm.get("invoice_id"));
		parameters.add(getDateASYYYYMMDD(getDateFromDB(conWithF)));
		parameters.add(newQty);
		parameters.add(hm.get("app_id"));
		insertUpdateDuablDB("insert into trn_stock_register values (default,?,?,?,?,?,sysdate(),?,?,?,?,?)", parameters,
				conWithF);
	}

	public HashMap<String, Object> saveInvoice(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		String invoiceNo;
		if (hm.get("invoice_no") == null) {
			invoiceNo = String.valueOf(
					getPkForThistable("trn_invoice_register", Long.valueOf(hm.get("app_id").toString()), conWithF));
		} else {
			invoiceNo = hm.get("invoice_no").toString();
		}

		parameters.add(hm.get("customer_id"));
		parameters.add(hm.get("gross_amount"));
		parameters.add(hm.get("item_discount"));
		parameters.add(hm.get("invoice_discount"));
		parameters.add(hm.get("total_amount"));
		parameters.add(hm.get("payment_type"));

		parameters.add(getDateASYYYYMMDD(hm.get("invoice_date").toString()));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("remarks"));
		parameters.add(hm.get("app_id"));

		parameters.add(invoiceNo);
		parameters.add(hm.get("total_gst"));

		parameters.add(hm.get("model_no"));
		parameters.add(hm.get("unique_no"));

		parameters.add(hm.get("total_sgst"));
		parameters.add(hm.get("total_cgst"));

		long invoiceId = insertUpdateDuablDB(
				"insert into trn_invoice_register values (default,?,?,?,?,?,?,?,?,sysdate(),1,?,?,?,?,?,?,?,?,?)",
				parameters,
				conWithF);
		hm.put("invoice_id", invoiceId);

		if (hm.get("shift_id") != null && !hm.get("shift_id").equals("")) {
			insertUpdateCustomParameterized(
					"insert into rlt_invoice_fuel_details values (default,:invoice_id,:shift_id,:attendant_id,:nozzle_id,sysdate(),:swipe_id)",
					hm, conWithF);

		}

		List<HashMap<String, Object>> itemDetailsList = (List<HashMap<String, Object>>) hm.get("itemDetails");
		for (HashMap<String, Object> item : itemDetailsList) {
			parameters = new ArrayList<>();
			parameters.add(invoiceId);
			parameters.add(item.get("item_id"));
			parameters.add(item.get("qty"));
			parameters.add(item.get("rate"));
			parameters.add(item.get("custom_rate"));
			parameters.add(hm.get("user_id"));
			parameters.add(hm.get("app_id"));

			if (item.get("gst_amount") == null || item.get("gst_amount").equals("")) {
				item.put("gst_amount", "0.00");
			}

			parameters.add(item.get("gst_amount"));

			String weight;
			if (item.get("weight") == null || item.get("weight").equals("")) {
				weight = "0.00";
			} else {
				weight = item.get("weight").toString();
			}

			parameters.add(weight);
			parameters.add(item.get("size"));

			String purchaseInvoiceId = null;
			if (item.get("purchaseDetailsId") != null) {
				purchaseInvoiceId = item.get("purchaseDetailsId").toString().equals("undefined") ? "0"
						: item.get("purchaseDetailsId").toString();
			}

			if (item.get("purchaseDetailsId") != null && item.get("purchaseDetailsId").toString().equals(" ")) {
				purchaseInvoiceId = null;
			}

			parameters.add(purchaseInvoiceId);

			parameters.add(item.get("sgst_percentage"));
			parameters.add(item.get("sgst_amount"));
			parameters.add(item.get("cgst_percentage"));
			parameters.add(item.get("cgst_amount"));

			long detailsId = insertUpdateDuablDB("insert into trn_invoice_details"
					+ "(details_id, invoice_id, item_id, qty, rate, custom_rate, updated_by,"
					+ " updated_date, app_id, gst_amount,weight,size,purchase_details_id,sgst_percentage,sgst_amount,cgst_percentage,cgst_amount) "
					+ " values (default,?,?,?,?,?,?,sysdate(),?,?,?,?,?,?,?,?,?)", parameters,
					conWithF);

			parameters.add(item.get("sgst_percentage"));
			parameters.add(item.get("sgst_amount"));
			parameters.add(item.get("cgst_percentage"));
			parameters.add(item.get("cgst_amount"));

			parameters.clear();
			if (item.get("RSPH") != null) {

				parameters.add(detailsId);
				parameters.add(item.get("RSPH") + "~" + item.get("RCYL") + "~" + item.get("RAXIS") + "~"
						+ item.get("RADD") + "~" + item.get("RVA") + "~" + item.get("RIPD"));
				parameters.add(item.get("LSPH") + "~" + item.get("LCYL") + "~" + item.get("LAXIS") + "~"
						+ item.get("LADD") + "~" + item.get("LVA") + "~" + item.get("LIPD"));

				insertUpdateDuablDB("insert into trn_sph_details "
						+ " values (?,?,?) ", parameters,
						conWithF);
			}

		}
		hm.put("payment_for", "Invoice");
		addPaymentFromCustomer(hm, conWithF);
		hm.put("invoice_id", invoiceId);
		hm.put("invoice_no", invoiceNo);
		return hm;
	}

	public long getPkForThistable(String sequenceName, Long appId, Connection conWithF) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		parameters.add(sequenceName);

		long generatedPK = 0;
		LinkedHashMap<String, String> hm = getMap(parameters,
				"select current_seq_no from seq_master where app_id=? and sequence_name=? for update", conWithF);

		if (hm.get("current_seq_no") == null) {
			parameters.clear();
			parameters.add(sequenceName);
			parameters.add(appId);
			insertUpdateDuablDB("insert into seq_master values (default,?,0,?)", parameters, conWithF);
			generatedPK = 1;
		} else {
			generatedPK = Long.valueOf(hm.get("current_seq_no"));
			generatedPK = generatedPK + 1;
			parameters.clear();
			parameters.add(generatedPK);
			parameters.add(appId);
			parameters.add(sequenceName);
			insertUpdateDuablDB("update seq_master set current_seq_no=? where app_id=? and sequence_name=?", parameters,
					conWithF);
		}
		return generatedPK;
	}

	public String addPaymentFromCustomer(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		if (hm.get("payment_type").equals("Pending")) {
			return "Payment Not added";
		}
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("customer_id"));
		parameters.add(getDateASYYYYMMDD(hm.get("invoice_date").toString()));
		parameters.add(hm.get("payment_mode"));
		if (hm.get("payment_type").equals("Paid") || hm.get("payment_type").equals("Debit")) {
			parameters.add(hm.get("total_amount"));
		} else if (hm.get("payment_type").equals("Partial")) {
			parameters.add(hm.get("paid_amount"));
		}
		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("invoice_id"));
		parameters.add(hm.get("payment_for"));
		parameters.add(hm.get("remarks"));
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("user_id"));
		insertUpdateDuablDB("insert into trn_payment_register values (default,?,?,?,?,?,?,?,?,?,?,sysdate(),1)",
				parameters,
				conWithF);
		return "Payment Added";

	}

	public String updateCategory(long categoryId, Connection con, String categoryName, String orderNo)
			throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(categoryName);
		parameters.add(orderNo);

		parameters.add(categoryId);
		insertUpdateDuablDB(
				"UPDATE mst_category  SET category_Name=?,updated_date=SYSDATE(),order_no=? WHERE category_id=?",
				parameters, con);
		return "Category updated Succesfully";

	}

	public long addCategory(Connection con, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("categoryName"));
		parameters.add(hm.get("app_id"));

		String orderNo = null;
		if (hm.get("order_no").equals("")) {
			orderNo = "1";
		} else {
			orderNo = hm.get("order_no").toString();
		}
		parameters.add(orderNo);

		return insertUpdateDuablDB("insert into mst_category values (default,?,1,sysdate(),null,null,?,?)", parameters,
				con);
	}

	public long addStockMaster(HashMap<String, Object> stockDetails, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(stockDetails.get("drpstoreId"));
		parameters.add(stockDetails.get("drpitems"));
		parameters.add(0);
		parameters.add(stockDetails.get("app_id"));
		return insertUpdateDuablDB("insert into stock_status values (default,?,?,?,1,0,?)", parameters, conWithF);
	}

	public long updateStockMaster(HashMap<String, Object> stockDetails, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(Double.parseDouble(stockDetails.get("qty").toString()));
		parameters.add(stockDetails.get("stock_id"));
		return insertUpdateDuablDB("update stock_status set qty_available=qty_available+(?) where stock_id=?",
				parameters, conWithF);
	}

	public long updateStockMasterInventoryCounting(HashMap<String, Object> stockDetails, Connection conWithF)
			throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(Double.parseDouble(stockDetails.get("qty").toString()));
		parameters.add(stockDetails.get("stock_id"));
		return insertUpdateDuablDB("update stock_status set qty_available=? where stock_id=?",
				parameters, conWithF);
	}

	public List<LinkedHashMap<String, Object>> getCategories(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"SELECT category_id,category_name,case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as ImagePath "
						+ " FROM mst_category cat left outer join tbl_attachment_mst tam  on  tam.file_id=cat.category_id and tam.type='category' WHERE  cat.activate_Flag=1 and cat.app_id=?",
				con);

	}

	public List<LinkedHashMap<String, Object>> getCategoriesWithAtLeastOneItem(HashMap<String, Object> hm,
			Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select\r\n"
						+ "	category_id,category_name,count(1) cnt\r\n"
						+ "from\r\n"
						+ "	mst_items mi ,\r\n"
						+ "	mst_category mc\r\n"
						+ "where\r\n"
						+ "	mi.parent_category_id = mc.category_id\r\n"
						+ "	and mi.app_id = ?\r\n"
						+ "	and mi.activate_flag = 1\r\n"
						+ "	group by mi.parent_category_id having cnt>=1 order by mc.order_no;",
				con);

	}

	public LinkedHashMap<String, String> getStockDetailsbyId(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("stock_id"));
		parameters.add(hm.get("app_id"));
		return getMap(parameters, "select * from stock_status stock,mst_items item\r\n"
				+ "where stock_id=? and item.item_id=stock.item_id and stock.app_id=? and item.app_id=stock.app_id",
				con);

	}

	public int getMaxAttachmentNoByItemId(long itemId, Connection con) throws SQLException {
		int count = 0;
		PreparedStatement stmnt = con.prepareStatement("SELECT count(1) FROM tbl_attachment_mst WHERE file_id=?");
		stmnt.setLong(1, itemId);
		ResultSet rs = stmnt.executeQuery();
		while (rs.next()) {
			count = rs.getInt(1);
		}
		stmnt.close();
		rs.close();
		return count;
	}

	public String deleteItem(long itemId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemId);
		insertUpdateDuablDB(
				"UPDATE mst_items  SET activate_flag=0,product_code=concat(item_id,product_code),updated_date=SYSDATE() WHERE item_Id=?",
				parameters, conWithF);
		return "Item Deleted Succesfully";
	}

	public String deleteVehicle(long vehicleId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(vehicleId);
		insertUpdateDuablDB(
				"UPDATE mst_vehicle  SET activate_flag=0,updated_date=SYSDATE() WHERE vehicle_id=?",
				parameters, conWithF);
		return "vehicle Deleted Succesfully";
	}

	public String deletePayment(long paymentId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(paymentId);
		insertUpdateDuablDB(
				"update trn_payment_register set activate_flag=0,updated_date=sysdate(),updated_by=? where payment_id=?",
				parameters, conWithF);
		return "Deleted Succesfully";
	}

	public String deleteStock(long stockId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(stockId);
		insertUpdateDuablDB("UPDATE stock_status  SET activate_flag=0 where stock_id=?", parameters, conWithF);
		return "Stock Deleted Succesfully";
	}

	public HashMap<String, Object> getDetailsforItem(long itemId, Connection con)
			throws SQLException {
		HashMap<String, Object> returnMap = null;

		List<HashMap<String, Object>> listofAttachments = new ArrayList<>();
		try {

			PreparedStatement stmnt = con.prepareStatement(
					"SELECT item_id,item_name,price,parent_category_id,price FROM mst_items WHERE item_id=?");
			stmnt.setLong(1, itemId);

			ResultSet rs = stmnt.executeQuery();
			while (rs.next()) {
				returnMap = new HashMap<>();
				returnMap.put("itemId", rs.getString(1));
				returnMap.put("itemName", rs.getString(2));
				returnMap.put("itemPrice", rs.getString(3));
				returnMap.put("itemParentCategoryId", rs.getString(4));
				returnMap.put("price", rs.getString(5));

				stmnt = con.prepareStatement(
						"SELECT attachment_id,concat(attachment_id,file_name) as file_name ,file_id,length(attachment_asblob) FROM tbl_attachment_mst WHERE file_id=? AND TYPE='Image' and activate_flag=1");
				stmnt.setLong(1, itemId);
				rs = stmnt.executeQuery();
				HashMap<String, Object> attachment = null;

				while (rs.next()) {
					attachment = new HashMap<>();

					attachment.put("attachmentId", rs.getString(1));
					attachment.put("path", "BufferedImagesFolder/" + rs.getString(2));
					attachment.put("file_id", rs.getString(3));
					attachment.put("file_size", rs.getLong(4) / 1024);
					listofAttachments.add(attachment);

				}

			}
			returnMap.put("listofAttachments", listofAttachments);
			stmnt.close();
			rs.close();

		} catch (Exception e) {
			writeErrorToDB(e);
		}

		return returnMap;
	}

	public String deleteAttachment(long attachmentId, Connection conWithF) throws Exception {
		try {
			String insertTableSQL = "delete from tbl_attachment_mst where  attachment_id=?";

			PreparedStatement preparedStatement = conWithF.prepareStatement(insertTableSQL);
			preparedStatement.setLong(1, attachmentId);
			preparedStatement.executeUpdate();

			if (preparedStatement != null) {
				preparedStatement.close();
			}

			return "Attachment Deleted Successfully";
		} catch (Exception e) {
			// write to error log
			writeErrorToDB(e);
			throw e;
		}

	}

	public LinkedHashMap<String, String> getCategoryDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("category_id"));
		parameters.add(hm.get("app_id"));

		return getMap(parameters,
				"select mc.*,concat(tam.attachment_id,tam.file_name) ImagePath,tam.attachment_id as attachId from "
						+ " mst_category as mc left outer join tbl_attachment_mst tam  on tam.file_id=mc.category_id  and tam.type = 'category' where mc.category_id=? and mc.app_id=?",
				con);
	}

	public LinkedHashMap<String, String> getFuelDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("fuelId"));

		return getMap(parameters,
				"select * from mst_items where item_id=? ",
				con);
	}

	public LinkedHashMap<String, String> getNozzleDetails(String nozzleId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(nozzleId);

		return getMap(parameters,
				"select\r\n"
						+ "	*\r\n"
						+ "from\r\n"
						+ "	nozzle_master nozmaster inner join \r\n"
						+ "	mst_items fuelmst on nozmaster.item_id =fuelmst .item_id  inner join  \r\n"
						+ "	dispenser_master dm on dm.dispenser_id =nozmaster .parent_dispenser_id \r\n"
						+ "left outer join trn_nozzle_register tnr on\r\n"
						+ "	tnr.nozzle_id = nozmaster.nozzle_id \r\n"
						+ "				\r\n"
						+ "where\r\n"
						+ "	nozmaster.nozzle_id =?\r\n"
						+ "order by\r\n"
						+ "	tnr.trn_nozzle_id desc\r\n"
						+ "limit 1",
				con);
	}

	public List<LinkedHashMap<String, Object>> getCustomerMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		String query = "select customer_id customerId,customer_name customerName, mobile_number mobileNumber, "
				+ " city customerCity, address customerAddress, customer_type customerType "
				+ " from mst_customer customer left outer join customer_group group1 on group1.group_id=customer.group_id and group1.app_id=customer.app_id"
				+ " where customer.activate_flag = 1 and   customer.app_id=? ";

		if (hm.get("searchInput") != null && !hm.get("searchInput").equals("")) {
			query += " and (customer_name like ? or mobile_number like ?) ";
			parameters.add("%" + hm.get("searchInput") + "%");
			parameters.add("%" + hm.get("searchInput") + "%");
		}

		if (hm.get("groupId") != null && !hm.get("groupId").equals("") && !hm.get("groupId").equals("-1")) {
			query += " and group1.group_id=? ";
			parameters.add(hm.get("groupId"));
		}

		if (hm.get("customerType") != null && !hm.get("customerType").equals("")
				&& !hm.get("customerType").equals("-1")) {
			query += " and customer.customer_type=?";
			parameters.add(hm.get("customerType"));
		}

		query += " order by customer_name";
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getAccountPrintMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		// parameters.add(hm.get("app_id"));
		String query = "select account_id accountId,account_name accountName, account_no accountNo "
				+ " from mst_account"
				+ " where activate_flag = 1";

		if (hm.get("searchInput") != null && !hm.get("searchInput").equals("")) {
			query += " and (account_name like ?) ";
			parameters.add("%" + hm.get("searchInput") + "%");
			parameters.add("%" + hm.get("searchInput") + "%");
		}

		// if (hm.get("groupId") != null && !hm.get("groupId").equals("") &&
		// !hm.get("groupId").equals("-1")) {
		// query += " and group1.group_id=? ";
		// parameters.add(hm.get("groupId"));
		// }

		// if (hm.get("customerType") != null && !hm.get("customerType").equals("")
		// && !hm.get("customerType").equals("-1")) {
		// query += " and customer.customer_type=?";
		// parameters.add(hm.get("customerType"));
		// }

		query += " order by account_name";
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getVendorMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		String query = "select * "
				+ " from mst_vendor vendor "
				+ " where vendor.activate_flag = 1 and vendor.app_id=? ";

		if (hm.get("searchInput") != null && !hm.get("searchInput").equals("")) {
			query += " and (vendor_name like ? or mobile_number like ?) ";
			parameters.add("%" + hm.get("searchInput") + "%");
			parameters.add("%" + hm.get("searchInput") + "%");
		}

		query += " order by vendor_name";
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public String deleteCustomer(long customerId, Connection conWithF) throws Exception {

		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("activate_flag", "0");
		valuesMap.put("updated_date", "~sysdate()");

		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("customer_id", customerId);

		Query q = new Query("mst_customer", "update", valuesMap, whereMap);
		insertUpdateEnhanced(q, conWithF);
		return "Customer Deleted Succesfully";
	}

	public String deleteVendor(long customerId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(Long.valueOf(customerId));
		insertUpdateDuablDB("UPDATE mst_vendor  SET activate_flag=0,updated_date=SYSDATE() WHERE vendor_id=?",
				parameters, conWithF);
		return "Vendor Deleted Succesfully";
	}

	public String updateCustomer(long customerId, Connection conWithF, HashMap<String, Object> hm) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("customerName"));
		parameters.add(Long.parseLong(hm.get("mobileNumber").toString()));
		parameters.add(hm.get("city"));
		parameters.add(hm.get("address"));
		parameters.add(hm.get("customerType"));
		parameters.add(hm.get("customerGroup"));
		parameters.add(hm.get("alternate_mobile_no"));
		parameters.add(hm.get("customer_reference"));

		if (hm.get("birthday").equals("")) {
			parameters.add(null);
		} else {
			parameters.add(getDateASYYYYMMDD(hm.get("birthday").toString()));
		}

		if (hm.get("anniversary").equals("")) {
			parameters.add(null);
		} else {
			parameters.add(getDateASYYYYMMDD(hm.get("anniversary").toString()));
		}

		parameters.add(hm.get("drpgender"));

		parameters.add(Long.valueOf(customerId));
		insertUpdateDuablDB(
				"UPDATE mst_customer  SET"
						+ " customer_name=?, mobile_number = ?, city=?, address= ?, customer_type=?,updated_date=SYSDATE(),"
						+ "group_id=?,alternate_mobile_no=?,customer_reference=?,dob=?,anniversary=?,gender=?	 WHERE customer_id=?",
				parameters, conWithF);
		return "Customer Updated Succesfully";

	}

	public long addCustomer(Connection conWithF, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("customerName"));
		parameters.add(Long.parseLong(hm.get("mobileNumber").toString()));
		parameters.add(hm.get("city"));
		parameters.add(hm.get("address"));
		parameters.add(hm.get("customerType"));
		parameters.add(hm.get("customerGroup"));
		parameters.add(hm.get("alternate_mobile_no"));

		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("customer_reference"));

		if (hm.get("birthday") == null || hm.get("birthday").equals("")) {
			parameters.add(null);
		} else {
			parameters.add(getDateASYYYYMMDD(hm.get("birthday").toString()));
		}

		if (hm.get("birthday") == null || hm.get("birthday").equals("")) {
			parameters.add(null);
		} else {
			parameters.add(getDateASYYYYMMDD(hm.get("birthday").toString()));
		}

		parameters.add(hm.get("drpgender"));

		String insertQuery = "insert into mst_customer values (default,?,?,?,?,?,1,sysdate(),null,null,?,?,?,?,?,?,?)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public long addVendor(Connection conWithF, HashMap<String, Object> hm) throws Exception {
		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("vendor_id", "~default");
		valuesMap.put("vendor_name", hm.get("vendorName"));
		valuesMap.put("mobile_number", (hm.get("mobileNumber").toString()));
		valuesMap.put("city", hm.get("city"));
		valuesMap.put("address", hm.get("address"));
		valuesMap.put("activate_flag", "1");
		valuesMap.put("created_Date", "~sysdate()");
		valuesMap.put("updated_by", "~null");
		valuesMap.put("updated_Date", "~null");
		valuesMap.put("alternate_mobile_no", hm.get("alternate_mobile_no"));
		valuesMap.put("app_id", hm.get("app_id"));
		valuesMap.put("vendor_reference", hm.get("vendor_reference"));
		valuesMap.put("gst_no", hm.get("gstno"));
		valuesMap.put("business_name", hm.get("business_name"));
		Query q = new Query("mst_vendor", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);
	}

	public long addVehicle(Connection conWithF, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("flatId"));
		parameters.add(hm.get("vehicleName"));
		parameters.add(hm.get("vehicleNumber"));
		parameters.add(hm.get("drptype"));
		parameters.add(hm.get("userId"));

		String insertQuery = "INSERT INTO mst_vehicle\r\n"
				+ "VALUES(default, ?, ?, ?, ?,?,sysdate(),1);";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public List<LinkedHashMap<String, Object>> getVehicleMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		
		String query="select\r\n"
				+ "	*\r\n"
				+ "from\r\n"
				+ "	mst_vehicle mv,mst_flat mf,mst_block mb,flat_owner_mapping fom,mst_person mp  \r\n"
				+ "where\r\n"
				+ "	mv.activate_flag = 1 and mv.flat_id =mf.flat_id and mb.block_id=mf.block_id and fom.flat_id=mf.flat_id and fom.person_id=mp.person_id";
		
		
		if(hm.get("blockId")!=null && !hm.get("blockId").equals("-1") && !hm.get("blockId").equals(""))
		{
			parameters.add(hm.get("blockId"));
			query +=" and mb.block_id=?";
		}

		if(hm.get("vehicleType")!=null && !hm.get("vehicleType").equals("-1") && !hm.get("vehicleType").equals(""))
		{
			parameters.add(hm.get("vehicleType"));
			query +=" and mv.type=?";
		}

		query+=" order by mb.block_name,mf.flat_name";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public long updateVendor(Connection conWithF, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("vendorName"));
		parameters.add(Long.parseLong(hm.get("mobileNumber").toString()));
		parameters.add(hm.get("city"));
		parameters.add(hm.get("address"));
		parameters.add(hm.get("user_id"));

		parameters.add(hm.get("alternate_mobile_no"));

		parameters.add(hm.get("vendor_reference"));
		parameters.add(hm.get("gstno"));
		parameters.add(hm.get("business_name"));

		parameters.add(hm.get("hdnVendorId"));

		String insertQuery = "update mst_vendor  "
				+ " SET vendor_name=?, mobile_number=?, city=?, address=?,"
				+ " updated_by=?, updated_Date=sysdate(), alternate_mobile_no=?,"
				+ " vendor_reference=?, gst_no=?, business_name=? where vendor_id=? ";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public LinkedHashMap<String, String> getCustomerDetails(long customerId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(Long.valueOf(customerId));
		return getMap(parameters,
				"select *,date_format(dob,'%d/%m/%Y') as Formattedbirthday,date_format(anniversary,'%d/%m/%Y') as formattedAnniversary from mst_customer where customer_id=?",
				con);
	}

	

	public LinkedHashMap<String, String> getInvoiceIdByInvoiceNo(String invoiceNo, String appId, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add((invoiceNo));
		parameters.add((appId));
		return getMap(parameters, "select * from trn_invoice_register where invoice_no=? and app_id=?", con);
	}

	public LinkedHashMap<String, String> getInvoiceNoByInvoiceId(String invoiceId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add((invoiceId));
		return getMap(parameters, "select * from trn_invoice_register where invoice_id=?", con);
	}

	public LinkedHashMap<String, String> getVendorDetails(long customerId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(Long.valueOf(customerId));
		return getMap(parameters, "select * from mst_vendor where vendor_id=?", con);
	}

	public LinkedHashMap<String, String> getPendingAmountForThisCustomer(long customerId, String fromDate,
			String toDate, Connection con) throws SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select \r\n" + "customer.customer_name, customer.customer_type, \r\n"
				+ " coalesce ((select sum(amount) as paid from "
				+ " trn_payment_register tpr where activate_flag=1 and  customer_id=customer.customer_id datesConditionPayment),0) -  coalesce ((select sum(total_amount) as toPay from trn_invoice_register where activate_flag=1 and customer_id=customer.customer_id datesConditionInvoice),0) "
				+ " PendingAmount "
				+ " from mst_customer customer where customer_id =?";

		if (!fromDate.equals("")) {
			query = query.replaceAll("datesConditionInvoice", " and date(invoice_date) between ? and ? ");
			parameters.add(getDateASYYYYMMDD(fromDate));
			parameters.add(getDateASYYYYMMDD(toDate));
			query = query.replaceAll("datesConditionPayment", " and date(payment_date) between ? and ? ");
			parameters.add(getDateASYYYYMMDD(fromDate));
			parameters.add(getDateASYYYYMMDD(toDate));
		} else {
			query = query.replaceAll("datesConditionInvoice", "");
			query = query.replaceAll("datesConditionPayment", "");
		}

		parameters.add(customerId);

		return getMap(parameters, query, con);
	}

	

	public List<LinkedHashMap<String, Object>> getStoreMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select store_id storeId,store_name storeName, address_line_1 address_line_1,address_line_2 address_line_2, store_email storeEmail from mst_store where activate_flag=1 and app_id=?",
				con);

	}
public List<LinkedHashMap<String, Object>> getBlockMaster(Connection con) throws ClassNotFoundException, SQLException {
	
		ArrayList<Object> parameters = new ArrayList<>();
		// parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select block_id blockId,block_name blockName from mst_block where activate_flag=1",
				con);

	}

	public List<LinkedHashMap<String, Object>> getShopMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		// parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select shop_id shopId,shop_name shopName from mst_shop where activate_flag=1",
				con);

	}

	public List<LinkedHashMap<String, Object>> getTermsMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select terms_condition_id termsId,terms_condition_content termscondition, `order` from mst_terms_and_conditions where app_id=?  and activate_flag=1 ",
				con);

	}

	public List<LinkedHashMap<String, Object>> getInvoiceFormatList(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		return getListOfLinkedHashHashMap(parameters,
				"select * from invoice_formats order by format_name",
				con);

	}

	public List<LinkedHashMap<String, Object>> getInvoiceTypeList(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		return getListOfLinkedHashHashMap(parameters,
				"select * from invoice_types",
				con);

	}

	public LinkedHashMap<String, String> getStoreDetails(long storeId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(storeId);
		return getMap(parameters,
				"select * from mst_store where store_id=?", con);

	}

	public LinkedHashMap<String, String> getShopDetails(long shopId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(shopId);
		return getMap(parameters,
				"select * from mst_shop where shop_id=?", con);

	}

	public LinkedHashMap<String, String> getBlockDetails(String blockId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(blockId);
		return getMap(parameters,
				"select * from mst_block where block_id=?", con);

	}

	public LinkedHashMap<String, String> gettermsAndConditionDetails(long termsId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(termsId);
		return getMap(parameters,
				"select * from mst_terms_and_conditions where terms_condition_id=?", con);

	}

	public long addStore(Connection conWithF, HashMap<String, Object> hm) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("storeName"));
		parameters.add(hm.get("address_line_1"));
		parameters.add(hm.get("storeEmail"));
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("address_line_2"));
		parameters.add(hm.get("city"));
		parameters.add(hm.get("pincode"));
		parameters.add(hm.get("gstno"));
		parameters.add(hm.get("mobile_no"));
		parameters.add(hm.get("address_line_3"));
		parameters.add(hm.get("storetiming"));

		String insertQuery = "insert into mst_store values (default,?,?,?,1,null,sysdate(),?,?,?,?,?,?,?,?)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public long addBlock(Connection conWithF, HashMap<String, Object> hm) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("blockName"));

		String insertQuery = "insert into mst_block values (default,?,null,null,1)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public long addShop(Connection conWithF, HashMap<String, Object> hm) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("shopName"));

		String insertQuery = "insert into mst_shop values (default,?,null,null,1)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public long addTermsAndCondition(Connection conWithF, HashMap<String, Object> hm) throws Exception {
		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("terms_condition_id", "~default");
		valuesMap.put("terms_condition_content", hm.get("termscondition"));
		valuesMap.put("order", hm.get("order"));
		valuesMap.put("app_id", hm.get("app_id"));
		Query q = new Query("mst_terms_and_conditions", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);
	}

	public String updateStore(long storeId, Connection conWithF, HashMap<String, Object> hm) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("storeName"));
		parameters.add(hm.get("address_line_1"));
		parameters.add(hm.get("address_line_2"));
		parameters.add(hm.get("city"));
		parameters.add(hm.get("pincode"));
		parameters.add(hm.get("storeEmail"));
		parameters.add(hm.get("gstno"));
		parameters.add(hm.get("mobile_no"));
		parameters.add(hm.get("address_line_3"));
		parameters.add(hm.get("storetiming"));

		parameters.add(storeId);
		insertUpdateDuablDB(
				"UPDATE mst_store  SET store_name=?, address_line_1 = ?,address_line_2 = ?,city=?,pincode=?, store_email=?, updated_date=SYSDATE(),gst_no=?,mobile_no=?,address_line_3=?,store_timing=? WHERE store_id=?",
				parameters, conWithF);
		return "Store Updated Succesfully";

	}

	public String updateBlock(long blockId, Connection conWithF, HashMap<String, Object> hm) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("blockName"));

		parameters.add(blockId);
		insertUpdateDuablDB(
				"UPDATE mst_block  SET block_name=?, updated_date=SYSDATE() WHERE block_id=?",
				parameters, conWithF);
		return "Block Updated Succesfully";

	}

	public String updateShop(long blockId, Connection conWithF, HashMap<String, Object> hm) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("shopName"));

		parameters.add(blockId);
		insertUpdateDuablDB(
				"UPDATE mst_shop  SET shop_name=?, updated_date=SYSDATE() WHERE shop_id=?",
				parameters, conWithF);
		return "Shop Updated Succesfully";

	}

	public String updateTermsAndCondition(long termsId, Connection conWithF, HashMap<String, Object> hm)
			throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("termscondition"));
		parameters.add(hm.get("order"));
		parameters.add(hm.get("app_id"));

		parameters.add(termsId);
		insertUpdateDuablDB(
				"UPDATE mst_terms_and_conditions  SET terms_condition_content=?,`order` = ?,app_id=? WHERE terms_condition_id=?",
				parameters, conWithF);
		return "Terms And Condition Updated Succesfully";

	}

	public String deleteStore(long storeId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(storeId);
		insertUpdateDuablDB("UPDATE mst_store  SET activate_flag=0,updated_date=SYSDATE() WHERE store_id=?", parameters,
				conWithF);
		return "Store Deleted Succesfully";
	}

	public String deleteblock(long blockId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(blockId);
		insertUpdateDuablDB("UPDATE mst_block  SET activate_flag=0,updated_date=SYSDATE() WHERE block_id=?",
				parameters,
				conWithF);
		return "Block Deleted Succesfully";
	}

	public String deleteShop(long shopId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(shopId);
		insertUpdateDuablDB("UPDATE mst_shop  SET activate_flag=0,updated_date=SYSDATE() WHERE shop_id=?",
				parameters,
				conWithF);
		return "Shop Deleted Succesfully";
	}

	public String deleteTermsAndCondition(long termsId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(termsId);

		insertUpdateDuablDB("UPDATE mst_terms_and_conditions  SET activate_flag=0 WHERE terms_condition_id=?",
				parameters, conWithF);
		return "Terms And Condition  deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getDailyInvoiceDetails(HashMap<String, Object> hm1, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm1.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm1.get("toDate").toString()));
		parameters.add(hm1.get("app_id"));

		String query = "select *,date_format(inv.invoice_date,'%d/%m/%Y') as FormattedInvoiceDate,date_format(inv.updated_date,'%d/%m/%Y %H:%i:%s') as updatedDate,inv.activate_flag isActive from trn_invoice_register inv"
				+ " left outer join mst_customer cust on inv.customer_id=cust.customer_id and inv.app_id=cust.app_id  "
				+ "left outer join tbl_user_mst usertbl on inv.updated_by = usertbl.user_id "
				+ " left outer join trn_payment_register paymnt on inv.invoice_id =paymnt.ref_id and paymnt.activate_flag=1 and paymnt.payment_for='invoice' and paymnt.app_id = inv.app_id "
				+ " inner join mst_store store1 on inv.store_id=store1.store_id left outer join rlt_invoice_fuel_details rifd on rifd.invoice_id = inv.invoice_id "
				+ "where date(invoice_date) between ? and ?  and inv.app_id=?   "
				+ "and usertbl.app_id=inv.app_id and store1.app_id=inv.app_id and inv.activate_flag=1 ";

		if (hm1.get("customerId") != null && !hm1.get("customerId").equals("") && !hm1.get("customerId").equals("-1")) {
			parameters.add(hm1.get("customerId").toString());
			query += " and cust.customer_id =?";
		}

		if (Boolean.parseBoolean(hm1.get("deleteFlag").toString()) == true) {
			query = query.replaceAll("and inv.activate_flag=1", "");
		}
		if (hm1.get("storeId") != null && !hm1.get("storeId").equals("") && !hm1.get("storeId").equals("-1")) {
			parameters.add(hm1.get("storeId").toString());
			query += " and inv.store_id =?";
		}

		if (hm1.get("updatedBy") != null && !hm1.get("updatedBy").equals("")) {
			parameters.add(hm1.get("updatedBy").toString());
			query += " and inv.updated_by =?";
		}

		if (hm1.get("paymentType") != null && !hm1.get("paymentType").equals("")) {

			String questionMarks = "";
			for (String s : hm1.get("paymentType").toString().split(",")) {
				questionMarks += "?" + ",";
				parameters.add(s);
			}
			questionMarks = questionMarks.substring(0, questionMarks.length() - 1);
			query += " and inv.payment_type in (" + questionMarks + ")";
		}

		if (hm1.get("discount") != null && !hm1.get("discount").equals("")) {

			query += " and (inv.item_discount!=0 or inv.invoice_discount!=0) ";
		}

		if (hm1.get("attendant_id") != null && !hm1.get("attendant_id").equals("")) {

			query += " and rifd.attendant_id=? ";

			parameters.add(hm1.get("attendant_id"));
		}

		query += " order by invoice_date,rifd.invoice_id asc ";
		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getSalesReport3(HashMap<String, Object> hm1, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm1.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm1.get("toDate").toString()));
		parameters.add(hm1.get("app_id"));

		String query = "select *,date_format(inv.invoice_date,'%d/%m/%Y') as FormattedInvoiceDate,date_format(inv.updated_date,'%d/%m/%Y %H:%i:%s') as updatedDate,inv.activate_flag isActive,round(dtls.custom_rate*dtls.qty) amt from trn_invoice_register inv "
				+ " inner join trn_invoice_details dtls on dtls.invoice_id=inv.invoice_id "
				+ "inner join mst_items item on  item.item_id=dtls.item_id "
				+ "inner join mst_category category on item.parent_category_id=category.category_id "
				+ " left outer join mst_customer cust on inv.customer_id=cust.customer_id and inv.app_id=cust.app_id  "
				+ "left outer join tbl_user_mst usertbl on inv.updated_by = usertbl.user_id "
				+ " left outer join trn_payment_register paymnt on inv.invoice_id =paymnt.ref_id and paymnt.activate_flag=1 and paymnt.payment_for='invoice' and paymnt.app_id = inv.app_id "
				+ " inner join mst_store store1 on inv.store_id=store1.store_id "
				+ "where date(invoice_date) between ? and ?  and inv.app_id=?   "
				+ "and usertbl.app_id=inv.app_id and store1.app_id=inv.app_id and inv.activate_flag=1 ";

		if (hm1.get("customerId") != null && !hm1.get("customerId").equals("") && !hm1.get("customerId").equals("-1")) {
			parameters.add(hm1.get("customerId").toString());
			query += " and cust.customer_id =?";
		}

		if (Boolean.parseBoolean(hm1.get("deleteFlag").toString()) == true) {
			query = query.replaceAll("and inv.activate_flag=1", "");
		}
		if (hm1.get("storeId") != null && !hm1.get("storeId").equals("") && !hm1.get("storeId").equals("-1")) {
			parameters.add(hm1.get("storeId").toString());
			query += " and inv.store_id =?";
		}

		if (hm1.get("updatedBy") != null && !hm1.get("updatedBy").equals("")) {
			parameters.add(hm1.get("updatedBy").toString());
			query += " and inv.updated_by =?";
		}

		if (hm1.get("paymentType") != null && !hm1.get("paymentType").equals("")) {

			String questionMarks = "";
			for (String s : hm1.get("paymentType").toString().split(",")) {
				questionMarks += "?" + ",";
				parameters.add(s);
			}
			questionMarks = questionMarks.substring(0, questionMarks.length() - 1);
			query += " and inv.payment_type in (" + questionMarks + ")";
		}

		if (hm1.get("discount") != null && !hm1.get("discount").equals("")) {

			query += " and (inv.item_discount!=0 or inv.invoice_discount!=0) ";
		}

		query += " order by invoice_date,inv.invoice_id asc ";
		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getSalesReport4(HashMap<String, Object> hm1, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm1.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm1.get("toDate").toString()));

		parameters.add(hm1.get("app_id"));

		String query = "select item_name,sum(tid.qty*tid.custom_rate) as amt from\r\n"
				+ "trn_invoice_register tir,\r\n"
				+ "trn_invoice_details tid,\r\n"
				+ "mst_items mi\r\n"
				+ "where invoice_date between ? and ? and tid.item_id =mi.item_id\r\n"
				+ "and tir.app_id =? and tid.invoice_id =tir.invoice_id  \r\n";

		if (hm1.get("storeId") != null && !hm1.get("storeId").equals("") && !hm1.get("storeId").equals("-1")) {
			query += " and tir.store_id=? ";
			parameters.add(hm1.get("storeId"));
		}
		query += " group by mi.item_name order by amt desc";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getShiftData(HashMap<String, Object> hm1, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm1.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm1.get("txttodate").toString()));
		parameters.add(hm1.get("app_id"));

		String query = "select *, name,date_format(date(check_in_time),'%d/%m/%Y') dtcheckin,\r\n"
				+ "concat(shift_name,' - ',from_time,' to ',to_time) shiftNameConcat,\r\n"
				+ "nozzle_name,fm.item_name,opening_reading,closing_reading,\r\n"
				+ "(closing_reading-opening_reading) diffReading from\r\n"
				+ "trn_nozzle_register tnr ,shift_master sm,\r\n"
				+ "nozzle_master nm ,mst_items fm ,tbl_user_mst tum\r\n"
				+ "where\r\n"
				+ "tnr.shift_id=sm.shift_id and nm.nozzle_id =tnr.nozzle_id and nm.item_id =fm.item_id and tum.user_id =tnr.user_id\r\n"
				+ "and date(check_in_time) between ? and ? and tnr.app_id=? order by tnr.check_in_time";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getStockRegister(HashMap<String, Object> hm1, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm1.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm1.get("toDate").toString()));
		parameters.add(hm1.get("app_id"));

		String query = "select store_name,item_name,qty,type,invoice_id,name,stockreg.updated_date,date_format(stockreg.updated_date,'%d/%m/%Y %H:%i') as FormattedUpdatedDate from \r\n"
				+ "trn_stock_register stockreg,\r\n" + "mst_items  item ,\r\n" + "mst_store store,\r\n"
				+ "tbl_user_mst user\r\n" + "					where \r\n"
				+ "					date(stockreg.updated_date) between ? and ? and  \r\n"
				+ "					item.item_id=stockreg.item_id and user.user_id=stockreg.updated_by\r\n"
				+ "					and stockreg.store_id=store.store_id and stockreg.app_id=?";
		if (!hm1.get("storeId").toString().equals("-1")) {
			parameters.add(hm1.get("storeId").toString());
			query += " and stockreg.store_id=?";
		}

		query += " order by stockreg.updated_date desc";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getInventoryCountingListForThisStore(HashMap<String, Object> hm1,
			Connection con) throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select store_name,item_name,qty,type,invoice_id,name,stockreg.updated_date,date_format(stockreg.updated_date,'%d/%m/%Y %H:%i') as FormattedUpdatedDate from \r\n"
				+ "trn_stock_register stockreg,\r\n" + "mst_items  item ,\r\n" + "mst_store store,\r\n"
				+ "tbl_user_mst user\r\n" + "					where \r\n" + "					  \r\n"
				+ "					item.item_id=stockreg.item_id and user.user_id=stockreg.updated_by\r\n"
				+ "					and stockreg.store_id=store.store_id and stockreg.type=?";
		parameters.add(hm1.get("stockType"));
		if (!hm1.get("storeId").toString().equals("-1")) {
			parameters.add(hm1.get("storeId").toString());
			query += " and stockreg.store_id=?";
		}

		query += " order by stockreg.updated_date desc";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getDailyDebitRegister(HashMap<String, Object> hm, Connection con)
			throws ParseException, ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add(hm.get("app_id"));

		String query = "select *,date_format(payment_date,'%d/%m/%Y') as FormattedPaymentDate,payment_for,name,date_format(inv.updated_date,'%d/%m/%Y %H:%i') as FormattedUpdatedDate  \r\n"
				+ "				 from trn_payment_register inv left outer join mst_customer cust on inv.customer_id=cust.customer_id\r\n"
				+ "				  inner join tbl_user_mst user on user.user_id=inv.updated_by\r\n"
				+ "				  where date(payment_date) between ? and ?  and inv.activate_flag=1 and inv.app_id=? and payment_for in ('Debit Entry') ";

		if (hm.get("paymentMode") != null && !hm.get("paymentMode").equals("")) {
			query += " and payment_mode=?";
			parameters.add(hm.get("paymentMode"));
		}

		if (hm.get("storeId") != null && !hm.get("storeId").equals("")) {
			query += "and inv.store_id = ?";
			parameters.add(hm.get("storeId"));
		}

		if (hm.get("paymentFor") != null && !hm.get("paymentFor").equals("")) {
			query += " and inv.payment_for = ?";
			parameters.add(hm.get("paymentFor"));
		}

		query += "order by inv.updated_date desc;";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getDailyPaymentRegister(HashMap<String, Object> hm, Connection con)
			throws ParseException, ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add(hm.get("app_id"));

		String query = "select *,date_format(payment_date,'%d/%m/%Y') as FormattedPaymentDate,payment_for,name,date_format(inv.updated_date,'%d/%m/%Y %H:%i') as FormattedUpdatedDate \r\n"
				+ "				 from trn_payment_register inv left outer join mst_customer cust on inv.customer_id=cust.customer_id\r\n"
				+ "				  inner join tbl_user_mst user on user.user_id=inv.updated_by left outer join rlt_invoice_fuel_details rifd on rifd.invoice_id =inv.ref_id \r\n"
				+ "				  where date(payment_date) between ? and ?  and inv.activate_flag=1 and inv.app_id=? and payment_for not in ('Debit Entry') ";

		if (hm.get("paymentMode") != null && !hm.get("paymentMode").equals("")) {
			query += " and payment_mode=?";
			parameters.add(hm.get("paymentMode"));
		}

		if (hm.get("storeId") != null && !hm.get("storeId").equals("")) {
			query += "and inv.store_id = ?";
			parameters.add(hm.get("storeId"));
		}

		if (hm.get("paymentFor") != null && !hm.get("paymentFor").equals("")) {
			query += " and inv.payment_for = ?";
			parameters.add(hm.get("paymentFor"));
		}

		if (hm.get("attendant_id") != null && !hm.get("attendant_id").equals("")) {
			query += " and rifd.attendant_id = ?";
			parameters.add(hm.get("attendant_id"));
		}

		query += "order by inv.updated_date desc;";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getPendingCustomerCollection(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add(hm.get("app_id"));

		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add(hm.get("app_id"));

		return getListOfLinkedHashHashMap(parameters,
				"select sum(amount) PendingAmount,T.customer_id,T.customer_name,T.mobile_number ,T.customer_reference,T.alternate_mobile_no,T.city from \r\n"
						+
						"(\r\n" +
						"select mc.customer_id,mc.customer_name,mc.mobile_number ,mc.alternate_mobile_no,mc.customer_reference, mc.city,(tir.total_amount) amount from mst_customer mc\r\n"
						+
						"left outer join trn_invoice_register tir on tir.activate_flag=1 and mc.customer_id =tir.customer_id and tir.invoice_date  between ? and ?  and mc.app_id=?\r\n"
						+
						"union all\r\n" +
						"select mc.customer_id,mc.customer_name,mc.mobile_number ,mc.alternate_mobile_no,mc.customer_reference ,mc.city,(tpr.amount*-1)  from mst_customer mc\r\n"
						+
						"left outer join trn_payment_register tpr on mc.customer_id =tpr.customer_id and tpr.payment_date  between ? and ? and mc.app_id=? and tpr.activate_flag =1 \r\n"
						+
						")\r\n" +
						" as T group by T.customer_id having PendingAmount>0 order by T.customer_name",
				con);

	}

	public List<LinkedHashMap<String, Object>> getEmployeeWiseReport(HashMap<String, Object> hm, Connection con)
			throws ParseException, ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add(hm.get("storeId").toString());

		return getListOfLinkedHashHashMap(parameters,
				"select username EmployeeName, c.store_name StoreName, invoice_date InvoiceDate, \r\n"
						+ " sum(total_amount) TotalAmount,date_format(a.updated_date,'%d/%m/%Y %H:%i') as FormattedInvoiceDate from trn_invoice_register a, tbl_user_mst b, mst_store c \r\n"
						+ " where a.updated_by = b.user_id and a.store_id = c.store_id and a.invoice_date between ? and ? \r\n"
						+ " and a.store_id = ? and a.activate_flag=1 group by a.invoice_date,a.updated_by;",
				con);
	}

	public List<LinkedHashMap<String, Object>> getCategoryWiseReport(HashMap<String, Object> hm, Connection con)
			throws ParseException, ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add((hm.get("app_id").toString()));

		return getListOfLinkedHashHashMap(parameters,
				"select cat.category_name CategoryName, sto.store_name StoreName,\r\n "
						+ " sum(total_amount) TotalAmount from trn_invoice_register tir, trn_invoice_details tid,\r\n"
						+ " mst_items itm, mst_category cat, mst_store sto where tir.invoice_id=tid.invoice_id and tid.item_id = itm.item_id\r\n"
						+ " and itm.parent_category_id = cat.category_id and tir.store_id = sto.store_id and tir.invoice_date between ? and ? \r\n"
						+ " and tir.activate_flag=1 and tir.app_id=? group by tir.store_id,itm.parent_category_id;",
				con);
	}

	public long getSequenceForItem(Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		long product_code = Long.parseLong(
				getMap(parameters, "select current_seq_no from seq_master where sequence_name='Item' for update ",
						conWithF).get("current_seq_no"));
		insertUpdateDuablDB("update seq_master set  current_seq_no=current_seq_no+1 where sequence_name='Item' ",
				parameters, conWithF);
		return product_code + 1;
	}

	public boolean checkIfProductCodeAlreadyExist(HashMap<String, Object> hm, Connection conWithF)
			throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select count(1) cnt from mst_items where product_code=? and activate_flag=1 and app_id=?";
		parameters.add(hm.get("product_code"));
		parameters.add(hm.get("app_id"));
		if (!hm.get("hdnItemId").equals("")) {
			query += " and item_id!=?";
			parameters.add(hm.get("hdnItemId"));
		}
		int count = Integer.parseInt(getMap(parameters, query, conWithF).get("cnt"));
		return count != 0;
	}

	public String checkifStockAlreadyExist(long storeId, long itemId, Connection con)
			throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(storeId);
		parameters.add(itemId);
		String stockId = getMap(parameters,
				"select stock_id from stock_status where store_id=? and item_id=? and activate_flag=1", con)
				.get("stock_id");
		stockId = stockId == null ? "0" : stockId;
		return stockId;
	}

	public void addStoreItemMapping(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("hdnItemId"));
		insertUpdateDuablDB("delete from store_item_mpg where item_id=?", parameters, conWithF);

		List<String> availableStoreIds = (List<String>) hm.get("availableStoreIds");
		for (String s : availableStoreIds) {
			parameters = new ArrayList<>();
			parameters.add(s);
			parameters.add(hm.get("hdnItemId"));
			parameters.add(hm.get("app_id"));

			insertUpdateDuablDB("insert into store_item_mpg values (default,?,?,sysdate(),1,?)", parameters, conWithF);
		}

	}

	public List<String> getListOfStoresForThisItem(String itemId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemId);
		return getListOfString(parameters, "select store_id from store_item_mpg where item_id=?", con);

	}

	public List<String> getListOfTermsAndConditionForThisItem(String termsId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(termsId);
		return getListOfString(parameters,
				"select terms_condition_id from mst_terms_and_conditions where terms_condition_id=?", con);

	}

	public List<String> ListOfTermsAndCondition(String itemId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemId);
		return getListOfString(parameters, "select terms_condition_id from mst_terms_and_conditions where app_id=?",
				con);

	}

	public List<LinkedHashMap<String, Object>> getTableStatus(int storeId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(storeId);
		return getListOfLinkedHashHashMap(parameters, "select table1.table_id,table_no,tor.*,dtls.*,item.*,\r\n"
				+ "	concat('', SEC_TO_TIME(TIMESTAMPDIFF(second, start_time, sysdate() ))) activeSince,\r\n"
				+ "	sum(qty) totalQty,\r\n"
				+ "	sum(qty*price) totalAmount from  mst_tables table1 "
				+ " left outer join trn_order_register tor on tor.order_id =table1.order_id left outer join trn_order_details dtls on dtls.order_id=tor.order_id left outer join mst_items item on item.item_id=dtls.item_id "
				+ "where store_id =? group by table1.table_id", con);

	}

	public List<LinkedHashMap<String, Object>> getListOfTables(int storeId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(storeId);
		return getListOfLinkedHashHashMap(parameters,
				"select * from  mst_tables mt  where  store_id=? and order_id is not null order by table_no", con);

	}

	public List<LinkedHashMap<String, Object>> getListOfTablesForOnGoingOrders(int storeId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(storeId);
		return getListOfLinkedHashHashMap(parameters, "select\r\n"
				+ "	distinct(mt.table_id),table_no \r\n"
				+ "from\r\n"
				+ "	mst_tables mt,\r\n"
				+ "	trn_order_register tor ,\r\n"
				+ "	trn_order_details tod \r\n"
				+ "where\r\n"
				+ "	store_id =?\r\n"
				+ "	and mt.order_id is not null\r\n"
				+ "	and tor.order_id =mt.order_id and tor.order_id =tod.order_id \r\n"
				+ "	and served_time is null\r\n"
				+ "order by\r\n"
				+ "	table_no;\r\n"
				+ "	", con);

	}

	public LinkedHashMap<String, Object> getInvoiceDetails(String invoiceId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(invoiceId);
		LinkedHashMap<String, Object> itemDetailsMap = new LinkedHashMap<>();
		itemDetailsMap = getMapReturnObject(parameters, "select \r\n" + "*,\r\n"
				+ "case when cust.customer_id is null then \"\" else customer_name end  as customerName,\r\n"
				+ "date_format(invoice_date,'%d/%m/%Y') theInvoiceDate,\r\n" + "sum(qty) totalQuantities,\r\n"
				+ "paym.amount as paid_amount,date_format(invoice.updated_date,'%d/%m/%Y %h:%i%p') theUpdatedDate"
				+ ",dtls.sgst_amount ,dtls.sgst_percentage ,dtls.cgst_amount ,dtls.sgst_percentage \r\n" + " from\r\n"
				+ " trn_invoice_register invoice inner join mst_store store1 on store1.store_id=invoice.store_id left outer join  mst_customer cust on cust.customer_id=invoice.customer_id and invoice.activate_flag=1 \r\n"
				+ " inner join  trn_invoice_details dtls on  dtls.invoice_id=invoice.invoice_id left outer join  trn_payment_register paym on paym.ref_id=invoice.invoice_id and paym.payment_for='Invoice'\r\n"
				+ "where invoice.invoice_id=? order by dtls.details_id", con);

		parameters = new ArrayList<>();
		parameters.add(invoiceId);

		itemDetailsMap.put("listOfItems",
				getListOfLinkedHashHashMap(parameters, "select tsd.*,item.*,dtls.*,cat.*,return1.*,"
						+ "(select case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as ImagePath from tbl_attachment_mst tam2 "
						+ "where tam2.file_id=item.item_id and tam2.type='Image' limit 1 ) ImagePath,"
						+ " sum(coalesce(qty_to_return,0)) ReturnedQty,dtls.details_id theDetailsId \r\n"
						+ "from mst_items item  inner join trn_invoice_details dtls on item.item_id=dtls.item_id "
						+ "inner join mst_category cat on cat.category_id=item.parent_category_id \r\n"
						+ "	left outer join trn_return_register return1 on return1.details_id=dtls.details_id left outer join trn_sph_details tsd on tsd.details_id=dtls.details_id \r\n"
						+ "where\r\n" + "invoice_id = ? group by dtls.details_id  order by dtls.details_id ", con));
		return itemDetailsMap;

	}

	public LinkedHashMap<String, Object> getQuoteDetails(String quoteId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(quoteId);
		LinkedHashMap<String, Object> itemDetailsMap = new LinkedHashMap<>();
		itemDetailsMap = getMapReturnObject(parameters, "select \r\n" + "*,\r\n"
				+ "case when cust.customer_id is null then \"\" else customer_name end  as customerName,\r\n"
				+ "date_format(quote_date,'%d/%m/%Y') theQuoteDate,\r\n" + "sum(qty) totalQuantities\r\n"
				+ " from\r\n"
				+ " trn_quote_register invoice inner join mst_store store1 on store1.store_id=invoice.store_id left outer join  mst_customer cust on cust.customer_id=invoice.customer_id and invoice.activate_flag=1 \r\n"
				+ " inner join  trn_quote_details dtls on  dtls.quote_id=invoice.quote_id inner join mst_items item on item.item_id=dtls.item_id \r\n"
				+ "where invoice.quote_id=? order by dtls.details_id", con);

		parameters = new ArrayList<>();
		parameters.add(quoteId);

		itemDetailsMap.put("listOfItems",
				getListOfLinkedHashHashMap(parameters, "select item.*,dtls.*,cat.*,"
						+ "(select case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as ImagePath from tbl_attachment_mst tam2 "
						+ "where tam2.file_id=item.item_id and tam2.type='Image' limit 1 ) ImagePath "
						+ "from mst_items item  inner join trn_quote_details dtls on item.item_id=dtls.item_id "
						+ "inner join mst_category cat on cat.category_id=item.parent_category_id \r\n"
						+ "	 \r\n"
						+ "where\r\n" + "quote_id = ? group by dtls.details_id  order by dtls.details_id ", con));
		return itemDetailsMap;

	}

	public LinkedHashMap<String, Object> getInvoiceDetailsForTable(String tableId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(tableId);
		LinkedHashMap<String, Object> itemDetailsMap = new LinkedHashMap<>();
		itemDetailsMap.put("invoice_id", "0");
		itemDetailsMap.put("theInvoiceDate", getDateFromDB(con));
		itemDetailsMap.put("listOfItems",
				getListOfLinkedHashHashMap(parameters, "select\r\n"
						+ "	mt.table_no,item_name,mi.item_id,price as rate,price as custom_rate,sum(qty) qty,mi.sgst sgst_percentage,mi.cgst cgst_percentage,"
						+ "price*sgst/100 as sgst_amount,price*cgst/100 as cgst_amount \r\n"
						+ "from\r\n"
						+ "	mst_tables mt,trn_order_details tod,mst_items mi \r\n"
						+ "where\r\n"
						+ "	table_id = ? and tod.order_id =mt.order_id and mi.item_id =tod.item_id group by item_id",
						con));
		return itemDetailsMap;

	}

	public LinkedHashMap<String, Object> getInvoiceDetailsForBooking(String bookingId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(bookingId);
		LinkedHashMap<String, Object> itemDetailsMap = new LinkedHashMap<>();
		itemDetailsMap.put("invoice_id", "0");
		itemDetailsMap.put("theInvoiceDate", getDateFromDB(con));
		itemDetailsMap.put("listOfItems",
				getListOfLinkedHashHashMap(parameters, "select\r\n"
						+ "*,tbr.booking_id,item_name,mi.item_id,price as rate,price as custom_rate,qty \r\n"
						+ "from\r\n"
						+ "	trn_booking_register tbr,booking_item_mpg bim,mst_items mi,mst_customer cust \r\n"
						+ "where\r\n"
						+ "	tbr.booking_id=? and bim.booking_id =tbr.booking_id and mi.item_id =bim.item_id and cust.customer_id=tbr.customer_id",
						con));
		return itemDetailsMap;

	}

	public LinkedHashMap<String, Object> getInvoiceDetailsForMobileBooking(String bookingId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(bookingId);
		LinkedHashMap<String, Object> itemDetailsMap = new LinkedHashMap<>();
		itemDetailsMap.put("invoice_id", "0");
		itemDetailsMap.put("theInvoiceDate", getDateFromDB(con));
		itemDetailsMap.put("listOfItems",
				getListOfLinkedHashHashMap(parameters, "select\r\n"
						+ "	*,price as rate,price as custom_rate,quantity qty,date_format(torf.created_date, '%d/%m/%Y %H:%i') as FormattedCreatedDate \r\n"
						+ "from\r\n"
						+ "	trn_order_register_frommobileapp torf ,\r\n"
						+ "	trn_suborder_register tsr,\r\n"
						+ "	customer_user_mpg cum ,\r\n"
						+ "	mst_items mi \r\n"
						+ "where\r\n"
						+ "	torf.order_id = tsr.order_id and cum.user_id =torf .user_id and torf.order_id =? and tsr.item_id =mi.item_id ;",
						con));
		return itemDetailsMap;

	}

	public List<LinkedHashMap<String, Object>> getConsolidatedPaymentModeCollection(HashMap<String, Object> hm1,
			Connection con) throws ClassNotFoundException, SQLException, ParseException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm1.get("app_id"));
		parameters.add(getDateASYYYYMMDD(hm1.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm1.get("toDate").toString()));

		String query = "select\r\n" + "	store.store_name StoreName,\r\n" + "	sum(amount) TotalAmount,\r\n"
				+ "	payment_mode PaymentMode,\r\n" + "	payment_date PaymentDate,\r\n"
				+ "	date_format(invoice.payment_date, '%d/%m/%Y %H:%i') as FormattedInvoiceDate\r\n" + "from\r\n"
				+ "	trn_payment_register invoice,\r\n" + "	mst_store store\r\n" + "where\r\n"
				+ "	invoice.store_id = store.store_id and invoice.app_id=?\r\n"
				+ "	and date(payment_date) between ? and ?  and invoice.activate_flag=1 ";

		if (!hm1.get("storeId").toString().equals("-1")) {
			query += " and store.store_id=? ";
			parameters.add(hm1.get("storeId").toString());
		}
		query += "group by PaymentDate,payment_mode order by payment_date desc";
		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getPaymentTypeCollectionCollection(HashMap<String, Object> hm1,
			Connection con) throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add((hm1.get("app_id").toString()));
		parameters.add(getDateASYYYYMMDD(hm1.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm1.get("toDate").toString()));
		String query = "select store.store_name StoreName,payment_type PaymentType,invoice_date InvoiceDate,sum(total_amount) Amount from "
				+
				"trn_invoice_register invoice, mst_store store where invoice.activate_flag=1 and invoice.store_id=store.store_id and invoice.app_id=? and date(invoice_date) between ? and ? \r\n";

		if (!hm1.get("storeId").toString().equals("-1")) {
			parameters.add(hm1.get("storeId").toString());
			query += " and store.store_id=? ";
		}
		query += " group by payment_type,store.store_id, invoice_date order by invoice_date desc";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public String updateGroup(long categoryId, Connection conWithF, String categoryName) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(categoryName);
		parameters.add(categoryId);
		insertUpdateDuablDB("UPDATE customer_group  SET group_Name=?,updated_date=SYSDATE() WHERE group_id=?",
				parameters, conWithF);
		return "Group updated Succesfully";

	}

	public String deleteGroup(long itemId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemId);
		insertUpdateDuablDB("UPDATE customer_group  SET activate_flag=0 WHERE group_id=?", parameters, conWithF);
		return "Group Deleted Succesfully";
	}

	public long updateLowStockDetails(long stock_id, long lowqty, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(lowqty);
		parameters.add(stock_id);
		return insertUpdateDuablDB("update stock_status set low_stock_limit=? where stock_id=?", parameters, conWithF);

	}

	public long addGroup(Connection conWithF, String groupName, String appId) throws Exception {

		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("group_id", "~default");
		valuesMap.put("group_name", groupName);
		valuesMap.put("updated_by", "1");
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("activate_flag", "1");
		valuesMap.put("app_id", appId);

		Query q = new Query("customer_group", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);
	}

	public List<LinkedHashMap<String, Object>> getCustomerGroup(String appId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfLinkedHashHashMap(parameters, "select * from customer_group where activate_flag=1 and app_id=?",
				con);
	}

	public LinkedHashMap<String, String> getGroupDetails(long categoryId, Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(categoryId);
		return getMap(parameters, "select * from customer_group where group_id=?", con);
	}

	public LinkedHashMap<String, String> getInvoiceSubDetails(long detailId, Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(detailId);
		return getMap(parameters, "select\r\n"
				+ "	register.customer_id,dtls.custom_rate,register.invoice_id,dtls.item_id,dtls.details_id,item_name,qty-coalesce(sum( qty_to_return),0) returnAbleQty\r\n"
				+ "from\r\n" + "	trn_invoice_register register,\r\n" + "	\r\n"
				+ " 	mst_items item ,trn_invoice_details dtls left outer join\r\n"
				+ "	trn_return_register ret on ret.details_id=dtls.details_id where\r\n"
				+ "	dtls.details_id =?\r\n" + "	and item.item_id = dtls.item_id\r\n"
				+ "	 and register.activate_flag=1 and register.invoice_id = dtls.invoice_id;\r\n" + "\r\n" + "\r\n"
				+ "", con);
	}

	public void insertToTrnReturnRegister(long detailsId, Double returnqty, String userId, String appId,
			Connection conWithF)
			throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(detailsId);
		parameters.add(returnqty);
		parameters.add(userId);
		parameters.add(appId);
		insertUpdateDuablDB("insert into trn_return_register values (default,?,?,?,sysdate(),?);", parameters,
				conWithF);
	}

	public LinkedHashMap<String, String> getuserDetailsById(long userId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		return getMap(parameters, "select * from tbl_user_mst where user_id=?", con);

	}

	public String updateStoreForThisUser(long storeId, String userId, Connection conWithF) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(storeId);
		parameters.add(userId);
		insertUpdateDuablDB("update tbl_user_mst set store_id=? where user_id=?", parameters, conWithF);
		return "Updated Succesfully";
	}

	public String updateConfigurationForThisUser(long invoiceFormat, String invoice_default_checked_print,
			String invoice_default_checked_generatepdf, String restaurant_default_checked_generatepdf,
			String user_total_payments, String user_payment_collections, String user_counter_sales,
			String user_payment_sales, String user_store_sales, String user_store_bookings, String user_store_expenses,
			String userId, String invoiceType, Connection conWithF) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(invoiceFormat);

		parameters.add(invoice_default_checked_print);
		parameters.add(invoice_default_checked_generatepdf);
		parameters.add(restaurant_default_checked_generatepdf);
		parameters.add(user_total_payments);
		parameters.add(user_payment_collections);
		parameters.add(user_counter_sales);
		parameters.add(user_payment_sales);
		parameters.add(user_store_sales);
		parameters.add(user_store_bookings);
		parameters.add(user_store_expenses);
		parameters.add(invoiceType);

		parameters.add(userId);
		insertUpdateDuablDB("update user_configurations set invoice_format=?,invoice_default_checked_print=?,"
				+ "invoice_default_checked_generatepdf=?,restaurant_default_checked_generatepdf=?,user_total_payments=?,"
				+ "user_payment_collections=?,user_counter_sales=?,user_payment_sales=?,user_store_sales=?,user_store_bookings=?,"
				+ "user_store_expenses=?,invoice_type=? where user_id=?", parameters, conWithF);
		return "Updated Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getEmployeeMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		
		return getListOfLinkedHashHashMap(parameters,
				"select	* from tbl_user_mst user"
						+ " where user.activate_flag = 1 order by user.name",
				con);
	}

	public List<LinkedHashMap<String, Object>> getTimeline(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		return getListOfLinkedHashHashMap(parameters,
				" select sysdate() as testVariable from dual",
				con);
	}

	public List<LinkedHashMap<String, Object>> getEmployeeMasterForStore(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("store_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select	* from tbl_user_mst user,mst_store store"
						+ " where user.activate_flag = 1	and store.store_id = user.store_id and store.app_id=? and user.app_id=store.app_id and store.store_id=?",
				con);
	}

	public List<LinkedHashMap<String, Object>> getModelList(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select distinct(model) modelName from trn_booking_register where app_id=?",
				con);
	}

	public String updateEmployee(long employeeId, Connection conWithF, HashMap<String, Object> hm) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("username"));
		parameters.add(hm.get("EmployeeName"));
		parameters.add(Long.parseLong(hm.get("MobileNumber").toString()));
		parameters.add(hm.get("email").toString());
		parameters.add(Long.parseLong(hm.get("txtstore").toString()));

		parameters.add(employeeId);

		insertUpdateDuablDB(
				"UPDATE tbl_user_mst  SET username=?, name = ?,updated_date=SYSDATE(),mobile=?,email=?,store_id=? WHERE user_id=?",
				parameters, conWithF);
		return "Employee Updated Succesfully";

	}

	public long addEmployee(Connection conWithF, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("username"));
		parameters.add(getSHA256String("123"));
		parameters.add(hm.get("EmployeeName"));
		parameters.add(hm.get("MobileNumber").toString());
		parameters.add(hm.get("email").toString());
		parameters.add(Long.parseLong(hm.get("txtstore").toString()));
		parameters.add(Long.parseLong(hm.get("app_id").toString()));
		String insertQuery = "insert into tbl_user_mst values (default,?,?,sysdate(),null,1,?,?,?,?,?)";
		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public long addDefaultUserConfigurations(Connection conWithF, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("user_id"));

		String insertQuery = "insert into user_configurations (user_id,invoice_format) values (?,1)";
		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public long mapCustomerEmployee(long customerId, long employeeId, Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(customerId);
		parameters.add(employeeId);
		String insertQuery = "insert into customer_user_mpg values (?,?)";
		return insertUpdateDuablDB(insertQuery, parameters, con);
	}

	public LinkedHashMap<String, String> getEmployeeDetails(long customerId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(customerId);
		return getMap(parameters, "select  * from tbl_user_mst where user_id=?", con);
	}

	public boolean mobileNoAlreadyExist(String mobileNo, String appId, Connection con) throws SQLException {
		String query = "select count(1) as cnt from mst_customer where activate_flag=1 and mobile_number=? and app_id=?";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(mobileNo);
		parameters.add(appId);
		return !getMap(parameters, query, con).get("cnt").equals("0");
	}

	public List<LinkedHashMap<String, Object>> getItemHistory(long storeId, String itemId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(itemId);

		String query = "select *,invoice_id,qty,'' as custom_rate,"
				+ "	`type` as type,"
				+ "	date_format(tsr.updated_date, '%d/%m/%Y %H:%i:%s') as formattedUpdatedDate from"
				+ "	trn_stock_register tsr,mst_store store, tbl_user_mst user1 "
				+ "where item_id = ? and tsr.store_id = store.store_id "
				+ "	and tsr.updated_by = user1.user_id ";
		if (storeId != -1) {
			query += "and store.store_id=? ";
			parameters.add(storeId);
		}
		query += " order by tsr.stock_register_id desc";

		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getItemMasterHistoryForThisItem(String itemId, Connection con)
			throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(itemId);
		parameters.add(itemId);

		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_items where item_id=? Union all select * from hst_mst_items where item_id=? order by updated_date desc",
				con);

	}

	public boolean checkIfRoleUserAlreadyExist(long userId, Long roleId, Connection conWithF) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(roleId);
		return !getMap(parameters,
				"select count(1) cnt from acl_user_role_rlt where user_id=? and role_id=? and activate_flag=1",
				conWithF).get("cnt").equals("0");

	}

	public long addUserRoleMapping(long userId, Long roleId, String roleName, Connection conWithF) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(roleId);
		parameters.add(roleName);
		return insertUpdateDuablDB("insert into acl_user_role_rlt values (default,?,?,1,sysdate(),null,?)", parameters,
				conWithF);

	}

	public List<LinkedHashMap<String, Object>> getReturnRegister(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select\r\n"
						+ "	tid.*,\r\n"
						+ "	trr.*,user.*,tir2.*\r\n"
						+ "from\r\n"
						+ "	trn_invoice_register tir2,\r\n"
						+ "	trn_invoice_details tid ,\r\n"
						+ "	trn_return_register trr,tbl_user_mst user\r\n"
						+ "where\r\n"
						+ "	invoice_date between ? and ?\r\n"
						+ "	and tid.invoice_id = tir2.invoice_id\r\n"
						+ "	and trr.details_id = tid.details_id\r\n"
						+ "	and tir2.app_id = ? and trr.updated_by =user.user_id ;\r\n"
						+ "\r\n"
						+ "",
				con);

	}

	public List<LinkedHashMap<String, Object>> getCustomerInvoiceHistory(String customerId, String fromDate,
			String toDate, Connection con, String appId) throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = " select\r\n" + "	*,\r\n"
				+ "	date_format(invoice_date, '%d/%m/%Y') as formattedInvoiceDate,\r\n"
				+ "	date_format(a.updated_date, '%d/%m/%Y %H:%i:%s') as formattedUpdatedDate,\r\n"
				+ "	rate-custom_rate Discount,\r\n"
				+ "	(details.qty-sum(coalesce (return1.qty_to_return,0)))*custom_rate as ItemAmount, \r\n"
				+ "	(details.qty)*custom_rate as ActualItemAmount, \r\n"
				+ "	((details.qty-sum(coalesce (return1.qty_to_return,0)))*rate - (details.qty-sum(coalesce (return1.qty_to_return,0)))*custom_rate) DiscountAmount,\r\n"
				+ "	details.qty-sum(coalesce (return1.qty_to_return,0)) as BilledQty, sum(coalesce(qty_to_return,0)) as sumReturnQty	\r\n"
				+ "from\r\n"
				+ "mst_items item inner join trn_invoice_details details on item.item_id=details.item_id\r\n"
				+ "inner join	trn_invoice_register a on a.activate_flag=1 and details.invoice_id=a.invoice_id\r\n"
				+ "left outer join mst_customer b on	a.customer_id = b.customer_id and b.activate_flag=1 \r\n"
				+ "left outer join  trn_return_register return1 on details.details_id=return1.details_id\r\n"
				+ "where\r\n" + "	a.activate_flag = 1\r\n" + "	\r\n"
				+ "	 \r\n" + "	and a.app_id=? and date(a.invoice_date) between ? and ?  ";

		parameters.add((appId));

		parameters.add(getDateASYYYYMMDD(fromDate));
		parameters.add(getDateASYYYYMMDD(toDate));

		if (customerId != null && !customerId.equals("")) {
			query += " and b.customer_id = ? ";
			parameters.add(Long.valueOf(customerId));
		}

		query += "group by details.details_id order by a.invoice_date,a.invoice_id,details.details_id";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getCustomerItemHistory(String appId, String customerId, String fromDate,
			String toDate,
			Connection con) throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		String query = " select\r\n" + "	*,\r\n"
				+ "	date_format(invoice_date, '%d/%m/%Y') as formattedInvoiceDate,\r\n"
				+ "	date_format(a.updated_date, '%d/%m/%Y %H:%i:%s') as formattedUpdatedDate,\r\n"
				+ "	rate-custom_rate Discount,\r\n"
				+ "	(details.qty-coalesce(coalesce (return1.qty_to_return,0),0))*custom_rate as ItemAmount, \r\n"
				+ "	((details.qty-coalesce(coalesce (return1.qty_to_return,0),0))*rate - (details.qty-coalesce(coalesce (return1.qty_to_return,0),0))*custom_rate) DiscountAmount,\r\n"
				+ "	details.qty-coalesce(coalesce (return1.qty_to_return,0),0) as BilledQty,category.category_name	\r\n"
				+ "from\r\n"
				+ "mst_items item inner join trn_invoice_details details on item.item_id=details.item_id "
				+ "inner join mst_category category on item.parent_category_id=category.category_id \r\n"
				+ "inner join	trn_invoice_register a on a.activate_flag=1 and details.invoice_id=a.invoice_id\r\n"
				+ "left outer join mst_customer b on	a.customer_id = b.customer_id and b.activate_flag=1 \r\n"
				+ "left outer join  trn_return_register return1 on details.details_id=return1.details_id\r\n"
				+ "where\r\n" + "	a.activate_flag = 1\r\n" + "	\r\n"
				+ "	 \r\n" + "	and date(a.invoice_date) between ? and ? and details.app_id=?  ";

		if (customerId != null && !customerId.equals("")) {
			query += " and b.customer_id = ? ";
			parameters.add(Long.valueOf(customerId));
		}

		query += " order by b.customer_name,a.invoice_date,a.invoice_id,details.details_id ";

		parameters.add(getDateASYYYYMMDD(fromDate));
		parameters.add(getDateASYYYYMMDD(toDate));
		parameters.add(appId);

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getItemWiseReports(String appId, String customerId, String fromDate,
			String toDate,
			Connection con) throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		String query = "select mi.item_name,sum(tid.qty) qty,sum(qty*custom_rate) amt,tid.item_id  from \r\n"
				+ "trn_invoice_register tir,\r\n"
				+ "trn_invoice_details tid,\r\n"
				+ "mst_items mi \r\n"
				+ "where tir.activate_flag =1 and tir.app_id =? and tir.invoice_id =tid.invoice_id and mi.item_id =tid.item_id \r\n"
				+ "and tir.invoice_date between ? and ?\r\n"
				+ "group by tid.item_id ;";

		parameters.add(appId);
		parameters.add(getDateASYYYYMMDD(fromDate));
		parameters.add(getDateASYYYYMMDD(toDate));

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getSalesItemSummary(String appId, String storeId, String customerId,
			String fromDate, String toDate,
			Connection con) throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(getDateASYYYYMMDD(fromDate));
		parameters.add(getDateASYYYYMMDD(toDate));

		parameters.add(appId);
		parameters.add(storeId);

		String query = "select\r\n"
				+ "	mc.category_name,\r\n"
				+ "	item_name,\r\n"
				+ "	mi.product_code ,\r\n"
				+ "	sum(qty*custom_rate) Amount,\r\n"
				+ "	sum(tid.qty) quantity,\r\n"
				+ "	mi.item_id\r\n"
				+ "	\r\n"
				+ "from\r\n"
				+ "	trn_invoice_register tir,\r\n"
				+ "	trn_invoice_details tid ,\r\n"
				+ "	mst_items mi ,\r\n"
				+ "	mst_category mc\r\n"
				+ "	\r\n"
				+ "where\r\n"
				+ "	tir.invoice_date between ? and ? \r\n"
				+ "	and tir.app_id = ?\r\n"
				+ "	and tir.invoice_id = tid.invoice_id\r\n"
				+ "	and tir.activate_flag = 1\r\n"
				+ "	and mi.item_id = tid.item_id\r\n"
				+ "	and mc.category_id = mi.parent_category_id and tir.store_id=? \r\n"
				+ "	\r\n";

		if (customerId != null && !customerId.equals("")) {
			query += " and tir.customer_id = ? ";
			parameters.add(Long.valueOf(customerId));
		}

		query += " group by item_id order by mc.category_name asc,quantity desc";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getCustomerLedgerReport(String customerId, String fromDate,
			String toDate, Connection con) throws ParseException, ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select\r\n"
				+ "	tir.invoice_date orderDate,\r\n"
				+ "	invoice_no,\r\n"
				+ "	invoice_id as RefId,\r\n"
				+ "	date_format(tir.invoice_date, '%d/%m/%Y') as transaction_date,\r\n"
				+ "	total_amount as Amount,\r\n"
				+ "	concat('Invoice (', remarks, ' )') as type,\r\n"
				+ "	date_format(updated_date, '%d/%m/%Y %H:%i:%s') upd1,\r\n"
				+ "	'Debit' as creditDebit,\r\n"
				+ "	total_amount as debitAmount,\r\n"
				+ "	0 creditAmount\r\n"
				+ "from\r\n"
				+ "	trn_invoice_register tir\r\n"
				+ "where\r\n"
				+ "	customer_id = ?\r\n"
				+ "	and tir.activate_flag = 1\r\n"
				+ "	and date(invoice_date) between ? and ?\r\n"
				+ "union all\r\n"
				+ "select\r\n"
				+ "	payment_date orderDate,\r\n"
				+ "	invoice_no,\r\n"
				+ "	ref_id RefId,\r\n"
				+ "	date_format(payment_date, '%d/%m/%Y') as transaction_date,\r\n"
				+ "	amount*-1 as Amount,\r\n"
				+ "	concat(payment_mode, ' ( ', tpr.remarks, ' ) ', ' ( ', tpr.payment_for, ' ) ') as type,\r\n"
				+ "	date_format(tpr.updated_date, '%d/%m/%Y %H:%i:%s') upd1,\r\n"
				+ "	case\r\n"
				+ "		when payment_for = 'Debit Entry' then 'Debit'\r\n"
				+ "		else 'Credit'\r\n"
				+ "	end as creditDebit,\r\n"
				+ "	case\r\n"
				+ "		when payment_for = 'Debit Entry' then amount*-1\r\n"
				+ "		else 0\r\n"
				+ "	end as debitAmount,\r\n"
				+ "	case\r\n"
				+ "		when payment_for != 'Debit Entry' then amount\r\n"
				+ "		else 0\r\n"
				+ "	end as creditAmount\r\n"
				+ "from\r\n"
				+ "	trn_payment_register tpr left outer join trn_invoice_register tir2 on tir2.invoice_id =tpr.ref_id\r\n"
				+ "where\r\n"
				+ "	tpr.customer_id = ?\r\n"
				+ "	and  tpr.activate_flag = 1\r\n"
				+ "	and date(tpr.payment_date) between ? and ?\r\n"
				+ "order by\r\n"
				+ "	orderDate,\r\n"
				+ "	upd1";

		parameters.add((customerId));
		parameters.add(getDateASYYYYMMDD(fromDate));
		parameters.add(getDateASYYYYMMDD(toDate));

		parameters.add((customerId));
		parameters.add(getDateASYYYYMMDD(fromDate));
		parameters.add(getDateASYYYYMMDD(toDate));

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getStockModifications(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		String query = "select *,date_format(modification.updated_date,'%d/%m/%Y') as formattedUpdatedDate from stock_modification_master modification, mst_store store ,"
				+ " tbl_user_mst user where store.store_id=modification.store_id and user.user_id=modification.updated_user and modification.app_id=store.app_id and store.app_id=? ";
		if (hm.get("storeId") != null && !hm.get("storeId").equals("") && !hm.get("storeId").equals("-1")) {
			query += " and store.store_id=?";
			parameters.add(hm.get("storeId"));
		}
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public long addStockModification(HashMap<String, Object> outputMap, Connection conWithF) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(outputMap.get("type"));
		parameters.add(outputMap.get("userId"));
		parameters.add(outputMap.get("storeId"));
		parameters.add(outputMap.get("outerRemarks"));
		parameters.add(outputMap.get("app_id"));

		String insertQuery = "insert into stock_modification_master values (default,?,curdate(),sysdate(),?,?,?,?)";
		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public long addStockModificationAddRemove(HashMap<String, Object> outputMap, Connection conWithF)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(outputMap.get("stockModificationId"));
		parameters.add(outputMap.get("itemId"));
		parameters.add(outputMap.get("currentStock"));
		parameters.add(outputMap.get("qty"));
		parameters.add(outputMap.get("remarks"));
		parameters.add(outputMap.get("app_id"));
		String insertQuery = "insert into stock_modification_addremove values (default,?,?,?,?,?,?)";
		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public List<LinkedHashMap<String, Object>> getStockModificationDetailsAddRemove(String stockModificationId,
			Connection con) throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		String query = "select\r\n"
				+ "	*,date_format(transaction_date,'%d/%m/%Y') as transactionDateFormatted,master.remarks remarksouter,addrem.remarks as remarksinner \r\n"
				+ "from\r\n" + "	stock_modification_master master,\r\n"
				+ "	stock_modification_addremove addrem,\r\n" + "	mst_items item\r\n" + "where\r\n"
				+ "	master.stock_modification_id = ? and master.stock_modification_id=addrem.stock_modification_id and item.item_id=addrem.item_id";
		parameters.add(stockModificationId);
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getStockModificationDetailsInventoryCounting(String stockModificationId,
			Connection con) throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		String query = "select\r\n"
				+ "	*,date_format(transaction_date,'%d/%m/%Y') as transactionDateFormatted,master.remarks remarksouter \r\n"
				+ "from\r\n" + "	stock_modification_master master,\r\n"
				+ "	stock_modification_inventorycounting ivecounting,\r\n" + "	mst_items item\r\n" + "where\r\n"
				+ "	master.stock_modification_id = ? and master.stock_modification_id=ivecounting.stock_modification_id and item.item_id=ivecounting.item_id";
		parameters.add(stockModificationId);
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public long saveStockModificationInventoryCounting(HashMap<String, Object> outputMap, Connection conWithF)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(outputMap.get("stockModificationId"));
		parameters.add(outputMap.get("itemId"));
		parameters.add(outputMap.get("expectedCount"));
		parameters.add(outputMap.get("currentCount"));
		parameters.add(outputMap.get("difference"));
		parameters.add(outputMap.get("differenceAmount"));
		parameters.add(outputMap.get("app_id"));
		String insertQuery = "insert into stock_modification_inventorycounting values (default,?,?,?,?,?,?,?)";
		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public long saveStockModificationtransferStock(HashMap<String, Object> outputMap, Connection conWithF)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(outputMap.get("stockModificationId"));
		parameters.add(outputMap.get("itemId"));
		parameters.add(outputMap.get("sourcebefore"));
		parameters.add(outputMap.get("sourceafter"));
		parameters.add(outputMap.get("qty"));
		parameters.add(outputMap.get("destinationbefore"));
		parameters.add(outputMap.get("destinationafter"));
		parameters.add(outputMap.get("sourceStore"));
		parameters.add(outputMap.get("destinationStore"));
		parameters.add(outputMap.get("app_id"));

		String insertQuery = "insert into stock_modification_transferstock values (default,?,?,?,?,?,?,?,?,?,?)";
		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public List<LinkedHashMap<String, Object>> getStockModificationDetailsStocktransfer(String stockModificationId,
			Connection con) throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		String query = "select *,date_format(transaction_date,'%d/%m/%Y') as transactionDateFormatted "
				+ "from	stock_modification_master master,"
				+ "	stock_modification_transferstock transferstock,	mst_items item where "
				+ "	master.stock_modification_id = ? and master.stock_modification_id=transferstock.stock_modification_id and item.item_id=transferstock.item_id";
		parameters.add(stockModificationId);
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public LinkedHashMap<String, String> validateLoginForApp(String number, String password, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(number);
		parameters.add(getSHA256String(password));
		return getMap(parameters,
				"select  user_id,store1.store_id,store_name,usermst.app_id from tbl_user_mst usermst,mst_store store1 where mobile=? and password=? and store1.store_id=usermst.store_id ",

				con);
	}

	public LinkedHashMap<String, String> validateLoginForAppCustomer(String number, String password, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(number);
		parameters.add(getSHA256String(password));

		return getMap(parameters,
				"select  user_id,usermst.app_id from tbl_user_mst usermst where mobile=? and password=? ",

				con);
	}

	public List<LinkedHashMap<String, Object>> getBookingsForThisUser(LinkedHashMap<String, Object> hm1,
			Connection con) throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm1.get("user_id"));
		parameters.add(hm1.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select inv.*,cust.*,date_format(inv.updated_date,'%d/%m/%Y') as FormattedInvoiceDate "
						+ "from trn_booking_register inv left outer join mst_customer cust on inv.customer_id=cust.customer_id "
						+ "left outer join tbl_user_mst usertbl on inv.updated_by = usertbl.user_id "
						+ "where inv.preffered_employee=? and inv.activate_flag=1 and inv.app_id=? order by booking_id desc limit 100 ",
				con);
	}

	public List<LinkedHashMap<String, Object>> getRecentInvoiceForUser(LinkedHashMap<String, Object> hm1,
			Connection con) throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm1.get("user_id"));
		parameters.add(hm1.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select inv.*,cust.*,date_format(inv.updated_date,'%d/%m/%Y') as FormattedInvoiceDate "
						+ "from trn_invoice_register inv left outer join mst_customer cust on inv.customer_id=cust.customer_id "
						+ "left outer join tbl_user_mst usertbl on inv.updated_by = usertbl.user_id "
						+ "where inv.updated_by=? and inv.activate_flag=1 and inv.app_id=? order by invoice_id desc limit 100 ",
				con);
	}

	public List<LinkedHashMap<String, Object>> getStatisticalSalesData(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add((hm.get("app_id").toString()));
		String query = "select\r\n"
				+ "T.store_id,	store_name,	round(sum(total_amount)) total_amount,round(sum(Paid)) paid,round(sum(Pending)) pending,	round(sum(profit)) profit,round(sum(discount)) discount,	sum(gross_amount) gross_amount ,sum(returnedAmount) returnedAmount,sum(cnt) as Count\r\n"
				+ "from\r\n" + "	(	select\r\n" + "	1 cnt,tirouter.store_id,	store_name,(total_amount),\r\n"
				+ "		case\r\n"
				+ "			when payment_type = 'Paid' then (total_amount)\r\n"
				+ "			when payment_type = 'Partial' then (amount)\r\n" + "			else 0\r\n"
				+ "		end as Paid,\r\n" + "		case\r\n"
				+ "			when payment_type = 'Pending' then (total_amount)\r\n"
				+ "			when payment_type = 'Partial' then (total_amount-amount)\r\n" + "			else 0\r\n"
				+ "		end as Pending,(\r\n" + "		select\r\n"
				+ "			round(total_amount-sum(qty*average_cost))\r\n" + "		from\r\n"
				+ "			trn_invoice_register tir, trn_invoice_details tid, mst_items mi\r\n" + "		where\r\n"
				+ "			tir.activate_flag=1 and tid.invoice_id = tirouter.invoice_id\r\n"
				+ "			and mi.item_id = tid.item_id\r\n"
				+ "			and tir.invoice_id = tid.invoice_id) as profit,\r\n" + "			(\r\n"
				+ "		select\r\n" + "			round(sum(trr.qty_to_return*tid.custom_rate)) \r\n" + "		from\r\n"
				+ "			trn_invoice_register tir, trn_invoice_details tid, mst_items mi,trn_return_register trr\r\n"
				+ "		where\r\n" + "	tir.activate_flag=1 and		tid.invoice_id = tirouter.invoice_id\r\n"
				+ "			and mi.item_id = tid.item_id and trr.details_id =tid.details_id \r\n"
				+ "			and tir.invoice_id = tid.invoice_id) as returnedAmount,\r\n"
				+ "			gross_amount -total_amount as discount,gross_amount			\r\n" + "	from\r\n"
				+ "		trn_invoice_register tirouter\r\n" + "	inner join mst_store store1 on\r\n"
				+ "		tirouter.activate_flag=1 and tirouter.store_id = store1.store_id\r\n"
				+ "	left outer join trn_payment_register tpr on\r\n"
				+ "		tpr.ref_id = tirouter.invoice_id\r\n" + "		and tpr.payment_for = 'Invoice'\r\n"
				+ "	where\r\n"
				+ "		tirouter.invoice_date between ? and ? and tirouter.app_id=? StoreFilter) as T\r\n"
				+ "group by\r\n"
				+ "	store_name;";

		if (hm.get("store_id") != null && !hm.get("store_id").equals("")) {
			query = query.replaceAll("StoreFilter", " and tirouter.store_id=? ");
			parameters.add(hm.get("store_id"));
		} else {
			query = query.replaceAll("StoreFilter", " ");
		}

		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getPaymentDataAgainstSales(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add((hm.get("app_id").toString()));
		String query = "select store_name,round(sum(Cash)) Cash,	round(sum(Paytm)) Paytm,round(sum(Amazon)) Amazon,round(sum(GooglePay)) GooglePay,round(sum(Zomato)) Zomato,round(sum(Swiggy)) Swiggy,round(sum(Card)) Card,round(sum(PhonePay)) PhonePay, "
				+ "round(sum(Cash)+sum(Paytm)+sum(Amazon)+sum(GooglePay)+sum(Zomato)+sum(Swiggy)+sum(Card)+sum(PhonePay)) as HoriTotal,T.store_id \r\n"
				+ " from (\r\n"
				+ "\r\n" + "select\r\n"
				+ "		ms.store_id ,store_name,case when payment_mode ='Cash' then amount else 0 end Cash, \r\n"
				+ "							case when payment_mode ='Paytm' then amount else 0 end Paytm, \r\n"
				+ "							case when payment_mode ='Amazon' then amount else 0 end Amazon, \r\n"
				+ "							case when payment_mode ='Google Pay' then amount else 0 end GooglePay, \r\n"
				+ "							case when payment_mode ='Phone Pay' then amount else 0 end PhonePay, \r\n"
				+ "							case when payment_mode ='Zomato' then amount else 0 end Zomato, \r\n"
				+ "							case when payment_mode ='Card' then amount else 0 end Card, \r\n"
				+ "							case when payment_mode ='Swiggy' then amount else 0 end Swiggy \r\n"
				+ "							\r\n" + "from\r\n" + "	trn_payment_register tpr\r\n"
				+ "inner join mst_store ms on\r\n" + "	ms.store_id = tpr.store_id\r\n" + "where\r\n"
				+ "	payment_for in ('invoice') and date(payment_date) between ? and ? and tpr.app_id=? and tpr.activate_flag=1 and tpr.app_id=ms.app_id StoreFilter \r\n"
				+ ") as T group by store_name";

		if (hm.get("store_id") != null && !hm.get("store_id").equals("")) {
			query = query.replaceAll("StoreFilter", " and tpr.store_id=? ");
			parameters.add(hm.get("store_id"));
		} else {
			query = query.replaceAll("StoreFilter", " ");
		}

		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getPaymentDataAgainstCollection(HashMap<String, Object> hm,
			Connection con) throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add((hm.get("app_id").toString()));
		String query = "select store_name,round(sum(Cash)) Cash,	round(sum(Paytm)) Paytm,round(sum(Amazon)) Amazon,round(sum(GooglePay)) GooglePay,round(sum(Zomato)) Zomato,round(sum(Swiggy)) Swiggy,round(sum(Card)) Card,round(sum(PhonePay)) PhonePay,"
				+ "round(sum(Cash)+sum(Paytm)+sum(Amazon)+sum(GooglePay)+sum(Zomato)+sum(Swiggy)+sum(Card)+sum(PhonePay)) as HoriTotal,T.store_id,sum(Kasar) Kasar from (\r\n"
				+ "\r\n" + "select\r\n"
				+ "		ms.store_id ,store_name,case when payment_mode ='Cash' then amount else 0 end Cash, \r\n"
				+ "							case when payment_mode ='Paytm' then amount else 0 end Paytm, \r\n"
				+ "							case when payment_mode ='Amazon' then amount else 0 end Amazon, \r\n"
				+ "							case when payment_mode ='Google Pay' then amount else 0 end GooglePay, \r\n"
				+ "							case when payment_mode ='Phone Pay' then amount else 0 end PhonePay, \r\n"

				+ "							case when payment_mode ='Zomato' then amount else 0 end Zomato, \r\n"
				+ "							case when payment_mode ='Kasar' then amount else 0 end Kasar, \r\n"
				+ "							case when payment_mode ='Card' then amount else 0 end Card, \r\n"
				+ "							case when payment_mode ='Swiggy' then amount else 0 end Swiggy \r\n"
				+ "							\r\n" + "from\r\n" + "	trn_payment_register tpr\r\n"
				+ "inner join mst_store ms on\r\n" + "	ms.store_id = tpr.store_id\r\n" + "where\r\n"
				+ "	payment_for in ('Collection') and date(payment_date) between ? and ?  and tpr.app_id=? and tpr.app_id= ms.app_id and tpr.activate_flag =1 StoreFilter \r\n"
				+ ") as T group by store_name";
		if (hm.get("store_id") != null && !hm.get("store_id").equals("")) {
			query = query.replaceAll("StoreFilter", " and tpr.store_id=? ");
			parameters.add(hm.get("store_id"));
		} else {
			query = query.replaceAll("StoreFilter", " ");
		}
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getPaymentData(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add(hm.get("app_id"));
		String query = "select store_name,"
				+ "round(sum(Cash)) Cash,round(sum(Paytm)) Paytm,round(sum(Amazon)) Amazon,round(sum(GooglePay)) GooglePay,"
				+ "round(sum(Zomato)) Zomato,round(sum(Swiggy)) Swiggy,round(sum(Card)) Card,round(sum(PhonePay)) PhonePay,"
				+ "round(sum(Cash)+sum(Paytm)+sum(Amazon)+sum(GooglePay)+sum(Zomato)+sum(Swiggy)+sum(Card)+sum(PhonePay)) as HoriTotal,store_id , sum(Kasar) Kasar from (\r\n"
				+ "\r\n" + "select\r\n"
				+ "		ms.store_id ,store_name,case when payment_mode ='Cash' then amount else 0 end Cash, \r\n"
				+ "							case when payment_mode ='Paytm' then amount else 0 end Paytm, \r\n"
				+ "							case when payment_mode ='Amazon' then amount else 0 end Amazon, \r\n"
				+ "							case when payment_mode ='Google Pay' then amount else 0 end GooglePay, \r\n"
				+ "							case when payment_mode ='Phone Pay' then amount else 0 end PhonePay, \r\n"

				+ "							case when payment_mode ='Zomato' then amount else 0 end Zomato, \r\n"
				+ "							case when payment_mode ='Kasar' then amount else 0 end Kasar, \r\n"
				+ "							case when payment_mode ='Card' then amount else 0 end Card, \r\n"
				+ "							case when payment_mode ='Swiggy' then amount else 0 end Swiggy \r\n"
				+ "							\r\n" + "from\r\n" + "	trn_payment_register tpr\r\n"
				+ "inner join mst_store ms on\r\n" + "	ms.store_id = tpr.store_id\r\n" + "where\r\n"
				+ "	payment_for in ('Collection','invoice') and tpr.activate_flag=1 and date(payment_date) between ? and ? and tpr.app_id=? and tpr.app_id=ms.app_id StoreFilter \r\n"
				+ ") as T group by store_name";
		if (hm.get("store_id") != null && !hm.get("store_id").equals("")) {
			query = query.replaceAll("StoreFilter", " and tpr.store_id=? ");
			parameters.add(hm.get("store_id"));
		} else {
			query = query.replaceAll("StoreFilter", " ");
		}
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getEmployeeWiseDetailsForDashboard(HashMap<String, Object> hm,
			Connection con) throws ParseException, ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		parameters.add((hm.get("app_id").toString()));
		String query = "select T.store_id,T.updated_by,store_name,name,\r\n" + "round(sum(Cash)) Cash,\r\n"
				+ "round(sum(Paytm)) Paytm,\r\n" + "round(sum(Amazon)) Amazon,\r\n"
				+ "round(sum(GooglePay)) GooglePay,\r\n"
				+ "round(sum(Zomato)) Zomato,\r\n" + "round(sum(Swiggy)) Swiggy,\r\n" + "round(sum(Card)) Card,\r\n"
				+ "round(sum(PhonePay)) PhonePay,\r\n" + "round(sum(pendingAmount)) pendingAmount,"
				+ "round(sum(Cash)+sum(Paytm)+sum(Amazon)+sum(GooglePay)+sum(Zomato)+sum(Swiggy)+sum(Card)+sum(PhonePay)+sum(pendingAmount)) as HoriTotal, T.store_id"
				+ " \r\n" + "from (\r\n"
				+ "select \r\n" + "tir.updated_by,tir.store_id,store_name,name,\r\n"
				+ "case when payment_mode ='Cash' then amount else 0 end Cash,  \r\n"
				+ "											case when payment_mode ='Paytm' then amount else 0 end Paytm,  \r\n"
				+ "											case when payment_mode ='Amazon' then amount else 0 end Amazon,  \r\n"
				+ "											case when payment_mode ='Google Pay' then amount else 0 end GooglePay, \r\n"
				+ "											case when payment_mode ='Phone Pay' then amount else 0 end PhonePay, \r\n"

				+ "											case when payment_mode ='Zomato' then amount else 0 end Zomato, \r\n"
				+ "											case when payment_mode ='Card' then amount else 0 end Card, \r\n"
				+ "											case when payment_mode ='Swiggy' then amount else 0 end Swiggy ,\r\n"
				+ "total_amount -coalesce (amount,0) pendingAmount from trn_invoice_register tir inner join tbl_user_mst tum  on tir.activate_flag=1 and tum.user_id =tir.updated_by					\r\n"
				+ "					inner join mst_store store1 on store1.store_id =tir.store_id  \r\n"
				+ "					left outer join trn_payment_register tpr  on tpr.ref_id =tir.invoice_id  and tpr.payment_for ='Invoice' and tpr.app_id=tir.app_id \r\n"
				+ "					where date(tir.invoice_date) between ? and ? and  tir.app_id=? and tir.app_id=tum.app_id and store1.app_id=tir.app_id StoreFilter \r\n"
				+ "					) as T\r\n"
				+ "					group by store_name,name";
		if (hm.get("store_id") != null && !hm.get("store_id").equals("")) {
			query = query.replaceAll("StoreFilter", " and tir.store_id=? ");
			parameters.add(hm.get("store_id"));
		} else {
			query = query.replaceAll("StoreFilter", " ");
		}
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getBookingDetailsForStore(HashMap<String, Object> hm,
			Connection con) throws ParseException, ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));

		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));

		parameters.add((hm.get("app_id").toString()));
		String query = "select count(1) cnt,store_name from trn_booking_register tbr,mst_store store where store.store_id=tbr.store_id and ((from_date between ? and ?) or (to_date between ? and ?)) and tbr.app_id=? StoreFilter group by store_name ";
		if (hm.get("store_id") != null && !hm.get("store_id").equals("")) {
			query = query.replaceAll("StoreFilter", " and tbr.store_id=? ");
			parameters.add(hm.get("store_id"));
		} else {
			query = query.replaceAll("StoreFilter", " ");
		}
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getExpenseDetailsForStore(HashMap<String, Object> hm,
			Connection con) throws ParseException, ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));

		parameters.add((hm.get("app_id").toString()));
		String query = "select sum(amount) cnt,store_name,tbr.store_id from trn_expense_register tbr,mst_store store where store.store_id=tbr.store_id and tbr.activate_flag=1 and tbr.expense_date between ? and ? and tbr.app_id=? StoreFilter group by store_name ";
		if (hm.get("store_id") != null && !hm.get("store_id").equals("")) {
			query = query.replaceAll("StoreFilter", " and tbr.store_id=? ");
			parameters.add(hm.get("store_id"));
		} else {
			query = query.replaceAll("StoreFilter", " ");
		}
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getCustomerDeliveryRoutine(Connection con, HashMap<String, Object> hm)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		String query = "select * from "
				+ " customer_delivery_routine routine,mst_customer cust,mst_items item"
				+ " where cust.customer_id=routine.customer_id and item.item_id=routine.item_id and routine.activate_flag=1 and routine.app_id=? ";

		if (hm.get("customer_id") != null && !hm.get("customer_id").equals("")) {
			parameters.add(hm.get("customer_id"));
			query += " and routine.customer_id=?";
		}

		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public String deleteRoutine(long routineId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(routineId);
		insertUpdateDuablDB("UPDATE customer_delivery_routine  SET activate_flag=0 WHERE routine_id=?", parameters,
				conWithF);
		return "Routine Deleted Succesfully";
	}

	public LinkedHashMap<String, String> getRoutinepDetails(long routineId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(routineId);
		return getMap(parameters, "select * from customer_delivery_routine routine,mst_items item,mst_customer cust "
				+ " where routine.routine_id=? and item.item_id=routine.item_id and routine.customer_id=cust.customer_id",
				con);
	}

	public long addRoutine(Connection conWithF, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("hdnSelectedCustomer"));
		parameters.add(hm.get("hdnselecteditem"));
		parameters.add(hm.get("txtcustomrate"));
		parameters.add(hm.get("txtitemqty"));
		parameters.add(hm.get("deliverypreference"));

		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("app_id"));
		return insertUpdateDuablDB("insert into customer_delivery_routine values (default,?,?,?,?,?,1,sysdate(),?,?)",
				parameters, conWithF);
	}

	public long updateRoutine(Connection conWithF, HashMap<String, Object> hm) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("hdnSelectedCustomer"));
		parameters.add(hm.get("hdnselecteditem"));
		parameters.add(hm.get("txtcustomrate"));
		parameters.add(hm.get("txtitemqty"));
		parameters.add(hm.get("deliverypreference"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("hdnroutineid"));

		return insertUpdateDuablDB("update customer_delivery_routine set customer_id=?,item_id=?,"
				+ "custom_rate=?,qty=?,occurance=?,updated_by=?,app_id=?,updated_date=sysdate() where routine_id=?",
				parameters, conWithF);

	}

	public List<LinkedHashMap<String, Object>> getRoutineDetailsForThisCustomer(String customerId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(Long.valueOf(customerId));
		String query = "select\r\n" +
				"	deliveryroutine.*,\r\n" +
				"	cust.*,cat.*,\r\n" +
				"	item.*,\r\n" +
				"	case\r\n" +
				"		when concat(attachment_id, file_name) is null then 'dummyImage.jpg'\r\n" +
				"		else concat(attachment_id, file_name)\r\n" +
				"	end as ImagePath\r\n" +
				"from\r\n" +
				"	customer_delivery_routine deliveryroutine inner join \r\n" +
				"	mst_items item on deliveryroutine.item_id =item.item_id inner join \r\n" +
				"	mst_customer cust on cust.customer_id =deliveryroutine .customer_id"
				+ " inner join mst_category cat on cat.category_id=item.parent_category_id \r\n" +
				"left outer join tbl_attachment_mst tam on\r\n" +
				"	item.item_id = tam.file_id\r\n" +
				"	and tam.type = 'Image'\r\n" +
				"where\r\n" +
				"	deliveryroutine.customer_id =? \r\n" +
				"	and deliveryroutine.activate_flag = 1\r\n" +
				"	and item.item_id = deliveryroutine.item_id\r\n" +
				"	and cust.customer_id = deliveryroutine.customer_id";
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getExpenseRegister(HashMap<String, Object> outputMap, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(outputMap.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(outputMap.get("toDate").toString()));

		String query = "select *,date_format(expense_date,'%d/%m/%Y') as FormattedExpenseDate from trn_expense_register where  expense_date between ? and ? and activate_flag=1 ";

		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getIncomeRegister(HashMap<String, Object> outputMap, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(outputMap.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(outputMap.get("toDate").toString()));

		String query = "select *,date_format(income_date,'%d/%m/%Y') as FormattedIncomeDate from trn_income_register where  income_date between ? and ? and activate_flag=1 ";

		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public String deleteExpense(long expenseId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(expenseId);
		insertUpdateDuablDB(
				"UPDATE trn_expense_register SET activate_flag=0,updated_by=?,updated_date=sysdate() WHERE expense_id=?",
				parameters, conWithF);
		return "Expense Deleted Succesfully";
	}

	public String deleteIncome(long incomeId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(incomeId);
		insertUpdateDuablDB(
				"UPDATE trn_income_register SET activate_flag=0,updated_by=?,updated_date=sysdate() WHERE income_id=?",
				parameters, conWithF);
		return "Income Deleted Succesfully";
	}

	public String deleteInvoice(long invoiceId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(invoiceId);
		insertUpdate("UPDATE trn_invoice_register SET activate_flag=0,updated_by=? WHERE invoice_id=?", parameters,
				conWithF);
		parameters.clear();

		// update stock_status
		// reverse stock_register entry

		return userId;
	}

	public String deletePaymentAgainstInvoice(long invoiceId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(invoiceId);
		insertUpdate(
				"UPDATE trn_payment_register SET activate_flag=0,updated_by=?,updated_date=sysdate() WHERE ref_id=? ",
				parameters, conWithF);
		return "Deleted Payment";

	}

	public String deleteReturnsAgainstInvoice(long invoiceId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(invoiceId);
		insertUpdate(
				"delete return1 from trn_return_register return1 ,trn_invoice_register register ,trn_invoice_details  dtls  \r\n"
						+ " where register.invoice_id =? and register.invoice_id =dtls.invoice_id  and \r\n"
						+ "return1.details_id = dtls.details_id",
				parameters, conWithF);
		return "Deleted Payment";

	}

	public LinkedHashMap<String, String> getExpenseDetails(long expenseId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(expenseId);
		return getMap(parameters,
				"select *,date_format(expense_date,'%d/%m/%Y') as FormattedExpenseDate from trn_expense_register where expense_id=?",
				con);
	}

	public LinkedHashMap<String, String> getIncomeDetails(long expenseId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(expenseId);
		return getMap(parameters,
				"select *,date_format(income_date,'%d/%m/%Y') as FormattedIncomeDate from trn_income_register where income_id=?",
				con);
	}

	public long addExpense(Connection con, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("expense_name"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtdate").toString()));
		parameters.add(hm.get("amount"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("drppaymentmode"));
		

		return insertUpdateDuablDB("insert into trn_expense_register values (default,?,?,?,?,sysdate(),1,?)", parameters,
				con);

	}

	public long addIncome(Connection con, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("income_name"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtdate").toString()));
		parameters.add(hm.get("amount"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("drppaymentmode"));

		return insertUpdateDuablDB("insert into trn_income_register values (default,?,?,?,?,sysdate(),1,?)", parameters,
				con);

	}

	
	public long updateExpense(Connection con, HashMap<String, Object> hm) throws ParseException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("expense_name"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtdate").toString()));
		parameters.add(hm.get("amount"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("drppaymentmode"));

		parameters.add(hm.get("hdnExpenseId"));

		return insertUpdateDuablDB(
				"update trn_expense_register set expense_name=?,expense_date=?,amount=?,updated_by=?, payment_mode=? where expense_id=?",
				parameters, con);

	}

	public long updateIncome(Connection con, HashMap<String, Object> hm) throws ParseException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("income_name"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtdate").toString()));
		parameters.add(hm.get("amount"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("drppaymentmode"));

		parameters.add(hm.get("hdnIncomeId"));

		return insertUpdateDuablDB(
				"update trn_income_register set income_name=?,income_date=?,amount=?,updated_by=?, payment_mode=? where income_id=?",
				parameters, con);

	}

	public List<LinkedHashMap<String, Object>> getDistinctExpenseList(Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();

		return getListOfLinkedHashHashMap(parameters,
				"select distinct(expense_name) expense_name from trn_expense_register  where activate_flag=1", con);
	}

	public List<LinkedHashMap<String, Object>> getDistinctIncomeList(Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();

		return getListOfLinkedHashHashMap(parameters,
				"select distinct(income_name) expense_name from trn_income_register  where activate_flag=1", con);
	}

	public List<LinkedHashMap<String, Object>> getUniqueModelNoForThisApp(Connection con, String appId)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfLinkedHashHashMap(parameters,
				"select distinct(model_no) as ModelNo from trn_invoice_register where app_id=?", con);
	}

	public long getTentativeSequenceNo(String appId, String tableName, Connection con) throws SQLException {
		long generatedPK = 0;
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		parameters.add(tableName);
		HashMap<String, String> hm = getMap(parameters,
				"select current_seq_no+1 as  current_seq_no from seq_master where app_id=? and sequence_name=?", con);
		if (hm.get("current_seq_no") == null) {
			parameters.clear();
			parameters.add(tableName);
			parameters.add(appId);
			insertUpdateDuablDB("insert into seq_master values (default,?,0,?)", parameters, con);
			generatedPK = 1;
		} else {
			generatedPK = Long.valueOf(hm.get("current_seq_no"));
		}
		return generatedPK;
	}

	public List<String> getDistinctCityNames(String appId, Connection con) throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfString(parameters, "select distinct(City) from mst_customer where app_id=?", con);
	}

	public String saveTableConfig(int noOfTables, String storeId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(storeId);
		insertUpdate("delete from mst_tables where store_id=?", parameters, con);
		for (int x = 1; x <= noOfTables; x++) {
			parameters.clear();
			parameters.add(storeId);
			parameters.add(x);
			insertUpdate("insert into mst_tables values (default,?,?,null)", parameters, con);
		}

		return "Tables Added Succesfully";
	}

	public long saveNewApp(String appname, String txtvalidtill, String txtstorename, String txtusername, String appType,
			Connection con) throws SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(appname);
		parameters.add(getDateASYYYYMMDD(txtvalidtill));
		parameters.add(appType);
		long appId = insertUpdateDuablDB(
				"insert into mst_app  (app_id,app_name,valid_till,app_type) values (default,?,?,?)", parameters, con);

		parameters = new ArrayList<>();
		parameters.add(txtstorename);
		parameters.add(appId);
		long storeId = insertUpdateDuablDB(
				"insert into mst_store (store_id,store_name,app_id,activate_flag) values (default,?,?,1)", parameters,
				con);

		parameters = new ArrayList<>();
		parameters.add(txtusername);
		parameters.add(getSHA256String("default@123"));
		parameters.add(storeId);
		parameters.add(appId);
		long userId = insertUpdateDuablDB(
				"insert into tbl_user_mst (user_id,username,password,store_id,app_id) values (default,?,?,?,?)",
				parameters, con);

		parameters = new ArrayList<>();
		parameters.add(userId);
		insertUpdateDuablDB("insert into user_configurations (user_id) values (?)", parameters, con);

		parameters = new ArrayList<>();
		parameters.add(userId);
		insertUpdateDuablDB(
				"INSERT INTO acl_user_role_rlt (rlt_pk, user_id, role_id, activate_flag, created_date, updated_date,role_name) VALUES(default, ?, 1, 1, sysdate(), NULL,'Admin');",
				parameters, con);

		return userId;
	}

	public List<LinkedHashMap<String, Object>> getOrderDetailsForTable(long tableId, Connection conWithF)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(tableId);
		return getListOfLinkedHashHashMap(parameters,
				"select table1.order_id orderId,table1.table_no  tableNo,tor.*,tod.*,mi.* from\r\n"
						+ "mst_tables table1 left outer join  trn_order_register tor  on tor.order_id=table1.order_id \r\n"
						+ "inner join trn_order_details tod   on tor.order_id =tod.order_id \r\n"
						+ "inner join mst_items mi  on mi.item_id =tod.item_id \r\n"
						+ "where table1.table_id=?",
				conWithF);
	}

	public long saveOrder(HashMap<String, Object> hm, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("table_id"));
		return insertUpdateDuablDB("insert into trn_order_register values (default,?,sysdate(),null)", parameters, con);
	}

	public String saveOrderDetails(HashMap<String, Object> hm, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		List<HashMap<String, Object>> itemListRequired = (List<HashMap<String, Object>>) hm.get("itemDetails");
		for (HashMap<String, Object> itemdetail : itemListRequired) {
			parameters.clear();
			parameters.add(hm.get("order_id"));
			parameters.add(itemdetail.get("item_id"));
			parameters.add(itemdetail.get("qty"));
			parameters.add("O");
			parameters.add(itemdetail.get("remarks"));
			parameters.add(hm.get("runningFlag"));

			long orderDetailsId = insertUpdateDuablDB(
					"insert into trn_order_details values (default,?,?,?,?,sysdate(),null,null,?,?)", parameters, con);

		}
		return "Save Succesfully";

	}

	public List<LinkedHashMap<String, Object>> getPendingOrders(HashMap<String, Object> hm, Connection conWithF)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("store_id"));

		String query = "select\r\n"
				+ "	*,\r\n"
				+ "	case when running_flag='Y' then 1 else 0 end priority\r\n"
				+ "from\r\n"
				+ "	mst_store ms ,\r\n"
				+ "	mst_tables mt ,\r\n"
				+ "	trn_order_register tor ,\r\n"
				+ "	trn_order_details tod,\r\n"
				+ "	mst_items item\r\n"
				+ "where\r\n"
				+ "	ms.app_id = ? \r\n"
				+ "	and ms.store_id = ? \r\n"
				+ "	and ms.store_id = mt.store_id\r\n"
				+ "	and tor.order_id = mt.order_id\r\n"
				+ "	and tod.order_id = tor.order_id\r\n"
				+ "	and item.item_id = tod.item_id\r\n"
				+ "	and tod.status = 'O'\r\n";

		if (hm.get("table_id") != null && !hm.get("table_id").toString().equals("-1")
				&& !hm.get("table_id").toString().equals("")) {
			parameters.add(hm.get("table_id"));
			query += " and mt.table_id=?";
		}

		query += " order by "
				+ " priority desc,ordered_time asc";

		return getListOfLinkedHashHashMap(parameters, query, conWithF);
	}

	public String markAsServed(String[] itemId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		String questionMarks = "";
		for (String s : itemId) {
			parameters.add(s);
			questionMarks += "?,";
		}
		questionMarks = questionMarks.substring(0, questionMarks.length() - 1);

		insertUpdateDuablDB(
				"UPDATE trn_order_details  SET status='S',served_time=sysdate() WHERE order_details_id in ("
						+ questionMarks + ")",
				parameters, conWithF);
		return "Served Succesfully";
	}

	public String markAllAsServed(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("table_id"));
		insertUpdateDuablDB(
				"update \r\n"
						+ "mst_tables mt,\r\n"
						+ "trn_order_details tod\r\n"
						+ "set status='S',served_time=sysdate()\r\n"
						+ "where mt.table_id =? and tod.order_id =mt.order_id  and status='O'",
				parameters, conWithF);
		return "Served Succesfully";
	}

	public String cancelOrderDetail(long orderDetailId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(orderDetailId);
		insertUpdateDuablDB(
				"UPDATE trn_order_details  SET status='C',cancelled_time=sysdate() WHERE order_details_id=?",
				parameters, con);
		return "Cancelled Succesfully";
	}

	public void updateTableWithOrderId(HashMap<String, Object> hm, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("order_id"));
		parameters.add(hm.get("table_id"));

		insertUpdateDuablDB(
				"update mst_tables set order_id=? where table_id=?",
				parameters, con);

	}

	public void removeOrderFromTable(HashMap<String, Object> hm, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("table_id"));

		insertUpdateDuablDB(
				"update mst_tables set order_id=null where table_id=?",
				parameters, con);

	}

	public List<LinkedHashMap<String, Object>> getCompositeItemDetails(long itemId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemId);
		return getListOfLinkedHashHashMap(parameters,
				"select * from rlt_composite_item_mpg rcim ,mst_items item where item.item_id=rcim.child_item_id and rcim.item_id =? ",
				con);
	}

	public long saveCompositeItem(HashMap<String, Object> itemDetails, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemDetails.get("parentItemId"));
		parameters.add(itemDetails.get("item_id"));
		parameters.add(itemDetails.get("qty"));
		String insertQuery = "insert into rlt_composite_item_mpg values (default,?,?,?)";
		return insertUpdateDuablDB(insertQuery, parameters, con);
	}

	public long deleteCompositeItem(HashMap<String, Object> hm, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("parentItemId"));
		String insertQuery = "delete from rlt_composite_item_mpg where item_id=?";
		return insertUpdateDuablDB(insertQuery, parameters, con);
	}

	public long saveBooking(HashMap<String, Object> itemDetails, Connection con)
			throws SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemDetails.get("customerId"));
		parameters.add(getDateASYYYYMMDDHHMM(itemDetails.get("fromDateTime").toString()));
		parameters.add(getDateASYYYYMMDDHHMM(itemDetails.get("toDateTime").toString()));
		parameters.add(itemDetails.get("prefferedEmployee"));
		parameters.add(itemDetails.get("app_id"));
		parameters.add(itemDetails.get("user_id"));
		parameters.add(itemDetails.get("remarks"));
		parameters.add(itemDetails.get("modelname"));
		parameters.add(itemDetails.get("uniqueno"));
		parameters.add(itemDetails.get("store_id"));

		String insertQuery = "insert into trn_booking_register values (default,?,?,?,?,?,?,sysdate(),1,'O',?,?,?,?)";
		return insertUpdateDuablDB(insertQuery, parameters, con);
	}

	public long saveBookingItems(HashMap<String, Object> itemDetails, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemDetails.get("bookingId"));
		parameters.add(itemDetails.get("item_id"));
		parameters.add(itemDetails.get("qty"));
		String insertQuery = "insert into booking_item_mpg values (default,?,?,?)";
		return insertUpdateDuablDB(insertQuery, parameters, con);
	}

	public String markBookingAsServed(long bookingId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(bookingId);
		insertUpdateDuablDB(
				"UPDATE trn_booking_register  SET status='S',updated_date=sysdate() WHERE booking_id=?",
				parameters, conWithF);
		return "Served Succesfully";
	}

	public boolean checkIfBookingAlreadyExist(HashMap<String, Object> hm, Connection con)
			throws SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDDHHMM(hm.get("fromDateTime").toString()));
		parameters.add(getDateASYYYYMMDDHHMM(hm.get("fromDateTime").toString()));
		parameters.add(getDateASYYYYMMDDHHMM(hm.get("toDateTime").toString()));
		parameters.add(getDateASYYYYMMDDHHMM(hm.get("toDateTime").toString()));
		parameters.add(hm.get("prefferedEmployee"));
		return !getMap(parameters, "select\r\n"
				+ "	count(1) as existingBookings\r\n"
				+ "from\r\n"
				+ "	trn_booking_register tbr\r\n"
				+ "where\r\n"
				+ "	(\r\n"
				+ "		((? between from_date and to_date) and (to_date !=?))\r\n"
				+ "		or\r\n"
				+ "		((? between from_date and to_date)  and from_date !=?)\r\n"
				+ "	) and preffered_employee =? and tbr.activate_flag =1", con).get("existingBookings").equals("0");

	}

	public List<LinkedHashMap<String, Object>> getCompositeItemChildsAndQuantity(long itemId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemId);
		return getListOfLinkedHashHashMap(parameters, "select * from rlt_composite_item_mpg where item_id=?", con);
	}

	public List<LinkedHashMap<String, Object>> getAuditList(Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		return getListOfLinkedHashHashMap(parameters, "select * from customizedpos.frm_audit_trail  \r\n"
				+ "union all\r\n"
				+ "select * from student_attendance.frm_audit_trail  \r\n"
				+ "order by accessed_time desc \r\n"
				+ "limit 100", con);
	}

	public List<LinkedHashMap<String, Object>> getAuditListByUser(String username, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(username);
		parameters.add(username);
		return getListOfLinkedHashHashMap(parameters, "select * from \r\n"
				+ "(\r\n"
				+ "select * from (select * from customizedpos.frm_audit_trail where user_name=?  order by accessed_time desc limit 100 ) as a\r\n"
				+ "union all\r\n"
				+ "select * from (select * from student_attendance.frm_audit_trail where user_name=? order by accessed_time desc  limit 100 ) as b\r\n"
				+ " \r\n"
				+ ") m order by accessed_time  desc limit 100", con);
	}

	public List<LinkedHashMap<String, Object>> getLastestUserHits(Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		return getListOfLinkedHashHashMap(parameters,
				"	select max(accessed_time) as T1,user_name,'abcdomain' appName from customizedpos.frm_audit_trail fat group by user_name having user_name is not null union all \r\n"
						+ "	select max(accessed_time) as T1,user_name,'AGS' from  student_attendance.frm_audit_trail fat group by user_name having user_name is not null \r\n"
						+ "	\r\n"
						+ "	order by T1 desc\r\n"
						+ "	limit 20;",
				con);
	}

	public List<LinkedHashMap<String, Object>> getSliderImages(long appId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfLinkedHashHashMap(parameters,
				"SELECT attachment_id,concat(attachment_id,file_name) as file_name FROM tbl_attachment_mst WHERE activate_flag=1 AND TYPE='Slider' and file_id=?",
				con);
	}

	public List<LinkedHashMap<String, Object>> getItemNamesForSearchAutocomplete(long appId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfLinkedHashHashMap(parameters,
				"SELECT item_id,item_name,category_name FROM mst_items item, mst_category cat WHERE item.parent_category_id=cat.category_id and  item.activate_flag=1 and item.app_id=?",
				con);
	}

	public List<LinkedHashMap<String, Object>> CategoryNameWithImage(long appId, Connection con)
			throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfLinkedHashHashMap(parameters, "select \r\n"
				+ "		category_id,category_name,\r\n"
				+ "		concat(tam.attachment_id,file_name),\r\n"
				+ "		case \r\n"
				+ "		when \r\n"
				+ "			concat(tam.attachment_id,file_name) is null 	 \r\n"
				+ "				then \r\n"
				+ "				     case when (select concat(tam.attachment_id,file_name) from mst_items as mi,tbl_attachment_mst tam where parent_category_id=mc.category_id and tam.file_id=mi.item_id and tam.type='Image' order by rand() limit 1) is null\r\n"
				+ "							then 'dummyImage.jpg' 				     	\r\n"
				+ "					else (select concat(tam.attachment_id,file_name) from mst_items as mi,tbl_attachment_mst tam where parent_category_id=mc.category_id and tam.file_id=mi.item_id and tam.type='Image' order by rand() limit 1) end 			\r\n"
				+ "				else concat(tam.attachment_id,file_name) end file_name \r\n"
				+ "	from \r\n"
				+ "		mst_category as mc \r\n"
				+ "		left outer join tbl_attachment_mst tam on mc.category_id=tam.file_id and tam.type='category'\r\n"
				+ "	where\r\n"
				+ "		mc.activate_Flag=1 and  app_id =?", con);

	}

	public List<LinkedHashMap<String, Object>> getProductsByCategoryId(long appId, String categoryId, Connection con)
			throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		parameters.add(categoryId);
		return getListOfLinkedHashHashMap(parameters, "SELECT  " +
				"item.item_id,item.item_name,item.`price`,cat.`category_name`, " +
				" 	(select case\r\n"
				+ "		when concat(attachment_id, file_name) is null then 'dummyImage.jpg'\r\n"
				+ "		else concat(attachment_id, file_name)\r\n"
				+ "	end as path from tbl_attachment_mst tam2  where tam2.file_id =item.item_id  and tam2.activate_flag =1 and tam2.`type` ='Image' limit 1) path "
				+
				"FROM  " +
				"mst_category cat, mst_items item   " +
				"WHERE cat.`category_id`=item.`parent_category_id` " +
				"AND item.`activate_flag`=1 AND cat.`activate_flag`=1  and item.app_id=? and cat.app_id=item.app_id  " +
				"AND cat.`category_id`=?", con);
	}

	public List<LinkedHashMap<String, Object>> getProductsForSearch(long appId, String searchString, Connection con)
			throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);

		parameters.add("%" + searchString + "%");
		parameters.add("%" + searchString + "%");
		return getListOfLinkedHashHashMap(parameters, "SELECT  " +
				"item.item_id,item.item_name,item.`price`,cat.`category_name`, " +
				" case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as path "
				+
				"FROM  " +
				"mst_category cat, mst_items item   " +
				" left outer join tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image'   " +
				"WHERE cat.`category_id`=item.`parent_category_id` " +
				"AND item.`activate_flag`=1 AND cat.`activate_flag`=1  and item.app_id=? and cat.app_id=item.app_id  " +
				"AND (cat.category_name like ? or item.item_name like ?)", con);
	}

	public List<LinkedHashMap<String, Object>> getItemsOfThisCategory(long appId, long categoryId, long itemId,
			int count, Connection con) throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		parameters.add(categoryId);
		parameters.add(itemId);
		parameters.add(count);
		return getListOfLinkedHashHashMap(parameters, "SELECT  " +
				"item.item_id,item.item_name,item.`price`,cat.`category_name`, " +
				" case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as path "
				+
				"FROM  " +
				"mst_category cat, mst_items item   " +
				" left outer join tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image'   " +
				"WHERE cat.`category_id`=item.`parent_category_id` " +
				"AND item.`activate_flag`=1 AND cat.`activate_flag`=1  and item.app_id=? and cat.app_id=item.app_id  " +
				"AND cat.`category_id`=?", con);

	}

	public List<LinkedHashMap<String, Object>> getItemsBySearchString(long appId, String SearchString, Connection con)
			throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(SearchString);
		parameters.add(SearchString);
		parameters.add(appId);

		return getListOfLinkedHashHashMap(parameters, "select\r\n"
				+ "	item.item_id,\r\n"
				+ "	item.item_name,\r\n"
				+ "	item.price,\r\n"
				+ "	cat.category_name,\r\n"
				+ " case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as path "
				+ "	\r\n"
				+ "from\r\n"
				+ "	mst_category cat, mst_items item left outer join  tbl_attachment_mst attachment on 	attachment.file_id = item.item_id	 and attachment.`activate_flag` = 1\r\n"
				+ "where\r\n"
				+ "	(item.item_name like ? or cat.category_name like ?) 	 \r\n"
				+ "	and item.`activate_flag` = 1\r\n"
				+ "	and item.`parent_category_id` = cat.`category_id`	\r\n"
				+ "	and cat.activate_flag = 1\r\n"
				+ "	and item.app_id = ?\r\n"
				+ "	and cat.app_id = item.app_id", con);

	}

	public LinkedHashMap<String, String> getAboutUsDetails(long appId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getMap(parameters,
				"select apm.*,concat(attach.attachment_id,attach.file_name) as fileName from mst_app apm left outer join tbl_attachment_mst attach on attach.file_id=apm.app_id  and attach.type='aboutus' where apm.app_id=? ",
				con);
	}

	public LinkedHashMap<String, String> getLogoDetails(long appId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getMap(parameters,
				"select concat(attach.attachment_id,attach.file_name) as fileName from tbl_attachment_mst attach where type='logo' and file_id=?",
				con);
	}

	public HashMap<String, Object> getCashbackForDeliveryTypes(Connection con) throws SQLException {
		HashMap<String, Object> hm = new HashMap<>();

		ResultSet rs = null;
		try {

			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT TYPE AS t1,PERCENTAGE AS p1 FROM mst_cashback ");
			while (rs.next()) {

				hm.put(rs.getString(1), rs.getInt(2));
			}
		} catch (Exception e) {
			writeErrorToDB(e);
		} finally {

			if (!rs.isClosed()) {
				rs.close();
			}
		}

		return hm;
	}

	public Long getWalletAmountForThisNumber(String number, Connection con) throws SQLException {

		PreparedStatement stmnt = null;
		ResultSet rs = null;
		Long amount = 0L;

		try {

			stmnt = con.prepareStatement("SELECT SUM(cashback_amount) FROM " +
					"trn_order_register_frommobileapp order1, " +
					"trn_cashback_register cashback " +
					"WHERE order1.number=? " +
					"AND cashback.orderId=order1.order_id");
			stmnt.setString(1, number);

			rs = stmnt.executeQuery();

			while (rs.next()) {
				amount = rs.getLong(1);
			}

		} catch (Exception e) {
			writeErrorToDB(e);
		} finally {

			if (!rs.isClosed()) {
				rs.close();
			}
			if (!stmnt.isClosed()) {
				stmnt.close();
			}

		}

		return amount;
	}

	public List<LinkedHashMap<String, Object>> getMobileAppOrders(String appId, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfLinkedHashHashMap(parameters, "select * from trn_order_register_frommobileapp where app_id=? ",
				con);
	}

	public LinkedHashMap<String, String> getInvoiceFormatName(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("user_id"));

		return getMap(parameters,
				"select * from user_configurations tum , invoice_formats format where tum.user_id=? and tum.invoice_format=format.format_id ",
				con);

	}

	public List<LinkedHashMap<String, Object>> getItemMasterForGenerateInvoice(HashMap<String, Object> hm,
			Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select\r\n"
				+ "	item.*,\r\n"
				+ "	cat.*,\r\n"
				+ "	case\r\n"
				+ "		when concat(attachment_id, file_name) is null then 'dummyImage.jpg'\r\n"
				+ "		else concat(attachment_id, file_name)\r\n"
				+ "	end as ImagePath,tpir.invoice_no PurchaseInvoiceNo,tpid.details_id purchase_details_id,store_id,tpid.qty - sum(COALESCE (tid.qty ,0)) as QtyAvailable\r\n"
				+ "from\r\n"
				+ "	mst_items item inner join mst_category cat on cat.category_id = item.parent_category_id\r\n"
				+ "left outer join tbl_attachment_mst tam on tam.file_id = item.item_id and tam.type = 'Image'\r\n"
				+ "left outer join trn_purchase_invoice_details tpid  on tpid.item_id =item.item_id\r\n"
				+ "left outer join trn_purchase_invoice_register tpir  on tpid.invoice_id =tpir.invoice_id  and tpir.store_id =?\r\n"
				+ "left outer join trn_invoice_details tid on tpid.details_id =tid.purchase_details_id \r\n"
				+ "where\r\n"
				+ "	item.activate_flag = 1\r\n"
				+ "	and item.app_id = ?\r\n"
				+ "	and cat.app_id = item.app_id\r\n"
				+ "	group by item.item_id,tpid.details_id"
				+ " --  having QtyAvailable>0 \r\n"
				+ "order by\r\n"
				+ "	item_name;";

		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("app_id"));

		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getItemMasterForGenerateInvoiceType1(HashMap<String, Object> hm,
			Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select item.item_name,item.price,stock.qty_available,item.item_id,product_code,item.sgst,item.cgst,cat.*,"
				+ " case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as ImagePath, stock.qty_available "
				+ "from mst_items item inner join mst_category cat on cat.category_id=item.parent_category_id left outer join "
				+ " tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image' left outer join stock_status stock on  stock.item_id=item.item_id and stock.app_id=item.app_id and stock.store_id=? "
				+ " where item.activate_flag=1 and item.app_id=? and cat.app_id=item.app_id ";

		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("app_id"));

		query += " group by item.item_id";
		query += " order by item_name";
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public List<LinkedHashMap<String, Object>> getItemMasterForGenerateInvoiceForThisStore(HashMap<String, Object> hm,
			Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select item.*,cat.*,"
				+ " case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as ImagePath, stock.qty_available "
				+ "from mst_items item inner join store_item_mpg sim on sim.store_id=? and sim.item_id=item.item_id inner join mst_category cat on cat.category_id=item.parent_category_id left outer join "
				+ " tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image' left outer join stock_status stock on  stock.item_id=item.item_id and stock.app_id=item.app_id and stock.store_id=? "
				+ " where item.activate_flag=1 and item.app_id=? and cat.app_id=item.app_id ";

		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("app_id"));

		query += " group by item.item_id";
		query += " order by item_name";
		return getListOfLinkedHashHashMap(parameters, query, con);
	}

	public boolean checkifUserAlreadyExist(long number, long appId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		parameters.add(number);
		int count = Integer.parseInt(
				getMap(parameters, "select count(1) as cnt from mst_customer where app_id=? and mobile_number=?", con)
						.get("cnt").toString());
		return count >= 1;
	}

	public boolean hasMultipleAttemps(long number, long appId, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		parameters.add(number);
		int count = Integer.parseInt(getMap(parameters,
				"select count(1) as cnt from trn_otp_register where app_id=? and mobile_number=?  and date(time_start)=curdate()",
				con).get("cnt").toString());
		return count >= 3;
	}

	public String validateOTP(long appId, long number, int otp, Connection con)
			throws ClassNotFoundException, SQLException {
		String message = "OTP validation Failed";

		PreparedStatement ps = con.prepareStatement(
				"SELECT count(1) FROM trn_otp_register WHERE mobile_number = ? AND otp = ? AND activate_flag = 1 and app_id=?");
		ps.setLong(1, number);
		ps.setInt(2, otp);
		ps.setLong(3, appId);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			if (rs.getString(1).equals("1")) {
				message = "OTP validation Successfull";
			}
		}

		return message;
	}

	public String resetPassword(long number, String password, long appId, Connection con) throws SQLException {

		PreparedStatement stmnt = null;
		String message = "Something went wrong";
		
		try {

			stmnt = con.prepareStatement(
					"update tbl_customer_mst set password=?,updated_date=sysdate() where mobile_number=? and app_id=?");
			stmnt.setString(1, password);
			stmnt.setLong(2, number);
			stmnt.setLong(3, appId);

			stmnt.executeUpdate();
			message = "Password Updated";

		} catch (Exception e) {
			writeErrorToDB(e);
		} finally {

			if (!stmnt.isClosed()) {
				stmnt.close();
			}

		}

		return message;
	}

	public String createNewCustomer(long number, String password, long appId, Connection con) throws SQLException {

		PreparedStatement ps = null;
		int rs;
		String message = "Sign Up failed";

		try {

			if (checkifUserAlreadyExist(number, appId, con)) {
				message = "User Already Exist";
				return message;
			}

			ps = con.prepareStatement("INSERT INTO tbl_customer_mst (Mobile_number, password, "
					+ "created_date, activate_flag, updated_date,app_id) VALUES(?,?,sysdate(),1,null,?)");
			ps.setLong(1, number);
			ps.setString(2, password);
			ps.setLong(3, appId);

			rs = ps.executeUpdate();

			if (rs > 0) {
				message = "Succesfully Created Account";
			}
		} catch (Exception e) {
			writeErrorToDB(e);
		} finally {

			if (ps != null && !ps.isClosed()) {
				ps.close();
			}

		}
		return message;
	}

	public LinkedHashMap<String, String> getuserDetailsByMobileNo(String mobileNo, String appId, Connection con)
			throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(mobileNo);
		parameters.add(appId);
		return getMap(parameters, "select * from tbl_user_mst where mobile=? and app_id=?", con);

	}

	public LinkedHashMap<String, String> getuserDetailsByEmailId(String emailId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(emailId);
		return getMap(parameters, "select * from tbl_user_mst where email=?", con);

	}

	public List<HashMap<String, Object>> showOrderHistory(long number, Connection con)
			throws ClassNotFoundException, SQLException {
		HashMap<String, Object> hm = null;
		List<HashMap<String, Object>> lstHm = new ArrayList<HashMap<String, Object>>();

		PreparedStatement stmnt = null;
		ResultSet rs = null;

		try {

			stmnt = con.prepareStatement("select " +
					" order_id, " +
					" date_format( tor.created_date, '%d/%m/%y' ) as dt1, " +
					" case when curr_status = 1 then 'ordered'" +
					"	  when curr_status = 2 then 'accepted'" +
					"    when curr_status =- 1 then 'rejected'" +
					"    when curr_status = 3 then 'Delivered'" +
					"	end status1," +
					" amount," +
					" case when curr_status = 1 then '0'	when curr_status = 3 then cashback.cashback_amount" +
					"	when curr_status =- 1 then '0'" +
					"	when curr_status =2 then '0'" +
					" end status1, " +
					" tor.previouscashbackamountused" +
					" from  " +
					" trn_order_register_frommobileapp tor left outer join trn_cashback_register cashback on cashback.orderId=tor.order_id and cashback.orderType!='Redeemed'  "
					+
					" where tor.`number`=?  " +
					" order by tor.created_date desc");

			stmnt.setLong(1, number);

			rs = stmnt.executeQuery();

			while (rs.next()) {
				hm = new HashMap<>();

				hm.put("id", rs.getString(1));
				hm.put("date", rs.getString(2));
				hm.put("status", rs.getString(3));
				hm.put("amount", rs.getString(4));
				hm.put("cashbackreceived", rs.getString(5));
				hm.put("previouscashbackamountused", rs.getString(6));

				lstHm.add(hm);
			}

		} catch (Exception e) {
			writeErrorToDB(e);
		} finally {

			if (!rs.isClosed()) {
				rs.close();
			}
			if (!stmnt.isClosed()) {
				stmnt.close();
			}

		}

		return lstHm;
	}

	public List<LinkedHashMap<String, Object>> getRelatedItems(long appId, String categoryId, Connection con, int count,
			long itemId) throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		parameters.add(categoryId);
		parameters.add(itemId);
		parameters.add(count);
		return getListOfLinkedHashHashMap(parameters, "SELECT  " +
				"item.item_id,item.item_name,item.`price`,cat.`category_name`, " +
				" case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as path "
				+
				"FROM  " +
				"mst_category cat, mst_items item   " +
				" left outer join tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image'   " +
				"WHERE cat.`category_id`=item.`parent_category_id` " +
				"AND item.`activate_flag`=1 AND cat.`activate_flag`=1  and item.app_id=? and cat.app_id=item.app_id  " +
				"AND cat.`category_id`=? and item.item_id!=? order by rand() limit ? ", con);

	}

	public List<LinkedHashMap<String, Object>> getPopularItems(String appId, Connection con)
			throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);

		return getListOfLinkedHashHashMap(parameters, "SELECT  " +
				"item.item_id,item.item_name,item.`price`,cat.`category_name`, " +
				" case when concat(attachment_id, file_name) is null then 'dummyImage.jpg' else concat(attachment_id, file_name) end as path "
				+
				"FROM  " +
				"mst_category cat, mst_items item   " +
				" left outer join tbl_attachment_mst tam on tam.file_id=item.item_id and tam.type='Image'   " +
				"WHERE cat.`category_id`=item.`parent_category_id` " +
				"AND item.`activate_flag`=1 AND cat.`activate_flag`=1  and item.app_id=? and cat.app_id=item.app_id order by rand() limit 20 ",
				con);
	}

	public LinkedHashMap<String, String> getItemdetailsById(long itemDetailsId, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(itemDetailsId);
		return getMap(parameters, "select * from trn_invoice_details where details_id=?", con);

	}

	public HashMap<String, Object> saveQuote(HashMap<String, Object> hm, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		long invoiceNo = getPkForThistable("trn_quote_register", Long.valueOf(hm.get("app_id").toString()), conWithF);

		parameters.add(hm.get("customer_id"));
		parameters.add(hm.get("gross_amount"));
		parameters.add(hm.get("item_discount"));
		parameters.add(hm.get("invoice_discount"));
		parameters.add(hm.get("total_amount"));
		parameters.add(hm.get("payment_type"));

		parameters.add(getDateASYYYYMMDD(hm.get("invoice_date").toString()));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("remarks"));
		parameters.add(hm.get("app_id"));

		parameters.add(invoiceNo);
		parameters.add(hm.get("total_gst"));

		long quoteId = insertUpdateDuablDB(
				"insert into trn_quote_register values (default,?,?,?,?,?,?,?,?,sysdate(),1,?,?,?,?,?)", parameters,
				conWithF);
		hm.put("quote_id", quoteId);

		List<HashMap<String, Object>> itemDetailsList = (List<HashMap<String, Object>>) hm.get("itemDetails");
		String[] stringTermsArray = (String[]) hm.get("stringTermsArray");

		int i = 1;
		for (Object item : stringTermsArray) {
			parameters = new ArrayList<>();
			parameters.add(quoteId);
			parameters.add(item);
			parameters.add(i++);

			insertUpdateDuablDB("insert into quote_terms_details values (default,?,?,?)", parameters,
					conWithF);
		}

		for (HashMap<String, Object> item : itemDetailsList) {
			parameters = new ArrayList<>();
			parameters.add(quoteId);
			parameters.add(item.get("item_id"));
			parameters.add(item.get("qty"));
			parameters.add(item.get("rate"));
			parameters.add(item.get("custom_rate"));
			parameters.add(hm.get("user_id"));
			parameters.add(hm.get("app_id"));
			parameters.add(item.get("gst_amount"));

			insertUpdateDuablDB("insert into trn_quote_details values (default,?,?,?,?,?,?,sysdate(),?,?)", parameters,
					conWithF);
		}

		hm.put("payment_for", "Invoice");
		hm.put("quote_id", quoteId);
		hm.put("quote_no", invoiceNo);
		return hm;
	}

	public List<LinkedHashMap<String, Object>> getDailyQuoteDetails(HashMap<String, Object> hm1, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm1.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm1.get("toDate").toString()));
		parameters.add(hm1.get("app_id"));

		String query = "select *,date_format(inv.quote_date,'%d/%m/%Y') as FormattedQuoteDate,date_format(inv.updated_date,'%d/%m/%Y %H:%i:%s') as updatedDate from trn_quote_register inv"
				+ " left outer join mst_customer cust on inv.customer_id=cust.customer_id and inv.app_id=cust.app_id  "
				+ "left outer join tbl_user_mst usertbl on inv.updated_by = usertbl.user_id "
				+ " inner join mst_store store1 on inv.store_id=store1.store_id "
				+ "where date(quote_date) between ? and ?  and inv.app_id=?   "
				+ "and usertbl.app_id=inv.app_id and store1.app_id=inv.app_id and inv.activate_flag=1 ";

		if (hm1.get("storeId") != null && !hm1.get("storeId").equals("") && !hm1.get("storeId").equals("-1")) {
			parameters.add(hm1.get("storeId").toString());
			query += " and inv.store_id =?";
		}

		query += " order by quote_date,quote_id asc ";
		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<String> getTermsAndConditionsForQuote(Connection con, String quote_id)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(quote_id);
		return getListOfString(parameters, "select term from quote_terms_details where quote_id=? order by `order` ",
				con);
	}

	public List<String> getDefaultTermsAndConditions(Connection con, String appId)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfString(parameters,
				"select terms_condition_content from mst_terms_and_conditions where app_id=? order by `order` ", con);
	}

	public LinkedHashMap<String, Object> getMobileBookingDetailsById(String mobileBookingId, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(mobileBookingId);
		LinkedHashMap<String, Object> itemDetailsMap = new LinkedHashMap<>();
		itemDetailsMap = getMapReturnObject(parameters,
				"select *,date_format(torf.created_date,'%d/%m/%Y %H:%i') as FormattedFromDate from trn_order_register_frommobileapp torf,customer_user_mpg cum,mst_customer cust  where order_id=? and cum.user_id=torf.user_id  and cust.customer_id=cum.customer_id",
				con);

		parameters = new ArrayList<>();
		parameters.add(mobileBookingId);

		itemDetailsMap.put("listOfItems",
				getListOfLinkedHashHashMap(parameters,
						"select * from trn_suborder_register reg,mst_items item where order_id=? and item.item_id=reg.item_id",
						con));
		return itemDetailsMap;

	}

	public String getDebitInForItem(String item_id, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(item_id);
		return getMap(parameters, "select debit_in from mst_items where item_id=?", con).get("debit_in");

	}

	public HashMap<String, Object> savePurchaseInvoice(HashMap<String, Object> hm, Connection conWithF)
			throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		long invoiceNo = getPkForThistable("trn_purchase_invoice_register", Long.valueOf(hm.get("app_id").toString()),
				conWithF);

		parameters.add(hm.get("customer_id"));
		parameters.add(hm.get("gross_amount"));
		parameters.add(hm.get("total_amount"));
		parameters.add(getDateASYYYYMMDD(hm.get("invoice_date").toString()));
		parameters.add(hm.get("user_id"));

		parameters.add(hm.get("store_id"));
		parameters.add(hm.get("remarks"));
		parameters.add(hm.get("app_id"));
		parameters.add(invoiceNo);

		parameters.add(hm.get("total_gst"));
		parameters.add(hm.get("txttallyrefno"));
		parameters.add(hm.get("txtvendorinvoiceno"));

		long invoiceId = insertUpdateDuablDB(
				"insert into trn_purchase_invoice_register values (default,?,?,?,?,?,sysdate(),1,"
						+ "?,?,?,?,?,?,?)",
				parameters,
				conWithF);
		hm.put("invoice_id", invoiceId);

		List<HashMap<String, Object>> itemDetailsList = (List<HashMap<String, Object>>) hm.get("itemDetails");
		for (HashMap<String, Object> item : itemDetailsList) {
			parameters = new ArrayList<>();
			parameters.add(invoiceId);
			parameters.add(item.get("item_id"));
			parameters.add(item.get("qty"));
			parameters.add(item.get("rate"));

			parameters.add(item.get("sgst_amount"));
			parameters.add(item.get("sgst_percentage"));

			parameters.add(item.get("cgst_amount"));
			parameters.add(item.get("cgst_percentage"));

			parameters.add(item.get("item_amount"));
			parameters.add(item.get("user_id"));
			parameters.add(hm.get("app_id"));

			insertUpdateDuablDB("insert into trn_purchase_invoice_details values (default,?,?,?,?,?,?,"
					+ "?,?,?,?,sysdate(),?)", parameters,
					conWithF);
		}
		hm.put("invoice_id", invoiceId);
		hm.put("invoice_no", invoiceNo);
		return hm;
	}

	public List<LinkedHashMap<String, Object>> getInvoicesPurchase(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		String query = "select * from trn_purchase_invoice_register tpr,mst_vendor cust, mst_store store"
				+ " where cust.vendor_id=tpr.customer_id and store.store_id=tpr.store_id and tpr.activate_flag=1 ";

		String storeId = hm.get("storeId").toString();
		String fromDate = hm.get("txtfromdate").toString();
		String toDate = hm.get("txttodate").toString();

		if (storeId != null && !storeId.equals("") && !storeId.equals("-1")) {
			query += " and tpr.store_id= ? ";
			parameters.add(storeId);
		}

		if (fromDate != null && !fromDate.equals("")) {
			query += " and tpr.invoice_date between  ?  and ?";
			parameters.add(getDateASYYYYMMDD(fromDate));
			parameters.add(getDateASYYYYMMDD(toDate));

		}

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public String deleteQuote(long quoteId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(quoteId);
		insertUpdateDuablDB("UPDATE trn_quote_register  SET activate_flag=0,updated_date=SYSDATE() WHERE quote_id=?",
				parameters,
				conWithF);
		return "Quote Deleted Succesfully";
	}

	public String deletePurchaseInvoice(long invoiceId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(invoiceId);
		insertUpdate(
				"UPDATE trn_purchase_invoice_register SET activate_flag=0,updated_by=?,updated_date=sysdate() WHERE invoice_id=?",
				parameters, conWithF);
		parameters.clear();

		return userId;
	}

	public List<LinkedHashMap<String, Object>> getCategoryWiseStoreWiseDetails(String appId, String fromDate,
			String toDate, String storeId, Connection con) throws ParseException, ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select\r\n"
				+ "ms.store_name ,mc.category_name,sum(tid.custom_rate) as amt1 \r\n"
				+ "from\r\n"
				+ "	trn_invoice_register tir,\r\n"
				+ "	trn_invoice_details tid,\r\n"
				+ "	mst_items mi ,\r\n"
				+ "	mst_category mc ,\r\n"
				+ "	mst_store ms \r\n"
				+ "where\r\n"
				+ "	tir.invoice_id = tid.invoice_id\r\n"
				+ "	and tir.activate_flag = 1\r\n"
				+ "	and tir.app_id = ?\r\n"
				+ "	 and tid.item_id =mi.item_id and mc.category_id =mi.parent_category_id and\r\n"
				+ "	 ms.store_id =tir.store_id and ms.activate_flag =1 and tir.invoice_date  between ? and ? and ms.store_id=?\r\n"
				+ "group by ms.store_name,mc.category_name";

		parameters.add((appId));
		parameters.add(getDateASYYYYMMDD(fromDate));
		parameters.add(getDateASYYYYMMDD(toDate));
		parameters.add((storeId));

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public long AddVisitor(Connection conWithF, HashMap<String, Object> hm) throws Exception {

		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("visitor_id", "~default");
		valuesMap.put("visitor_name", hm.get("visitorname"));
		valuesMap.put("address", hm.get("address"));
		valuesMap.put("purpose_of_visit", hm.get("purpose_of_visit"));
		valuesMap.put("remarks", hm.get("remarks"));
		valuesMap.put("mobile_no", hm.get("MobileNo"));
		valuesMap.put("email_id", hm.get("EmailId"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("app_id", hm.get("app_id"));
		valuesMap.put("in_time", "~sysdate()");
		valuesMap.put("activate_flag", "1");

		Query q = new Query("visitor_entry", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}

	public String updateVisitor(long visitorId, Connection conWithF, HashMap<String, Object> hm) throws Exception {

		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("visitor_name", hm.get("visitorname"));
		valuesMap.put("address", hm.get("address"));
		valuesMap.put("purpose_of_visit", hm.get("purpose_of_visit"));
		valuesMap.put("remarks", hm.get("remarks"));
		valuesMap.put("mobile_no", hm.get("MobileNo"));
		valuesMap.put("email_id", hm.get("EmailId"));
		valuesMap.put("updated_date", "~sysdate()");

		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("visitor_id", visitorId);

		Query q = new Query("visitor_entry", "update", valuesMap, whereMap);
		insertUpdateEnhanced(q, conWithF);

		return "visitor Updated Succesfully";

	}

	public LinkedHashMap<String, String> getvisitorDetails(long VisitorId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(VisitorId);
		return getMap(parameters,
				"select * from visitor_entry where visitor_id=?", con);

	}

	public List<LinkedHashMap<String, Object>> showVisitors(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));
		return getListOfLinkedHashHashMap(parameters,
				"select visitor_id visitorId,visitor_name visitorname, purpose_of_visit purpose_of_visit, mobile_no MobileNo,email_id EmailId,in_time in_time from visitor_entry where app_id=? and date(in_time) between ? and ? and activate_flag=1 order by in_time desc",
				con);

	}

	public String deleteVisitor(long visitorId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(visitorId);

		insertUpdateDuablDB("UPDATE visitor_entry  SET activate_flag=0,updated_date=SYSDATE() WHERE visitor_id=?",
				parameters, conWithF);
		return "Visitor deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getDistinctPurposeOfVisitList(Connection con, String appId)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfLinkedHashHashMap(parameters,
				"select distinct(purpose_of_visit) from visitor_entry where app_id=? and activate_flag=1", con);
	}

	public LinkedHashMap<String, String> getUserConfigurations(String userId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		return getMap(parameters,
				"select * from user_configurations uc where user_id =?", con);

	}

	public String deleteEmployee(long employeeId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(employeeId);
		insertUpdateDuablDB("UPDATE tbl_user_mst SET activate_flag=0,updated_date=SYSDATE() WHERE user_id=?",
				parameters, conWithF);
		return "Employee Deleted Succesfully";
	}

	public LinkedHashMap<String, String> getuserDetailsByUserName(String username, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(username);
		return getMap(parameters, "select * from tbl_user_mst where username=?", con);

	}

	public long addInvoiceFormats(long id, String formatName, Connection con) throws Exception {

		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("format_id", id);
		valuesMap.put("format_name", formatName);

		Query q = new Query("invoice_formats", "insert", valuesMap);
		return insertUpdateEnhanced(q, con);

	}

	public long addInvoiceTypes(long id, String typeName, Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);
		parameters.add(typeName);
		return insertUpdateDuablDB("insert into invoice_types values (?,?)", parameters, con);
	}

	public long addSphDetails(long detailsId, String sphr, String sphl, Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(detailsId);
		parameters.add(sphr);
		parameters.add(sphl);
		return insertUpdateDuablDB("insert into trn_sph_details values (default,?,?)", parameters, con);
	}

	public List<LinkedHashMap<String, Object>> getFuelMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_items where app_id=? and activate_flag=1",
				con);
	}

	public List<LinkedHashMap<String, Object>> getNozzleMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from nozzle_master nzlmst,mst_items fuelmst,dispenser_master dm "
						+ "where nzlmst.app_id=? and nzlmst.activate_flag=1 and fuelmst.item_id=nzlmst.item_id and dm.dispenser_id=nzlmst.parent_dispenser_id order by dispenser_name,nozzle_name",
				con);
	}

	public List<LinkedHashMap<String, Object>> getActiveNozzles(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from trn_nozzle_register tnr,nozzle_master nm,"
						+ "mst_items item,tbl_user_mst tum,shift_master shift where check_in_time is not null and check_out_time is null "
						+ "and tnr.app_id=? and nm.nozzle_id=tnr.nozzle_id and item.item_id=nm.item_id and tnr.attendant_id=tum.user_id and shift.shift_id=tnr.shift_id order by check_in_time desc",
				con);
	}

	public List<LinkedHashMap<String, Object>> getPastTwoDaysNozzles(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from trn_nozzle_register tnr,nozzle_master nm,"
						+ "mst_items item,tbl_user_mst tum,shift_master shift where "
						+ "tnr.app_id=? and nm.nozzle_id=tnr.nozzle_id and item.item_id=nm.item_id and tnr.attendant_id=tum.user_id and shift.shift_id=tnr.shift_id and check_in_time >=DATE_ADD(curdate() , INTERVAL -2 DAY) order by check_in_time desc",
				con);
	}

	public List<LinkedHashMap<String, Object>> getActiveNozzlesForMe(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("user_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from trn_nozzle_register tnr,nozzle_master nm,mst_items item where check_in_time is not null and check_out_time is null and tnr.app_id=? and nm.nozzle_id=tnr.nozzle_id and item.item_id=nm.item_id and tnr.user_id=?",
				con);
	}

	public List<LinkedHashMap<String, Object>> getAvailableNozzles(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select \r\n"
						+ "*,case when (check_in_time is not null and check_out_time is null) then 'Red' else 'Green' end color\r\n"
						+ " from nozzle_master nm \r\n"
						+ "left outer join (\r\n"
						+ "select nozzle_id,max(check_in_time) checkintime,user_id,check_in_time,check_out_time,opening_reading,closing_reading  from trn_nozzle_register tnr  where app_id =? \r\n"
						+ "group by nozzle_id ) T  on  nm.nozzle_id =T.nozzle_id \r\n"
						+ "left outer join tbl_user_mst tum on tum.user_id =nm.updated_by left outer join mst_items fuelmst on  fuelmst.item_id=nm.item_id \r\n"
						+ " \r\n"
						+ "where nm.app_id =?",
				con);
	}

	public String deleteFuel(long categoryId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(categoryId);
		insertUpdateDuablDB("UPDATE mst_items  SET activate_flag=0,updated_date=SYSDATE() WHERE item_id=?",
				parameters, conWithF);
		return "Category updated Succesfully";
	}

	public String deleteNozzle(long categoryId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(categoryId);
		insertUpdateDuablDB("UPDATE nozzle_master  SET activate_flag=0,updated_date=SYSDATE() WHERE nozzle_id=?",
				parameters, conWithF);
		return "Category updated Succesfully";
	}

	public long addFuel(Connection conWithF, HashMap<String, Object> hm) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("fuelName"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("app_id"));

		String insertQuery = "insert into mst_items values (default,?,1,?,sysdate(),?) ";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public long checkInNozzle(Connection conWithF, HashMap<String, Object> hm) throws SQLException, ParseException {

		ArrayList<Object> parameters = new ArrayList<>();

		hm.put("itemId", getNozzleDetails(hm.get("nozzle_id").toString(), conWithF).get("item_id"));

		parameters.add(hm.get("nozzle_id"));
		parameters.add(hm.get("drpattendantid"));
		parameters.add(hm.get("opening_reading"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("drpshift"));
		parameters.add(hm.get("itemPrice"));
		parameters.add(hm.get("itemId"));
		parameters.add(getDateASYYYYMMDD(hm.get("accountingDate").toString()));

		String insertQuery = "insert into trn_nozzle_register values "
				+ " (default,?,?,sysdate(),null,?,null,1,?,sysdate(),?,?,?,?,?)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public long checkInNozzleNew(Connection conWithF, HashMap<String, Object> hm) throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		hm.put("itemId", getNozzleDetails(hm.get("nozzle_id").toString(), conWithF).get("item_id"));
		valuesMap.put("trn_nozzle_id", "~default");
		valuesMap.put("nozzle_id", hm.get("nozzle_id"));
		valuesMap.put("attendant_id", hm.get("drpattendantid"));
		valuesMap.put("check_in_time", "~sysdate()");
		valuesMap.put("check_out_time", "~null");
		valuesMap.put("opening_reading", hm.get("opening_reading"));
		valuesMap.put("closing_reading", "~null");
		valuesMap.put("totalizer_opening_reading", hm.get("totalizer_opening_reading"));
		valuesMap.put("totalizer_closing_reading", "~null");
		valuesMap.put("activate_flag", "~1");
		valuesMap.put("updated_by", hm.get("user_id"));
		valuesMap.put("updated_date", "~null");
		valuesMap.put("app_id", hm.get("app_id"));
		valuesMap.put("shift_id", hm.get("drpshift"));
		valuesMap.put("rate", hm.get("itemPrice"));
		valuesMap.put("item_id", hm.get("itemId"));
		valuesMap.put("accounting_date", getDateASYYYYMMDD(hm.get("accountingDate").toString()));

		Query q = new Query("trn_nozzle_register", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}

	public long checkOutNozzle(Connection conWithF, HashMap<String, Object> hm) throws Exception {

		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("closing_reading", hm.get("closing_reading"));
		valuesMap.put("totalizer_closing_reading", hm.get("totalizer_closing_reading"));
		valuesMap.put("check_out_time", "~sysdate()");

		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("trn_nozzle_id", hm.get("trn_nozzle_id"));

		Query q = new Query("trn_nozzle_register", "update", valuesMap, whereMap);
		return insertUpdateEnhanced(q, conWithF);

	}

	public long addNozzle(Connection conWithF, HashMap<String, Object> hm) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("NozzleName"));
		parameters.add(hm.get("drpfueltype")); // this also

		parameters.add(hm.get("user_id"));

		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("drpDispenserId"));

		String insertQuery = "insert into nozzle_master values (default,?,?,1,?,sysdate(),?,?)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public String updateNozzle(long nozzleId, String nozzleName, String drpfuelType, String drpDispenserId,
			Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(nozzleName);
		parameters.add(drpfuelType); // this also
		parameters.add(drpDispenserId);
		parameters.add(nozzleId);
		insertUpdateDuablDB("update nozzle_master set nozzle_name=?,item_id=?,parent_dispenser_id=? where nozzle_id=?",
				parameters, con);
		return "Nozzle Updated Succesfully";
	}

	public LinkedHashMap<String, String> getLatestNozzelByCheckout(String nozzleId, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(nozzleId);

		return getMap(parameters, "select *,\r\n"
				+ "case when (check_in_time is not null and check_out_time is null) then 'Occupied' else 'Empty' end status\r\n"
				+ "from trn_nozzle_register tnr2\r\n"
				+ "left outer join tbl_user_mst tum on tnr2.attendant_id =tum.user_id \r\n"
				+ "where trn_nozzle_id =\r\n"
				+ "(select trn_nozzle_id from trn_nozzle_register tnr  where nozzle_id =? order by check_in_time desc limit 1)",
				con);

	}

	public LinkedHashMap<String, String> getDispenserDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("dispenser_id"));

		return getMap(parameters,
				"select * from dispenser_master where dispenser_id=? ",
				con);
	}

	public List<LinkedHashMap<String, Object>> getDispenserMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from dispenser_master where app_id=? and activate_flag=1",
				con);

	}

	public String deleteDispenser(long dispenserId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(dispenserId);
		insertUpdateDuablDB("UPDATE dispenser_master  SET activate_flag=0,updated_date=SYSDATE() WHERE dispenser_id=?",
				parameters, conWithF);
		return "Dispenser Deleted Succesfully";
	}

	public String updateDispenser(long dispenserId, String dispenserName, String userId, Connection con)
			throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(dispenserName);
		parameters.add(userId);
		parameters.add(dispenserId);

		insertUpdateDuablDB(
				"update dispenser_master set dispenser_name=?,updated_by=?,updated_date=sysdate() where dispenser_id=?",
				parameters, con);
		return "Dispenser Updated Succesfully";
	}

	public String updateQRCode(HashMap<String, Object> hm, Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("qr_code_number"));
		parameters.add(hm.get("CurrentlyAssignedTo"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("hdnQrId"));

		insertUpdateDuablDB(
				"update mst_qr_code set qr_code_number=?,currently_assigned_to=?,updated_by=? where qr_id=?",
				parameters, con);
		return "QR Updated Succesfully";
	}

	public long addDispenser(Connection conWithF, HashMap<String, Object> hm) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("dispenser_name"));
		parameters.add(hm.get("app_id"));

		parameters.add(hm.get("user_id"));

		String insertQuery = "insert into dispenser_master values (default,?,?,1,?,sysdate()) ";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public List<LinkedHashMap<String, Object>> getNozzleRegister(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));

		return getListOfLinkedHashHashMap(parameters,
				"select totalizer_opening_reading,totalizer_closing_reading,nozzle_name,item_name,shift_name,attendantName,check_in_time,check_out_time,opening_reading,closing_reading,testFuel,"
						+ "updated_by_supervisor,FormattedUpdatedDate"
						+ ",closing_reading-opening_reading-COALESCE(TestFuel,0) diffReading,rate,round((closing_reading-opening_reading-COALESCE(TestFuel,0))*rate,2) totalAmount from ( select\r\n"
						+ "	totalizer_opening_reading,totalizer_closing_reading,nozzle_name,item_name,shift_name,check_in_time,check_out_time,opening_reading,closing_reading,\r\n"
						+ "	date_format(tnr.updated_date, '%d/%m/%Y %H:%i:%s') as FormattedUpdatedDate,rate,\r\n"
						+ "	tum.name attendantName,\r\n"
						+ "	tum2.name updated_by_supervisor,\r\n"
						+ "	(select sum(test_quantity) from trn_test_fuel_register ttfr\r\n"
						+ "where test_date =accounting_date and user_id=tnr.attendant_id and ttfr.activate_flag=1 and shift_id =tnr.shift_id and ttfr.nozzle_id=tnr.nozzle_id)\r\n"
						+ "as testFuel \r\n"
						+ "from\r\n"
						+ "	trn_nozzle_register tnr,\r\n"
						+ "	nozzle_master nm,\r\n"
						+ "	tbl_user_mst tum,\r\n"
						+ "	mst_items item,\r\n"
						+ "	tbl_user_mst tum2,\r\n"
						+ "	shift_master shift\r\n"
						+ "where\r\n"
						+ "	tnr.app_id = ? \r\n"
						+ "	and nm.nozzle_id = tnr.nozzle_id\r\n"
						+ "	and tum.user_id = tnr.attendant_id\r\n"
						+ "	and tum2.user_id = tnr.updated_by\r\n"
						+ "	and shift.shift_id = tnr.shift_id\r\n"
						+ "	and accounting_date between ? and ? \r\n"
						+ "	and item.item_id = tnr.item_id\r\n"
						+ "order by\r\n"
						+ "	nozzle_name ) as T",
				con);
	}

	public List<LinkedHashMap<String, Object>> getPaymentsForDatesAttendantWise(HashMap<String, Object> hm,
			Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));
		parameters.add(hm.get("app_id"));

		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));
		parameters.add(hm.get("app_id"));

		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));
		parameters.add(hm.get("app_id"));

		return getListOfLinkedHashHashMap(parameters,
				"select name,\r\n"
						+ "sum(Cash) csh,\r\n"
						+ "sum(Card) cswp,\r\n"
						+ "sum(Paytm) pytm,\r\n"
						+ "sum(Pending) pnding,\r\n"
						+ "shift_name,from_time,to_time,dt,attendant_id from \r\n"
						+ "(select \r\n"
						+ "name,\r\n"
						+ "case when paymentMode='Cash' then amt else 0 end Cash,\r\n"
						+ "case when paymentMode='Card' then amt else 0 end Card,\r\n"
						+ "case when paymentMode='Paytm' then amt else 0 end Paytm,\r\n"
						+ "case when paymentMode='Pending' then amt else 0 end Pending,\r\n"
						+ "shift_id,dt,attendant_id\r\n"
						+ "from (\r\n"
						+ " select\r\n"
						+ "	sum(amount) amt,\r\n"
						+ "	tum.name, tsc.collection_mode paymentMode,shift_id,collection_date dt,tsc.attendant_id\r\n"
						+ "from\r\n"
						+ "	trn_supervisor_collection tsc ,\r\n"
						+ "	tbl_user_mst tum\r\n"
						+ "where\r\n"
						+ "	tsc.attendant_id = tum.user_id\r\n"
						+ "	and tsc.collection_date between ? and ? \r\n"
						+ "	and tum.app_id=? and tsc.activate_flag=1 \r\n"
						+ "group by\r\n"
						+ "	tum.name,tsc.collection_date,tsc.shift_id,tsc.collection_mode \r\n"
						+ " union all \r\n"
						+ "\r\n"
						+ "select\r\n"
						+ "	sum(total_amount) amt,tum.name ,tpr.payment_mode paymentMode,shift_id,tir.invoice_date dt,tum.user_id\r\n"
						+ "from\r\n"
						+ "	trn_invoice_register tir\r\n"
						+ "inner join rlt_invoice_fuel_details rifd\r\n"
						+ "on rifd.invoice_id =tir.invoice_id \r\n"
						+ "inner join tbl_user_mst tum on tum.user_id =rifd.attendant_id  \r\n"
						+ "inner join trn_payment_register tpr on tpr.ref_id=tir.invoice_id \r\n"
						+ "where invoice_date between ? and ? and tpr.payment_mode !='Cash'\r\n"
						+ "and tir.app_id =? and tir.activate_flag=1 group by tum.name,tpr.payment_mode,rifd.shift_id union all \r\n"
						+ "\r\n"
						+ "select\r\n"
						+ "	sum(total_amount) amt,tum.name ,'Pending',shift_id,tir.invoice_date dt,rifd.attendant_id\r\n"
						+ "from\r\n"
						+ "	trn_invoice_register tir\r\n"
						+ "inner join rlt_invoice_fuel_details rifd\r\n"
						+ "on rifd.invoice_id =tir.invoice_id \r\n"
						+ "inner join tbl_user_mst tum on tum.user_id =rifd.attendant_id  \r\n"
						+ "where invoice_date between ? and ? and tir.payment_type='Pending'\r\n"
						+ "and tir.app_id =? and tir.activate_flag=1 group by tum.name,rifd.shift_id) as T) as M,shift_master shft where shft.shift_id=M.shift_id group by name,M.shift_id",
				con);
	}

	public long saveCollectionSupervisor(Connection conWithF, HashMap<String, Object> hm)
			throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<String, Object>();
		valuesMap.put("collection_id", "~default");
		valuesMap.put("attendant_id", hm.get("drpemployee"));
		valuesMap.put("amount", hm.get("amount"));
		valuesMap.put("activate_flag", "~1");
		valuesMap.put("updated_by", hm.get("user_id"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("shift_id", hm.get("drpshiftid"));
		valuesMap.put("collection_date", getDateASYYYYMMDD(hm.get("txtcollectiondate").toString()));
		valuesMap.put("app_id", hm.get("app_id"));
		valuesMap.put("collection_mode", hm.get("mode"));
		valuesMap.put("shift_date", getDateASYYYYMMDD(hm.get("shift_date").toString()));

		Query q = new Query("trn_supervisor_collection", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}

	public long submitCashtoVault(Connection conWithF, HashMap<String, Object> hm) throws SQLException, ParseException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("userId"));
		parameters.add(hm.get("shiftId"));
		parameters.add(getDateASYYYYMMDD(hm.get("collectionDate").toString()));
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("userId"));
		parameters.add(hm.get("notes"));
		parameters.add(hm.get("coins"));

		String insertQuery = "insert into trn_cash_to_vault values (default,?,?,?,?,sysdate(),1,?,?,?)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public LinkedHashMap<String, String> getShiftDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("shift_id"));

		return getMap(parameters,
				"select\r\n"
						+ "*,	TIME_FORMAT(from_time, '%H') fromHour,\r\n"
						+ "	minute(from_time) fromMinute,\r\n"
						+ "	TIME_FORMAT(to_time, '%H') toHour,\r\n"
						+ "	minute(to_time) toMinute\r\n"
						+ "from\r\n"
						+ "	shift_master where shift_id=? ",
				con);
	}

	public List<LinkedHashMap<String, Object>> getShiftMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from shift_master where app_id=? and activate_flag=1",
				con);

	}

	public String getSuggestedShiftId(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		String quer = "select shift_id from shift_master where app_id=? and activate_flag=1 and current_time() between from_time and to_time";
		// String quer="select shift_id from shift_master where app_id=? and
		// activate_flag=1 and '23:00' between from_time and to_time";
		return getMap(parameters,
				quer,
				con).get("shift_id");

	}

	public String isTimeBetween00to06(Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		String quer = "select case  when curtime() between '00:00' and '06:00' then '0' else '1' end isTimeBetween from dual";
		// String quer="select case when '23:00' between '00:00' and '06:00' then '0'
		// else '1' end isTimeBetween from dual";
		return getMap(parameters,
				quer,
				con).get("isTimeBetween");

	}

	public String getSuggestedShiftIdBasedOnOrderId(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("date_time_from_payment"));
		return getMap(parameters,
				"select shift_id from shift_master where app_id=? and activate_flag=1 and time(?) between from_time and to_time",
				con).get("shift_id");

	}

	public long addShift(Connection conWithF, HashMap<String, Object> hm) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("shift_name"));

		parameters.add(hm.get("from_time_hour") + ":" + hm.get("from_time_minute"));
		parameters.add(hm.get("to_time_hour") + ":" + hm.get("to_time_minute"));

		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("user_id"));
		// String insertQuery = "insert into shift_master values
		// (default,?,?,?,?,?,1,?,?,sysdate()) ";
		String insertQuery = "insert into shift_master values (default,?,?,?,1,?,?,sysdate()) ";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public String updateShift(long shiftId, String shift_name, String from_time_hour, String from_time_minute,
			String to_time_hour, String to_time_minute, String userId, Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(shift_name);
		parameters.add(from_time_hour + ":" + from_time_minute);

		parameters.add(to_time_hour + ":" + to_time_minute);

		parameters.add(userId);
		parameters.add(shiftId);

		insertUpdateDuablDB(
				"update shift_master set shift_name=?,from_time=?,to_time=?,updated_by=?,updated_date=sysdate() where shift_id=?",
				parameters, con);
		return "Shift Updated Succesfully";
	}

	public HashMap<String, String> getNozzleDetailsFromRegister(HashMap<String, String> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("testNozzle"));
		return getMap(parameters,
				"select * from trn_nozzle_register where nozzle_id=? and check_in_time is not null and check_out_time is null",
				con);
	}

	public String deleteShift(long shiftId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(shiftId);
		insertUpdateDuablDB("UPDATE shift_master  SET activate_flag=0,updated_date=SYSDATE() WHERE shift_id=?",
				parameters, conWithF);
		return "Shift Deleted Succesfully";
	}

	public long addTestFuel(Connection conWithF, HashMap<String, String> hm) throws SQLException, ParseException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("testQuantity"));
		parameters.add(hm.get("testNozzle"));
		parameters.add(hm.get("shift_id"));
		parameters.add(hm.get("attendant_id"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("app_id"));
		parameters.add(getDateASYYYYMMDD(hm.get("testDate")));
		parameters.add(hm.get("test_type"));

		String insertQuery = "INSERT INTO trn_test_fuel_register\r\n"
				+ " VALUES (default,?,?,?,?,sysdate(),?,?,?,1,?)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public long addConfigureLR(Connection conWithF, HashMap<String, String> hm) throws SQLException, ParseException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("printer"));
		parameters.add(hm.get("copies"));
		parameters.add(hm.get("app_id"));

		String insertQuery = "INSERT INTO mst_config \r\n"
				+ " VALUES (default,?,?,?)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public long addGenerateLR(Connection conWithF, HashMap<String, String> hm) throws SQLException, ParseException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("lrnumber"));
		parameters.add(hm.get("stockistname"));
		parameters.add(hm.get("wadhwanto"));
		parameters.add(hm.get("address"));
		parameters.add(hm.get("city"));
		parameters.add(hm.get("telno"));
		parameters.add(hm.get("truckno"));
		parameters.add(hm.get("weight"));
		parameters.add(hm.get("cement"));
		parameters.add(hm.get("bags"));
		parameters.add(hm.get("app_id"));

		String insertQuery = "insert into trn_lr_register"
				+ "(lr_no,stockist_name,wadhwan_to,address,created_date,city,tel_no,truck_no,weight,cement,bags,app_id) VALUES"
				+ "(?,?,?,?,sysdate(),?,?,?,?,?,?,?)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);
	}

	public LinkedHashMap<String, String> getMaxLrNo(Connection con, HashMap<String, Object> hm)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));

		String query = "SELECT   CASE WHEN MAX(lr_no) IS NULL  THEN 1 ELSE MAX(lr_no)+1 END lrno  FROM `trn_lr_register` WHERE app_id=?";

		return getMap(parameters, query, con);

	}

	public LinkedHashMap<String, String> searchLR(Connection con, HashMap<String, Object> hm)
			throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("lrnumbersearch"));
		parameters.add(hm.get("app_id"));

		String query = "SELECT DATE_FORMAT(created_date,'%d/%m/%Y') AS niceDate,`stockist_name`,`wadhwan_to`,`address`,city,tel_no,truck_no,weight,cement,bags FROM trn_lr_register WHERE `lr_no`=? and app_id=?";

		return getMap(parameters, query, con);
	}

	public LinkedHashMap<String, String> getSwipeDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("swipe_machine_id"));

		return getMap(parameters,
				"select * from swipe_machine_master where swipe_machine_id=? ",
				con);
	}

	public LinkedHashMap<String, String> getVehicleDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("vehicle_id"));

		return getMap(parameters,
				"select * from mst_vehicle mv,mst_flat mf,mst_block mb,flat_owner_mapping fom ,mst_person pm  where \r\n" + //
						"\t\t\t\tmv.flat_id =mf.flat_id and mb.block_id =mf.block_id and mf.flat_id =fom.flat_id and pm.person_id =fom.person_id and\r\n" + //
						"\t\t\t\tmv.vehicle_id=? ",
				con);
	}
	public List<LinkedHashMap<String, Object>> getVehiclesiblingDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("vehicle_id"));

		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_vehicle mv2 where flat_id in (" +
					"select flat_id  from mst_vehicle mv where vehicle_id =?)and activate_flag =1 ",
				con);
	}
	
	public List<LinkedHashMap<String, Object>> getSwipeMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from swipe_machine_master where app_id=? and activate_flag=1",
				con);

	}

	public long addSwipe(Connection conWithF, HashMap<String, Object> hm) throws SQLException {

		String insertQuery = "insert into swipe_machine_master  values (default,:swipe_machine_name,:swipe_machine_bank,"
				+ ":swipe_machine_account_no,:swipe_machine_short_name,1,:app_id,:user_id,sysdate()) ";
		return insertUpdateCustomParameterized(insertQuery, hm, conWithF);
	}

	public long addIncomingPaymentPetrol(Connection conWithF, HashMap<String, String> hm) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("order_id"));
		parameters.add(hm.get("bhim_upi_id"));
		parameters.add(hm.get("amount"));
		parameters.add(hm.get("mobile_no"));
		parameters.add(hm.get("date_time_from_payment"));
		parameters.add(hm.get("app_id"));

		String insertQuery = "INSERT INTO trn_incoming_online_payments\r\n"
				+ " VALUES (?, ?, ?, ?, 0, ?, sysdate(), NULL, '0',?)";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public LinkedHashMap<String, String> getUnclaimedPaymentDetails(String categoryId, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(categoryId);
		return getMap(parameters, "select * from trn_incoming_online_payments where order_id=?", con);
	}

	public List<LinkedHashMap<String, Object>> getEmployeesCheckedInToNozzle(String appId, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfLinkedHashHashMap(parameters, "select\r\n"
				+ "	*\r\n"
				+ "from\r\n"
				+ "	trn_nozzle_register tnr inner join tbl_user_mst tum on tnr.attendant_id =tum.user_id  \r\n"
				+ "where\r\n"
				+ "	check_in_time is not null\r\n"
				+ "	and check_out_time is null and tnr.app_id =?", con);
	}

	public List<LinkedHashMap<String, Object>> getDistinctEmployeesCheckedInToNozzle(String appId, Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(appId);
		return getListOfLinkedHashHashMap(parameters, " select\r\n"
				+ "	distinct(user_id),username,name\r\n"
				+ "from\r\n"
				+ "	trn_nozzle_register tnr inner join tbl_user_mst tum on tnr.attendant_id =tum.user_id  \r\n"
				+ "where\r\n"
				+ "	check_in_time is not null\r\n"
				+ "	and check_out_time is null and tnr.app_id =?", con);
	}

	public String updateSwipe(long hdnSwipeMachineId, String swipe_machine_name, String swipe_machine_bank,
			String swipe_machine_account_no, String swipe_machine_short_name, String userId, Connection con)
			throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(swipe_machine_name);
		parameters.add(swipe_machine_bank);
		parameters.add(swipe_machine_account_no);
		parameters.add(swipe_machine_short_name);
		parameters.add(userId);
		parameters.add(hdnSwipeMachineId);

		insertUpdateDuablDB(
				"update swipe_machine_master set swipe_machine_name=?,swipe_machine_bank=?,swipe_machine_account_no=?,swipe_machine_short_name=?,updated_by=?,updated_date=sysdate() where swipe_machine_id=?",
				parameters, con);
		return "Swipe Updated Succesfully";
	}

	public String updateVehicle(HashMap<String, Object> hm, Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("vehicleName"));
		parameters.add(hm.get("hdnselectedflat"));

		parameters.add(hm.get("vehicleNumber"));
		parameters.add(hm.get("userId"));
		parameters.add(hm.get("vehicle_id"));

		insertUpdateDuablDB(
				"update mst_vehicle set vehicle_name=?,flat_id=?, vehicle_number=?,updated_by=?,updated_date=sysdate() where vehicle_id=?",
				parameters, con);
		return "Vehicle Updated Succesfully";
	}

	public String deleteSwipe(long swipeMachineId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(swipeMachineId);
		insertUpdateDuablDB(
				"UPDATE swipe_machine_master  SET activate_flag=0,updated_date=SYSDATE() WHERE swipe_machine_id=?",
				parameters, conWithF);
		return "Swipe Deleted Succesfully";
	}

	public String deleteSupervisorTransaction(String appId, long collection_id, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(collection_id);
		parameters.add(appId);
		insertUpdateDuablDB(
				"UPDATE trn_supervisor_collection tsc  SET activate_flag=0,updated_date=SYSDATE() WHERE collection_id=? and app_id=?",
				parameters, conWithF);
		return "Transaction Deleted Succesfully";
	}

	public String deletePaytmTransaction(long order_id, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(order_id);
		insertUpdateDuablDB(
				"UPDATE trn_supervisor_collection tsc, trn_incoming_online_payments tiop SET tsc.activate_flag=0,tsc.updated_date=SYSDATE() WHERE tsc.paytm_order_id=?",
				parameters, conWithF);
		return "Transaction Deleted Succesfully";
	}

	public String deletePaytmTransactionFromCollectPayment(long collection_id, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(collection_id);
		insertUpdateDuablDB(
				"UPDATE trn_supervisor_collection tsc SET activate_flag=0 and updated_date=sysdate() where collection_id=?",
				parameters, conWithF);
		return "Transaction Deleted Succesfully";
	}

	public LinkedHashMap<String, String> getOrderIdForCollectionId(long collection_id, Connection conWithF)
			throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(collection_id);
		return getMap(parameters, "select paytm_order_id from trn_supervisor_collection tsc where collection_id=?",
				conWithF);
	}

	public String deleteTestFuel(long test_id, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(test_id);
		insertUpdateDuablDB("UPDATE trn_test_fuel_register ttfr set activate_flag=0 where test_id=?",
				parameters, conWithF);
		return "Test Fuel Deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getTestData(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));
		parameters.add(hm.get("app_id"));

		return getListOfLinkedHashHashMap(parameters,
				"select *,tum.name attendantName,tum2.name superVisorName from trn_test_fuel_register ttfr,tbl_user_mst tum,tbl_user_mst tum2,shift_master shft,nozzle_master nm,mst_items fm "
						+ " where test_date between ? and ? and ttfr.activate_flag=1 and ttfr.app_id=? and ttfr.shift_id=shft.shift_id and "
						+ "tum.user_id=ttfr.user_id and tum2.user_id=ttfr.updated_by and nm.nozzle_id=ttfr.nozzle_id and fm.item_id=nm.item_id order by ttfr.updated_date desc ",
				con);
	}

	public List<LinkedHashMap<String, Object>> getCollectionData(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));

		return getListOfLinkedHashHashMap(parameters,
				"select \r\n"
						+ "*,\r\n"
						+ "tum.name as AttendantName,shift_name,tum2.name as SupervisorName\r\n"
						+ "from trn_supervisor_collection tsc,shift_master sm ,tbl_user_mst tum  ,tbl_user_mst tum2  \r\n"
						+ "where collection_date  between ? and ? and sm.shift_id=tsc.shift_id and tum.user_id =tsc.attendant_id\r\n"
						+ "and \r\n"
						+ "tum2.user_id =tsc.updated_by;",
				con);
	}

	public List<LinkedHashMap<String, String>> getCollectionDataDateAndShiftWise(String collection_date, String shiftId,
			Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(collection_date));
		parameters.add(shiftId);

		return getListOfLinkedHashHashMapString(parameters,
				"select \r\n"
						+ "*,\r\n"
						+ "tum.name as AttendantName,shift_name,tum2.name as SupervisorName\r\n"
						+ "from trn_supervisor_collection tsc,shift_master sm ,tbl_user_mst tum  ,tbl_user_mst tum2  \r\n"
						+ "where collection_date=? and sm.shift_id=tsc.shift_id and tsc.shift_id=? and tum.user_id =tsc.attendant_id\r\n"
						+ "and \r\n"
						+ "tum2.user_id =tsc.updated_by;",
				con);
	}

	public List<LinkedHashMap<String, String>> getTestDataDateAndShiftWise(String collection_date, String shiftId,
			Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(collection_date));
		parameters.add(shiftId);

		return getListOfLinkedHashHashMapString(parameters,
				"select \r\n"
						+ "*,\r\n"
						+ "tum.name as AttendantName,shift_name,tum2.name as SupervisorName,DATE_FORMAT(test_date,'%d/%m/%Y') AS niceTestDate\r\n"
						+ "from trn_test_fuel_register tsc,shift_master sm ,tbl_user_mst tum  ,tbl_user_mst tum2,nozzle_master nm  \r\n"
						+ "where test_date=? and sm.shift_id=tsc.shift_id and tsc.shift_id=? and tum.user_id =tsc.user_id and nm.nozzle_id=tsc.nozzle_id \r\n"
						+ "and \r\n"
						+ "tum2.user_id =tsc.updated_by;",
				con);
	}

	public LinkedHashMap<String, String> getSumOfCollectionAmount(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));
		parameters.add(hm.get("suggestedShiftId"));
		parameters.add(hm.get("user_id"));

		return getMap(parameters,
				"select \r\n"
						+ "sum(amount) mySum,\r\n"
						+ "tum.name as AttendantName,shift_name,tum2.name as SupervisorName\r\n"
						+ "from trn_supervisor_collection tsc,shift_master sm ,tbl_user_mst tum  ,tbl_user_mst tum2  \r\n"
						+ "where collection_date  between ? and ? and tsc.shift_id=? and tsc.updated_by=? and sm.shift_id=tsc.shift_id and tum.user_id =tsc.attendant_id\r\n"
						+ "and \r\n"
						+ "tum2.user_id =tsc.updated_by;",
				con);
	}

	public LinkedHashMap<String, String> getVaultData(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));
		parameters.add(hm.get("suggestedShiftId"));
		parameters.add(hm.get("user_id"));

		return getMap(parameters,
				"select \r\n"
						+ "SUM(notes+coins) as vaultSum \r\n"
						+ "from trn_cash_to_vault tctv  \r\n"
						+ "where accounting_date between ? and ? and shift_id=? and supervisor_id=? ;",
				con);
	}

	public List<LinkedHashMap<String, Object>> getItemList(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));

		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_items where app_id=? and activate_flag=1",
				con);
	}

	public long insertIntoItemHistory(String itemId, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(itemId);

		return insertUpdateDuablDB(
				"insert into hst_mst_items select * from mst_items where item_id=?", parameters,
				con);
	}

	public LinkedHashMap<String, String> getPaytmOrderDetails(String order_id, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(order_id);

		return getMap(parameters,
				"select * from trn_incoming_online_payments tiop where order_id =? ",
				con);
	}

	public List<LinkedHashMap<String, Object>> getSupervisorCollection(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("app_id"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));

		String query = "select \r\n"
				+ "*,\r\n"
				+ "tum.name as AttendantName,shift_name,tum2.name as SupervisorName\r\n"
				+ "from trn_supervisor_collection tsc,shift_master sm ,tbl_user_mst tum  ,tbl_user_mst tum2  \r\n"
				+ "where tsc.activate_flag=1 and tsc.app_id=? and collection_date  between ? and ? and sm.shift_id=tsc.shift_id and tum.user_id =tsc.attendant_id\r\n"
				+ "and \r\n"
				+ "tum2.user_id =tsc.updated_by";

		if (hm.get("attendantId") != null && !hm.get("attendantId").equals("")) {
			query += " and tsc.attendant_id=?";
			parameters.add(hm.get("attendantId"));
		}

		return getListOfLinkedHashHashMap(parameters,
				query,
				con);
	}

	public List<LinkedHashMap<String, Object>> getPaytmTransaction(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));

		String query = "select * from trn_incoming_online_payments tsc where accepted_shift_id is not null and date(date_time_from_payment) between ? and ? ";

		if (hm.get("attendantId") != null && !hm.get("attendantId").equals("")) {
			query += " and tsc.claimed_by_user_id=?";
			parameters.add((hm.get("attendantId").toString()));

		}
		query += " order by date_time_from_payment";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public LinkedHashMap<String, String> getQrCodeDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("qr_id"));

		return getMap(parameters,
				"select * from mst_qr_code where qr_id=? ",
				con);
	}

	public List<LinkedHashMap<String, Object>> getQrCodeMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_qr_code qr, tbl_user_mst tum where qr.app_id=? and qr.activate_flag=1 and tum.user_id=qr.currently_assigned_to",
				con);

	}

	public String deleteQrCode(long dispenserId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(dispenserId);
		insertUpdateDuablDB("UPDATE mst_qr_code  SET activate_flag=0,updated_date=SYSDATE() WHERE qr_id=?",
				parameters, conWithF);
		return "QrCode Deleted Succesfully";
	}

	public String updateQrCode(long qrId, String qrCodeNumber, String userId, Connection con) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(qrCodeNumber);
		parameters.add(userId);
		parameters.add(qrId);

		insertUpdateDuablDB("update mst_qr_code set qr_code_number=?,updated_by=?,updated_date=sysdate() where qr_id=?",
				parameters, con);
		return "Dispenser Updated Succesfully";
	}

	public long addQrCode(Connection conWithF, HashMap<String, Object> hm) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("qr_code_number"));
		parameters.add(hm.get("app_id"));
		parameters.add(hm.get("CurrentlyAssignedTo"));

		parameters.add(hm.get("user_id"));

		String insertQuery = "insert into mst_qr_code values (default,?,?,?,?,1) ";

		return insertUpdateDuablDB(insertQuery, parameters, conWithF);

	}

	public long savePaymentToDB(HashMap<String, String> hm, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("orderId"));
		parameters.add(hm.get("bhimupiid"));
		parameters.add(hm.get("amount"));
		parameters.add(hm.get("PaymentDate"));
		parameters.add(hm.get("currently_assigned_to"));
		parameters.add(hm.get("StoreName"));

		String insertQuery = "replace into trn_incoming_online_payments values (?,?,?,?,sysdate(),?,208,null,null,?) ";

		return insertUpdateDuablDB(insertQuery, parameters, con);

	}

	public HashMap<String, String> getuserIdFromStoreName(HashMap<String, String> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("StoreName"));
		return getMap(parameters, "select currently_assigned_to from mst_qr_code where qr_code_number=?", con);

	}

	public List<LinkedHashMap<String, Object>> getPhonePePayments(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {

		String query = "select *,concat(SUBSTRING(order_id ,1,length(order_id)/2) ,' ', \r\n"
				+ "SUBSTRING(order_id ,length(order_id)/2 +1,length(order_id))) orderIdWithSpace,concat(SUBSTRING(bhim_upi_id ,1,length(order_id)/2) ,' ', \r\n"
				+ "SUBSTRING(bhim_upi_id ,length(order_id)/2 +1,length(bhim_upi_id))) bhimupiidwithspace from trn_incoming_online_payments where claimed_by_user_id=? and date(date_time_from_payment) between ? and ? ";

		if (!hm.get("chkaccepted").equals("true")) {
			query += "and accepted_shift_id is null  ";
		}

		query += "order by date_time_from_payment desc";

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("user_id"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));

		return getListOfLinkedHashHashMap(parameters,
				query,
				con);

	}

	public HashMap<String, String> getAccountinDateAndShiftId(String userId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		return getMap(parameters,
				"select DATE_FORMAT(accounting_date,'%d/%m/%Y') AS niceDate,shift_id from trn_nozzle_register tnr where check_out_time is null and attendant_id =?",
				con);

	}

	public void updatePhonePayPayment(String orderId, String accounting_date, String shiftId, Connection con)
			throws ParseException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(getDateASYYYYMMDD(accounting_date));
		parameters.add(shiftId);
		parameters.add(orderId);

		insertUpdateDuablDB("update trn_incoming_online_payments set shift_date=?,accepted_shift_id=? where order_id=?",
				parameters, con);

	}

	public String resetPassword(String employeeId, Connection conWithF) throws Exception {

		changePasswordById(employeeId, "123", conWithF);
		return "Password Reset Succesfully";
	}

	public void changePasswordById(String userId, String newPassword, Connection con) throws Exception {
		try {
			String insertTableSQL = "UPDATE tbl_user_mst set password=?,updated_date=sysdate() WHERE user_id=?";

			PreparedStatement preparedStatement = con.prepareStatement(insertTableSQL);
			preparedStatement.setString(1, getSHA256String(newPassword));
			preparedStatement.setString(2, userId);
			preparedStatement.executeUpdate();

			if (preparedStatement != null) {
				preparedStatement.close();
			}

		} catch (Exception e) {
			// write to error log
			writeErrorToDB(e);
			throw e;
		}
	}

	public List<LinkedHashMap<String, Object>> getBankMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_bank where activate_flag=1 and app_id=?",
				con);
	}

	public List<LinkedHashMap<String, Object>> getAccountMaster(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		// sparameters.add(hm.get("app_id"));
		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_account where activate_flag=1 ",
				con);
	}

	public LinkedHashMap<String, String> getBankDetail(HashMap<String, Object> hm, Connection con) throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("bank_id"));

		return getMap(parameters,
				"select * from mst_bank where bank_id=?",
				con);
	}

	public LinkedHashMap<String, String> getAccountDetail(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("accountId"));

		return getMap(parameters,
				"select * from mst_account where account_id=?",
				con);
	}

	public long addBank(Connection con, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("bank_name"));
		parameters.add(hm.get("account_no"));
		parameters.add(hm.get("ifsc_code"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("app_id"));

		return insertUpdateDuablDB("insert into mst_bank values (default,?,?,?,1,?,sysdate(),?)", parameters,
				con);
	}

	public long addAccount(Connection con, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("account_name"));
		parameters.add(hm.get("account_no"));
		parameters.add(hm.get("ifsc_code"));
		parameters.add(hm.get("qr_code"));

		return insertUpdateDuablDB("insert into mst_account values (default,?,?,?,?,1)", parameters,
				con);
	}

	public String updateBank(HashMap<String, Object> hm, Connection con) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("bank_name"));
		parameters.add(hm.get("account_no"));
		parameters.add(hm.get("ifsc_code"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("hdnBankId"));

		insertUpdateDuablDB(
				"UPDATE mst_bank SET bank_name=?,account_no=?,ifsc_code=?,updated_date=SYSDATE(),updated_by=?"
						+ " WHERE bank_id=?",

				parameters, con);
		return "Bank updated Succesfully";

	}

	public String updateAccount(HashMap<String, Object> hm, Connection con) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("account_name"));
		parameters.add(hm.get("account_no"));
		parameters.add(hm.get("ifsc_code"));
		parameters.add(hm.get("qr_code"));

		parameters.add(hm.get("hdnAccountId"));

		insertUpdateDuablDB(
				"UPDATE mst_account SET account_name=?,account_no=?,ifsc_code=?,qr_code=?"
						+ " WHERE account_id=?",

				parameters, con);
		return "Account updated Succesfully";

	}

	public String deletebank(long bankId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(bankId);
		insertUpdateDuablDB("UPDATE mst_bank SET activate_flag=0,updated_date=SYSDATE() WHERE bank_id=?",
				parameters, conWithF);
		return "Bank Deleted Succesfully";
	}

	public String deleteAccount(long accountId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(accountId);
		insertUpdateDuablDB("UPDATE mst_account SET activate_flag=0 WHERE account_id=?",
				parameters, conWithF);
		return "Account Deleted Succesfully";
	}

	public LinkedHashMap<String, String> getBankReconcilationDetail(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("reconcilation_id"));

		return getMap(parameters,
				"select * from trn_bank_reconcilation where reconcilation_id=?",
				con);
	}

	public long addBankReconcilation(Connection con, HashMap<String, Object> hm) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("drpBankId"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtreconcilationdate").toString()));
		parameters.add(hm.get("amount"));
		parameters.add(hm.get("user_id"));

		return insertUpdateDuablDB("insert into trn_bank_reconcilation values (default,?,?,?,1,?,sysdate())",
				parameters,
				con);
	}

	public String updateBankReconcilation(HashMap<String, Object> hm, Connection con) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("drpBankId"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtreconcilationdate").toString()));
		parameters.add(hm.get("amount"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("hdnReconcilationId"));

		insertUpdateDuablDB(
				"UPDATE trn_bank_reconcilation SET bank_account_id=?,reconcilation_date=?,amount=?,updated_date=SYSDATE(),updated_by=?"
						+ " WHERE reconcilatio_id=?",

				parameters, con);
		return "Bank updated Succesfully";

	}

	public String deletebankReconcilation(long reconcilationId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(reconcilationId);
		insertUpdateDuablDB(
				"UPDATE trn_bank_reconcilation SET activate_flag=0,updated_date=SYSDATE() WHERE reconcilatio_id=?",
				parameters, conWithF);
		return "Bank Deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getReconcilationRegister(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));

		String query = "select * from trn_bank_reconcilation where reconcilation_date between ? and ? and activate_flag=1 order by reconcilation_date desc ";

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public String deleteReconcilation(long reconcilation_id, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(reconcilation_id);
		insertUpdateDuablDB(
				"UPDATE trn_bank_reconcilation tbr SET activate_flag=0 and updated_date=sysdate() where reconcilation_id=?",
				parameters, conWithF);
		return "Reconcilation Deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getAttendantsForDateAndShift(String collectiondate, String shiftId,
			Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(collectiondate));
		parameters.add(shiftId);
		return getListOfLinkedHashHashMap(parameters,
				"select distinct(username),user_id from trn_nozzle_register tnr,tbl_user_mst tum where accounting_date=? and shift_id =? and tum.user_id=tnr.attendant_id",
				con);
	}

	public List<LinkedHashMap<String, Object>> getCheckinRegister(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));
		parameters.add(hm.get("app_id"));

		return getListOfLinkedHashHashMap(parameters,
				"select *,tum.name attendantName,tum2.name superVisorName from trn_nozzle_register tnr,tbl_user_mst tum,tbl_user_mst tum2,shift_master shft,nozzle_master nm,mst_items fm "
						+ " where accounting_date between ? and ? and tnr.activate_flag=1 and tnr.app_id=? and tnr.shift_id=shft.shift_id and "
						+ "tum.user_id=tnr.attendant_id and tum2.user_id=tnr.updated_by and nm.nozzle_id=tnr.nozzle_id and fm.item_id=nm.item_id",
				con);
	}

	public String deleteCheckin(long nozzle_id, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(nozzle_id);
		insertUpdateDuablDB("Delete from  trn_nozzle_register where nozzle_id=?",
				parameters, conWithF);
		return "Checkin Deleted Succesfully";
	}

	// public List<LinkedHashMap<String, Object>>
	// getAttendantsForDateAndShiftUnclubbed(String collectiondate,
	// String shiftId, Connection con)
	// throws ClassNotFoundException, SQLException, ParseException {
	// ArrayList<Object> parameters = new ArrayList<>();
	// parameters.add(getDateASYYYYMMDD(collectiondate));
	// parameters.add(shiftId);
	// return getListOfLinkedHashHashMap(parameters, "select\r\n"
	// + " username,name,\r\n"
	// + " user_id,\r\n"

	
	
	
	public List<LinkedHashMap<String, Object>> getFlatMaster(Connection con,HashMap<String, Object> hm)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		String query="select\r\n" + //
				"*\r\n" + //
				"from\r\n" + //
				"mst_block bm,\r\n" + //
				"mst_flat fm \r\n" + //
				"left outer join flat_owner_mapping fom on fom.flat_id=fm.flat_id and fom.activate_flag=1  \r\n" + //
				"left outer join mst_person mp on mp.person_id=fom.person_id \r\n" + //
				"where\r\n" + //
				"fm.activate_flag = 1\r\n" + //
				"and bm.block_id = fm.block_id ";
		if(hm.get("blockId")!=null && !hm.get("blockId").equals("-1") && !hm.get("blockId").equals(""))
		{
			parameters.add(hm.get("blockId"));
			query +=" and bm.block_id=?";
		}
		if(hm.get("type")!=null && !hm.get("type").equals("-1") && !hm.get("type").equals("") )
		{
			parameters.add(hm.get("type"));
			query +=" and fm.type=?";
		}
		query+=" order by block_name,flat_name,type";
		return getListOfLinkedHashHashMap(parameters,query,con);
	}

	public List<LinkedHashMap<String, Object>> getFlatMasterFB(Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		
		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_block mb ,mst_flat mf \r\n" + //
						"where mb.block_id =mf.block_id ",

				con);
	}



	public LinkedHashMap<String, String> getFlatDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("flat_id"));

		return getMap(parameters,
				"select * from mst_flat where flat_id=?",
				con);
	}

	public long addFlat(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<>();
		valuesMap.put("flat_id", "~default");
		valuesMap.put("block_id", hm.get("drpblockname"));
		valuesMap.put("flat_name", hm.get("txtflatname"));
		valuesMap.put("type", hm.get("drptype"));
		valuesMap.put("updated_by", hm.get("user_id"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("activate_flag", "~1");
		Query q = new Query("mst_flat", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}

	public String updateFlat(HashMap<String, Object> hm, Connection con) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("drpblockname"));
		parameters.add(hm.get("txtflatname"));

		parameters.add(hm.get("drptype"));
		parameters.add(hm.get("user_id"));

		parameters.add(hm.get("hdnFlatId"));

		insertUpdateDuablDB(
				"UPDATE mst_flat SET block_id=?,flat_name=?,type=?,updated_date=SYSDATE(),updated_by=? WHERE flat_id=?",
				parameters, con);
		return "Flat updated Succesfully";

	}

	public String deleteFlat(long flatId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(userId);
		parameters.add(flatId);
		insertUpdateDuablDB("UPDATE mst_flat  SET activate_flag=0,updated_date=SYSDATE(),updated_by=? WHERE flat_id=?",
				parameters, conWithF);
		return "Flat Deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getBlocks(Connection con) throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		String query = "SELECT block_id blockId,block_name blockName FROM mst_block WHERE activate_Flag=1";
		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getShopMaster(Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		return getListOfLinkedHashHashMap(parameters,
				"SELECT * from mst_shop where activate_flag=1",
				con);
	}

	public LinkedHashMap<String, String> getShopDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("shop_id"));

		return getMap(parameters,
				"select * from mst_shop where shop_id=?",
				con);
	}

	public long addShop(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<>();
		valuesMap.put("shop_id", "~default");
		valuesMap.put("shop_name", hm.get("txtshopname"));
		valuesMap.put("updated_by", hm.get("user_id"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("activate_flag", "~1");
		Query q = new Query("mst_shop", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}

	public String updateShop(HashMap<String, Object> hm, Connection con) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("txtshopname"));
		parameters.add(hm.get("user_id"));
		parameters.add(hm.get("hdnShopId"));

		insertUpdateDuablDB("UPDATE mst_shop SET shop_name=?,updated_by=?,updated_date=SYSDATE() WHERE shop_id=?",
				parameters, con);
		return "Shop updated Succesfully";

	}

	public String deleteShop(long shopId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(userId);
		parameters.add(shopId);
		insertUpdateDuablDB("UPDATE mst_shop  SET activate_flag=0,updated_date=SYSDATE(),updated_by=? WHERE shop_id=?",
				parameters, conWithF);
		return "Shop Deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getPersonMaster(Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		return getListOfLinkedHashHashMap(parameters,
				"select * from mst_person where activate_flag=1" ,
				con);
	}


public LinkedHashMap<String, String> getPersonDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("person_id"));

		return getMap(parameters,
				"select * from mst_person where person_id=?",
				con);
	}

	public long addPerson(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<>();
		valuesMap.put("person_id", "~default");
		valuesMap.put("person_name", hm.get("txtpersonname"));

		valuesMap.put("person_mobile_no", hm.get("txtmobileno"));

		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("activate_flag", "~1");
		valuesMap.put("updated_by", hm.get("user_id"));
		Query q = new Query("mst_person", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}

	public String updatePerson(HashMap<String, Object> hm, Connection con) throws Exception {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(hm.get("txtpersonname"));

		parameters.add(hm.get("txtmobileno"));
		parameters.add(hm.get("user_id"));

		parameters.add(hm.get("hdnPersonId"));

		insertUpdateDuablDB(
				"UPDATE mst_person SET person_name=?,person_mobile_no=?,updated_date=SYSDATE(),updated_by=? WHERE person_id=?",
				parameters, con);
		return "Person updated Succesfully";

	}

public String deletePerson(long personId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(userId);
		parameters.add(personId);
		insertUpdateDuablDB("UPDATE mst_person  SET activate_flag=0,updated_date=SYSDATE(),updated_by=? WHERE person_id=?",
				parameters, conWithF);
		return "Person Deleted Succesfully";
	}

	public LinkedHashMap<String, String> getFlatOwnerDetails(HashMap<String, Object> hm, Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("flat-owner_id"));

		return getMap(parameters,
				"select * from flat_owner_mapping where flat_owner_id=?",
				con);
	}

	public List<LinkedHashMap<String, Object>> getFlatOwnerMapping(Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		return getListOfLinkedHashHashMap(parameters,
				"select *, date_format(purchase_date,'%d/%m/%Y') as purchaseDateFormatted from flat_owner_mapping fom, mst_flat mf, mst_person mp,mst_block mb  where mf.flat_id=fom.flat_id\r\n" + //
						"and fom.activate_flag =1 and mp.person_id = fom.person_id and mb.block_id=mf.block_id" ,
				con);
	}

	public List<LinkedHashMap<String, Object>> getFlats(Connection con) throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		String query = "select * from mst_flat mf , mst_block mb where mf.block_id=mb .block_id and mf.activate_flag =1";

		
		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getPersons(Connection con) throws ClassNotFoundException, SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		String query = "SELECT person_id personId,person_name personName, person_mobile_no personMobileNo FROM mst_person WHERE activate_Flag=1";
		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public long addFlatOwner(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<>();
		valuesMap.put("flat_owner_id", "~default");
		valuesMap.put("flat_id", hm.get("hdnselectedflat"));
		valuesMap.put("person_id", hm.get("hdnselectedperson"));
		valuesMap.put("purchase_date", getDateASYYYYMMDD(hm.get("txtpurchasedate").toString()) );
		valuesMap.put("updated_by", hm.get("user_id"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("activate_flag", "~1");
		Query q = new Query("flat_owner_mapping", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}

	public String deleteFlatOwner(long flatownerId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(userId);
		parameters.add(flatownerId);
		insertUpdateDuablDB("UPDATE flat_owner_mapping  SET activate_flag=0,updated_date=SYSDATE(),updated_by=? WHERE flat_owner_id=?",
				parameters, conWithF);
		return "Flat Owner Mapping Deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getCollectMaintenence(Connection con,String blockid,String flatName) throws ClassNotFoundException, SQLException {
	
		ArrayList<Object> parameters = new ArrayList<>();
		String query="select\r\n" + //
						"\t*,\r\n" + //
						"\tdate_format(collection_date, '%d/%m/%Y') as collectionDateFormatted,date_format(maintenence_from_date, '%d/%m/%Y') as maintenenceFromDateFormatted,date_format(maintenence_to_date, '%d/%m/%Y') as maintenenceToDateFormatted, \r\n" + //
						"\tmp.person_name  owner_name\r\n" + //
						"from\t\r\n" + //
						"\ttrn_maintenence_collection tmc\r\n" + //
						"\tleft outer join  mst_flat mf on tmc.unique_id=mf.flat_id \t\r\n" + //
						"\tleft outer join  mst_block mb on mf.block_id =mb.block_id \r\n" + //
						"\tleft outer join flat_owner_mapping fom on fom.flat_id=mf.flat_id  \r\n" + //
						"\tleft outer join mst_person mp on mp.person_id =fom.person_id \r\n" + //
						"\tleft outer join tbl_user_mst tum on tum.user_id =tmc.updated_by\r\n" + //
						"where\r\n" + //
						"\ttmc.activate_flag = 1 and fom.activate_flag =1 \r\n" + //
						"\tand tmc.updated_by = tum.user_id\r\n" ;
						
	if(blockid!=null && !blockid.equals("") && !blockid.equals("-1"))
		{
			parameters.add(blockid);
			query+=" and mf.block_id=?";
		}
	if(flatName!=null && !flatName.equals("") && !flatName.equals("-1"))
		{
			parameters.add(flatName);
			query+=" and mf.flat_name=?";
		}

		query+=" order by tmc.maintenence_from_date desc ";
		return getListOfLinkedHashHashMap(parameters,
				query,
				con);

	}

	public List<LinkedHashMap<String, Object>> getListOfTransferFees(Connection con,String blockid,String flatName) throws ClassNotFoundException, SQLException {
	
		ArrayList<Object> parameters = new ArrayList<>();
		String query="select\n" + 
		"tctf.transfer_id,tctf.receipt_no,mb.block_name ,\n" + 
		"mf.flat_name ,\n" + 
		"tctf.amount ,\n" + 
		"date_format(tctf.transfer_date, '%d/%m/%Y') as TransferDate ,\n" + 
		"date_format(tctf.payment_date, '%d/%m/%Y') as PaymentDate ,\n" + 		
		"tctf.payment_mode ,\n" + 
		"tctf .updated_by ,\n" + 
		"tctf.updated_date,person1.person_name FromOwner,person2.person_name ToOwner,tum.name updatedBy\n" + 
		"from\n" + 
		"trn_collect_transfer_fees tctf,\n" + 
		"mst_flat mf,\n" + 
		"mst_block mb,mst_person person1,mst_person person2,tbl_user_mst tum\n" + 
		"where\n" + 
		"mf.flat_id = tctf.unique_id\n" + 
		"and mb.block_id = mf.block_id and person1.person_id=from_owner and person2.person_id=to_owner and tum.user_id=tctf.updated_by and tctf.activate_flag=1 \n";
						
	if(blockid!=null && !blockid.equals("") && !blockid.equals("-1"))
		{
			parameters.add(blockid);
			query+=" and mf.block_id=?";
		}
	if(flatName!=null && !flatName.equals("") && !flatName.equals("-1"))
		{
			parameters.add(flatName);
			query+=" and mf.flat_name=?";
		}

		query+=" order by tctf.updated_date desc ";
		return getListOfLinkedHashHashMap(parameters,
				query,
				con);

	}


	public List<LinkedHashMap<String, Object>> getCollectMaintenenceByMobileNo(Connection con,String mobileNo) throws ClassNotFoundException, SQLException {
	
		ArrayList<Object> parameters = new ArrayList<>();
		String query="select\r\n" + //
						"\t*,\r\n" + //
						"\tdate_format(collection_date, '%d/%m/%Y') as collectionDateFormatted,date_format(maintenence_from_date, '%d/%m/%Y') as maintenenceFromDateFormatted,date_format(maintenence_to_date, '%d/%m/%Y') as maintenenceToDateFormatted, \r\n" + //
						"\tmp.person_name  owner_name\r\n" + //
						"from\t\r\n" + //
						"\ttrn_maintenence_collection tmc\r\n" + //
						"\tleft outer join  mst_flat mf on tmc.unique_id=mf.flat_id \t\r\n" + //
						"\tleft outer join  mst_block mb on mf.block_id =mb.block_id \r\n" + //
						"\tleft outer join flat_owner_mapping fom on fom.flat_id=mf.flat_id  \r\n" + //
						"\tleft outer join mst_person mp on mp.person_id =fom.person_id \r\n" + //
						"\tleft outer join tbl_user_mst tum on tum.user_id =tmc.updated_by\r\n" + //
						"where\r\n" + //
						"\ttmc.activate_flag = 1\r\n" + //
						"\tand tmc.updated_by = tum.user_id and fom.activate_flag=1 \r\n" ;
						
	
			parameters.add(mobileNo);
			query+=" and mp.person_mobile_no=?";
		

		query+=" order by tmc.updated_date desc ";
		return getListOfLinkedHashHashMap(parameters,
				query,
				con);

	}
public LinkedHashMap<String, String> getCollectionDetails(long collectionId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(collectionId);
		return getMap(parameters,
				"select * from trn_maintenence_collection where collection_id=?", con);

	}

	public long addMaintenence(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<>();
		valuesMap.put("collection_id", "~default");
		valuesMap.put("unique_id", hm.get("hdnselectedflat"));
		valuesMap.put("receipt_no", hm.get("receiptNo"));		
		valuesMap.put("amount", hm.get("txtamount"));
		valuesMap.put("collection_date", getDateASYYYYMMDD(hm.get("txtcollectiondate").toString()) );
		valuesMap.put("maintenence_from_date", getDateASYYYYMMDD(hm.get("txtfromdate").toString()) );
		valuesMap.put("maintenence_to_date", getDateASYYYYMMDD(hm.get("txttodate").toString()) );
		valuesMap.put("payment_mode", hm.get("paymentmode"));
		valuesMap.put("reference_no", hm.get("referenceno"));
		valuesMap.put("type", hm.get("drppropertytype"));
		valuesMap.put("owner_flag", hm.get("ownerType"));		
		
		
		valuesMap.put("updated_by", hm.get("user_id"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("activate_flag", "~1");
		Query q = new Query("trn_maintenence_collection", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}

	public String deleteMaintenence(long collectionId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(userId);
		parameters.add(collectionId);
		insertUpdateDuablDB("UPDATE trn_maintenence_collection  SET activate_flag=0,updated_date=SYSDATE(),updated_by=? WHERE collection_id=?",
				parameters, conWithF);
		return "Maintenence Deleted Succesfully";
	}

	public String deleteTransfer(long collectionId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(userId);
		parameters.add(collectionId);
		insertUpdateDuablDB("UPDATE trn_collect_transfer_fees  SET activate_flag=0,updated_date=SYSDATE(),updated_by=? WHERE transfer_id=?",
				parameters, conWithF);
		return "Transfer Deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getFlatTenantMapping(Connection con) throws ClassNotFoundException, SQLException {
	
		ArrayList<Object> parameters = new ArrayList<>();
		
		return getListOfLinkedHashHashMap(parameters,
				"select *,date_format(rented_date,'%d/%m/%Y') as rentedDateFormatted,date_format(vacated_date,'%d/%m/%Y') as vacatedFormattedDate from flat_tenant_mapping ftm  , mst_flat mf, mst_person mp where mf.flat_id=ftm.flat_id and ftm.activate_flag =1 and mp.person_id=ftm.person_id ",
				con);

	}

public LinkedHashMap<String, String> getFlatTenantDetails(long flattenantId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(flattenantId);
		return getMap(parameters,
				"select * from flat_tenant_mapping where flat_tenant_id=?", con);

	}
public long addFlatTenant(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<>();
		valuesMap.put("flat_tenant_id", "~default");
		valuesMap.put("flat_id", hm.get("hdnselectedflat"));
		valuesMap.put("person_id", hm.get("hdnselectedperson"));
		valuesMap.put("rented_date", getDateASYYYYMMDD(hm.get("txtrenteddate").toString()) );
		valuesMap.put("vacated_date", getDateASYYYYMMDD(hm.get("txtvacateddate").toString()));
		valuesMap.put("updated_by", hm.get("user_id"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("activate_flag", "~1");
		Query q = new Query("flat_tenant_mapping", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}
	public String deleteFlatTenant(long flattenantId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(userId);
		parameters.add(flattenantId);
		insertUpdateDuablDB("UPDATE flat_tenant_mapping  SET activate_flag=0,updated_date=SYSDATE(),updated_by=? WHERE flat_tenant_id=?",
				parameters, conWithF);
		return "Flat Tenant Deleted Succesfully";
	}

public List<LinkedHashMap<String, Object>> getGuestVehicleEntry(Connection con) throws ClassNotFoundException, SQLException {
	
		ArrayList<Object> parameters = new ArrayList<>();
		
		return getListOfLinkedHashHashMap(parameters,
				"select *,date_format(in_time,'%d/%m/%Y %H:%i') as FormattedIntime from guest_vehicle_entry gve  , mst_flat mf where mf.flat_id=gve.flat_id and gve.activate_flag =1  ",
				con);

	}

	public LinkedHashMap<String, String> getGuestVehicleDetails(long flattenantId, Connection con) throws SQLException {

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(flattenantId);
		return getMap(parameters,
				"select * from guest_vehicle_entry where guest_vehiclet_id=?", con);

	}
public long addGuestVehicle(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<>();
		valuesMap.put("guest_vehicle_id", "~default");
		valuesMap.put("flat_id", hm.get("hdnselectedflat"));
		valuesMap.put("guest_name", hm.get("txtguestname"));
		valuesMap.put("guest_mobile_no", hm.get("txtmobileno"));
		valuesMap.put("guest_vehicle_name", hm.get("txtguestvehiclename"));
		valuesMap.put("guest_vehicle_no", hm.get("txtvehicleno"));
		valuesMap.put("in_time", "~sysdate()");
		valuesMap.put("remark", hm.get("txtremark"));
		valuesMap.put("updated_by", hm.get("user_id"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("activate_flag", "~1");
		Query q = new Query("guest_vehicle_entry", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}
	

	public String deleteGuestVehicle(long guestvehicleId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(userId);
		parameters.add(guestvehicleId);
		insertUpdateDuablDB("UPDATE guest_vehicle_entry  SET activate_flag=0,updated_date=SYSDATE(),updated_by=? WHERE guest_vehicle_id=?",
				parameters, conWithF);
		return "Guest Vehile Deleted Succesfully";
	}

	public String getReceiptNo(Connection con,boolean updateflag) throws Exception
		 {	
			 String seqName="AKIBAH-Rec-No"+"-"+getCurrentYear(con);
				  long uniqueNo=getSequenceNumberWithoutAppid(con,updateflag,seqName);
				  int uniqueNoInt=(int) uniqueNo;
				  seqName+="-"+String.format("%03d",uniqueNoInt);
				  return seqName;
		 }

	
		 public LinkedHashMap<String,String> getTransferReceiptDetails(String receiptNo,Connection con)
				throws SQLException, ClassNotFoundException {

			String query = "select\n" + 
			"*,\n" + 
			"date_format(tmc.transfer_date, '%d/%m/%Y') as transferDate,\n" + 
			"date_format(tmc.payment_date , '%d/%m/%Y') as paymentDate,mp.person_name fromOwner,mp1.person_name toOwner\n" + 
			"from\n" + 
			"trn_collect_transfer_fees tmc\n" + 
			"left outer join mst_flat mf on mf.flat_id =tmc.unique_id\n" + 
			"left outer join mst_block mb on mb.block_id =mf.block_id\n" + 
			"left outer join mst_person mp on mp.person_id =tmc.from_owner\n" + 
			"left outer join mst_person mp1 on mp1.person_id =tmc.to_owner\n" + 
			"left outer join tbl_user_mst tum on tum.user_id =tmc.updated_by\n" + 
			"where\n" + 
			"receipt_no = ? \n" + 
			"and tmc.unique_id= mf.flat_id\n" + 
			"and mb.block_id = mf.block_id\n" + 
			"and tum.user_id = tmc.updated_by \n";;
			ArrayList<Object> parameters = new ArrayList<>();
			parameters.add(receiptNo);
			return getMap(parameters, query, con);
		}
	

	public LinkedHashMap<String,String> getReceiptDetails(String receiptNo,Connection con)
				throws SQLException, ClassNotFoundException {

			String query = "select\r\n" + //
					"\t*,\r\n" + //
					"\tdate_format(collection_date, '%d/%m/%Y') as formattedCollectionDate,\r\n" + //
					"\tdate_format(maintenence_from_date, '%d/%m/%Y') as maintenenceFromDateFormatted,\r\n" + //
					"\tdate_format(maintenence_to_date, '%d/%m/%Y') as maintenenceToDateFormatted,\r\n" + //
					"\tmp.person_name owner_name\r\n" + //
					"from\r\n" + //
					"\ttrn_maintenence_collection tmc\r\n" + //
					"\tleft outer join mst_flat mf on mf.flat_id =tmc.unique_id \r\n" + //
					"\tleft outer join mst_block mb on mb.block_id =mf.block_id \r\n" + //
					"\tleft outer join flat_owner_mapping fom on fom.flat_id =mf.flat_id \r\n" + //
					"\tleft outer join mst_person mp on mp.person_id =fom.person_id \r\n" + //
					"\tleft outer join tbl_user_mst tum on tum.user_id =tmc.updated_by \r\n" + //
					"where\r\n" + //
					"\treceipt_no = ? \r\n" + //
					"\tand tmc.unique_id = mf.flat_id\r\n" + //
					"\tand mb.block_id = mf.block_id\r\n" + //
					"\tand tum.user_id = tmc.updated_by and fom.activate_flag=1";
			ArrayList<Object> parameters = new ArrayList<>();
			parameters.add(receiptNo);
			return getMap(parameters, query, con);
		}

		public HashMap<String, String> getDataForHomepage(HashMap<String, Object> hm,Connection conWithF) throws SQLException {
		
		
			String query="select \r\n"
					+ " (select count(1) from mst_shop ms where activate_flag =1) as totalShops,\r\n"
					+ " (select count(1) from flat_owner_mapping fom where activate_flag =1) as totalOwners,\r\n"
					+ " (select count(1) from mst_vehicle mv where activate_flag =1) as totalVehicles, \r\n"
					+ " (select count(1) from flat_tenant_mapping ftm where activate_flag =1) as totalTenants, \r\n"
					+ " (select count(1) from mst_flat mf where activate_flag =1) as totalFlats \r\n"
					+ " from dual";			
			ArrayList<Object> parameters=new ArrayList<>();			
			return getMap(parameters,query,conWithF);
			
			
		}


        public String getOwnerTypeForShop(String shopId, Connection con) throws SQLException {
			ArrayList<Object> parameters=new ArrayList<>();
			getMap(parameters, "select shop_owner_mapping", con);
			return "Owner";
        }

        public String getOwnerTypeForFlat(String flatId, String month,String Year,Connection con) throws SQLException {
			ArrayList<Object> parameters=new ArrayList<>();			
			String maintenenceMonth=Year+"-"+month+"-01";
			parameters.add(flatId);
			parameters.add(maintenenceMonth);
			getMap(parameters, "select * from flat_tenant_mapping where flat_id=? and ? between rented_date and vacated_date  ", con);
			return "Owner";
        }

        public String getRentAmountForthisFlat(String propertyType, String subType, String month, String year,
                String duration,Connection con) throws SQLException {
					ArrayList<Object> parameters=new ArrayList<>();			
			String maintenenceMonth=year+"-"+month+"-01";			
			
			parameters.add(propertyType);
			parameters.add(subType);			
			parameters.add(duration);
			parameters.add(maintenenceMonth);
			LinkedHashMap<String, String> returnMap= getMap(parameters, "select * from config_maintenence cm where property_type =? and sub_type =? \r\n" + //
					"and duration =? and ? between effective_from_date and effective_to_date ", con);
			return returnMap.get("amount");            
        }

	public List<LinkedHashMap<String, Object>> getMaintenenceSummary(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("app_id"));
		parameters.add(getDateASYYYYMMDD(hm.get("txtfromdate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("txttodate").toString()));

		return getListOfLinkedHashHashMap(parameters,
				"select totalizer_opening_reading,totalizer_closing_reading,nozzle_name,item_name,shift_name,attendantName,check_in_time,check_out_time,opening_reading,closing_reading,testFuel,"
						+ "updated_by_supervisor,FormattedUpdatedDate"
						+ ",closing_reading-opening_reading-COALESCE(TestFuel,0) diffReading,rate,round((closing_reading-opening_reading-COALESCE(TestFuel,0))*rate,2) totalAmount from ( select\r\n"
						+ "	totalizer_opening_reading,totalizer_closing_reading,nozzle_name,item_name,shift_name,check_in_time,check_out_time,opening_reading,closing_reading,\r\n"
						+ "	date_format(tnr.updated_date, '%d/%m/%Y %H:%i:%s') as FormattedUpdatedDate,rate,\r\n"
						+ "	tum.name attendantName,\r\n"
						+ "	tum2.name updated_by_supervisor,\r\n"
						+ "	(select sum(test_quantity) from trn_test_fuel_register ttfr\r\n"
						+ "where test_date =accounting_date and user_id=tnr.attendant_id and ttfr.activate_flag=1 and shift_id =tnr.shift_id and ttfr.nozzle_id=tnr.nozzle_id)\r\n"
						+ "as testFuel \r\n"
						+ "from\r\n"
						+ "	trn_nozzle_register tnr,\r\n"
						+ "	nozzle_master nm,\r\n"
						+ "	tbl_user_mst tum,\r\n"
						+ "	mst_items item,\r\n"
						+ "	tbl_user_mst tum2,\r\n"
						+ "	shift_master shift\r\n"
						+ "where\r\n"
						+ "	tnr.app_id = ? \r\n"
						+ "	and nm.nozzle_id = tnr.nozzle_id\r\n"
						+ "	and tum.user_id = tnr.attendant_id\r\n"
						+ "	and tum2.user_id = tnr.updated_by\r\n"
						+ "	and shift.shift_id = tnr.shift_id\r\n"
						+ "	and accounting_date between ? and ? \r\n"
						+ "	and item.item_id = tnr.item_id\r\n"
						+ "order by\r\n"
						+ "	nozzle_name ) as T",
				con);
	}

	
	public List<LinkedHashMap<String, Object>> getFlatExceptionMaster(Connection con)
			throws SQLException, ClassNotFoundException {
		ArrayList<Object> parameters = new ArrayList<>();
		return getListOfLinkedHashHashMap(parameters,
				"select *,date_format(from_date, '%d/%m/%Y') as fromDateFormatted, date_format(to_date, '%d/%m/%Y') as toDateFormatted from flat_exception_master fem, mst_flat mf, mst_block mb where mf.flat_id=fem.flat_id   \r\n" + //
						" and fem.activate_flag =1 and mb.block_id=mf.block_id " ,
				con);
	}	
		
	public LinkedHashMap<String, String> getFlatExceptionDetails(long exceptionId,Connection con)
			throws SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add("exceptionId");


		return getMap(parameters,
				"select * from flat_exception_master where exception_id=?",
				con);
	}
 public long addFlatException(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

		HashMap<String, Object> valuesMap = new HashMap<>();
		valuesMap.put("exception_id", "~default");
		valuesMap.put("flat_id", hm.get("hdnselectedflat"));
		valuesMap.put("from_date", getDateASYYYYMMDD(hm.get("txtfromdate").toString()) );
		valuesMap.put("to_date", getDateASYYYYMMDD(hm.get("txttodate").toString()) );
		valuesMap.put("remarks", hm.get("txtremarks"));
		valuesMap.put("updated_by", hm.get("user_id"));
		valuesMap.put("updated_date", "~sysdate()");
		valuesMap.put("activate_flag", "~1");
		Query q = new Query("flat_exception_master", "insert", valuesMap);
		return insertUpdateEnhanced(q, conWithF);

	}
	public String deleteFlatException(long exceptionId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(userId);
		parameters.add(exceptionId);
		insertUpdateDuablDB("UPDATE flat_exception_master  SET activate_flag=0,updated_date=SYSDATE(),updated_by=? WHERE exception_id=?",
				parameters, conWithF);
		return "Flat Exception Deleted Succesfully";
	}

	public List<LinkedHashMap<String, Object>> getMaintenenceMonthlyReport(HashMap<String, Object> hm, Connection con)
			throws ClassNotFoundException, SQLException, ParseException {

		ArrayList<Object> parameters = new ArrayList<>();

		parameters.add(getDateASYYYYMMDD(hm.get("fromDate").toString()));
		parameters.add(getDateASYYYYMMDD(hm.get("toDate").toString()));
		
			String query="select\n" + 
			"date_format(maintenence_from_date,'%d/%m/%Y') as MaintenanceFromDate ,\n" + 
			"date_format(maintenence_to_date,'%d/%m/%Y') as MaintenanceToDate ,\n" + 
			"collection_date ,\n" + 
			"flat_name,\n" + 
			"block_name,\n" + 
			"amount,\n" + 
			"payment_mode ,\n" + 
			"owner_flag,\n" + 
			"tum.name updatedBy,convert(mf.flat_name, SIGNED) flatnameint,receipt_no,'Flat' type,reference_no\n" + 
			"from\n" + 
			"trn_maintenence_collection tmc ,\n" + 
			"mst_flat mf ,\n" + 
			"mst_block mb ,\n" + 
			"tbl_user_mst tum\n" + 
			"where\n" + 
			"collection_date between ? and ? \n" + 
			"and mf.flat_id = tmc.unique_id\n" + 
			"and mb.block_id = mf.block_id\n" + 
			"and tum.user_id = tmc.updated_by and tmc.activate_flag=1 blockidcondition \n" ;
				
		
		if(hm.get("blockId")!=null && !hm.get("blockId").equals("-1") && !hm.get("blockId").equals(""))
		{
			parameters.add(hm.get("blockId"));
			query=query.replaceAll("blockidcondition", " and mb.block_id=?");
		}
		else
		{
			query=query.replaceAll("blockidcondition", "");
		}
		query+=" order by block_name,flatnameint";
		

		return getListOfLinkedHashHashMap(parameters, query, con);

	}

	public List<LinkedHashMap<String, Object>> getDistributionRegister(String fromDate,String toDate,Connection con)
						throws SQLException, ClassNotFoundException, ParseException {
					ArrayList<Object> parameters = new ArrayList<>();
					parameters.add((getDateASYYYYMMDD(fromDate)));
					parameters.add((getDateASYYYYMMDD(toDate)));
					return getListOfLinkedHashHashMap(parameters,
					"select\n" + 
					"*,\n" + 
					"date_format (collection_date ,\n" + 
					"'%d/%m/%Y') collection_date_formatted\n" + 
					", tum.name updatedByUser from\n" + 
					"trn_distribution_register tdr,\n" + 
					"mst_vehicle mv,\n" + 
					"mst_flat mf ,\n" + 
					"mst_block mb,\n" + 
					"tbl_user_mst tum\n" + 
					"where\n" + 
					"date(collection_date) between ? and ?\n" + 
					"and tdr.activate_flag = 1 and\n" + 
					"mv.vehicle_id =tdr.vehicle_id  and\n" + 
					"mv.flat_id =mf.flat_id and\n" + 
					"mf.block_id =mb.block_id and tum.user_id=tdr.updated_by\n",							
							con); 
				}
	public String addDistribution(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

					HashMap<String, Object> valuesMap = new HashMap<>();
					valuesMap.put("distribution_id", "~default");
					valuesMap.put("vehicle_id", hm.get("vehicle_id"));
					valuesMap.put("collected_by", hm.get("collectedBy"));
					valuesMap.put("collection_date","~sysdate()");

					valuesMap.put("updated_by", hm.get("userId"));
					valuesMap.put("activate_flag", "~1");
					Query q = new Query("trn_distribution_register", "insert", valuesMap);
					 insertUpdateEnhanced(q, conWithF);
					 return "Distribution Added Successfully";
			
				}
			
				public List<LinkedHashMap<String, Object>> getMaintenanceDefaulters(HashMap<String, Object> hm, Connection con) throws ParseException, ClassNotFoundException, SQLException 
				{

					ArrayList<Object> parameters = new ArrayList<>();
		String query="SELECT\n" + 
"ownerName,\n" + 
"CONCAT(BlockName, CAST(FlatNo AS SIGNED), ' (', COUNT(mtname), ') ') AS BlockName,\n" + 
"CAST(FlatNo AS SIGNED) FlatNo,\n" + 
"CONCAT(BlockName, FlatNo) uniqueFlatName,\n" + 
"yrname,\n" + 
"GROUP_CONCAT(CONCAT(mtname, '-', yrname) ORDER BY yrname, mtnumber) AS PendingMonths,\n" + 
"COUNT(mtname) noofPendingMonths,\n" + 
"mtnumber,\n" + 
"originalBlockName\n" + 
"FROM (\n" + 
"SELECT\n" + 
"mp.person_name ownerName,\n" + 
"block_name BlockName,\n" + 
"block_name originalBlockName,\n" + 
"CAST(flat_name AS SIGNED) FlatNo,\n" + 
"YEAR(month) yrname,\n" + 
"MONTHNAME(month) mtname,\n" + 
"MONTH(month) mtnumber\n" + 
"FROM (\n" + 
"SELECT\n" + 
"mb.block_name,\n" + 
"mf.flat_name,\n" + 
"mf.flat_id,\n" + 
"DATE_FORMAT(date_range, '%Y-%m-%d') AS month\n" + 
"FROM (\n" + 
"SELECT\n" + 
"DATE_ADD('2023-08-01', INTERVAL m MONTH) AS date_range\n" + 
"FROM (\n" + 
"SELECT @row := @row + 1 AS m\n" + 
"FROM (\n" + 
"SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL\n" + 
"SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL\n" + 
"SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11\n" + 
") t1,\n" + 
"(\n" + 
"SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL\n" + 
"SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL\n" + 
"SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11\n" + 
") t2,\n" + 
"(SELECT @row := -1) r\n" + 
") months\n" + 
") AS date_series,\n" + 
"mst_flat mf,\n" + 
"mst_block mb\n" + 
"WHERE\n" + 
"date_range <= CURDATE()\n" + 
"AND mf.activate_flag = 1\n" + 
"AND mf.block_id = mb.block_id\n" + 
"ORDER BY\n" + 
"mb.block_name,\n" + 
"mf.flat_name,\n" + 
"month\n" + 
") AS T\n" + 
"LEFT OUTER JOIN trn_maintenence_collection tmc\n" + 
"ON tmc.unique_id = T.flat_id\n" + 
"AND month BETWEEN tmc.maintenence_from_date AND tmc.maintenence_to_date\n" + 
"AND tmc.activate_flag = 1\n" + 
"LEFT OUTER JOIN flat_owner_mapping fom\n" + 
"ON fom.flat_id = T.flat_id\n" + 
"LEFT OUTER JOIN mst_person mp\n" + 
"ON mp.person_id = fom.person_id\n" + 
"WHERE\n" + 
"receipt_no IS NULL\n" + 
"AND fom.activate_flag = 1\n" + 
"ORDER BY\n" + 
"block_name,\n" + 
"FlatNo,\n" + 
"yrname,\n" + 
"mtnumber\n" + 
") AS T\n" + 
"GROUP BY uniqueFlatName;\n";		
		
		
		return getListOfLinkedHashHashMap(parameters, query, con);		
                    
                }

	public long addTransferFees(HashMap<String, Object> hm, Connection conWithF) throws Exception, ParseException {

					HashMap<String, Object> valuesMap = new HashMap<>();
					valuesMap.put("transfer_id", "~default");
					valuesMap.put("unique_id", hm.get("hdnselectedflat"));
					valuesMap.put("receipt_no", hm.get("receiptNo"));
					valuesMap.put("from_owner", hm.get("hdnselectedfromperson"));		
					valuesMap.put("to_owner", hm.get("hdnselectedtoperson"));
					valuesMap.put("transfer_date", getDateASYYYYMMDD(hm.get("txttransferdate").toString()) );
					valuesMap.put("payment_date", getDateASYYYYMMDD(hm.get("txtpaymentdate").toString()) );
					valuesMap.put("payment_mode", hm.get("paymentmode"));
					valuesMap.put("type", hm.get("drppropertytype"));	
					valuesMap.put("amount", hm.get("txtamount"));	

					
					
					valuesMap.put("updated_by", hm.get("user_id"));
					valuesMap.put("updated_date", "~sysdate()");
					valuesMap.put("activate_flag", "~1");
					valuesMap.put("reference_no", hm.get("txtreferenceno"));	
					valuesMap.put("remarks", hm.get("txtremarks"));	
					Query q = new Query("trn_collect_transfer_fees", "insert", valuesMap);
					return insertUpdateEnhanced(q, conWithF);
			
				}

    /**
 * Returns date‑wise totals per payment_mode for bank reconciliation.
 * ------------------------------------------------------------------
 * Expected keys in hm: "fromDate", "toDate"
 * Dates are dd/MM/yyyy (e.g. 01/07/2025)
 */
public List<LinkedHashMap<String, Object>> getBankReconciliationData(HashMap<String, Object> hm,
                                                                     Connection con)
        throws SQLException, ClassNotFoundException {

    String fromDate = (String) hm.get("fromDate");
    String toDate = (String) hm.get("toDate");
    String paymentMode = (String) hm.get("paymentMode");

    ArrayList<Object> parameters = new ArrayList<>();

    StringBuilder sql = new StringBuilder()
        .append("SELECT  DATE(collection_date)                         AS txn_date, ")
        .append("        payment_mode, ")
        .append("        SUM(CAST(amount AS DECIMAL(12,2)))            AS total_amount,group_concat(tum.username) updatedbys, ")
        .append("        GROUP_CONCAT(receipt_no ORDER BY receipt_no SEPARATOR ', ')   AS receipt_nos, ")
		.append("        GROUP_CONCAT(tum.username ORDER BY receipt_no SEPARATOR ', ')   AS receipt_nos, ")
        .append("        GROUP_CONCAT(reference_no ORDER BY reference_no SEPARATOR ', ') AS reference_nos, group_concat( concat(mb.block_name,'-',mf.flat_name)) flatnames ")
        .append("FROM    trn_maintenence_collection tmc,tbl_user_mst tum,mst_flat mf ,mst_block mb")
        .append(" WHERE   tmc.activate_flag = 1 and tum.user_id=tmc.updated_by and mf.flat_id=tmc.unique_id and mb.block_id=mf.block_id")
        .append("  AND   collection_date BETWEEN STR_TO_DATE(?, '%d/%m/%Y') ")
        .append("                          AND STR_TO_DATE(?, '%d/%m/%Y') ");

    parameters.add(fromDate);
    parameters.add(toDate);

    if (paymentMode != null && !paymentMode.trim().isEmpty() && !paymentMode.trim().equals("-1")) {
        sql.append("  AND payment_mode = ? ");
        parameters.add(paymentMode);
    }

    sql.append("GROUP BY DATE(collection_date), payment_mode ")
       .append("ORDER BY DATE(collection_date) DESC, payment_mode");

    return getListOfLinkedHashHashMap(parameters, sql.toString(), con);
}

public String getMOMNo(Connection con,boolean updateflag,String appId) throws Exception
	{	
		String seqName="MOM-"+getCurrentMonth(con)+"-"+getCurrentYear(con);
			 long uniqueNo=getSequenceNumber(con,updateflag,seqName,appId);
			 int uniqueNoInt=(int) uniqueNo;
			 seqName+="-"+String.format("%03d",uniqueNoInt);
			 return seqName;
}


public long addMomRegister(HashMap<String, Object> hm, Connection con) throws ClassNotFoundException, SQLException, ParseException {
    ArrayList<Object> parameters = new ArrayList<>();

    parameters.add(hm.get("mom_no"));
    parameters.add(getDateASYYYYMMDD(hm.get("momDate").toString()));
    parameters.add(hm.get("conclusion"));
    parameters.add(hm.get("user_id")); // for updated_by

    StringBuilder query = new StringBuilder();
    query.append("INSERT INTO trn_mom_register ");
    query.append("(mom_no, mom_date, mom_conclusion, updated_by) ");
    query.append("VALUES (?, ?, ?, ?)");

    return insertUpdateDuablDB(query.toString(), parameters, con);
}
	public long addMomAttendee(HashMap<String, Object> hm, Connection con) throws ClassNotFoundException, SQLException {

	ArrayList<Object> parameters = new ArrayList<>();
	parameters.add(hm.get("mom_id"));
	parameters.add(hm.get("employee_id"));
	parameters.add(hm.get("user_id"));

	String query = "INSERT INTO trn_mom_attendees (mom_id, employee_id, created_by, created_ts) VALUES (?, ?, ?, sysdate())";

	return insertUpdateDuablDB(query, parameters, con);
}

	public long addMomAgenda(HashMap<String, Object> hm, Connection con) throws ClassNotFoundException, SQLException {

	ArrayList<Object> parameters = new ArrayList<>();	
	parameters.add(hm.get("agenda_name"));	
	parameters.add(hm.get("mom_id"));
	parameters.add(hm.get("user_id"));

	String query = "INSERT INTO trn_agenda_register (agenda_name,mom_id, created_by, created_dt) VALUES (?, ?, ?, sysdate())";

	return insertUpdateDuablDB(query, parameters, con);
}

public long addRltMom(HashMap<String, Object> hm, Connection con) throws ClassNotFoundException, SQLException {

	ArrayList<Object> parameters = new ArrayList<>();
	parameters.add(hm.get("mom_id"));
	parameters.add(hm.get("content"));
	parameters.add(hm.get("user_id"));

	String query = "INSERT INTO rlt_mom (mom_id, content, created_by, created_ts) VALUES (?, ?, ?, sysdate())";

	return insertUpdateDuablDB(query, parameters, con);
}

public long addMomAnnouncement(HashMap<String, Object> hm, Connection con) throws ClassNotFoundException, SQLException {

	ArrayList<Object> parameters = new ArrayList<>();
	parameters.add(hm.get("agenda_id"));
	parameters.add(hm.get("announcement"));
	parameters.add(hm.get("user_id"));

	String query = "INSERT INTO trn_agenda_announcements (agenda_id, announcement, created_by, created_ts) VALUES (?, ?, ?, sysdate())";

	return insertUpdateDuablDB(query, parameters, con);
}

	public long addMomActionItem(HashMap<String, Object> hm, Connection con) throws ClassNotFoundException, SQLException {

	ArrayList<Object> parameters = new ArrayList<>();
	parameters.add(hm.get("mom_id"));
	parameters.add(hm.get("action_description"));
	parameters.add(hm.get("user_id"));

	String query = "INSERT INTO rlt_action_items (mom_id, action_description, created_by, created_ts) VALUES (?, ?, ?, sysdate())";

	return insertUpdateDuablDB(query, parameters, con);
}

public long addMomTask(HashMap<String, Object> hm, Connection con) throws ClassNotFoundException, SQLException {

	ArrayList<Object> parameters = new ArrayList<>();
	parameters.add(hm.get("mom_id"));
	parameters.add(hm.get("task_manager_id"));
	parameters.add(hm.get("remarks"));
	parameters.add(hm.get("user_id"));

	String query = "INSERT INTO rlt_tasks (mom_id, task_manager_id, remarks, created_by, created_ts) VALUES (?, ?, ?, ?, sysdate())";

	return insertUpdateDuablDB(query, parameters, con);
}

public long addMomApproval(HashMap<String, Object> hm, Connection con) throws ClassNotFoundException, SQLException {

	ArrayList<Object> parameters = new ArrayList<>();
	parameters.add(hm.get("mom_id"));
	parameters.add(hm.get("approval_description"));
	parameters.add(hm.get("user_id"));

	String query = "INSERT INTO rlt_approvals (mom_id, approval_description, created_by, created_ts) VALUES (?, ?, ?, sysdate())";

	return insertUpdateDuablDB(query, parameters, con);
}

public long addMomDiscussion(Connection con, HashMap<String, Object> inputMap) throws Exception {
    ArrayList<Object> parameters = new ArrayList<>();
    StringBuilder query = new StringBuilder();

    query.append("INSERT INTO trn_mom_discussions (");
    query.append("agenda_id, discussion_text, updated_by, updated_date");
    query.append(") VALUES (?, ?, ?, NOW())");

    parameters.add(inputMap.get("agenda_id"));
    parameters.add(inputMap.get("discussion_text"));
    parameters.add(inputMap.get("user_id"));

    return insertUpdateDuablDB(query.toString(), parameters, con);
}

public long linkMomAgendaTask(Connection con, HashMap<String, Object> inputMap) throws Exception {
    ArrayList<Object> parameters = new ArrayList<>();
    StringBuilder query = new StringBuilder();

    query.append("INSERT INTO rlt_mom_agenda_task (");
    query.append("mom_agenda_id, task_id, updated_by, updated_date");
    query.append(") VALUES (?, ?, ?, NOW())");

    parameters.add(inputMap.get("mom_agenda_id"));
    parameters.add(inputMap.get("task_id"));
    parameters.add(inputMap.get("user_id"));

    return insertUpdateDuablDB(query.toString(), parameters, con);
}
public long linkAgendaWithTask(Connection con, HashMap<String, Object> inputMap) throws Exception {
    ArrayList<Object> parameters = new ArrayList<>();
    StringBuilder query = new StringBuilder();

    query.append("INSERT INTO rlt_agenda_task (");
    query.append("agenda_id, task_id, updated_by, updated_date, activate_flag");
    query.append(") VALUES (?, ?, ?, NOW(), 1)");

    parameters.add(inputMap.get("agenda_id"));
    parameters.add(inputMap.get("task_id"));
    parameters.add(inputMap.get("user_id"));

    return insertUpdateDuablDB(query.toString(), parameters, con);
}

public LinkedHashMap<String, Object> getMOMHeaderDetails(Connection con, HashMap<String, Object> inputMap) throws Exception {
    ArrayList<Object> parameters = new ArrayList<>();
    StringBuilder query = new StringBuilder();

    query.append("SELECT ");
    query.append("  mom.mom_id, mom.mom_no, mom.mom_date, mom.mom_conclusion, ");
    query.append("  emp.name AS prepared_by ");
    query.append("FROM trn_mom_register mom ");
    query.append("LEFT JOIN tbl_user_mst emp ON emp.user_id = mom.updated_by ");
    query.append("WHERE mom.activate_flag = 1 ");

    if (inputMap.get("momNo") != null && !inputMap.get("momNo").toString().isEmpty()) {
        query.append("AND mom.mom_no = ? ");
        parameters.add(inputMap.get("momNo"));
    }

    return getMapReturnObject(parameters,query.toString(), con);
}


public List<LinkedHashMap<String, Object>> getAgendaListForMOM(Connection con, HashMap<String, Object> inputMap) throws Exception {
    ArrayList<Object> parameters = new ArrayList<>();
    StringBuilder query = new StringBuilder();

    query.append("SELECT ");
    query.append("  agenda.agenda_id, ");
    query.append("  agenda.agenda_name ");    
    query.append("FROM trn_agenda_register agenda ");    
    query.append("WHERE agenda.activate_flag = 1 ");

    if (inputMap.get("mom_id") != null && !inputMap.get("mom_id").toString().isEmpty()) {
        query.append("AND agenda.mom_id = ? ");
        parameters.add(inputMap.get("mom_id"));
    }

    return getListOfLinkedHashHashMap(parameters, query.toString(), con);
}

public List<LinkedHashMap<String, Object>> getDiscussionsForAgenda(Connection con, HashMap<String, Object> inputMap) throws Exception {
    ArrayList<Object> parameters = new ArrayList<>();
    StringBuilder query = new StringBuilder();

    query.append("SELECT ");
    query.append("  discussion_id, discussion_text ");
    query.append("FROM trn_mom_discussions ");
    query.append("WHERE activate_flag = 1 ");

    if (inputMap.get("agenda_id") != null && !inputMap.get("agenda_id").toString().isEmpty()) {
        query.append("AND agenda_id = ? ");
        parameters.add(inputMap.get("agenda_id"));
    }

    return getListOfLinkedHashHashMap(parameters, query.toString(), con);
}

public List<LinkedHashMap<String, Object>> getAnnouncementsForAgenda(Connection con, HashMap<String, Object> inputMap) throws Exception {
    ArrayList<Object> parameters = new ArrayList<>();
    StringBuilder query = new StringBuilder();

    query.append("SELECT ");
    query.append("  announcement_id, announcement ");
    query.append("FROM trn_agenda_announcements ");

    
        query.append("where agenda_id = ? ");
        parameters.add(inputMap.get("agenda_id"));
    

    return getListOfLinkedHashHashMap(parameters, query.toString(), con);
}
public List<LinkedHashMap<String, Object>> getTasksForAgenda(Connection con, HashMap<String, Object> inputMap) throws Exception {
    ArrayList<Object> parameters = new ArrayList<>();
    StringBuilder query = new StringBuilder();

    query.append("SELECT ");
    query.append("  t.task_id, t.task_name, t.task_type, date(t.task_date) task_date, date(t.target_date) target_date, t.priority, ");
    query.append("  user.name AS assigned_to ");
    query.append("FROM rlt_agenda_task rlt ");
    query.append("JOIN tbl_task_manager t ON t.task_id = rlt.task_id AND t.activate_flag = 1 ");
    query.append("LEFT JOIN tbl_user_mst user ON user.user_id = t.assigned_to ");
    query.append("WHERE rlt.activate_flag = 1 ");

    if (inputMap.get("agenda_id") != null && !inputMap.get("agenda_id").toString().isEmpty()) {
        query.append("AND rlt.agenda_id = ? ");
        parameters.add(inputMap.get("agenda_id"));
    }

    return getListOfLinkedHashHashMap(parameters, query.toString(), con);
}

public List<String> getRecurringTaskDates(HashMap<String, Object> inputMap, Connection con) throws SQLException, ParseException, ClassNotFoundException {
    ArrayList<Object> parameters = new ArrayList<>();
    List<String> result = new ArrayList<>();

    String recurrenceType = inputMap.get("drptasktype").toString(); // Daily, Weekly, Monthly, Quarterly

    String query = 
        "WITH RECURSIVE date_range AS ( " +
        "  SELECT DATE(?) AS dt " +
        "  UNION ALL " +
        "  SELECT dt + INTERVAL 1 DAY FROM date_range WHERE dt + INTERVAL 1 DAY <= DATE(?) " +
        ") " +
        "SELECT DATE_FORMAT(dt, '%Y-%m-%d') AS working_date " +
        "FROM date_range " +
        "WHERE dt NOT IN ( " +
        "  SELECT holiday_date FROM holiday_master WHERE activate_flag = 1 " +
        ")";

    parameters.add(getDateASYYYYMMDD(inputMap.get("txttaskdate").toString()));
    parameters.add(getDateASYYYYMMDD(inputMap.get("txtrecurringtill").toString()));

    List<String> allWorkingDates = getListOfString(parameters, query, con);

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate start = LocalDate.parse(parameters.get(0).toString());
    
    switch (recurrenceType.toLowerCase()) {
        case "daily":
            result = allWorkingDates;
            break;

        case "weekly": {
            for (int i = 0; i < allWorkingDates.size(); i += 7) {
                result.add(allWorkingDates.get(i));
            }
            break;
        }

        case "monthly": {
            LocalDate date = start;
            while (!date.isAfter(LocalDate.parse(parameters.get(1).toString()))) {
                String candidate = date.format(formatter);
                if (allWorkingDates.contains(candidate)) {
                    result.add(candidate);
                }
                date = date.plusMonths(1);
            }
            break;
        }

        case "quarterly": {
            LocalDate date = start;
            while (!date.isAfter(LocalDate.parse(parameters.get(1).toString()))) {
                String candidate = date.format(formatter);
                if (allWorkingDates.contains(candidate)) {
                    result.add(candidate);
                }
                date = date.plusMonths(3);
            }
            break;
        }



		case "yearly": {
        LocalDate date = start;
        while (!date.isAfter(LocalDate.parse(parameters.get(1).toString()))) {
            String candidate = date.format(formatter);
            if (allWorkingDates.contains(candidate)) {
                result.add(candidate);
            }
            date = date.plusYears(1);
        }
        break;
    }
		
        case "onetime": {
            String taskDateFormatted = start.format(formatter);
            if (allWorkingDates.contains(taskDateFormatted)) {
                result.add(taskDateFormatted);
            }
            break;
        }

        default:
            throw new IllegalArgumentException("Invalid recurrence type: " + recurrenceType);
    }

    // Convert to dd/MM/yyyy format
    DateTimeFormatter outFormat = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    return result.stream()
                 .map(d -> LocalDate.parse(d, formatter).format(outFormat))
                 .collect(Collectors.toList());
}

public List<LinkedHashMap<String, Object>> getTaskDetails(String taskId,Connection con)
	throws ClassNotFoundException, SQLException {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(taskId);

		return getListOfLinkedHashHashMap(parameters,
		"select * from tbl_task_manager where task_id = ?",
		con);


	}

	public long addTask(HashMap<String, Object> hm, Connection con)
	throws ClassNotFoundException, SQLException, ParseException {

	ArrayList<Object> parameters = new ArrayList<>();
	parameters.add(getDateASYYYYMMDD(hm.get("txttaskdate").toString()));
	parameters.add(getDateASYYYYMMDD(hm.get("txttargetdate").toString()));
	parameters.add(hm.get("taskname"));
	parameters.add(hm.get("drptasktype"));
	parameters.add(hm.get("drpassignedto"));
	parameters.add(hm.get("user_id")); // assigned_by
	parameters.add("Pending"); // curr_status
	parameters.add(hm.get("drppriority"));
	parameters.add(hm.get("remarks"));
	parameters.add(hm.get("app_id"));
	parameters.add(hm.get("user_id")); // updated_by

	String query = "INSERT INTO tbl_task_manager " +
		"(task_id, task_date, target_date, task_name, task_type, assigned_to, assigned_by, curr_status, activate_flag, priority, remarks, app_id, updated_date, updated_by) " +
		"VALUES (DEFAULT, ?, ?, ?, ?, ?, ?, ?, 1, ?, ?, ?, SYSDATE(), ?)";

	return insertUpdateDuablDB(query, parameters, con);
}

public long addTaskInHistTbl(HashMap<String, Object> hm,Connection con)
	throws ClassNotFoundException, SQLException {
		
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(hm.get("task_id"));
		parameters.add(hm.get("task_date"));
		parameters.add(hm.get("target_date"));
		parameters.add(hm.get("task_name"));
		parameters.add(hm.get("task_type"));
		parameters.add(hm.get("assigned_to"));
		parameters.add(hm.get("assigned_by"));
		parameters.add(hm.get("curr_status"));
		parameters.add(hm.get("task_completed_date"));
		parameters.add(hm.get("activate_flag"));
		parameters.add(hm.get("priority"));
		parameters.add(hm.get("remarks"));
		parameters.add(hm.get("updated_date"));
		parameters.add(hm.get("updated_by"));
		parameters.add(hm.get("action_type"));
		parameters.add(hm.get("action_msg"));
		parameters.add(hm.get("action_by"));
		parameters.add(hm.get("app_id"));
       
		String query="INSERT into hist_tbl_task_manager (task_id, task_date, target_date, task_name, task_type, assigned_to, assigned_by, curr_status, task_completed_date,activate_flag,priority,remarks, updated_date, updated_by, action_type, action_msg, action_date, action_by, app_id) values ( ? , ? , ?, ? , ? , ? , ? , ? , ? , ?, ?, ?, ? , ?, ?, ?, sysdate(), ?, ?);";  


		return insertUpdateDuablDB(query, parameters,con);

	}

	public List<LinkedHashMap<String, Object>> getMOMMaster(HashMap<String, Object> inputMap, Connection con, String searchString) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
	StringBuilder sql = new StringBuilder();

	sql.append("SELECT * ");
	sql.append("FROM trn_mom_register WHERE 1=1 ");

	if (inputMap.get("from_date") != null && !inputMap.get("from_date").toString().isEmpty()) {
		sql.append("AND mom_date >= ? ");
		parameters.add(getDateASYYYYMMDD(inputMap.get("from_date").toString()));
	}

	if (inputMap.get("to_date") != null && !inputMap.get("to_date").toString().isEmpty()) {
		sql.append("AND mom_date <= ? ");
		parameters.add(getDateASYYYYMMDD(inputMap.get("to_date").toString()));
	}

	if (inputMap.get("category") != null && !inputMap.get("category").toString().isEmpty()) {
		sql.append("AND category = ? ");
		parameters.add(inputMap.get("category"));
	}

	if (searchString != null && !searchString.trim().isEmpty()) {
		sql.append("AND (mom_no LIKE ? OR conclusion LIKE ? OR initiated_by LIKE ?) ");
		parameters.add("%" + searchString + "%");
		parameters.add("%" + searchString + "%");
		parameters.add("%" + searchString + "%");
	}

	sql.append("ORDER BY mom_date DESC, mom_id DESC");

	return getListOfLinkedHashHashMap(parameters,sql.toString() , con);
}

public List<LinkedHashMap<String, Object>> getMOMCategoryMaster(HashMap<String, Object> inputMap, Connection con) throws Exception {
	String sql = "SELECT mom_category_id AS id, mom_category_name AS name " +
	             "FROM mom_category_mst " +
	             "WHERE activate_flag = 1 " +
	             "ORDER BY mom_category_name";

	ArrayList<Object> parameters = new ArrayList<>();
	return getListOfLinkedHashHashMap(parameters, sql, con);
}

public List<LinkedHashMap<String, Object>> getAttendeesForMOM(Connection con, HashMap<String, Object> inputMap) throws Exception {
    ArrayList<Object> parameters = new ArrayList<>();
    StringBuilder query = new StringBuilder();

    query.append("SELECT ");    
    query.append("u.name ");    
    query.append("FROM trn_mom_attendees a ");
    query.append("JOIN tbl_user_mst u ON u.user_id = a.employee_id ");    
    query.append("WHERE a.mom_id = ?");

    parameters.add(inputMap.get("mom_id"));

    return getListOfLinkedHashHashMap(parameters, query.toString(), con);
}

public long insertRentalExpense(Connection con, HashMap<String, Object> hm) throws Exception {
    HashMap<String, Object> valuesMap = new HashMap<>();

    valuesMap.put("expense_id", "~default");
    valuesMap.put("expense_date", hm.get("txtdate") != null ? getDateASYYYYMMDD(hm.get("txtdate").toString()) : "~null");
    valuesMap.put("expense_name", hm.get("expense_name"));
    valuesMap.put("payment_mode", hm.get("payment_mode"));
	valuesMap.put("qty", hm.get("qty"));
    valuesMap.put("amount", hm.get("amount"));
    valuesMap.put("remarks", hm.get("remarks"));
    valuesMap.put("updated_by", hm.get("user_id"));	
	
	
	
    valuesMap.put("updated_date", "~sysdate()");
    valuesMap.put("activate_flag", 1);

    Query q = new Query("trn_expense_register", "insert", valuesMap);
    return insertUpdateEnhanced(q, con);
}




public String deleteRentalExpense(long expenseId, String userId, Connection conWithF) throws Exception {
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(userId);
		parameters.add(expenseId);
		insertUpdateDuablDB(
				"UPDATE trn_expense_register SET activate_flag=0,updated_by=?,updated_date=sysdate() WHERE expense_id=?",
				parameters, conWithF);
		return "Expense Deleted Succesfully";
	}




}
