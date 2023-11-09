package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "pictures")
public class Picture {
    private int _pictureID;
    private Hike _hikePicture;
    private byte[] _image;

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
    @Lob // @Lob for large binary data, like images
    @Column(name = "image", nullable = false)
    public byte[] getImage() {
        return _image;
    }
    public void setImage(byte[] image) {
        _image = image;
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