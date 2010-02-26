/*
 * FadeBallTest.fx
 *
 * Created on Jan 28, 2010, 1:44:59 PM
 */

package zuma.test;

import zuma.Config;
import zuma.Resources;
import zuma.components.FadeBall;

import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 * @author javatest
 */
def ball = FadeBall{
                        image : Resources.bomImage[0],
                        ball_deameter: Config.BALL_DIAMETER};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                ball
        ]
    }
}
ball.start();
class FadeBallTest {

}
