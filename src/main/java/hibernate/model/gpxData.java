package hibernate.model;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table (name = "gpx_data")
public class gpxData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "gpx_id")
    private Long gpxId;

    /*@Column(name = "file_name", nullable = false)
    private String fileName;*/

    @Column(name = "upload_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date uploadDate;

    @Column(name = "gpx_content", columnDefinition = "TEXT")
    private String gpxContent;



    @OneToOne
    @JoinColumn(name = "hike_id")
    private Hike hike;

    public gpxData() {
    }

    public Long getGpxId() {
        return gpxId;
    }

    public void setGpxId(Long gpxId) {
        this.gpxId = gpxId;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
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
