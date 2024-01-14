package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.util.List;

@Entity
@Table(name = "points_of_interest")
public class PointOfInterest {
    private int _poiID;
    private List<Hike> _hikes;
    private String _name;
    private String _description;
    private double _longitude;
    private double _latitude;
    private String _type;

    @Id
    @NotNull
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "poi_id")
    public int getPoiID() {
        return _poiID;
    }
    public void setPoiID(int poiID) {
        _poiID = poiID;
    }

    @NotNull
    @Column(name = "name")
    public String getName() {
        return _name;
    }
    public void setName(String name) {
        _name = name;
    }

    @Column(name = "description")
    public String getDescription() {
        return _description;
    }
    public void setDescription(String description) {
        _description = description;
    }

    @NotNull
    @Column(name = "longitude")
    public double getLongitude() {
        return _longitude;
    }
    public void setLongitude(double longitude) {
        _longitude = longitude;
    }

    @NotNull
    @Column(name = "latitude")
    public double getLatitude() {
        return _latitude;
    }
    public void setLatitude(double latitude) {
        _latitude = latitude;
    }

    @NotNull
    @Column(name = "type")
    public String getType() {
        return _type;
    }
    public void setType(String type) {
        _type = type;
    }

    @ManyToMany
    @JoinTable(name = "poi_on_hike", joinColumns = @JoinColumn(name ="hike"), inverseJoinColumns = @JoinColumn(name = "poi"))
    public List<Hike> getHikes() {
        return _hikes;
    }
    public void setHikes(List<Hike> hikes) {
        _hikes = hikes;
    }
}
