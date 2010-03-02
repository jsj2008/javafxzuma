/*
 * SVGTransition.fx
 *
 * Created on 2010-1-23, 19:15:22
 */

package zuma.components;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.Node;
import java.util.ArrayList;

import javafx.animation.transition.OrientationType;

import javafx.util.Math;


/**
 * @author tzp
 */

public class SVGTransition {
public var rate : Number = 1;
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
var timer = Timeline {
        rate : bind setRate(rate)
        repeatCount: Timeline.INDEFINITE;
        keyFrames : [
            KeyFrame {
                time: bind 0.03s
                action: function () {
                   if(count < 0){
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
            }
        ]
};
public function play(){
    if(stopped){
        count =fromIndex*3;
        timer.playFromStart();
        return;
    }
    timer.play();
    stopped = false;
}
public function playFromStart(){
    if(stopped){
        count = 0;
        timer.playFromStart();
    }
    count = 0;
    timer.play();
    stopped = false;
}
public function pause(){
    timer.pause();
}
public function stop(){
    stopped = true;
    timer.stop();
}
public function isRunning(){
    return timer.running;
}
public function setRate(r : Double):Number{
    if(r == 0){
            direct = 0;
            return 1;
    }
    if(r > 0){
            direct = 1;
            return r;
    }
    if(r < 0){
            direct = -1;
            return Math.abs(r);
    }
    return 1;
}
}

