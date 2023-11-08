package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "points_of_interest")
public class PointOfInterest {
    private int _pofID;
    private Hike _hikePOF;
    private String _name;
    private String _description;
    private double _longitude;
    private double _latitude;

    @Id
    @NotNull
    @Column(name = "pof_id")
    public int getPofID() {
        return _pofID;
    }
    public void setPofID(int pofID) {
        _pofID = pofID;
    }

    @NotNull
    @ManyToOne
    @JoinColumn(name = "hike")
    public Hike getHikePOF() {
        return _hikePOF;
    }
    public void setHikePOF(Hike hikePOF) {
        _hikePOF = hikePOF;
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
}
