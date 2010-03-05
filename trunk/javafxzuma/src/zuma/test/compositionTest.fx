/*
 * compositionTest.fx
 *
 * Created on Mar 5, 2010, 9:40:19 AM
 */

package zuma.test;

import javafx.scene.image.ImageView;

import zuma.Resources;

import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 * @author javatest
 */
def clip = ImageView{
            translateX : 0
            translateY : 0
            image: bind Resources.fireIcon[1]
            cache : false
            };
def imageview = ImageView {
        translateX : 0
        translateY : 0
        image: bind Resources.fireIcon[0]
        clip : clip
        cache : false
};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                imageview
        ]
    }
}
