/*
 * MapConverter.fx
 *
 * Created on Mar 9, 2010, 3:07:26 PM
 */

package zuma.util;

import zuma.MapLoader;

import java.io.FileWriter;

/**
 * @author javatest
 */

var list = MapLoader.getMap("/zuma/svg/mobile/map2");
var fw = new FileWriter("./src/zuma/svg/mobile/map2_mobile");
for(data in list){
        fw.append(data.toString());
        fw.append(",");
}
fw.flush();