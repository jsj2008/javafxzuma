/*
 * ThrowTest.fx
 *
 * Created on Mar 9, 2010, 5:42:52 PM
 */

package zuma.test;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

import javafx.scene.shape.Circle;

import javafx.scene.Scene;
import javafx.stage.Stage;

import javafx.scene.image.ImageView;
import javafx.scene.input.KeyEvent;


import zuma.components.ParabolaTransition;

/**
 * @author javatest
 */
var ty = 0;
var tx = 0;
var backx = false;
var backy = false;
var vx = 10;
var vy = 20;
var borderx = 0;
var bordery = 0;
var timer = Timeline {
        repeatCount: Timeline.INDEFINITE;
        keyFrames : [
            KeyFrame {
                time: 0.03s
                action: function(){
                    ty++;
                    tx++;
                    cy.translateX = borderx + vx*tx;
                    if(cy.translateX >= 200-40){
                        tx = 0;
                        vx = -vx/2;
                        borderx = 160;
                    }
                    if(cy.translateX <= -380){
                        tx = 0;
                        vx = -vx/2;
                        borderx = -380;
                    }
                    cy.translateY = bordery + (1*ty*ty - vy*ty);
                    if(cy.translateY >= 300-40){
                        ty = 0;
                        vy = -vy/2;
                        bordery = 240;
                    }
                }
                }
        ]
};
var cy  = Circle {
//                translateX:160
//                translateY:260
                centerX: 400  centerY:300
                radius: 20
}
var backgroundview = ImageView {
//                        image: Main.currentData.background
                        focusTraversable: true
    onKeyPressed: function( e: KeyEvent ):Void {
            transtion.stop();
            cy.translateX = 0;
            cy.translateY = 0;
            ty = 0;
            tx = 0;
            vx = 20;
            vy = 20;
            borderx = 0;
            bordery = 0;
            transtion.start();
     }
};
var transtion = ParabolaTransition{
            node : cy
            maxx : 160
            maxy : 260
            p : 0.75
            minx : - 380
}
Stage {
    title: "Application title"
    width: 600
    height: 620
    scene: Scene {
        content: [
                backgroundview,cy
        ]
    }
}
//timer.playFromStart();