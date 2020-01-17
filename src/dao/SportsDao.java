package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import bean.Event;
import helper.DBConnect;


public class SportsDao {

    //list all team events of a certain sports (sports detail page)
    public List<Event> getTeamEvent(String sports_name){
        List<Event> list = new ArrayList<Event>();
        Connection conn = DBConnect.getConnection();//
        String sql  = "select distinct event_name from event where sports_name='" + sports_name + 
        		      "' and type='team'";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	Event event=new Event();
                event.setEvent_name(rst.getString("event_name"));
                String sql1 = "select distinct event_name,state " 
                		   + "from (select event_name,state,event_date from event join team_result using (event_name,state) "
                		         + "where event_name='" + rst.getString("event_name") + "') T "
                		   + "where event_date>=all (select event_date from event join team_result using (event_name,state) "
                		                             + "where event_name='" + rst.getString("event_name") + "')";
                PreparedStatement pst1 = conn.prepareStatement(sql1);
                ResultSet rst1 = pst1.executeQuery();
                while(rst1.next()) {
                	event.setState( rst1.getString("state")); 
                }
                list.add(event);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
    //list all individual events of a certain sports (sports detail page)
    public List<Event> getIndividualEvent(String sports_name){
        List<Event> list = new ArrayList<Event>();
        Connection conn = DBConnect.getConnection();//
        String sql  = "select distinct event_name from event where sports_name='" + sports_name + 
        		      "' and type='individual'";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	Event event=new Event();
                event.setEvent_name(rst.getString("event_name"));
                String sql1 = "select distinct event_name,state " 
                		   + "from (select event_name,state,event_date from event join individual_result using (event_name,state) "
                		         + "where event_name='" + rst.getString("event_name") + "') T "
                		   + "where event_date>=all (select event_date from event join individual_result using (event_name,state) "
                		                             + "where event_name='" + rst.getString("event_name") + "')";
                PreparedStatement pst1 = conn.prepareStatement(sql1);
                ResultSet rst1 = pst1.executeQuery();
                while(rst1.next()) {
                	event.setState( rst1.getString("state")); 
                }
                list.add(event);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
	//get all sports name that can skip to another page
	public List<String> getSportsNames(){		
		Connection conn = DBConnect.getConnection();
		String sql = "select sports_name from sports";
		List<String> names = new ArrayList<String>();
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				names.add(rst.getString("sports_name"));
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return names;
	}	

}