package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "starts")
public class Start {
    private int _startID;
    private String _name;
    private double _longitude;
    private double _latitude;

    @Id
    @NotNull
    @Column(name = "start_id")
    public int getStartID() {
        return _startID;
    }
    public void setStartID(int startID) {
        _startID = startID;
    }

    @NotNull
    @Column(name = "name")
    public String getName() {
        return _name;
    }
    public void setName(String name) {
        _name = name;
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
