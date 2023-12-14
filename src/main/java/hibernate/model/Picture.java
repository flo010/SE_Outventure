package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;


import java.util.UUID;

@Entity
@Table(name = "pictures")
public class Picture{
    private String _pictureID;
    private Hike _hikePicture;
    private byte[] _picture;

    @Id
    @NotNull
    @Column(name = "picture_id")
    public String getPictureID() {
        return _pictureID;
    }
    public void setPictureID(String UUID) {
        _pictureID = UUID;
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