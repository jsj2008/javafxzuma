/*
 * SVGTransitionTest.fx
 *
 * Created on 2010-1-23, 21:10:06
 */

package zuma.test;

import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.shape.SVGPath;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.util.ArrayList;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import zuma.Resources;
import javafx.animation.Timeline;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.KeyCode;
import zuma.ScrollBall;
import javafx.scene.Group;

import zuma.components.SVGTransition;
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
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Resources.background
                        focusTraversable: true
                        onMousePressed: function( e: MouseEvent ):Void {
                            rate=rate+1;
    }
    onKeyPressed: function( e: KeyEvent ):Void {
                if(e.code == KeyCode.VK_UP){
//                        ball.rate++;
                }
                if(e.code == KeyCode.VK_DOWN){
                        println(ball.anim1.isRunning());
                }
                if(e.code == KeyCode.VK_ENTER){
                        ball.start();
                }
     }
};
var in = new FileInputStream("./src/zuma/svg/tmp");
var s = new ObjectInputStream(in);
var patharray = (s.readObject() as ArrayList);
var rate = 1;
var fromIndex = 3000;
var group: Group = Group {
            content: [
            ]};
var ball = ScrollBall{fromIndex : 1514};
println(patharray.size());
var anim = SVGTransition{
    fromIndex : bind fromIndex
    rate : bind rate;
    node : ball
    repeatCount : Timeline.INDEFINITE
    pathArray : patharray
    action : function(){
        println("complete ");
    }
};
Stage {
    title: "Application title"
    width: 900
    height: 900
    scene: Scene {
        content: [backgroundview,track,ball
        ]
    }
}
