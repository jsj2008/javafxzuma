/*
 * EndDoorTest.fx
 *
 * Created on Jan 29, 2010, 4:07:35 PM
 */

package zuma.test;
import zuma.EndDoor;

import javafx.scene.Scene;
import javafx.stage.Stage;

import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import zuma.Resources;
/**
 * @author javatest
 */
var door = EndDoor{translateX : 100, translateY : 100};
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Resources.background
                        focusTraversable: true
                        onMousePressed: function( e: MouseEvent ):Void {
                                door.open();
                        }
};
Stage {
    title: "Application title"
    width: 500
    height: 500
    scene: Scene {
        content: [backgroundview,door
        ]
    }
}
class EndDoorTest {

}
