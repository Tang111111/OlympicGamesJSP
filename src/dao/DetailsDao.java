package dao;

import java.sql.*;
import java.util.*;

import bean.Athlete;
import bean.History;
import bean.Medal;
import bean.Mem_position;
import bean.Picture;
import bean.Result;
import helper.DBConnect;

public class DetailsDao {
	
	//list team information(team details page) eg.USA_swimming.jsp title & flag
	public Picture getTeamTitle(String delegation_name,String event_name){		
		Connection conn = DBConnect.getConnection();
		String sql = "select distinct T1.team_name,T2.path from team_result T1 join delegation_pic T2 using(delegation_name) "
     		       + "where T2.type = 'common' and event_name= '" + event_name + "'and delegation_name='" + delegation_name + "'";
		Picture picture = null;
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				picture = new Picture();
				picture.setDelegation_name(rst.getString("T1.team_name"));
				picture.setPath(rst.getString("T2.path"));
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return picture;
	}

    //list individual information(individual details page) eg.SUNYANG.jsp delegation & flag
	public Picture getIndiTitle(String athlete_name){		
		Connection conn = DBConnect.getConnection();
		String sql = "select delegation_name,path from athlete join delegation_pic using(delegation_name) "
				   + "where athlete_name ='" + athlete_name + "' and type='common'";
		Picture picture = null;
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				picture = new Picture();
				picture.setDelegation_name(rst.getString("delegation_name"));
				picture.setPath(rst.getString("path"));
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return picture;
	}
	
	//calculate medals of a certain team eg.USA_swimming.jsp
	public Medal getTeamMedal(String team_name){
		Connection conn = DBConnect.getConnection();
		String sql = "select event_name,rank from team_result " 
				   + "where state='final' and (rank=1 or rank=2 or rank=3) and team_name = '" + team_name + "' union "
				   + "select event_name,rank from individual_result join member using(athlete_name) " 
			       + "where state='final' and (rank=1 or rank=2 or rank=3) and  team_name = '" + team_name + "'";
		Medal medal = new Medal();
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				if(rst.getInt("rank")==1) {
                    medal.setGold(++medal.gold);
				}
				else if(rst.getInt("rank")==2) {
					medal.setSilver(++medal.silver);
				}
				else {
					medal.setBronze(++medal.bronze);
				}							
			}			
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return medal;		
	}
	
	//calculate medals of a certain athlete  eg.SUNYANG.jsp
	public Medal getIndiMedal(String athlete_name){
		Connection conn = DBConnect.getConnection();
		String sql = "select event_name,rank from individual_result " 
				   + "where state='final' and (rank=1 or rank=2 or rank=3) and athlete_name = '" + athlete_name + "' union "
				   + "select event_name,rank from team_result join mem_position using (team_name,event_name) "
				   + "where state='final' and (rank=1 or rank=2 or rank=3) and athlete_name = '" + athlete_name + "'";
		Medal medal = new Medal();
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				if(rst.getInt("rank")==1) {
                    medal.setGold(++medal.gold);
				}
				else if(rst.getInt("rank")==2) {
					medal.setSilver(++medal.silver);
				}
				else {
					medal.setBronze(++medal.bronze);
				}							
			}			
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return medal;		
	}
	
    //List team information
    public List<String> getTeamInfo(String team_name){
        Connection conn = DBConnect.getConnection();
        String sql  = "select count(athlete_name) as amount,sports_name,description from team join member using(team_name) "
        		    + "where team_name='" + team_name + "'";
        List<String> list = new ArrayList<String>();
        try{
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
			while(rst.next()) {				
				list.add(rst.getString("amount"));
				list.add(rst.getString("sports_name"));
				list.add(rst.getString("description"));			
			}
			rst.close();
            pst.close();
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //List individual information
    public Athlete getIndiInfo(String athlete_name) {
        Athlete athlete = new Athlete();
        Connection conn = DBConnect.getConnection();//
        String sql  = "select birthday,delegation_name,sports_name,description from athlete where athlete_name='" + athlete_name +"'";
        try{
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while(rst.next()) {
            	athlete.setBirthday(rst.getString("birthday"));
                athlete.setDelegation_name(rst.getString("delegation_name"));
                athlete.setSports_name(rst.getString("sports_name"));
                athlete.setDescription(rst.getString("description"));
            }
            rst.close();
            pst.close();
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return athlete;
    }
    
   //List all the events that a team will participate in during the current tournament eg.USA_swimming.jsp
	public List<Result> getTeamEvent(String team_name){
		List<Result> list = new ArrayList<Result>();
		Connection conn = DBConnect.getConnection();
		String sql = "select distinct event_name,team_name as name from team_result where team_name='" + team_name + "'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				Result event = new Result();
				event.setEvent_name(rst.getString("event_name"));
				event.setName(rst.getString("name"));
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
	
    //List the position of a certain team event
	public List<Mem_position> getTeamPosition(String team_name,String event_name){
		List<Mem_position> list = new ArrayList<Mem_position>();
		Connection conn = DBConnect.getConnection();
		String sql = "select mem_position, athlete_name from mem_position "
				   + "where team_name='" + team_name + "' and event_name='" + event_name + "' "
				   + "order by mem_position";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				Mem_position position = new Mem_position();
				position.setPosition(rst.getInt("mem_position"));
				position.setAthlete_name(rst.getString("athlete_name"));
				list.add(position);
			}			
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;		
	}
	
	//List all the individual events that an athlete of this team will participate in 
	public List<Result> getTeamEvent2(String team_name){
		List<Result> list = new ArrayList<Result>();
		Connection conn = DBConnect.getConnection();
		String sql = "select distinct event_name,athlete_name as name from individual_result join member using(athlete_name) "
				   + "where team_name ='" + team_name + "'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				Result event = new Result();
				event.setEvent_name(rst.getString("event_name"));
				event.setName(rst.getString("name"));
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
	
   //List all the events an athlete will participate in during the current tournament
	public List<String> getIndiEvent(String athlete_name){
		List<String> list = new ArrayList<String>();
		Connection conn = DBConnect.getConnection();
		String sql = "select distinct event_name from individual_result "
				   + "where athlete_name ='" + athlete_name + "' union "
				   + "select distinct event_name from mem_position join athlete using (athlete_name) "
				   + "where athlete_name ='" + athlete_name + "'";
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
	
   //List the best history of a certain team eg.USA_swimming.jsp
    public List<History> getTeamHistory(String team_name){
        List<History> list = new ArrayList<History>();
        Connection conn = DBConnect.getConnection();
        String sql = "select rank,game,event_name,grade from history "
        		   + "where team_name='" + team_name + "' order by type desc, game asc,rank asc limit 0,5";
        try{
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
                History team_history = new History();
                team_history.setRank(rst.getInt("rank"));
                team_history.setGame(rst.getString("game"));
                team_history.setEvent_name(rst.getString("event_name"));
                team_history.setGrade(rst.getString("grade"));
                list.add(team_history);
            }
            rst.close();
            pst.close();
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //List the best history of a certain person eg.SUNYANG.jsp
    public List<History> getIndiHistory(String athlete_name){
        List<History> list=new ArrayList<History>();
        Connection conn = DBConnect.getConnection();
        String sql = "select rank,game,event_name,grade from history "
        		   + "where athlete_name='" + athlete_name + "' order by game asc,rank asc limit 0,5";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
                History individual_history = new History();
                individual_history.setRank(rst.getInt("rank"));
                individual_history.setGame(rst.getString("game"));
                individual_history.setEvent_name(rst.getString("event_name"));
                individual_history.setGrade(rst.getString("grade"));
                list.add(individual_history);
            }
            rst.close();
            pst.close();
        }catch (SQLException e){
            e.printStackTrace();
       }
       return list;
    }
  
 

}
