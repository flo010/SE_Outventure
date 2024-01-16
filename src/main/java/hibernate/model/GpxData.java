package hibernate.model;

import jakarta.persistence.*;

@Entity
@Table (name = "gpx_data")
public class GpxData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "gpx_id")
    private Long gpxId;

    @Column(name = "gpx_content", columnDefinition = "TEXT")
    private String gpxContent;

    @OneToOne
    @JoinColumn(name = "hike_id")
    private Hike hike;

    public GpxData() {
    }

    public String getGpxContent() {
        return gpxContent;
    }

    public void setGpxContent(String gpxContent) {
        this.gpxContent = gpxContent;
    }
    public Hike getHike() {
        return hike;
    }

    public void setHike(Hike hike) {
        this.hike = hike;
    }
}
