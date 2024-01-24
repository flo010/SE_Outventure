package ImageUpload;

import org.json.JSONObject;
import org.junit.jupiter.api.Test;
import servlets.hike.routing.HikeRouting;

import java.util.ArrayList;
import java.util.List;

class HikeRoutingTest {

    //[[8.681495,49.41461],[8.686507,49.41943],[8.687872,49.420318]]

    @Test
    void HikeRoutingRouteTest(){
        List<Double[]> test= new ArrayList<>();
        Double[][] test1= {{8.681495,49.41461},{8.686507,49.41943},{8.687872,49.420318}};
        test.add(test1[0]);
        test.add(test1[1]);
        test.add(test1[2]);
        System.out.println("Done with Testing");
        String response =(HikeRouting.route(test));
        JSONObject jsonObject = new JSONObject(response);
        System.out.println(jsonObject);
        System.out.println(jsonObject.get("routes"));
    }
}