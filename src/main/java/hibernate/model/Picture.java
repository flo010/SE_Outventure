package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "pictures")
public class Picture {
    private int _pictureID;
    private Hike _hikePicture;
    private byte[] _picture;

    @Id
    @NotNull
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "picture_id")
    public int getPictureID() {
        return _pictureID;
    }
    public void setPictureID(int pictureId) {
        _pictureID = pictureId;
    }

    @NotNull
    @Column(name = "picture")
    public byte[] getPicture() {
        return _picture;
    }
    public void setPicture(byte[] picture) {
        _picture = picture;
    }


    @ManyToOne
    @JoinColumn(name = "hike")
    public Hike getHikePicture() {
        return _hikePicture;
    }
    public void setHikePicture(Hike hikePicture) {
        _hikePicture = hikePicture;
    }
}