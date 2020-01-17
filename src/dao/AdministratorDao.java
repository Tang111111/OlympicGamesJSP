package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.Athlete;
import bean.Delegation_pic;
import bean.Event;
import helper.DBConnect;

public class AdministratorDao {
    public int login(String username,String password)
    {
    	Connection conn = DBConnect.getConnection();
    	 String sql = "select * from administrator where username = '"+username+"'";//SQLÓï¾ä
    	 int flag=0;
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			if(rst.next()) {
				 if(rst.getString("password").equals(password))
	                {
	                    flag=1;
	                }
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return flag;
    }
    
    public List<String> getAllSports()
    {
    	Connection conn = DBConnect.getConnection();
    	List<String> list = new ArrayList<String>();
    	 String sql = "select sports_name from sports";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			if(rst.next()) {
				String sportsName = rst.getString("sports_name");
				 list.add(sportsName);
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;
    }
    
    public List<String> getAllEvents(String sportName)//get all events of a certain sport
    {
    	Connection conn = DBConnect.getConnection();
    	List<String> list = new ArrayList<String>();
    	 String sql = "select distinct event_name from event where sports_name = '"+sportName+"'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				
				 list.add(rst.getString("event_name"));
			}
			System.out.println(list);
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;
    }
    
    public String getType(String sportName,String eventName)
    {
    	Connection conn = DBConnect.getConnection();
    	String type = null;
    	 String sql = "select distinct type from event where event_name = '"+eventName+"' and sports_name='"+sportName+"'; ";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				type=rst.getString("type");
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return type;
    }
    
  //Give event name,show its current state
    public String getCurrentState(String event_name){
        Connection conn = DBConnect.getConnection();//
        String sql  = "select distinct type from event where event_name='" + event_name + "'";
        String type = null, sql1 = null,state = null;
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
		    ResultSet rst = pst.executeQuery();
		    while(rst.next()) {
		    	type = rst.getString("type");
		    }
		    rst.close();
		    pst.close();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		if(type.equals("individual")) {
			sql1 = "select distinct state " 
         		 + "from (select event_name,state,event_date from event join individual_result using (event_name,state) "
         		 + "where event_name='" + event_name + "') T "
         		 + "where event_date>=all (select event_date from event join individual_result using (event_name,state) "
         		                         + "where event_name='" + event_name + "')";
		}else {
			sql1 = "select distinct state " 
	         	 + "from (select event_name,state,event_date from event join team_result using (event_name,state) "
	         	 + "where event_name='" + event_name + "') T "
	         	 + "where event_date>=all (select event_date from event join team_result using (event_name,state) "
	         		                     + "where event_name='" + event_name + "')";
		}
        try {
            PreparedStatement pst1 = conn.prepareStatement(sql1);
            ResultSet rst1 = pst1.executeQuery();
            while (rst1.next()) {
            	state = rst1.getString("state");
            }
            rst1.close();
            pst1.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return state;
    }

    //Give current state,list all participants of this state
    public List<String> getCurrentParticipant(String event_name,String current_state){
    	Connection conn = DBConnect.getConnection();
		List<String> list = new ArrayList<String>();
		String sql = "select distinct type from event where event_name='" + event_name +"'";
		String type = null,sql1=null;
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
		    ResultSet rst = pst.executeQuery();
		    while(rst.next()) {
		    	type = rst.getString("type");
		    }
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		if(type.equals("team")) {
			sql1 = "select team_name as name,delegation_name from team_result where event_name='" + event_name + "'"
				 + " and state='" + current_state + "' order by rank";
		}else {
			sql1 = "select athlete_name as name, delegation_name from individual_result where event_name='" + event_name + "'"
				 + " and state='" + current_state + "' order by rank";
		}
        try {
            PreparedStatement pst1 = conn.prepareStatement(sql1);
            ResultSet rst1 = pst1.executeQuery();
            while (rst1.next()) {
            	list.add(rst1.getString("name"));
            	list.add(rst1.getString("delegation_name"));
            }
            rst1.close();
            pst1.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return list;
    }

    
    public String getNextState(String currentState) {
		if (currentState.equals("NOTSTARTED")) {
			return "preliminary";
		}
		
		else if(currentState.equals("preliminary")) {
			return "semifinal";
		}
		else if(currentState.equals("semifinal")) {
			return "final";
		}
		else if(currentState.equals("final")) {
			return "already ended, cannot insert.";
		}
		
		return null;
    }
    //Add a new event
  	public boolean addEvent(Event newEvent){
  		Connection conn = DBConnect.getConnection();
  		String sql = "insert into event(sports_name,event_name,type,state,event_date) "
  				   + "values(?,?,?,?,?)";
  		try {
  			PreparedStatement pst = conn.prepareStatement(sql);
  			pst.setString(1,newEvent.getSports_name());
  			pst.setString(2, newEvent.getEvent_name());
  			pst.setString(3, newEvent.getType());
  			pst.setString(4, newEvent.getState());
  			pst.setString(5,newEvent.getDate());
  			int count = pst.executeUpdate();
  			pst.close();
  			return count>0 ? true:false;
  		}catch (SQLException e) {
  			// TODO: handle exception
              e.printStackTrace();			
  		}
  		return false;
  	}
  //Add athletes
  	public boolean addAthletes(Athlete newAthlete){
  		Connection conn = DBConnect.getConnection();
  		String sql = "insert into athlete(sports_name,athlete_name,sex,delegation_name,birthday) "
  				   + "values(?,?,?,?,?)";
  		try {
  			PreparedStatement pst = conn.prepareStatement(sql);
  			pst.setString(1,newAthlete.getSports_name());
  			pst.setString(2, newAthlete.getAthlete_name());
  			pst.setString(3, newAthlete.getSex());
  			pst.setString(4, newAthlete.getDelegation_name());
  			pst.setString(5,newAthlete.getBirthday());
  			int count = pst.executeUpdate();
  			pst.close();
  			return count>0 ? true:false;
  		}catch (SQLException e) {
  			// TODO: handle exception
              e.printStackTrace();			
  		}
  		return false;
  	}
    
}