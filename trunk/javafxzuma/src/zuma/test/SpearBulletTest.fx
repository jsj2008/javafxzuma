/*
 * SpearBulletTest.fx
 *
 * Created on Mar 15, 2010, 2:24:24 PM
 */

package zuma.test;

import javafx.scene.Scene;
import javafx.stage.Stage;

import zuma.PowerBullet;

/**
 * @author perkin tang
 */
 var bullet = PowerBullet{powerIndex:2,translateX:200,translateY:200,vis:true};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                bullet
        ]
    }
}
