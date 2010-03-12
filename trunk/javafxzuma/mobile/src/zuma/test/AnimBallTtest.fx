/*
 * AnimBallTtest.fx
 *
 * Created on Jan 26, 2010, 3:33:29 PM
 */

package zuma.test;




import javafx.scene.Scene;


import zuma.Resources;




import zuma.Config;



import zuma.components.AnimBall;

import javafx.scene.shape.Circle;

import javafx.scene.image.ImageView;


import javafx.scene.shape.Rectangle;


import javafx.stage.Stage;

import javafx.scene.input.MouseEvent;


/**
 * @author javatest
 */
def animball = AnimBall{
                        rotate:-90
                        translateX:200
                        translateY:200
                        rate : 0
                        image : Resources.ballarray[0],
                        ball_deameter: Config.BALL_DIAMETER};
var cy  = Circle {
                centerX: 75 centerY: 75
                radius: Config.BALL_DIAMETER/2
}

def imageview = ImageView {
        rotate : 90
        translateX : 100
        translateY : 100
        image: bind Resources.ballarray[0],
        clip : cy
        cache : false
};
var cycrct = CyClipRct{rotate:-90,translateX:20,translateY:20};
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Resources.test
                        onMouseClicked: function( e: MouseEvent ):Void {
                                cycrct.rotate = cycrct.rotate + 45;
                                cycrct.update();
                                animball.rotate = animball.rotate + 45;
                                animball.update(null);
                                println("mouse");
                        }
};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
               backgroundview,cycrct,animball
        ]
    }
}
animball.start();
cycrct.start();
