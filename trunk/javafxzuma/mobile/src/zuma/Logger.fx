/*
 * Logger.fx
 *
 * Created on 2010-1-21, 1:21:23
 */

package zuma;

/**
 * @author tzp
 */
def debug = Config.DEBUG;
public function log(s){
    if(debug){
        println(s);
    }
}
public class Logger {

}
