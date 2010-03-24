/*
 * SVGTransition.fx
 *
 * Created on 2010-1-23, 19:15:22
 */

package zuma.components;

import javafx.animation.Timeline;
import javafx.scene.Node;
import java.util.ArrayList;

import javafx.animation.transition.OrientationType;

import javafx.util.Math;


/**
 * @author perkin tang
 */

public class SVGTransition extends Schedulable{
public var node : Node;
public var pathArray : ArrayList;
public var repeatCount : Float = 1;
var repeatCount0 = bind repeatCount-1;
public var orientation : OrientationType;
public var rotate : Float= 0;
public var fromIndex : Integer = 0;
public var offsetX : Float;
public var offsetY : Float;
public var action : function(object : Object):Void;
public var onError : function(object : Object):Void;
var stopped = false;
var direct = 1;
var count : Integer= bind fromIndex*3;
public var rate : Integer = 0 on replace{
    tick = 0;
    if(rate == 0){
            ontick = -1;
            direct = 0;
    }
    if(rate > 0){
            ontick = maxrate/rate;
            direct = 1;
    }
    if(rate < 0){
            ontick = maxrate/Math.abs(rate);
            direct = -1;
    }
};
override public function update(object : Object):Void{
   if(stopped){
           return;
   }
   if(count < 0){
           count = 0;
           onError(object);
           return;
   }
   if(count >= pathArray.size()){
           if(repeatCount == Timeline.INDEFINITE){
                 count = fromIndex;
                 return;
           }
           if(repeatCount0 == 0){
                 count = -1;
                 stopped = true;
                 action(object);
                 return;
           }
           repeatCount --;
           count = fromIndex;
           return;
   }
   node.translateX = (pathArray.get(count) as Float) - offsetX;
   node.translateY = (pathArray.get(count+1) as Float)- offsetY;
   if(orientation == OrientationType.ORTHOGONAL_TO_TANGENT){
        node.rotate = (pathArray.get(count+2) as Float) +rotate as Float
   }
   count = count+3*direct;
}
public function play(){
    if(stopped){
        count =fromIndex*3;
    }
    stopped = false;
}
public function playFromStart(){
    count = 0;
    stopped = false;
}
public function pause(){
//    rate = 0;
//    timer.pause();
}
public function stop(){
    stopped = true;
//    rate = 0;
//    timer.stop();
}
public function debuginfo(){
    println("SVG status : (stoped={stopped},rate={rate},direct={direct},count={count})");
}
public function getCount():Integer{
    return count;
}
}

