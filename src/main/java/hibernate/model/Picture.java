package hibernate.model;

import jakarta.persistence.*;

import java.util.Arrays;

@Entity
public class Picture {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "picture_id")
    private int _pictureId;
    @Basic
    @Column(name = "image")
    private byte[] _image;

    public int get_pictureId() {
        return _pictureId;
    }

    public void set_pictureId(int pictureId) {
        _pictureId = pictureId;
    }

    public byte[] get_image() {
        return _image;
    }

    public void set_image(byte[] image) {
        _image = image;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Picture picture = (Picture) o;

        if (_pictureId != picture._pictureId) return false;
        if (!Arrays.equals(_image, picture._image)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = _pictureId;
        result = 31 * result + Arrays.hashCode(_image);
        return result;
    }
}
