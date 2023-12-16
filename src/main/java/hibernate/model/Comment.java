package hibernate.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;


@Entity
@Table(name = "comments")
public class Comment {

    private int _commentID;
    private Hike _hike;
    private Hiker _hiker;
    private String _commentText;
    private LocalDate _timeStamp;

    @Id
    @NotNull
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    public int getCommentID(){return _commentID;}
    public void setCommentID(int commentID){_commentID = commentID;}

    @NotNull
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "hike")
    public Hike getHike(){return _hike;}
    public void setHike(Hike hike){
        _hike = hike;}

    @NotNull
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "hiker")
    public Hiker getHiker(){return _hiker;}
    public void setHiker(Hiker hiker){_hiker = hiker;}

    @NotNull
    @Column(name = "comment_text")
    public String getCommentText(){return _commentText;}
    public void setCommentText(String commentText){_commentText = commentText;}


    @NotNull
    @Column(name = "timestamp")
    public LocalDate getTimestamp(){return _timeStamp;}
    public void setTimestamp(LocalDate timestamp){_timeStamp = timestamp;}
}
