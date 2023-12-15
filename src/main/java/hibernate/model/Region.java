package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name="regions")
public class Region {
    private int _regionID;
    private String _region;


    @Id
    @NotNull
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "region_id")
    public int getRegionID(){return _regionID;}
    public void setRegionID(int regionID){_regionID = regionID;}

    @NotNull
    @Column(name="region")
    public String getRegion(){return _region;}
    public void setRegion(String region){_region = region;}

}
