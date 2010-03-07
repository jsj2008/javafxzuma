/*
 * AnimBallTtest.fx
 *
 * Created on Jan 26, 2010, 3:33:29 PM
 */

package zuma.test;

import javafx.scene.paint.Color;

import javafx.scene.shape.ClosePath;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;

import javafx.animation.transition.OrientationType;

import javafx.scene.Scene;
import javafx.stage.Stage;


import zuma.Resources;

import javafx.scene.shape.SVGPath;

import javafx.scene.shape.Path;

import javafx.animation.Interpolator;
import javafx.animation.transition.AnimationPath;
import javafx.animation.transition.PathTransition;

import zuma.Config;

import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;

import javafx.animation.Timeline;

import zuma.components.AnimBall;
import zuma.components.SVGTransition;
import zuma.Level1Config;

/**
 * @author javatest
 */
def path = [
        MoveTo       {         x:  400         y: 300 },
        LineTo       {         x:  600         y: 12 },
       // QuadCurveTo  {  controlX:  82*S  controlY: 123*S
       //                        x:  600*S         y: 124*S },
        LineTo       {         x: 600         y: 200 },
      //  CubicCurveTo { controlX1: 148*S controlY1: 147*S
        //               controlX2:  56*S controlY2: 225*S
          //                     x: 120*S         y: 254*S },
        LineTo       {         x: 300         y: 300 },
       // CubicCurveTo { controlX1: 154*S controlY1: 277*S
       //                controlX2: 143*S controlY2: 300*S
        //                       x: 131*S         y: 295*S },
        LineTo       {         x:  84         y: 278 },
       // QuadCurveTo  {  controlX:  34*S  controlY: 255*S
       //                        x:  43*S         y: 231*S },
        LineTo       {         x:  50         y: 212 },
        ClosePath {},
    ];
def track1 = Path {
        stroke: Color.rgb(51,51,51)
        strokeWidth: 1
        elements: path
    };

def animball = AnimBall{rotate : -90
                        image : Resources.ballarray[1],
                        ball_deameter: Config.BALL_DIAMETER};
var anim1 = PathTransition {
        node:  animball
        path: AnimationPath.createFromPath(track1)
        orientation: OrientationType.ORTHOGONAL_TO_TANGENT
        interpolator: Interpolator.LINEAR
        duration: 10s
        repeatCount : Timeline.INDEFINITE
        action : function () {
        }
};
var anim = SVGTransition {
        rotate : -90
        node:animball
        pathArray : Resources.patharray
        orientation: OrientationType.ORTHOGONAL_TO_TANGENT
        action : function (object : Object) {
        }
};
 def track = SVGPath {
        stroke: Color.BLACK
        strokeWidth: 1
        fill : null
        content: "m 211.42857,189.50504 c 7.16263,6.87613 -5.7351,13.04751 -11.42858,11.90475 -15.42898,-3.09682 -18.29958,-22.71989 -12.38092,-34.76192 10.58709,-21.54036 39.15809,-24.62156 58.09525,-12.85709 27.79103,17.26482 31.12549,55.81734 13.33327,81.42858 -23.71423,34.13576 -72.5548,37.70661 -104.76192,13.80944 -40.52938,-30.07215 -44.3276,-89.32946 -14.28561,-128.09525 36.38487,-46.950572 106.12506,-50.971662 151.42858,-14.76179 53.38863,42.67209 57.63021,122.93374 15.23796,174.76192 -48.94353,59.8377 -139.75112,64.29842 -198.09526,15.71413 C 42.277025,241.44326 37.597965,140.0732 92.381043,75.219226 153.83938,2.4628716 265.78363,-2.4340278 337.14296,58.552752 416.36535,126.25964 421.47977,248.78667 354.28561,326.64801"
};
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Level1Config.background
                        focusTraversable: true
    onKeyPressed: function( e: KeyEvent ):Void {
                if(e.code == KeyCode.VK_UP){
                        anim.rate++;
                        animball.rate++;
                }
                if(e.code == KeyCode.VK_DOWN){
                        anim.rate--;
                        animball.rate--;
                }
                if(e.code == KeyCode.VK_ENTER){
                        if(animball.paused){
                        animball.resume();
                        }else{
                        animball.pause();
                        }
                }
     }
};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                backgroundview,track,animball,
        ]
    }
}
//anim.play();
//animball.rate = -3;
animball.start();
class AnimBallTtest {

}
