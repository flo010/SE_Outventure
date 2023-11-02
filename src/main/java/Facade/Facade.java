package Facade;

public interface Facade {

    //INSERT
    public void insert(Object hike);

    //DELETE
    public void delete (Object hike);

    //READ
    public List<Hike> getAllHikesByID();
    public Hike getHikeByID(int hikeID);

}
