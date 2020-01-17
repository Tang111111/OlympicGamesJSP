package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Event;
import bean.Result;
import helper.DBConnect;

public class ResultDao {
	
	//drop-down list(first column) of an event eg.team.jsp/individual.jsp
	public List<String> getList(String sports_name){
		List<String> list = new ArrayList<String>();
		Connection conn = DBConnect.getConnection();
		String sql = "select distinct sports_name from sports where sports_name <> '" + sports_name + "'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				String name = rst.getString("sports_name");
                list.add(name);							
			}			
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;		
	}
	
	//drop-down list(third column) of team event eg.team.jsp
	public List<String> getTeamList(String sports_name,String event_name){
		List<String> list = new ArrayList<String>();
		Connection conn = DBConnect.getConnection();
		String sql = "select distinct event_name from event where sports_name= '" + sports_name 
				   + "' and event_name <> '" + event_name + "' and type='team'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				String name = rst.getString("event_name");
                list.add(name);							
			}			
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;		
	}
	
	//drop-down list(third column) of individual event eg.individual.jsp
	public List<String> getIndiList(String sports_name,String event_name){
		List<String> list = new ArrayList<String>();
		Connection conn = DBConnect.getConnection();
		String sql = "select distinct event_name from event where sports_name= '" + sports_name 
				   + "' and event_name <> '" + event_name + "' and type='individual'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				String name = rst.getString("event_name");
                list.add(name);							
			}			
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;		
	}
	
	//list match schedule
	public List<Event> getSchedule(String event_name) {
		List<Event> list = new ArrayList<Event>();
		Connection conn = DBConnect.getConnection();
		String sql = "select state,event_date from event where state<>'NOTSTARTED' and event_name='" + event_name + "' order by event_date desc";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				Event event = new Event();
				event.setState(rst.getString("state"));
				event.setDate(rst.getString("event_date"));
				list.add(event);
			}			
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;	
	}
	
	//list team event result of each state 
	public List<String> getTeamResult(String event_name,String state){
		List<String> list = new ArrayList<String>();
		Connection conn = DBConnect.getConnection();
		String sql = "select rank,delegation_name,path,grade from team_result join delegation_pic using(delegation_name) "
				   + "where rank <>0 and type = 'common' "
				   + "and event_name ='" + event_name + "' and state='" + state + "' order by rank";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {				
				list.add(String.valueOf(rst.getInt("rank")));
				list.add(rst.getString("delegation_name"));
				list.add(rst.getString("path"));
				list.add(rst.getString("grade"));			
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;
	}
	
	//list individual event result of each state 
	public List<String> getIndiResult(String event_name,String state){
		List<String> list = new ArrayList<String>();
		Connection conn = DBConnect.getConnection();
		String sql = "select rank, athlete_name,delegation_name,path,grade " //T2.path为运动员头像，T3.path为国旗
				   + "from individual_result join athlete_pic using(athlete_name) " 
				   + "where type='profile' and rank<>0 and "
        		   + "event_name= '" + event_name + "' and state='" + state + "' order by rank";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				list.add(String.valueOf(rst.getInt("rank")));
				list.add(rst.getString("athlete_name"));
				list.add(rst.getString("delegation_name"));
				list.add(rst.getString("path"));
				list.add(rst.getString("grade"));	
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;
	}
	    
   //Add result 
	public boolean addResult(Result individual_result,String event_name){
		Connection conn = DBConnect.getConnection();
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
			sql1 = "insert into team_result (team_name,event_name,delegation_name,"
					    + "sports_name,grade,rank,state) values (?,?,?,?,?,?,?)";
		}else {
			sql1 = "insert into individual_result (athlete_name,event_name,delegation_name,"
				        + "sports_name,grade,rank,state) values (?,?,?,?,?,?,?)";
		}
		try {
			PreparedStatement pst1 = conn.prepareStatement(sql1);
			pst1.setString(1,individual_result.getName());
			pst1.setString(2, individual_result.getEvent_name());
			pst1.setString(3, individual_result.getDelegation_name());
			pst1.setString(4, individual_result.getSports_name());
			pst1.setString(5,individual_result.getGrade());
			pst1.setInt(6,individual_result.getRank());
			pst1.setString(7, individual_result.getState());
			int count = pst1.executeUpdate();
			pst1.close();
			return count>0 ? true:false;
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return false;
	}
	
	
	
}
