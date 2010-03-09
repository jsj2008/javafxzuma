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

/**
 * @author javatest
 */
var t = 0;
var timer = Timeline {
        repeatCount: Timeline.INDEFINITE;
        keyFrames : [
            KeyFrame {
                time: 0.02s
                action: function(){
                    cy.translateY = 1*t*t - 20*t;
                    t++;
                    cy.translateX = 4*t;
                }
                }
        ]
};
var cy  = Circle {
                centerX: 300  centerY: 300
                radius: 20
}
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                cy
        ]
    }
}
timer.play();