/*
 * AnimBall.fx
 *
 * Created on Jan 26, 2010, 3:31:58 PM
 */

package zuma.components;

import javafx.scene.image.ImageView;
import javafx.scene.shape.Circle;
import javafx.scene.Node;

import zuma.Config;

import javafx.util.Math;

/**
 * @author perkin tang
 */

public class AnimBall extends Ball,Schedulable{
public var ball_deameter : Float= 10;
public-read var paused = false;
var ajust = false;
public var rate : Integer = 0 on replace {
    tick = 0;
    if(rate == 0){
            ontick = -1;
    }
    if(rate > 0){
            ontick = maxrate/rate;
    }
    if(rate < 0){
            ontick = maxrate/Math.abs(rate);
    }
};
var cy  = Circle {
                centerX: ball_deameter/2 centerY: ball_deameter/2
                radius: Config.BALL_DIAMETER/2
}
def ratio = bind image.width / image.height;
def imageview = ImageView {
        smooth : bind smooth
        translateX : 0
        translateY : 0
        image: bind image
        clip : cy
        cache : false
        opacity : bind opacity
};
var imy : Number = 0;
var cyy : Number = 0;
//var timer = Timeline {
//        repeatCount: Timeline.INDEFINITE
//        keyFrames : [
//            KeyFrame {
//                time: bind 0.05s
//                action: update
//            }
//        ]
//};
override public function update(object : Object):Void{
    if(rate == 0){
            return;
    }
    if(ajust){
        if(rate < 0){
            imageview.translateY = - ball_deameter/ratio + ball_deameter;
            cy.centerY = ball_deameter/ratio - ball_deameter/2;
        }else{
            imageview.translateY = 0;
            cy.centerY = ball_deameter/2;
        }
        ajust = false;
        return;
    }
    imy = imageview.translateY-ball_deameter*rate;
    cyy = cy.centerY+ball_deameter*rate;
    if(imy < -ball_deameter/ratio + ball_deameter
        or imy > ball_deameter or cyy < ball_deameter/2 or cyy > ball_deameter/ratio - ball_deameter/2){
        ajust  = true;
    }else{
        imageview.translateY=imy;
        cy.centerY=cyy;
    }
}
override public function create(): Node {
       imageview
}
override public function start(){
      if(rate == 0){
              rate = 1;
      }
//    timer.playFromStart();
}
override public function pause(){
    paused = true;
    rate = 0;
//    timer.pause();
}
override public function resume(){
    if(rate == 0){
         rate = 1;
    }
    paused = false;
//    timer.play();
}
}
