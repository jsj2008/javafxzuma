/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package zuma;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

/**
 *
 * @author javatest
 */
public class MapLoader {

    public  static ArrayList getMap(String path) throws IOException, ClassNotFoundException {
        System.out.println("loading map ...");
        ArrayList list = new ArrayList();
        StringBuffer b = new StringBuffer();
        System.out.println(path);
        InputStream inputstream = MapLoader.class.getResourceAsStream(path);
        System.out.println(inputstream);
        int tmp;
        Double d;
        while((tmp = inputstream.read()) > 0){
            if(tmp == 44){//','
                d = Double.parseDouble(b.toString());
                list.add(d);
                b = new StringBuffer();
//                System.out.println(d);
                continue;
            }
            b.append((char)tmp);
        }
//        System.out.println((int)',');
//        System.out.println(b.toString());
        return list;
    }
}
