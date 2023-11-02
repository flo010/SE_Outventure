package hibernate.model;

import jakarta.persistence.*;

@Entity
public class Hike {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "hike_id")
    private int _hikeID;
    @Basic
    @Column(name = "picture")
    private int _picture;
    @Basic
    @Column(name = "title")
    private String _title;
    @Basic
    @Column(name = "description")
    private String _description;
    @Basic
    @Column(name = "duration")
    private double _duration;
    @Basic
    @Column(name = "distance")
    private double _distance;
    @Basic
    @Column(name = "altitude")
    private int _altitude;

    public int get_hikeID() {
        return _hikeID;
    }

    public void set_hikeID(int hikeId) {
        _hikeID = hikeId;
    }

    public int get_picture() {
        return _picture;
    }

    public void set_picture(int picture) {
        _picture = picture;
    }

    public String get_title() {
        return _title;
    }

    public void set_title(String title) {
        _title = title;
    }

    public String get_description() {
        return _description;
    }

    public void set_description(String description) {
        _description = description;
    }

    public double get_duration() {
        return _duration;
    }

    public void set_duration(double duration) {
        _duration = duration;
    }

    public double get_distance() {
        return _distance;
    }

    public void set_distance(double distance) {
        _distance = distance;
    }

    public int get_altitude() {
        return _altitude;
    }

    public void set_altitude(int altitude) {
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
        result = 31 * result + _picture;
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
