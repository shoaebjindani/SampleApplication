import java.sql.SQLException;
import java.util.HashMap;

public class someMain {

    public static void main(String[] args) throws SQLException, ClassNotFoundException {

        HashMap<String, Object> valuesMap=new HashMap<String, Object>();
        
        valuesMap.put("instance_id", "1");
        valuesMap.put("instance_name", "instance_name_goes_here");
        valuesMap.put("updated_date", "2022-01-01");
        valuesMap.put("updated_by", "3");
        
        HashMap<String, Object> whereMap=new HashMap<String, Object>();
        whereMap.put("instance_id", "3");
        whereMap.put("name", "Shoaeb");
        
        
        
       // cf.insertUpdateEnhanced(q,cf.getConnectionJDBC());
    }

}
