/*
 * PointerTest.fx
 *
 * Created on Feb 25, 2010, 10:21:13 AM
 */

package zuma.test;

/**
 * @author javatest
 */
import zuma.Pointer;

import javafx.scene.Scene;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.stage.Stage;
import zuma.Resources;
import zuma.Level1Config;
var p = Pointer{};
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Level1Config.background
                        focusTraversable: true
                        onMouseMoved: function( e: MouseEvent ):Void {
                            p.topx = e.x;
                            p.topy = e.y;
                            p.genPoints();
                        }
};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                backgroundview,p
        ]
    }
}