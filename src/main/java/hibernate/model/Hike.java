package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "hikes")
public class Hike {
    @Id
    @NotNull
    @Column(name = "hike_id")
    private int _hikeID;
    @OneToOne
    @JoinColumn(name = "picture")
    private Picture _picture;
    @NotNull
    @Column(name = "title")
    private String _title;
    @NotNull
    @Column(name = "description")
    private String _description;
    @NotNull
    @Column(name = "duration")
    private double _duration;
    @NotNull
    @Column(name = "distance")
    private double _distance;
    @NotNull
    @Column(name = "altitude")
    private int _altitude;

    public int getHikeID() {
        return _hikeID;
    }

    public void setHikeID(int hikeId) {
        _hikeID = hikeId;
    }

    public Picture getPicture() {
        return _picture;
    }

    public void setPicture(Picture picture) {
        _picture = picture;
    }

    public String getTitle() {
        return _title;
    }

    public void setTitle(String title) {
        _title = title;
    }

    public String getDescription() {
        return _description;
    }

    public void setDescription(String description) {
        _description = description;
    }

    public double getDuration() {
        return _duration;
    }

    public void setDuration(double duration) {
        _duration = duration;
    }

    public double getDistance() {
        return _distance;
    }

    public void setDistance(double distance) {
        _distance = distance;
    }

    public int getAltitude() {
        return _altitude;
    }

    public void setAltitude(int altitude) {
        _altitude = altitude;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Hike hike = (Hike) o;

        if (_hikeID != hike._hikeID) return false;
        if (_picture != hike._picture) return false;
        if (Double.compare(_duration, hike._duration) != 0) return false;
        if (Double.compare(_distance, hike._distance) != 0) return false;
        if (_altitude != hike._altitude) return false;
        if (_title != null ? !_title.equals(hike._title) : hike._title != null) return false;
        if (_description != null ? !_description.equals(hike._description) : hike._description != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = _hikeID;
        result = 31 * result + (_picture != null ? _picture.hashCode() : 0);
        result = 31 * result + (_title != null ? _title.hashCode() : 0);
        result = 31 * result + (_description != null ? _description.hashCode() : 0);
        temp = Double.doubleToLongBits(_duration);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        temp = Double.doubleToLongBits(_distance);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + _altitude;
        return result;
    }
}
