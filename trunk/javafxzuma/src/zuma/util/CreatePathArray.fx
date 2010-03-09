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


import java.io.FileWriter;

/**
 * @author tzp
 */
var content;
def track = SVGPath {
        stroke: Color.BLACK
        strokeWidth: 1
        fill : null
       content: "M 3.7333333,43.73996 C 47.020227,38.642362 90.25759,47.630554 133.57286,48.018154 c 42.23757,1.931892 84.32848,-3.261096 126.52607,-3.312099 42.04132,4.636772 83.76877,-6.068541 125.78296,-4.457203 24.27643,0.203104 35.82747,24.794393 35.3566,46.09403 1.38396,35.857198 8.34085,71.390988 6.40037,107.404488 -1.23134,16.63313 3.10824,38.85387 -15.78224,47.22329 -20.19903,10.39632 -43.56659,5.30047 -65.31889,7.02301 -35.45127,0.64497 -70.83958,-2.06092 -106.18689,-4.01729 -25.41892,0.82717 -50.88568,4.83493 -76.2603,0.9277 -28.92608,-2.12699 -57.97393,-0.058 -86.893308,-1.18079 -25.404789,-1.59754 -32.88065,-28.03371 -25.698506,-48.85153 3.905804,-17.86709 -2.32777,-35.28262 -1.809992,-53.10715 0.05566,-16.44257 2.14696,-32.93963 6.921969,-48.69823 15.369466,-14.47315 36.437661,-3.057391 54.408077,-2.698946 61.80226,-2.291306 123.88355,-0.765405 185.39065,-8.373623 18.90963,-1.064341 40.92333,-0.929127 55.49819,12.885108 15.19808,20.508161 8.64466,47.365711 11.29225,70.997051 0.0632,18.88267 -18.50411,36.8509 -37.66752,31.20745 -24.2893,-2.1016 -48.16002,7.36179 -72.52241,3.48235 -18.95759,-2.19502 -38.05816,-2.38127 -56.96292,0.29689 -20.44629,0.78419 -40.73574,-2.52548 -61.14499,-1.09339 -23.13654,1.59476 -30.8525,-26.80035 -22.16215,-44.08913 7.43845,-17.50561 27.48467,-9.35051 41.85809,-10.56837 41.36199,-0.89576 82.53894,-9.83245 123.97738,-4.73885 4.40761,0.30677 8.82677,0.5493 13.24687,0.43373"
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
        duration: 200s
        action : function () {
            timer.stop();
            print(count);
            var  f = new FileOutputStream("./src/zuma/svg/null");
            var  s = new ObjectOutputStream(f);
            s.writeObject(arraylist);
            s.flush();
            var fw = new FileWriter("./src/zuma/svg/mapdata.txt");
            fw.write(content);
            fw.flush();
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
                  content = "{content},{animball.translateX},{animball.translateY},{animball.rotate}";
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