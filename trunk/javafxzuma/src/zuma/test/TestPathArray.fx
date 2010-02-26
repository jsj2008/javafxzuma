/*
 * TestPathArray.fx
 *
 * Created on 2010-1-22, 23:55:28
 */

package zuma.test;

import javafx.scene.shape.Circle;


import javafx.scene.Scene;
import javafx.stage.Stage;

import javafx.scene.paint.Color;
import javafx.scene.shape.SVGPath;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import java.io.FileInputStream;
import java.io.ObjectInputStream;

import java.util.ArrayList;

/**
 * @author tzp
 */
var cy  = Circle {
                centerX: 0  centerY: 0
                radius: 20
               }
def track = SVGPath {
        stroke: Color.BLACK
        strokeWidth: 1
        fill : null
        content: "m 342.85715,463.79074 c 9.74117,18.47959 -20.10417,22.24808 -30.71429,16.19047 -28.75279,-16.41576 -21.47048,-57.50033 -1.66664,-77.61905 35.42441,-35.98767 94.51471,-23.19162 124.5238,12.85718 44.03954,52.90308 25.12946,132.09111 -27.38101,171.42856 -69.9882,52.43064 -169.87484,27.16957 -218.33331,-41.90483 -60.98004,-86.92309 -29.2646,-207.75932 56.42865,-265.23807 103.78602,-69.61447 245.70093,-31.39181 312.14283,70.95248 78.29948,120.60921 33.53927,283.6782 -85.47631,359.04758 C 334.97267,796.522 150.70159,745.20532 66.428535,609.50493 -29.327861,455.31352 28.557864,249.80785 180.95249,156.64784 351.91624,52.13638 578.67953,116.59992 680.71434,285.69562 793.99231,473.42391 722.94462,721.46177 537.14273,832.36222"
};
var count = 0;
var in = new FileInputStream("./src/zuma/svg/cyclemap1");
var s = new ObjectInputStream(in);
var patharray = (s.readObject() as ArrayList).toArray();
var timer = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames : [
            KeyFrame {
                time: 0.1s
                action: function () {
                     
                   cy.translateX = patharray[count++] as Float;
                   cy.translateY = patharray[count++] as Float;
                }
            }
        ]
    };
Stage {
    title: "Application title"
    width: 700
    height: 700
    scene: Scene {
        content: [cy,track
        ]
    }
}
timer.play()
