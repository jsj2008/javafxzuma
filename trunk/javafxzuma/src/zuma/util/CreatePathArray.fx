/*
 * CreatePathArray.fx
 *
 * Created on 2010-1-22, 23:25:26
 */

package zuma.util;

import javafx.scene.paint.Color;
import javafx.scene.shape.SVGPath;

import javafx.animation.Interpolator;
import javafx.animation.transition.AnimationPath;
import javafx.animation.transition.OrientationType;
import javafx.animation.transition.PathTransition;

import javafx.scene.shape.Circle;

import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import zuma.components.AnimBall;
import java.util.ArrayList;


import java.io.FileOutputStream;
import java.io.ObjectOutputStream;

import zuma.Resources;

import zuma.Config;

import javafx.scene.transform.Transform;

/**
 * @author tzp
 */
def track = SVGPath {
        stroke: Color.BLACK
        strokeWidth: 1
        fill : null
       content: "m 482.84444,160.09552 c -17.86971,-0.90859 -36.92027,-0.14037 -53.30925,7.66956 -13.63603,12.59478 -32.21951,18.39808 -50.66506,15.60313 -18.67167,-2.62312 -27.9939,-21.75044 -45.37662,-27.65558 -17.16001,-8.76598 -37.10937,-1.40004 -55.3657,-4.3227 -20.55011,-0.95954 -40.85428,-7.43085 -59.10559,-16.80553 -14.56045,-11.15749 -24.21354,-29.38415 -42.9709,-34.54292 -22.12406,-10.086407 -48.40186,-9.78236 -70.18422,0.90711 -16.450289,6.70499 -27.244885,23.68251 -44.412461,28.8211 C 43.314593,130.33496 25.060357,129.22201 6.8536826,129.55431 -3.1892086,128.17378 -14.143551,129.2574 -22.4,127.11774"
};
def arraylist : ArrayList = new ArrayList(10000);
var cy  = Circle {
                centerX: 0  centerY: 0
                radius: 20
}
def animball = AnimBall{rotate : -90,
                        image : Resources.ballarray[0],
                        ball_deameter: Config.BALL_DIAMETER};
var anim = PathTransition {
        node:  animball
        path: AnimationPath.createFromPath(track)
        orientation: OrientationType.ORTHOGONAL_TO_TANGENT
        interpolator: Interpolator.LINEAR
        duration: 50s
        action : function () {
            timer.stop();
            print(count);
            var  f = new FileOutputStream("./src/zuma/svg/map4");
            var  s = new ObjectOutputStream(f);
            s.writeObject(arraylist);
            s.flush();
        }
};
var line = 50;
var count = 0;
var timer = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames : [
            KeyFrame {
                time: 0.03s
                action: function () {
                arraylist.add(animball.translateX);
                arraylist.add(animball.translateY);
                arraylist.add(animball.rotate);
                  // print("{cy.translateX},{cy.translateY},");
                   count ++;
                }
            }
        ]
};
Stage {
    title: "Application title"
    width: 900
    height: 900
    scene: Scene {
        content: [cy,
                track,animball
        ]
    }
}
anim.play();
timer.play();
//print("var xyarray = [");