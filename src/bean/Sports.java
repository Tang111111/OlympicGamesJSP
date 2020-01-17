package bean;

public class Sports {
    private String sports_name;
    private String season;
    
    public int male_amount, female_amount;

    public String getSports_name() {
        return sports_name;
    }

    public void setSports_name(String sports_name) {
        this.sports_name = sports_name;
    }

    public String getSeason() {
        return season;
    }

    public void setSeason(String season) {
        this.season = season;
    }
    
    public int getMaleAmount() {
        return male_amount;
    }

    public void setMaleAmount(int male_amount) {
        this.male_amount = male_amount;
    }
    
    public int getFemaleAmount() {
        return female_amount;
    }

    public void setFemaleAmount(int female_amount) {
        this.female_amount = female_amount;
    }    
}
