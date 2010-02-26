/*
 * TestImagearray.fx
 *
 * Created on Jan 29, 2010, 3:04:55 PM
 */

package zuma.test;

import javafx.scene.Scene;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;
import zuma.Config;
import zuma.Resources;

import javafx.scene.input.MouseEvent;

/**
 * @author javatest
 */
var count : Integer= 0;
def specialimageview = ImageView {
        fitWidth : Config.BALL_DIAMETER
        fitHeight : Config.BALL_DIAMETER
        translateX :  100
        translateY :  100
        image: bind Resources.bomImage[count];
        cache : false
        opacity : 1
};
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Resources.background
                        focusTraversable: true
                        onMousePressed: function( e: MouseEvent ):Void {
                            count++;
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
 class TestImagearray {

}
