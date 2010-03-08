/*
 * ProgresTest.fx
 *
 * Created on Mar 8, 2010, 2:51:39 PM
 */

package zuma.test;

import javafx.scene.Scene;
import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.stage.Stage;
import zuma.Main;

import zuma.components.Progress;

import zuma.Resources;

/**
 * @author javatest
 */

var progress = Progress{
            progressImage:Resources.background_upper;
            fillImage:Resources.progress_fill
            max : 50
        };
var counter = 1;
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Main.currentData.background
                        focusTraversable: true
    onKeyPressed: function( e: KeyEvent ):Void {
                if(e.code == KeyCode.VK_UP){
                        progress.current++;
                };
                if(e.code == KeyCode.VK_DOWN){
                        progress.current--;
                }
     }
};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                backgroundview,progress
        ]
    }
}
