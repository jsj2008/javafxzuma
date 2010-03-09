/*
 * ViewClipT.fx
 *
 * Created on Jan 26, 2010, 2:44:59 PM
 */

package zuma.test;

import javafx.scene.image.ImageView;

import zuma.Resources;

import javafx.scene.shape.Circle;

import javafx.scene.Scene;
import javafx.stage.Stage;

import zuma.Config;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

/**
 * @author javatest
 */
var cy  = Circle {
                centerX: Config.BALL_DIAMETER/2 centerY: Config.BALL_DIAMETER/2+(Config.BALL_DIAMETER*49)
                radius: Config.BALL_DIAMETER/2
                //fill : null
}
def ratio = Resources.scrollBallGreen.width / Resources.scrollBallGreen.height;
def imageview = ImageView {
        fitWidth : Config.BALL_DIAMETER
        fitHeight : Config.BALL_DIAMETER/ratio
        translateX : 100
        translateY : -Config.BALL_DIAMETER/ratio+Config.BALL_DIAMETER
        smooth: true
        image: Resources.scrollBallGreen
        clip : cy
        cache : false;
    };
var count = 0;
var timer = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames : [
            KeyFrame {
                time: 0.1s
                action: function () {
                    if(count > 45){
                        count = 0;
                        imageview.translateX = 0;
                        cy.centerX = Config.BALL_DIAMETER;
                    }
                    imageview.translateX=imageview.translateX-2*Config.BALL_DIAMETER;
                    cy.centerX=cy.centerX+2*Config.BALL_DIAMETER;
                    count++;
                }
            }
        ]
};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [imageview
        ]
    }
}
//timer.play();
 class ViewClipT {

}
