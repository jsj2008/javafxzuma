/*
 * ImagePlayerTest.fx
 *
 * Created on Mar 1, 2010, 2:55:32 PM
 */

package zuma.test;

import javafx.scene.Scene;
import javafx.stage.Stage;
import zuma.Resources;
import zuma.components.ImagesPlayer;
/**
 * @author perkin tang
 */

var player = ImagesPlayer{images: Resources.powerlightningImage,rate : 1 ,opacity:1.0};
var counter = 1;
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                player
        ]
    }
}
player.play();