package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Picture;
import helper.DBConnect;

public class PictureDao {
	//list home page picture(轮播需要的5张图片) eg.index.jsp
    public List<String> getHomeGallery() {
    	List<String> list = new ArrayList<String>();
        Connection conn = DBConnect.getConnection();
        String sql = "select path from athlete_pic where type='match' limit 0,5";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	String path = rst.getString("path");
                list.add(path);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }  
    
	//list delegation name & picture(delegation overview page) eg.delegation.jsp (also can be used in homepage)
	public List<Picture> getAllDelegation(){
		List<Picture> list = new ArrayList<Picture>();
		Connection conn = DBConnect.getConnection();
		String sql = "select delegation_name,path from delegation_pic where type='common'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				Picture delegation_pic = new Picture();
				delegation_pic.setDelegation_name(rst.getString("delegation_name"));
				delegation_pic.setPath(rst.getString("path"));
				list.add(delegation_pic);
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;
	}
	
	//list sports name & picture (sports over view page) eg.sports.jsp (also can be used in homepage)
    public List<Picture> getAllSportslogo() {
        List<Picture> list = new ArrayList<Picture>();
        Connection conn = DBConnect.getConnection();
        String sql = "select sports_name,path from sports_pic where type='logo'";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	Picture sports_pic = new Picture();
            	sports_pic.setSports_name(rst.getString("sports_name"));
            	sports_pic.setPath(rst.getString("path"));
                list.add(sports_pic);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //list athletes name & picture (athletes over view page) eg.athlete.jsp
    public List<Picture> getAllAthlete() {
        List<Picture> list = new ArrayList<Picture>();
        Connection conn = DBConnect.getConnection();
        String sql = "select athlete_name,path from athlete_pic where type='profile'";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	Picture athlete_pic = new Picture();
            	athlete_pic.setAthlete_name(rst.getString("athlete_name"));
            	athlete_pic.setPath(rst.getString("path"));
                list.add(athlete_pic);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }  
    
    //show cover picture of a certain sports(sports detail page) eg.swimming.jsp
    public String getSportsCover(String sports_name) {
        Connection conn = DBConnect.getConnection();
        String sql  = "select path from sports_pic where type='cover' and sports_name= '"+sports_name+"'";
        String path = null;
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	path = rst.getString("path");
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return path;
    }
    //show gallery of a certain sports(sports detail page) eg.swimming.jsp
    public List<String> getSportsGallery(String sports_name) {
    	List<String> list = new ArrayList<String>();
        Connection conn = DBConnect.getConnection();
        String sql = "select path from athlete_pic join athlete using(athlete_name) "
        		   + "where type='match' and sports_name='" + sports_name +"' limit 0,3";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	String path = rst.getString("path");
                list.add(path);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }      
    
	//list all members participating in a certain sports of a certain delegation (show when you click on a certain sport in USA.jsp)
	public List<Picture> getMember(String delegation_name,String sports_name){
		List<Picture> list = new ArrayList<Picture>();
		Connection conn = DBConnect.getConnection();
		String sql = "select athlete_name,path,sex from athlete_pic join athlete using(athlete_name) "
				   + "where type='profile' and sports_name= '" + sports_name + "' and delegation_name='" + delegation_name +"'";
		try {
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rst = pst.executeQuery();
			while(rst.next()) {
				Picture athlete = new Picture();
				athlete.setAthlete_name(rst.getString("athlete_name"));
				athlete.setPath(rst.getString("path"));
				list.add(athlete);
			}
			rst.close();
			pst.close();
		}catch (SQLException e) {
			// TODO: handle exception
            e.printStackTrace();			
		}
		return list;
	}		
	
	//show gallery of a certain delegation(delegation detail page) eg.USA.jsp
    public List<String> getDeleGallery(String delegation_name) {
    	List<String> list = new ArrayList<String>();
        Connection conn = DBConnect.getConnection();
        String sql = "select path from athlete_pic join athlete using(athlete_name) "
        		   + "where type='match' and delegation_name='" + delegation_name +"' limit 0,3";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	String path = rst.getString("path");
                list.add(path);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }  
    
    //show cover of a certain athlete(individual detail page) eg.SUNYANG.jsp
    public String getAthleteCover(String athlete_name) {
        Connection conn = DBConnect.getConnection();
        String sql  = "select path from athlete_pic join athlete using(athlete_name) "
        		    + "where type='match' and athlete_name= '" + athlete_name + "'";
        String path = null;
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	path = rst.getString("path");
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return path;
    }
    
    //show cover of a certain team(team detail page) eg.USA_swimming.jsp
    public String getTeamCover(String team_name) {
        Connection conn = DBConnect.getConnection();
        String sql  = "select path from athlete_pic join member using(athlete_name) "
        		    + "where type='match' and team_name='" + team_name + "' limit 1";
        String path = null;
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	path = rst.getString("path");
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return path;
    }
    
    //show all members picture of a certain team eg.USA_swimming.jsp
    public List<Picture> getAllMember(String team_name) {
        List<Picture> list = new ArrayList<Picture>();
        Connection conn = DBConnect.getConnection();
        String sql = "select distinct athlete_name,path from athlete_pic join member using(athlete_name) "
        		   + "where type='match' and team_name = '" + team_name + "'";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	Picture athlete_pic = new Picture();
            	athlete_pic.setAthlete_name(rst.getString("athlete_name"));
            	athlete_pic.setPath(rst.getString("path"));
                list.add(athlete_pic);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
   
    //show all participants picture of a certain individual event eg.individual.jsp
    public List<Picture> getI_Participant(String event_name) {
        List<Picture> list = new ArrayList<Picture>();
        Connection conn = DBConnect.getConnection();
        String sql = "select distinct T1.athlete_name,T1.delegation_name,T2.path,T3.path "
        		   + "from individual_result T1, athlete_pic T2, delegation_pic T3 "
        		   + "where T1.athlete_name=T2.athlete_name and T1.delegation_name=T3.delegation_name and T2.type='profile' and T3.type='common' and "
        		   + "event_name= '" + event_name + "'";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	Picture picture = new Picture();
            	picture.setAthlete_name(rst.getString("T1.athlete_name"));
            	picture.setDelegation_name(rst.getString("T1.delegation_name"));
            	picture.setA_Path(rst.getString("T2.path"));
            	picture.setPath(rst.getString("T3.path"));
                list.add(picture);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //show all participants(delegations) picture of a certain team event eg.team.jsp
    public List<Picture> getT_Participant(String event_name) {
        List<Picture> list = new ArrayList<Picture>();
        Connection conn = DBConnect.getConnection();
        String sql = "select distinct T1.delegation_name,T2.path from team_result T1 join delegation_pic T2 using(delegation_name) "
        		   + "where T2.type = 'round' and event_name= '" + event_name + "'";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rst = pst.executeQuery();
            while (rst.next()) {
            	Picture picture = new Picture();
            	picture.setDelegation_name(rst.getString("T1.delegation_name"));
            	picture.setPath(rst.getString("T2.path"));
                list.add(picture);
            }
            rst.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    
}
