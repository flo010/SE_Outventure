package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "hikes")
public class Hike {
    private int _hikeID;
    private int _previewPicture;
    private String _title;
    private String _description;
    private double _duration;
    private double _distance;
    private int _altitude;
    private int _stamina;
    private int _strength;
    private int _experience;
    private int _landscape;
    private boolean _january;
    private boolean _february;
    private boolean _march;
    private boolean _april;
    private boolean _may;
    private boolean _june;
    private boolean _july;
    private boolean _august;
    private boolean _september;
    private boolean _october;
    private boolean _november;
    private boolean _december;
    private Start _start;
    private Destination _destination;
    private List<PointOfInterest> _pointOfInterests;
    private String _routeDescription;
    private String _parkingInformation;
    private String _arrivalInformation;
    private String _author;
    private LocalDate _date;
    private boolean _visible;
    private String _region;

    public Hike() {
    }

    @Id
    @NotNull
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "hike_id")
    public int getHikeID() {
        return _hikeID;
    }
    public void setHikeID(int hikeId) {
        _hikeID = hikeId;
    }
    @Column(name = "picture")
    public int getPreviewPicture() {
        return _previewPicture;
    }
    public void setPreviewPicture(int previewPicture) {
        _previewPicture = previewPicture;
    }

    @NotNull
    @Column(name = "title")
    public String getTitle() {
        return _title;
    }
    public void setTitle(String title) {
        _title = title;
    }

    @NotNull
    @Column(name = "description")
    public String getDescription() {
        return _description;
    }
    public void setDescription(String description) {
        _description = description;
    }

    @NotNull
    @Column(name = "duration")
    public double getDuration() {
        return _duration;
    }
    public void setDuration(double duration) {
        _duration = duration;
    }

    @NotNull
    @Column(name = "distance")
    public double getDistance() {
        return _distance;
    }
    public void setDistance(double distance) {
        _distance = distance;
    }

    @NotNull
    @Column(name = "altitude")
    public int getAltitude() {
        return _altitude;
    }
    public void setAltitude(int altitude) {
        _altitude = altitude;
    }


    @NotNull
    @Column(name = "stamina")
    public int getStamina() {
        return _stamina;
    }
    public void setStamina(int stamina) {
        _stamina = stamina;
    }

    @NotNull
    @Column(name = "strength")
    public int getStrength() {
        return _strength;
    }
    public void setStrength(int strength) {
        _strength = strength;
    }

    @NotNull
    @Column(name = "experience")
    public int getExperience() {
        return _experience;
    }
    public void setExperience(int experience) {
        _experience = experience;
    }

    @NotNull
    @Column(name = "landscape")
    public int getLandscape() {
        return _landscape;
    }
    public void setLandscape(int landscape) {
        _landscape = landscape;
    }

    @NotNull
    @Column(name = "january")
    public boolean isJanuary() {
        return _january;
    }
    public void setJanuary(boolean january) {
        _january = january;
    }

    @NotNull
    @Column(name = "february")
    public boolean isFebruary() {
        return _february;
    }
    public void setFebruary(boolean february) {
        _february = february;
    }

    @NotNull
    @Column(name = "march")
    public boolean isMarch() {
        return _march;
    }
    public void setMarch(boolean march) {
        _march = march;
    }

    @NotNull
    @Column(name = "april")
    public boolean isApril() {
        return _april;
    }
    public void setApril(boolean april) {
        _april = april;
    }

    @NotNull
    @Column(name = "may")
    public boolean isMay() {
        return _may;
    }
    public void setMay(boolean may) {
        _may = may;
    }

    @NotNull
    @Column(name = "june")
    public boolean isJune() {
        return _june;
    }
    public void setJune(boolean june) {
        _june = june;
    }

    @NotNull
    @Column(name = "july")
    public boolean isJuly() {
        return _july;
    }
    public void setJuly(boolean july) {
        _july = july;
    }

    @NotNull
    @Column(name = "august")
    public boolean isAugust() {
        return _august;
    }
    public void setAugust(boolean august) {
        _august = august;
    }

    @NotNull
    @Column(name = "september")
    public boolean isSeptember() {
        return _september;
    }
    public void setSeptember(boolean september) {
        _september = september;
    }

    @NotNull
    @Column(name = "october")
    public boolean isOctober() {
        return _october;
    }
    public void setOctober(boolean october) {
        _october = october;
    }

    @NotNull
    @Column(name = "november")
    public boolean isNovember() {
        return _november;
    }
    public void setNovember(boolean november) {
        _november = november;
    }

    @NotNull
    @Column(name = "december")
    public boolean isDecember() {
        return _december;
    }
    public void setDecember(boolean december) {
        _december = december;
    }

    @NotNull
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "start")
    public Start getStart() {
        return _start;
    }
    public void setStart(Start start) {
        _start = start;
    }

    @NotNull
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "destination")
    public Destination getDestination() {
        return _destination;
    }
    public void setDestination(Destination destination) {
        _destination = destination;
    }

    @OneToMany(mappedBy = "hikePOI",fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    public List<PointOfInterest> getPointsOfInterest() {
        return _pointOfInterests;
    }
    public void setPointsOfInterest(List<PointOfInterest> pointOfInterests) {
        _pointOfInterests = pointOfInterests;
    }

    @NotNull
    @Column(name = "route_description")
    public String getRouteDescription() {
        return _routeDescription;
    }
    public void setRouteDescription(String routeDescription) {
        _routeDescription = routeDescription;
    }

    @Column(name = "parking_info")
    public String getParkingInformation() {
        return _parkingInformation;
    }
    public void setParkingInformation(String parkingInformation) {
        _parkingInformation = parkingInformation;
    }

    @Column(name = "arrival_info")
    public String getArrivalInformation() {
        return _arrivalInformation;
    }
    public void setArrivalInformation(String arrivalInformation) {
        _arrivalInformation = arrivalInformation;
    }
    @NotNull
    @Column(name = "author")
    public String getAuthor() {return _author;}
    public void setAuthor(String author) {_author = author;}
    @NotNull
    @Column(name = "date")
    public LocalDate getDate(){return _date;}
    public void setDate(LocalDate date){_date = date;}

    @NotNull
    @Column(name = "visible")
    public boolean isVisible() {
        return _visible;
    }
    public void setVisible(boolean visible) {
        _visible = visible;
    }

    @NotNull
    @Column(name = "region")
    public String getRegion() {
        return _region;
    }
    public void setRegion(String region) {
        _region = region;
    }

    public boolean[] monthsArray() {
        boolean[] months = new boolean[12];
        months[0] = _january;
        months[1] = _february;
        months[2] = _march;
        months[3] = _april;
        months[4] = _may;
        months[5] = _june;
        months[6] = _july;
        months[7] = _august;
        months[8] = _september;
        months[9] = _october;
        months[10] = _november;
        months[11] = _december;

        return months;
    }
}
