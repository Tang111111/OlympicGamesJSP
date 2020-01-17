package bean;

public class Athlete {
    private String delegation_name;
    private String sports_name;
    private String athlete_name;
    private String sex;
    private String birthday;
    private String description;
    
    public int male_amount=0,female_amount=0;
    
    public String getDelegation_name() {
        return delegation_name;
    }

    public void setDelegation_name(String delegation_name) {
        this.delegation_name = delegation_name;
    }

    public String getSports_name() {
        return sports_name;
    }

    public void setSports_name(String sports_name) {
        this.sports_name = sports_name;
    }

    public String getAthlete_name() {
        return athlete_name;
    }

    public void setAthlete_name(String athlete_name) {
        this.athlete_name = athlete_name;
    }
    
    public String getSex() {
    	return sex;
    }
    public void setSex(String sex) {
    	this.sex = sex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
