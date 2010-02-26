/*
 * AnimBall.fx
 *
 * Created on Jan 26, 2010, 3:31:58 PM
 */

package zuma.components;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.image.ImageView;
import javafx.scene.shape.Circle;
import javafx.scene.Node;

import zuma.Config;
import javafx.scene.effect.DropShadow;
import javafx.scene.paint.Color;

/**
 * @author javatest
 */

public class AnimBall extends Ball{
public var ball_deameter : Float= 10;
public-read var paused = false;
var ajust = false;
public var rate = 1.0;
var cy  = Circle {
                centerX: ball_deameter/2 centerY: ball_deameter/2
                radius: Config.BALL_DIAMETER/2
}
def ratio = bind image.width / image.height;
def imageview = ImageView {
        smooth : bind smooth
        fitWidth : ball_deameter
        fitHeight : bind ball_deameter/ratio
        translateX : 0
        translateY : 0
        image: bind image
        clip : cy
        cache : false
        opacity : bind opacity
//        effect : DropShadow {
//                offsetX: 10
//                offsetY: 10
//                color: Color.BLACK
//                radius: 10
//        }


};
var imy : Number = 0;
var cyy : Number = 0;
var timer = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames : [
            KeyFrame {
                time: bind 0.05s
                action: function () {
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
            }
        ]
};
override public function create(): Node {
       imageview
}
override public function start(){
    timer.playFromStart();
}
override public function pause(){
    paused = true;
    timer.pause();
}
override public function resume(){
    paused = false;
    timer.play();
}
}
