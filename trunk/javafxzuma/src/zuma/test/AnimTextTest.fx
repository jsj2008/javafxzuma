/*
 * AnimTextTest.fx
 *
 * Created on Feb 24, 2010, 12:14:23 PM
 */

package zuma.test;

import javafx.scene.Scene;
import javafx.stage.Stage;

import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import zuma.components.AnimText;
import zuma.Level1Config;
/**
 * @author javatest
 */
var text = AnimText{translateX:200,translateY:200};
var counter = 1;
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Level1Config.background
                        focusTraversable: true
    onKeyPressed: function( e: KeyEvent ):Void {
                if(e.code == KeyCode.VK_ENTER){
                       text.addText(10);
                }
     }
};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                backgroundview,text
        ]
    }
}