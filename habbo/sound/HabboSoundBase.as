package com.sulake.habbo.sound
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class HabboSoundBase implements class_1814
   {
      
      private var var_660:SoundChannel = null;
      
      private var var_270:Boolean;
      
      private var _volume:Number;
      
      private var var_2777:int;
      
      protected var _soundObject:Sound = null;
      
      public function HabboSoundBase(param1:Sound, param2:int = 0)
      {
         super();
         _soundObject = param1;
         _soundObject.addEventListener("complete",onComplete);
         _volume = 1;
         var_270 = false;
         var_2777 = param2;
      }
      
      protected function getSoundObject() : Sound
      {
         return _soundObject;
      }
      
      protected function getSoundChannel() : SoundChannel
      {
         return var_660;
      }
      
      protected function setSoundChannel(param1:SoundChannel) : void
      {
         var_660 = param1;
      }
      
      protected function setComplete(param1:Boolean) : void
      {
         var_270 = param1;
      }
      
      public function dispose() : void
      {
         stop();
         var_660 = null;
         _soundObject = null;
      }
      
      public function play(param1:Number = 0) : Boolean
      {
         var_270 = false;
         var_660 = _soundObject.play(0,var_2777);
         setChannelVolume(_volume);
         return true;
      }
      
      public function stop() : Boolean
      {
         if(var_660)
         {
            var_660.stop();
         }
         return true;
      }
      
      public function get volume() : Number
      {
         return _volume;
      }
      
      public function set volume(param1:Number) : void
      {
         _volume = param1;
         setChannelVolume(param1);
      }
      
      protected function setChannelVolume(param1:Number) : void
      {
         if(var_660 != null)
         {
            var_660.soundTransform = new SoundTransform(param1);
         }
      }
      
      public function get position() : Number
      {
         return var_660.position;
      }
      
      public function set position(param1:Number) : void
      {
      }
      
      public function get length() : Number
      {
         return _soundObject.length;
      }
      
      public function get ready() : Boolean
      {
         return !_soundObject.isBuffering;
      }
      
      public function get finished() : Boolean
      {
         return !var_270;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return 0;
      }
      
      public function set fadeOutSeconds(param1:Number) : void
      {
      }
      
      public function get fadeInSeconds() : Number
      {
         return 0;
      }
      
      public function set fadeInSeconds(param1:Number) : void
      {
      }
      
      private function onComplete(param1:Event) : void
      {
         var_270 = true;
      }
   }
}

