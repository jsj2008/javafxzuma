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
        content: "M 291.72393,554.62054 C 183.14222,572.70037 85.520327,487.43049 70.926113,381.9629 52.794583,250.93229 156.10465,134.56885 283.95109,119.32989 437.40609,101.03845 572.60255,222.49373 588.41929,372.72219 606.93537,548.58912 467.27226,702.67387 294.65966,719.02559 96.387867,737.80802 -76.621259,579.89678 -93.478933,384.89863 -112.55615,164.22628 63.630712,-27.732111 281.01536,-45.075159 524.08545,-64.467405 735.01104,130.01466 752.82434,369.78646 762.61549,501.57797 714.47439,633.56308 624.06832,729.643"
				transforms: [
					Transform.affine(0.5764226, 0.0, 0.0, 0.6323865, 131.03493, 74.16948)
				]
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
        duration: 300s
        action : function () {
            timer.stop();
            print(count);
            var  f = new FileOutputStream("./src/zuma/svg/cyclemap1");
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
                time: 0.1s
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