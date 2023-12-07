package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.util.List;

@Entity
@Table(name = "hikers")
public class Hiker {
    private int _hikerID;
    private String _username;
    private String _email;
    private String _password;
    private List<Hike> _completedHikes;

    @Id
    @NotNull
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name = "hiker_id")
    public int getHikerID() {
        return _hikerID;
    }
    public void setHikerID(int hikerID) {
        _hikerID = hikerID;
    }

    @NotNull
    @Column(name = "username")
    public String getUsername() {
        return _username;
    }
    public void setUsername(String username) {
        _username = username;
    }

    @NotNull
    @Column(name = "email")
    public String getEmail() {
        return _email;
    }
    public void setEmail(String email) {
        _email = email;
    }

    @NotNull
    @Column(name = "password")
    public String getPassword() {
        return _password;
    }
    public void setPassword(String password) {
        _password = password;
    }

    @ManyToMany
    @JoinTable(name = "hiked", joinColumns = @JoinColumn(name="hiker_id"), inverseJoinColumns = @JoinColumn(name = "hike_id"))
    public List<Hike> getCompletedHikes() {
        return _completedHikes;
    }
    public void setCompletedHikes(List<Hike> completedHikes) {
        _completedHikes = completedHikes;
    }
}

