/*
 * Test.fx
 *
 * Created on 2010-1-18, 23:02:39
 */

package zuma.test;


import javafx.scene.image.ImageView;

import javafx.scene.Scene;
import javafx.stage.Stage;


import javafx.scene.Group;

import javafx.scene.input.MouseEvent;

import javafx.scene.paint.Color;
import javafx.scene.shape.ClosePath;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;

import zuma.BulletBall;
import zuma.Resources;

import zuma.ScrollBall;
import zuma.Model;


import javafx.util.Math;

/**
 * @author tzp
 */
 var S = 1.0;
def arrayofarray = [[1,2],[2,3]];
def ballImage = Resources.bomImage[0];
def background = Resources.background;
def image = ImageView {
        smooth: true
        image: bind ballImage
        translateX : 500 - ballImage.width/2
        translateY : 500 - ballImage.width/2
        visible : true
        //opacity : 0
    };
    def path = [
        MoveTo       {         x:  400*S         y: 300*S },
        LineTo       {         x:  600*S         y: 12*S },
       // QuadCurveTo  {  controlX:  82*S  controlY: 123*S
       //                        x:  600*S         y: 124*S },
        LineTo       {         x: 600*S         y: 200*S },
      //  CubicCurveTo { controlX1: 148*S controlY1: 147*S
        //               controlX2:  56*S controlY2: 225*S
          //                     x: 120*S         y: 254*S },
        LineTo       {         x: 300*S         y: 300*S },
       // CubicCurveTo { controlX1: 154*S controlY1: 277*S
       //                controlX2: 143*S controlY2: 300*S
        //                       x: 131*S         y: 295*S },
        LineTo       {         x:  84*S         y: 278*S },
       // QuadCurveTo  {  controlX:  34*S  controlY: 255*S
       //                        x:  43*S         y: 231*S },
        LineTo       {         x:  50*S         y: 212*S },
        ClosePath {},
    ];

    def track = Path {
        stroke: Color.rgb(51,51,51)
        strokeWidth: S
        elements: path
    };
var backgroundview = ImageView {
                        image: background
                        focusTraversable: true
                        onMousePressed: function( e: MouseEvent ):Void {
                                shiftball.setRate(-2);
                                println(shiftball.translateX);
                                println(shiftball.translateY);

                        }
          
        visible: true
    }

    def ball0 = BulletBall{};
    def shiftball = ScrollBall{};
    var group: Group = Group {
            content: [
            ball0,shiftball]};
println(Math.sin(Math.toRadians(30)));
Stage {
    title: "Application title"
    width: 700
    height:700
    scene: Scene {
        content: [
               backgroundview,group
        ]

    }

}
    while (Model.sizeofRecycled() < 20){
         def ball0 = ScrollBall{};
//         ball0.state = GameBall.DEAD_STATE;
         ball0.makeVisable();
         Model.recycleBall(ball0);
    }
                                