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
       content: "m -12.745763,31.345233 c 49.756239,-5.549871 99.483741,2.423983 149.350793,-0.560805 40.61344,-0.117585 81.26362,-3.706057 121.73883,-4.618322 29.36013,9.020641 15.88992,46.2359 22.47743,68.622469 2.65549,23.988195 13.46546,64.119215 -18.66564,72.346195 -39.11086,4.51668 -78.81346,-1.02105 -118.16287,-0.54472 C 112.8737,165.51658 81.615001,166.24422 50.65251,163.73312 23.03901,157.12975 35.466535,123.809 33.21278,103.61838 23.868005,79.174464 43.405228,48.713114 71.153714,57.625492 121.6706,61.25867 172.17873,52.25156 222.687,56.290826 c 25.01978,10.867381 28.72786,52.563364 10.69936,70.427354 -27.42631,12.99075 -59.90742,5.65523 -89.36907,9.3516 -22.87281,-1.20446 -85.471176,6.93889 -69.295934,-32.32959 25.516824,-17.880151 63.027524,-3.3873 93.302844,-9.776066 7.72288,-0.304277 15.44425,-0.649164 23.16226,-1.059532"
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
            var  f = new FileOutputStream("./src/zuma/svg/mobile/map2");
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