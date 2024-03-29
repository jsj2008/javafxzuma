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


/**
 * @author perkin tang
 */
public def emitterImage = Image {
                            width : Config.EMITTER_DIAMETER
                            height: Config.EMITTER_DIAMETER
                            url: "{__DIR__}images/emitter.png" };
public def endDoorImage = [Image { url: "{__DIR__}images/bagua_1.png" }
                                 Image { url: "{__DIR__}images/bagua_2.png" }
                                 Image { url: "{__DIR__}images/bagua_3.png" }
                                 Image { url: "{__DIR__}images/bagua_4.png" }];
public def ballarray = [Image {
                        width : Config.BALL_DIAMETER
                        height: 1504/32*Config.BALL_DIAMETER
                        url: "{__DIR__}images/ball/baBallBlue.gif" },
                        Image {
                        width : Config.BALL_DIAMETER
                        height: 1600/32*Config.BALL_DIAMETER
                        url: "{__DIR__}images/ball/baBallGreen.gif" },
                        Image {
                        width : Config.BALL_DIAMETER
                        height: 1632/32*Config.BALL_DIAMETER
                        url: "{__DIR__}images/ball/baBallPurple.gif" },
                        Image {
                        width : Config.BALL_DIAMETER
                        height: 1600/32*Config.BALL_DIAMETER
                        url: "{__DIR__}images/ball/baBallRed.gif" },
                        Image {
                        width : Config.BALL_DIAMETER
                        height: 1600/32*Config.BALL_DIAMETER
                        url: "{__DIR__}images/ball/baBallWhite.gif" },
                        Image {
                        width : Config.BALL_DIAMETER
                        height: 1600/32*Config.BALL_DIAMETER
                        url: "{__DIR__}images/ball/baBallYellow.gif" }];
public def bomImage = [Image {
                       width : Config.BALL_DIAMETER
                       height: Config.BALL_DIAMETER
                       url: "{__DIR__}images/ball/BomBlue.png" }
                       Image {
                       width : Config.BALL_DIAMETER
                       height: Config.BALL_DIAMETER
                       url: "{__DIR__}images/ball/BomGreen.png" }
                       Image {
                       width : Config.BALL_DIAMETER
                       height: Config.BALL_DIAMETER
                       url: "{__DIR__}images/ball/BomPurple.png" }
                       Image {
                       width : Config.BALL_DIAMETER
                       height: Config.BALL_DIAMETER
                       url: "{__DIR__}images/ball/BomRed.png" }
                       Image {
                       width : Config.BALL_DIAMETER
                       height: Config.BALL_DIAMETER
                       url: "{__DIR__}images/ball/BomWhite.png" }
                       Image {
                       width : Config.BALL_DIAMETER
                       height: Config.BALL_DIAMETER
                       url: "{__DIR__}images/ball/BomYellow.png" }];
public def backwardsImage = [Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baBackwardsBlue.png" }
                             Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baBackwardsGreen.png" }
                             Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baBackwardsPurple.png" }
                             Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baBackwardsRed.png" }
                             Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baBackwardsWhite.png" }
                             Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baBackwardsYellow.png" }];
public def accuracyImage = [Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baAccuracyBlue.png" }
                            Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baAccuracyGreen.png" }
                            Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baAccuracyPurple.png" }
                            Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baAccuracyRed.png" }
                            Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baAccuracyWhite.png" }
                            Image {
                                width : Config.BALL_DIAMETER
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/baAccuracyYellow.png" }];
public def slowImage = [Image {
                            width : Config.BALL_DIAMETER
                            height: Config.BALL_DIAMETER
                            url: "{__DIR__}images/ball/baSlowBlue.png" }
                        Image {
                            width : Config.BALL_DIAMETER
                            height: Config.BALL_DIAMETER
                            url: "{__DIR__}images/ball/baSlowGreen.png" }
                        Image {
                            width : Config.BALL_DIAMETER
                            height: Config.BALL_DIAMETER
                            url: "{__DIR__}images/ball/baSlowPurple.png" }
                        Image {
                            width : Config.BALL_DIAMETER
                            height: Config.BALL_DIAMETER
                            url: "{__DIR__}images/ball/baSlowRed.png" }
                        Image {
                            width : Config.BALL_DIAMETER
                            height: Config.BALL_DIAMETER
                            url: "{__DIR__}images/ball/baSlowWhite.png" }
                        Image {
                            width : Config.BALL_DIAMETER
                            height: Config.BALL_DIAMETER
                            url: "{__DIR__}images/ball/baSlowYellow.png" }];
public def arrowImage = [Image {
                            url: "{__DIR__}images/ball/arrow_blue_up.png" }
                         Image {
                            url: "{__DIR__}images/ball/arrow_green_up.png" }
                         Image {
                            url: "{__DIR__}images/ball/arrow_violet_up.png" }
                         Image {
                            url: "{__DIR__}images/ball/arrow_red_up.png" }
                         Image {
                            url: "{__DIR__}images/ball/arrow_grey_up.png" }
                         Image {
                            url: "{__DIR__}images/ball/arrow_yellow_up.png" }];
public def specialEffectImage = [Image {
                                    width : Config.BONUS_DIAMETER
                                    height: Config.BONUS_DIAMETER
                                    url: "{__DIR__}images/BomEffect.png" }
                                 Image {
                                    width : Config.BONUS_DIAMETER
                                    height: Config.BONUS_DIAMETER
                                    url: "{__DIR__}images/BackwardsEffect.png" }
                                 Image {
                                    width : Config.BONUS_DIAMETER
                                    height: Config.BONUS_DIAMETER
                                    url: "{__DIR__}images/AccuracyEffect.png" }
                                 Image {
                                    width : Config.BONUS_DIAMETER
                                    height: Config.BONUS_DIAMETER
                                    url: "{__DIR__}images/SlowEffect.png" }];
public def purgeffectImage = [Image {
                                width : Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                height: Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                url: "{__DIR__}images/effect/effect.000.png" }
                              Image {
                                width : Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                height: Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                url: "{__DIR__}images/effect/effect.001.png" }
                              Image {
                                width : Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                height: Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                url: "{__DIR__}images/effect/effect.002.png" }
                              Image {
                                width : Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                height: Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                url: "{__DIR__}images/effect/effect.003.png" }
                              Image {
                                width : Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                height: Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                url: "{__DIR__}images/effect/effect.004.png" }
                              Image {
                                width : Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                height: Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                url: "{__DIR__}images/effect/effect.005.png" }
                              Image {
                                width : Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                height: Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                url: "{__DIR__}images/effect/effect.006.png" }
                              Image {
                                width : Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                height: Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                url: "{__DIR__}images/effect/effect.007.png" }
                              Image {
                                width : Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                height: Config.BALL_DIAMETER*Config.BALL_PURGE_RATIO
                                url: "{__DIR__}images/effect/effect.008.png" }
                              ];
public def patharray = MapLoader.getMap("/zuma/svg/map1");
public def track = SVGPath {
                            stroke: Color.BLACK
                            strokeWidth: 1
                            fill : null
                            content: "M 291.72393,554.62054 C 183.14222,572.70037 85.520327,487.43049 70.926113,381.9629 52.794583,250.93229 156.10465,134.56885 283.95109,119.32989 437.40609,101.03845 572.60255,222.49373 588.41929,372.72219 606.93537,548.58912 467.27226,702.67387 294.65966,719.02559 96.387867,737.80802 -76.621259,579.89678 -93.478933,384.89863 -112.55615,164.22628 63.630712,-27.732111 281.01536,-45.075159 524.08545,-64.467405 735.01104,130.01466 752.82434,369.78646 762.61549,501.57797 714.47439,633.56308 624.06832,729.643"
				transforms: [
					Transform.affine(0.5764226, 0.0, 0.0, 0.6323865, 131.03493, 74.16948)
				]
                            }
public def balls_particles = Image {
                                width : 117/2
                                height: 32/2
                                url: "{__DIR__}images/effect/balls_particles.png" };
public def scrollBallBlue = Image{url : "{__DIR__}images/baBallBlue.gif"};
public def scrollBallGreen = Image{url : "{__DIR__}images/baBallGreen.gif"};
public def loading_txt_image = Image { url: "{__DIR__}images/text/txt_loading.jpg" };
public def fireIcon = [Image { url: "{__DIR__}images/fireball_cursor.jpg" }
                       Image { url: "{__DIR__}images/fireball_cursor_a.jpg" }];
public def background_bottom : Image = Image { url: "{__DIR__}images/background/background_bottom.png" };
public def background_upper : Image = Image { url: "{__DIR__}images/background/background_upper.png" };
public def progress_fill : Image = Image { url: "{__DIR__}images/background/progress_fill.jpg" };

public def spear_ball : Image = Image{
                                width : Config.BALL_DIAMETER*10
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/power/spear_ball.png"};
public def spear_ball_big : Image = Image{
                                width : Config.BALL_DIAMETER*10*2
                                height: Config.BALL_DIAMETER*2
                                url: "{__DIR__}images/ball/power/spear_ball.png"};
public def mutilcolor_bullet : Image = Image{
                                width : Config.BALL_DIAMETER*20
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/power/mutilcolor_bullet.png"};
public def mutilcolor_bullet_big : Image = Image{
                                width : Config.BALL_DIAMETER*20*2
                                height: Config.BALL_DIAMETER*2
                                url: "{__DIR__}images/ball/power/mutilcolor_bullet.png"};
public def fire_bullet : Image = Image{
                                width : Config.BALL_DIAMETER*12
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/power/pup_fireball.png"};
public def fire_bullet_big : Image = Image{
                                width : Config.BALL_DIAMETER*12*2
                                height: Config.BALL_DIAMETER*2
                                url: "{__DIR__}images/ball/power/pup_fireball.png"};
public def strike_bullet : Image = Image{
                                width : Config.BALL_DIAMETER*10
                                height: Config.BALL_DIAMETER
                                url: "{__DIR__}images/ball/power/strike_ball.png"};
public def strike_bullet_big : Image = Image{
                                width : Config.BALL_DIAMETER*10*2
                                height: Config.BALL_DIAMETER*2
                                url: "{__DIR__}images/ball/power/strike_ball.png"};
public def powerbulletarray = [spear_ball,mutilcolor_bullet,fire_bullet,strike_bullet];
public def powerbulletbigarray = [spear_ball_big,mutilcolor_bullet_big,fire_bullet_big,strike_bullet_big];
public def powerlightningImage = [Image {
                                    width : 16
                                    height: 320
                                    url: "{__DIR__}images/ball/power/pak_lightning_0001.png" }
                                  Image {
                                    width : 16
                                    height: 320
                                    url: "{__DIR__}images/ball/power/pak_lightning_0002.png" }
                                  Image {
                                    width : 16
                                    height: 320
                                    url: "{__DIR__}images/ball/power/pak_lightning_0003.png" }
                                  Image {
                                    width : 16
                                    height: 320
                                    url: "{__DIR__}images/ball/power/pak_lightning_0004.png" }
                                  Image {
                                    width : 16
                                    height: 320
                                    url: "{__DIR__}images/ball/power/pak_lightning_0005.png" }
                                  Image {
                                    width : 16
                                    height: 320
                                    url: "{__DIR__}images/ball/power/pak_lightning_0006.png" }
                                  Image {
                                    width : 16
                                    height: 320
                                    url: "{__DIR__}images/ball/power/pak_lightning_0007.png" }
                                  Image {
                                    width : 16
                                    height: 320
                                    url: "{__DIR__}images/ball/power/pak_lightning_0008.png" }
                                 ];

//------------------------------sound-------------------------------------
public def ballclick_sound = "ball_hit.wav";
public def ballclick_sound_2 = "ballclick1.wav";
public def purge_sound = "chain1.wav";
public def rolling_sound = "initialfill.wav";
public def send_bullet_sound = "pop.wav";
public def switch_door_sound = "doorswitch.wav";
//-------------------------------------------------------------------------


public def fortest = Image { url: "{__DIR__}images/background/background2.jpg" };
