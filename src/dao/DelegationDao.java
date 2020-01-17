package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Medal;
import bean.Picture;
import bean.Result;
import helper.DBConnect;

public class DelegationDao {
	
	//list delegation information(delegation details page) eg.USA.jsp title & flag
	public Picture getDelegationInfo(String delegation_name){		
		Connection conn = DBConnect.getConnection();
		String sql = "select * from delegation_pic where type='common' and delegation_name = '" + delegation_name + "'";
		Picture delegation = null;
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				delegation = new Picture();
				delegation.setDelegation_name(rst.getString("delegation_name"));
				delegation.setPath(rst.getString("path"));
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return delegation;
	}
	
	//medal list-List events that have won medals  eg.USA.jsp
		public List<String> getMedalList(String delegation_name){
			List<String> list = new ArrayList<String>();
			Connection conn = DBConnect.getConnection();
			String sql = "select event_name,team_name as name,rank,type,T1.sports_name "
					+ "from team_result T1 join event using(event_name) "
					+ "where T1.state='final' and (rank=1 or rank=2 or rank=3) and delegation_name = '"+delegation_name+"' union "
					+ "select event_name,athlete_name as name,rank,type,T1.sports_name "
					+ "from individual_result T1 join event using(event_name)"
					+ "where T1.state='final' and (rank=1 or rank=2 or rank=3) and delegation_name = '"+delegation_name+"'";
			try {
				PreparedStatement pst = conn.prepareStatement(sql);
				ResultSet rst = pst.executeQuery();
				while(rst.next()) {
					
					list.add(rst.getString("event_name"));
					list.add(rst.getString("name"));//team name
					list.add(String.valueOf(rst.getInt("rank")));
					list.add(rst.getString("type"));
					list.add(rst.getString("sports_name"));
				}			
				rst.close();
				pst.close();
			}catch (SQLException e) {
				// TODO: handle exception
	            e.printStackTrace();			
			}
			return list;		
		}

	

	//medal list-list each record picture 
	public List<String> getListPic(String delegation_name){
		List<String> list = new ArrayList<String>();
		Connection conn = DBConnect.getConnection();
		String sql = "select path,event_name,team_name,rank "
				   + "from team_result join sports_pic using(sports_name) " 
				   + "where type='logo' and state='final' and (rank=1 or rank=2 or rank=3) and delegation_name = '" + delegation_name + "' union "
		           + "select path,event_name,athlete_name,rank "
		           + "from individual_result join sports_pic using (sports_name) " 
		           + "where type='logo' and state='final' and (rank=1 or rank=2 or rank=3) and delegation_name = '" + delegation_name + "'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				String path = rst.getString("path");
                list.add(path);							
			}			
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;		
	}
		
	//calculate medal
	public Medal getMedal(String delegation_name){
		Connection conn = DBConnect.getConnection();
		String sql = "select event_name,rank from team_result " 
				   + "where state='final' and (rank=1 or rank=2 or rank=3) and delegation_name = '" + delegation_name + "' union "
				   + "select event_name,rank from individual_result " 
				   + "where state='final' and (rank=1 or rank=2 or rank=3) and delegation_name = '" + delegation_name + "'";
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
	
	//list all sports that a delegation participates in eg.USA.jsp
	public List<String> getSports(String name){
		List<String> list = new ArrayList<String>();
		Connection conn = DBConnect.getConnection();
		String sql = "select sports_name from team where delegation_name= '" + name + "'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				String team = rst.getString("sports_name");
				list.add(team);
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;
	}	
    
	//Calculate the number of male and female athletes in a certain sport in a delegation eg.USA.jsp
		public List<Integer> getMemAmount(String delegation_name,String sports_name){
			List<Integer> list = new ArrayList<Integer>();
			List<String> list2 = new ArrayList<String>();
			Connection conn = DBConnect.getConnection();
			String sql = "select count(athlete_name) as amount,sex from athlete where sports_name='" + sports_name
					+ "' and delegation_name='" + delegation_name +"' group by sex order by sex";
			try {
				PreparedStatement pst = conn.prepareStatement(sql);
				ResultSet rst = pst.executeQuery();
				while(rst.next()) {
					String amount = String.valueOf(rst.getInt("amount"));
					String sex = rst.getString("sex");
					list2.add(amount);
					list2.add(sex);
				}
				if(list2.size()==0) {
					list.add(0);
					list.add(0);
				}
				else if(list2.size()==2) {
					if(list2.get(1).equals("Female")) {
						list.add(Integer.parseInt(list2.get(0)));
						list.add(0);
					}else {
						list.add(0);
						list.add(Integer.parseInt(list2.get(0)));
					}
				}
				else {
					list.add(Integer.parseInt(list2.get(0)));
					list.add(Integer.parseInt(list2.get(2)));
				}
				rst.close();
				pst.close();
			}catch (SQLException e) {
				// TODO: handle exception
	            e.printStackTrace();			
			}
			return list;
		}

	
	//get all delegation name that can skip to another page
	public List<String> getDelegationNames(){		
		Connection conn = DBConnect.getConnection();
		String sql = "select delegation_name from delegation";
		List<String> names = new ArrayList<String>();
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				names.add(rst.getString("delegation_name"));
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
