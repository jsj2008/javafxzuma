/*
 * SpecialEffectTest.fx
 *
 * Created on Jan 29, 2010, 1:49:37 PM
 */

package zuma.test;

import javafx.animation.transition.FadeTransition;
import javafx.animation.transition.ParallelTransition;
import javafx.animation.transition.ScaleTransition;
import javafx.scene.image.ImageView;
import zuma.Config;
import zuma.Resources;

import javafx.scene.Scene;
import javafx.stage.Stage;

import javafx.scene.input.MouseEvent;

import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;

/**
 * @author javatest
 */
def specialimageview = ImageView {
        fitWidth : Config.BALL_DIAMETER
        fitHeight : Config.BALL_DIAMETER
        translateX :  100
        translateY :  100
        image: bind Resources.specialEffectImage[0];
        cache : false
        opacity : 1
};
var specialparTransition = ParallelTransition {
        node: specialimageview
        content: [
            FadeTransition { duration: 0.8s fromValue:0.0  toValue: 1.0
                },
            ScaleTransition { duration: 1s  fromX : 1 fromY : 1 byX: 4.5 byY: 4.5
                },
        ]
        action : function(){
//            specialimageview.opacity = 0;
            specialimageview.scaleX = 1;
            specialimageview.scaleY = 1;
        }
}
function sepcialEffect(x : Number,y : Number){
        specialimageview.translateX = x;
        specialimageview.translateY = y;
        specialimageview.toFront();
        specialparTransition.playFromStart();
}
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Resources.background
                        focusTraversable: true
                        onMousePressed: function( e: MouseEvent ):Void {
                            sepcialEffect(e.x,e.y);
//            specialimageview.scaleX = 2;
//            specialimageview.scaleY = 2;
    }
        onKeyPressed: function( e: KeyEvent ):Void {
                if(e.code == KeyCode.VK_UP){
                        specialimageview.scaleX = specialimageview.scaleX + 1;
                }
                if(e.code == KeyCode.VK_DOWN){
                        specialimageview.scaleX = specialimageview.scaleX -1;
                }
                if(e.code == KeyCode.VK_ENTER){
                }
     }
};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [backgroundview,specialimageview
        ]
    }
}

class SpecialEffectTest {

}
