/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package zuma;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.ArrayList;

/**
 *
 * @author perkin tang
 */
public class MapLoader {

    public static ArrayList getMap(String path) throws IOException, ClassNotFoundException {
        ObjectInputStream s = new ObjectInputStream(MapLoader.class.getResourceAsStream(path));
        ArrayList patharray = (ArrayList) s.readObject();
        s.close();
        return patharray;
    }
}
