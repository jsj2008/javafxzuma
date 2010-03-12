/*
 * CyClipRct.fx
 *
 * Created on Mar 12, 2010, 11:47:20 AM
 */

package zuma.test;

import javafx.scene.shape.Circle;
import javafx.scene.shape.Rectangle;

import javafx.scene.CustomNode;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

import javafx.scene.image.ImageView;

import zuma.Resources;

/**
 * @author javatest
 */

public class CyClipRct extends CustomNode{
var cy  = Circle {
                centerX: 15 centerY: 15
                radius: 10
}
def imageview = ImageView {
        translateX:50
        translateY:50
        image: Resources.ballarray[0];
        clip : cy
        cache : false
        opacity : bind opacity
};
var timer = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames : [
            KeyFrame {
                time: bind 0.05s
                action: update
            }
        ]
};
public function update():Void{
    cy.centerY = cy.centerY + 10;
    imageview.translateY = imageview.translateY - 10;
}
override public function create(){
    return imageview;
}
public function start(){
    timer.play();
}
}
