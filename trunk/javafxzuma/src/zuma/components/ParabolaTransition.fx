/*
 * ParabolaTransition.fx
 *
 * Created on Mar 10, 2010, 1:42:53 PM
 */

package zuma.components;

import javafx.scene.Node;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

/**
 * @author perkin tang
 */

public class ParabolaTransition extends Schedulable{
public var node : Node;
public var vx : Number = 5;
public var vy : Number = 10;
public var maxx : Number = 6000;
public var maxy : Number = 6000;
public var minx : Number = -10000;
public var miny : Number = -10000;
public var g : Number = 0.5;
public var p : Number = 0.5;
public var borderx : Number = 0;
public var bordery : Number = 0;
var ty = 0;
var tx = 0;
var ivx : Number = bind vx;
var ivy : Number = bind vy;
var iborderx : Number = bind borderx;
var ibordery : Number = bind bordery;
override public var ontick = 30;
var timer = Timeline {
        repeatCount: Timeline.INDEFINITE;
        keyFrames : [
            KeyFrame {
                time: 0.03s
                action: update
            }
        ]
};
override public function update(object : Object){
    ty++;
    tx++;
    node.translateX = iborderx + ivx*tx;
    if(node.translateX >= maxx){
        tx = 0;
        ivx = -ivx*p;
        iborderx = maxx;
    }
    if(node.translateX <= minx){
        tx = 0;
        ivx = -ivx*p;
        iborderx = minx;
    }
    node.translateY = ibordery + (g*ty*ty - ivy*ty);
    if(node.translateY >= maxy){
        ty = 0;
        ivy = -ivy*p;
        ibordery = maxy;
    }
    if(node.translateY <= miny){
        ty = 0;
        ivy = -ivy*p;
        ibordery = miny;
    }
}
function update(){
    update(null);
}
public function start(){
    tx = 0;
    ty = 0;
    ivx = vx;
    ivy = vy;
    iborderx = borderx;
    ibordery = bordery;
//    timer.playFromStart();
}
public function pause(){
    timer.pause();
}
public function stop(){
    timer.stop();
}
public function selfStart(){
    tx = 0;
    ty = 0;
    ivx = vx;
    ivy = vy;
    iborderx = borderx;
    ibordery = bordery;
      timer.playFromStart();
}
}
