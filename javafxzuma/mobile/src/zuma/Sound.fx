/*
 * Sound.fx
 *
 * Created on Feb 21, 2010, 11:36:55 AM
 */

package zuma;

/**
 * @author javatest
 */

import java.applet.Applet;
import java.applet.AudioClip;
import java.net.MalformedURLException;
import java.net.URL;

import java.lang.Thread;

/**
 * <p>
 * A <code>Sound</code> is a recognized sound file that can be played, looped or
 * stopped.  The sound file is loaded from the specified file name.  If the file
 * cannot be found or is not a recognized sound file, no sound will be played.
 * </p>
 *
 * @author aarmistead
 */
public class Sound {

  // Public Variables.

  /**
   * The file name of the sound to play.  i.e. "sounds/test.wav".  The codebase
   * path should not be specified.  When changed, a new audio clip is created.
   */
  public var fileName : String on replace {
    try {
      var url : URL = new URL("{__DIR__}sounds/{fileName}");
      sound = Applet.newAudioClip(url);
    } catch (e : MalformedURLException) {
      // Do nothing, sound will be just be null and not play.
    }
  };

  // Private Variables.

  /**
   * The audio clip loaded from the codebase path and the specified fileName.
   */
  var sound : AudioClip;

  // Public Methods.

  /**
   * Loop the sound.
   */
  public function loop() : Void {
    if(sound != null) {
      sound.loop();
    }
  }

  /**
   * Play the sound.
   */
  public function play() : Void {
    if(sound != null) {
      sound.play();
    }
  }

  /**
   * Stop the sound.
   */
  public function stop() : Void {
    if(sound != null) {
      sound.stop();
    }
  }

}
