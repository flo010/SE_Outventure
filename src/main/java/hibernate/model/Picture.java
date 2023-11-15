package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "pictures")
public class Picture {
    private int _pictureID;
    private Hike _hikePicture;
    private String _base64;

    @Id
    @NotNull
    @Column(name = "picture_id")
    public int getPictureID() {
        return _pictureID;
    }
    public void setPictureID(int pictureId) {
        _pictureID = pictureId;
    }

    @NotNull
    @Column(name = "base64")
    public String getBase64() {
        return _base64;
    }
    public void setBase64(String base64) {
        _base64 = base64;
    }

    @NotNull
    @ManyToOne
    @JoinColumn(name = "hike")
    public Hike getHikePicture() {
        return _hikePicture;
    }
    public void setHikePicture(Hike hikePicture) {
        _hikePicture = hikePicture;
    }
}