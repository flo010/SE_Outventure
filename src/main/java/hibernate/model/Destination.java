package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "destination")
public class Destination {
    private int _destinationID;
    private String _name;
    private Hike _hikeDestination;
    private double _longitude;
    private double _latitude;

    @Id
    @NotNull
    @Column(name = "destination_id")
    public int getDestinationID() {
        return _destinationID;
    }
    public void setDestinationID(int destinationID) {
        _destinationID = destinationID;
    }

    @NotNull
    @Column(name = "name")
    public String getName() {
        return _name;
    }
    public void setName(String name) {
        _name = name;
    }

    @OneToOne(mappedBy = "destination")
    public Hike getHikeDestination() {
        return _hikeDestination;
    }
    public void setHikeDestination(Hike hikeDestination) {
        _hikeDestination = hikeDestination;
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
