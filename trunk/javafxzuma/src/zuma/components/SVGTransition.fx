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
 * @author tzp
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
public var action : function():Void;
var stopped = false;
var direct = 1;
var count : Number= bind fromIndex*3;
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
override public function update():Void{
   if(stopped or count < 0){
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
                 action();
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
        return;
    }
    stopped = false;
}
public function playFromStart(){
    if(stopped){
        count = 0;
    }
    count = 0;
    stopped = false;
}
public function pause(){
    rate = 0;
//    timer.pause();
}
public function stop(){
    stopped = true;
    rate = 0;
//    timer.stop();
}
}

