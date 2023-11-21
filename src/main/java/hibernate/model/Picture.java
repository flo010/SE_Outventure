package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "pictures")
public class Picture {
    private int _pictureID;
    private Hike _hikePicture;
    private byte[] _base64;

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
    @Column(name = "base64")
    public byte[] getBase64() {
        return _base64;
    }
    public void setBase64(byte[] base64) {
        _base64 = base64;
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