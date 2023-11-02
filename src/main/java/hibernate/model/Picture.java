package hibernate.model;

import jakarta.persistence.*;

import java.util.Arrays;

@Entity
@Table(name = "pictures")
public class Picture {
    @Id
    @Column(name = "picture_id")
    private int _pictureID;
    @Lob // Use @Lob for large binary data, like images
    @Basic(fetch = FetchType.LAZY) // Use FetchType.LAZY for better performance
    @Column(name = "image", nullable = false)
    private byte[] _image;
    @OneToOne(mappedBy = "_picture")
    private Hike _hike; // Add this to establish the bidirectional relationship

    public int getPictureID() {
        return _pictureID;
    }

    public void setPictureID(int pictureId) {
        _pictureID = pictureId;
    }

    public byte[] getImage() {
        return _image;
    }

    public void setImage(byte[] image) {
        _image = image;
    }

    public Hike getHike() {
        return _hike;
    }

    public void setHike(Hike hike) {
        _hike = hike;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Picture picture = (Picture) o;

        if (_pictureID != picture._pictureID) return false;
        return Arrays.equals(_image, picture._image);
    }

    @Override
    public int hashCode() {
        int result = _pictureID;
        result = 31 * result + Arrays.hashCode(_image);
        return result;
    }
}
