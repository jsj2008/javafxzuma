/*
 * LoadingUI.fx
 *
 * Created on Mar 8, 2010, 12:23:13 PM
 */

package zuma;

import javafx.scene.image.ImageView;

/**
 * @author perkin tang
 */

public class LoadingUI extends UI{
var loading = ImageView {
                translateX : (Config.WINDOW_WIDTH/2 - 173/2)
                translateY : (Config.WINDOW_HEIGHT/2 - 55/2)
                image: Resources.loading_txt_image
                focusTraversable: true
                visible: true}
public var splashcontent =  [loading];
override public function start(){
    Main.mainscene.content = splashcontent;
}
override public function stop(){

}
override public function pause(){

}
override public function resume(){

}
}
