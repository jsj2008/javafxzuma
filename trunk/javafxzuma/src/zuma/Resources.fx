/*
 * Resources.fx
 *
 * Created on Jan 19, 2010, 10:35:43 AM
 */

package zuma;

import javafx.scene.image.Image;
import javafx.scene.paint.Color;
import javafx.scene.shape.SVGPath;

import javafx.scene.transform.Transform;

import javafx.scene.media.Media;

/**
 * @author javatest
 */
public def emitterImage = Image { url: "{__DIR__}images/emitter.png" };
public def endDoorImage = [Image { url: "{__DIR__}images/bagua_1.png" }
                                 Image { url: "{__DIR__}images/bagua_2.png" }
                                 Image { url: "{__DIR__}images/bagua_3.png" }
                                 Image { url: "{__DIR__}images/bagua_4.png" }];
public def background = Image { url: "{__DIR__}images/background.png" };
public def ballarray = [Image { url: "{__DIR__}images/baBallBlue.gif" },
                        Image { url: "{__DIR__}images/baBallGreen.gif" },
                        Image { url: "{__DIR__}images/baBallPurple.gif" },
                        Image { url: "{__DIR__}images/baBallRed.gif" },
                        Image { url: "{__DIR__}images/baBallWhite.gif" },
                        Image { url: "{__DIR__}images/baBallYellow.gif" }];
public def bomImage = [Image { url: "{__DIR__}images/BomBlue.png" }
                       Image { url: "{__DIR__}images/BomGreen.png" }
                       Image { url: "{__DIR__}images/BomPurple.png" }
                       Image { url: "{__DIR__}images/BomRed.png" }
                       Image { url: "{__DIR__}images/BomWhite.png" }
                       Image { url: "{__DIR__}images/BomYellow.png" }];
public def backwardsImage = [Image { url: "{__DIR__}images/baBackwardsBlue.png" }
                               Image { url: "{__DIR__}images/baBackwardsGreen.png" }
                               Image { url: "{__DIR__}images/baBackwardsPurple.png" }
                               Image { url: "{__DIR__}images/baBackwardsRed.png" }
                               Image { url: "{__DIR__}images/baBackwardsWhite.png" }
                               Image { url: "{__DIR__}images/baBackwardsYellow.png" }];
public def accuracyImage = [Image { url: "{__DIR__}images/baAccuracyBlue.png" }
                               Image { url: "{__DIR__}images/baAccuracyGreen.png" }
                               Image { url: "{__DIR__}images/baAccuracyPurple.png" }
                               Image { url: "{__DIR__}images/baAccuracyRed.png" }
                               Image { url: "{__DIR__}images/baAccuracyWhite.png" }
                               Image { url: "{__DIR__}images/baAccuracyYellow.png" }];
public def slowImage = [Image { url: "{__DIR__}images/baSlowBlue.png" }
                               Image { url: "{__DIR__}images/baSlowGreen.png" }
                               Image { url: "{__DIR__}images/baSlowPurple.png" }
                               Image { url: "{__DIR__}images/baSlowRed.png" }
                               Image { url: "{__DIR__}images/baSlowWhite.png" }
                               Image { url: "{__DIR__}images/baSlowYellow.png" }];
public def specialEffectImage = [Image { url: "{__DIR__}images/BomEffect.png" }
                                 Image { url: "{__DIR__}images/BackwardsEffect.png" }
                                 Image { url: "{__DIR__}images/AccuracyEffect.png" }
                                 Image { url: "{__DIR__}images/SlowEffect.png" }];
public def purgeffectImage = [Image { url: "{__DIR__}images/effect.000.png" }
                                 Image { url: "{__DIR__}images/effect.001.png" }
                                 Image { url: "{__DIR__}images/effect.002.png" }
                                 Image { url: "{__DIR__}images/effect.003.png" }
                                 Image { url: "{__DIR__}images/effect.004.png" }
                                 Image { url: "{__DIR__}images/effect.005.png" }
                                 Image { url: "{__DIR__}images/effect.006.png" }
                                 Image { url: "{__DIR__}images/effect.007.png" }
                                 Image { url: "{__DIR__}images/effect.008.png" }];
public def scrollBallBlue = Image{url : "{__DIR__}images/baBallBlue.gif"};
public def scrollBallGreen = Image{url : "{__DIR__}images/baBallGreen.gif"};
public def patharray = MapLoader.getMap(Config.PATH_DATA_FILE);
public def track = SVGPath {
                            stroke: Color.BLACK
                            strokeWidth: 1
                            fill : null
                            content: "M 291.72393,554.62054 C 183.14222,572.70037 85.520327,487.43049 70.926113,381.9629 52.794583,250.93229 156.10465,134.56885 283.95109,119.32989 437.40609,101.03845 572.60255,222.49373 588.41929,372.72219 606.93537,548.58912 467.27226,702.67387 294.65966,719.02559 96.387867,737.80802 -76.621259,579.89678 -93.478933,384.89863 -112.55615,164.22628 63.630712,-27.732111 281.01536,-45.075159 524.08545,-64.467405 735.01104,130.01466 752.82434,369.78646 762.61549,501.57797 714.47439,633.56308 624.06832,729.643"
				transforms: [
					Transform.affine(0.5764226, 0.0, 0.0, 0.6323865, 131.03493, 74.16948)
				]
                            }
public def effectimage = [Image { url: "{__DIR__}images/effect.000.png" }
                               Image { url: "{__DIR__}images/effect.001.png" }
                               Image { url: "{__DIR__}images/effect.002.png" }
                               Image { url: "{__DIR__}images/effect.003.png" }
                               Image { url: "{__DIR__}images/effect.004.png" }
                               Image { url: "{__DIR__}images/effect.005.png" }
                               Image { url: "{__DIR__}images/effect.006.png" }
                               Image { url: "{__DIR__}images/effect.007.png" }
                               Image { url: "{__DIR__}images/effect.008.png" }];
public def ballclick_sound = "ball_hit.wav";
public def ballclick_sound_2 = "ballclick1.wav";
public def purge_sound = "chain1.wav";
public def rolling_sound = "initialfill.wav";
public def send_bullet_sound = "pop.wav";
public def switch_door_sound = "doorswitch.wav";
