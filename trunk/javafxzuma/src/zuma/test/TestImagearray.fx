/*
 * TestImagearray.fx
 *
 * Created on Jan 29, 2010, 3:04:55 PM
 */

package zuma.test;

import javafx.scene.image.ImageView;
import zuma.Config;
import zuma.Resources;

import javafx.scene.input.MouseEvent;



import javafx.scene.Scene;







import java.lang.Runnable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javafx.stage.Stage;

import java.util.Timer;
import java.util.TimerTask;

import java.lang.Thread;
import java.lang.Throwable;

import zuma.Main;
/**
 * @author javatest
 */
def eh : Thread.UncaughtExceptionHandler = Thread.UncaughtExceptionHandler{
                        var defaultUncaughtExceptionHandler;
                        function init() {
                            defaultUncaughtExceptionHandler = Thread.getDefaultUncaughtExceptionHandler();
                        }
                        override function uncaughtException(t : Thread , e : Throwable) {
                             e.printStackTrace();
                        }
                        };
var count : Integer= 0;
def specialimageview = ImageView {
        fitWidth : Config.BALL_DIAMETER
        fitHeight : Config.BALL_DIAMETER
        translateX :  100
        translateY :  100
        image: bind Resources.effectimage[count];
        cache : false
        opacity : 1
};
var backgroundview = ImageView {
                        fitHeight : 700
                        fitWidth : 700
                        image: Main.currentData.background
                        focusTraversable: true
                        onMousePressed: function( e: MouseEvent ):Void {
                            count++;
                        }
};
//def updateCursorAction : Action= AbstractAction{
//    override function actionPerformed(e :ActionEvent) {
//            if(count <= 8){
//                  count++;
//            }else{
//                  count=0;
//            }
//    }
//};
//def timer = new Timer(300,updateCursorAction);
def timer : Timer = new Timer(false);
def worker : TimerTask  = TimerTask{
                    override function run(){
//                         if(count <= 8){
//                  count++;
//            }else{
//                  count=0;
//            }
//            println("{count}");
process();
                    }
                };
def pool : ExecutorService = Executors.newCachedThreadPool();
function process() {
                var task: Runnable = Runnable {
                     override function run() {
                     FX.deferAction(function():Void{
                              if(count <= 8){
                  count++;
            }else{
                  count=0;
            }
            println("{count}");
                             });
                        
                     }
                 }
         pool.execute(task);
};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [backgroundview,specialimageview
        ]
    }
}
Thread.setDefaultUncaughtExceptionHandler(eh);
//process();
timer.schedule(worker,0,100);
