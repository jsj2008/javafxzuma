/*
 * Schedulable.fx
 *
 * Created on Mar 3, 2010, 1:10:54 PM
 */

package zuma.components;

/**
 * @author javatest
 */

mixin public class Schedulable {
public var maxrate : Integer = 20;
public var ontick : Integer = -1;
public var tick = 0;
abstract public function update(object : Object):Void;
public function scheduledUpdate(object : Object):Void{
    if(tick == -1){
            return;
    }
    if(tick == ontick){
            tick = 0;
            update(object);
            return;
    }
    tick++;
}
}
