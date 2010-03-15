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
       content: "M -12.20339,45.989301 C 22.028168,48.396683 56.181623,40.411253 90.405095,44.61208 134.0405,47.097988 178.197,50.97716 221.49931,42.876692 c 31.28916,-2.371255 62.62239,1.658497 93.9313,0.06894 27.23032,1.008894 54.75242,2.891524 81.75781,-0.692196 23.68109,6.260174 15.67812,35.771828 22.03865,53.56549 6.26601,22.224839 7.1869,45.313159 7.35339,68.226359 0.52001,20.29168 2.5426,40.95531 0.74434,61.05449 -10.45207,21.60628 -38.27318,15.83346 -57.60377,21.50501 -24.93523,4.77908 -50.44032,3.30607 -75.43249,0.16037 -42.98863,-2.13156 -85.93386,2.27244 -128.86096,3.06819 -28.51567,-1.66968 -57.04853,-7.79269 -85.646368,-3.79723 -25.092916,1.54599 -31.392628,-25.15645 -28.117056,-44.80251 -3.478867,-26.65428 5.598321,-53.58873 -1.802005,-79.8972 -7.140584,-17.2676 10.117927,-32.833931 26.152951,-34.94761 19.666579,-4.851001 38.604688,5.428835 58.341868,4.636574 43.61397,1.099781 87.19583,-1.693632 130.58719,-5.827428 24.95775,-0.77042 49.92353,0.436809 74.88387,-0.06072 22.16608,5.946074 23.73892,33.591724 22.70629,52.519044 2.6869,20.14329 6.95083,51.18224 -19.93566,56.1923 -55.40328,13.5626 -112.5804,5.43943 -168.87873,7.06478 -19.77382,-3.19555 -48.68378,9.1235 -60.84512,-11.47541 -12.879999,-20.46276 -1.41541,-52.19205 26.30007,-45.83831 35.83849,3.74185 70.95277,-11.27084 106.8415,-5.56904 11.41706,2.49554 22.95962,3.602 34.66159,3.55189"
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
            var  f = new FileOutputStream("./src/zuma/svg/map2");
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