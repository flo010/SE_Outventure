package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "completed_hikes")
public class CompletedHike {
    private int _completedHikeID;
    private Hike _hike;
    private Hiker _hiker;
    private String _timestamp;

    @Id
    @NotNull
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name = "id")
    public int getCompletedHikeID() {
        return _completedHikeID;
    }
    public void setCompletedHikeID(int completedHikeID) {
        _completedHikeID = completedHikeID;
    }

    @NotNull
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "hike")
    public Hike getHike() {
        return _hike;
    }
    public void setHike(Hike hike) {
        _hike = hike;
    }

    @NotNull
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "hiker")
    public Hiker getHiker() {
        return _hiker;
    }
    public void setHiker(Hiker hiker) {
        _hiker = hiker;
    }

    @NotNull
    @JoinColumn(name = "timestamp")
    public String getTimestamp() {
        return _timestamp;
    }
    public void setTimestamp(String timestamp) {
        _timestamp = timestamp;
    }
}
