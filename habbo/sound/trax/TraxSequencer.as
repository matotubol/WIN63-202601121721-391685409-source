package com.sulake.habbo.sound.trax
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.sound.class_1814;
   import com.sulake.habbo.sound.events.SoundCompleteEvent;
   import flash.events.IEventDispatcher;
   import flash.events.SampleDataEvent;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class TraxSequencer implements class_1814, class_13
   {
      
      private static const SAMPLES_PER_SECOND:Number = 44100;
      
      private static const BUFFER_LENGTH:uint = 8192;
      
      private static const SAMPLES_BAR_LENGTH:uint = 88000;
      
      private static const BAR_LENGTH:uint = 88000;
      
      private static const SAMPLES_PER_BAR:Number = 88200;
      
      private static const ROUND_UP_THRESHOLD_BIAS:Number = 0.875;
      
      private static const MIXING_BUFFER:Vector.<int> = new Vector.<int>(8192,true);
      
      private static const INTERPOLATION_BUFFER:Vector.<int> = new Vector.<int>(8192,true);
      
      private var _disposed:Boolean = false;
      
      private var name_1:IEventDispatcher;
      
      private var _volume:Number;
      
      private var _sound:Sound;
      
      private var var_660:SoundChannel;
      
      private var var_831:TraxData;
      
      private var var_2506:class_55;
      
      private var var_1668:Boolean;
      
      private var var_2766:int;
      
      private var var_3131:int = 0;
      
      private var var_346:uint;
      
      private var var_596:Array;
      
      private var var_2192:Boolean;
      
      private var var_1034:Boolean = true;
      
      private var var_453:uint;
      
      private var var_3675:uint = 30;
      
      private var var_1079:Boolean;
      
      private var var_1039:Boolean;
      
      private var var_1315:int;
      
      private var var_789:int;
      
      private var var_1463:int;
      
      private var var_472:int;
      
      private var var_1140:Timer;
      
      private var var_829:Timer;
      
      private var var_2457:Boolean;
      
      private var var_1742:int = 0;
      
      private var var_3152:int = 0;
      
      public function TraxSequencer(param1:int, param2:TraxData, param3:class_55, param4:IEventDispatcher)
      {
         super();
         name_1 = param4;
         var_2766 = param1;
         _volume = 1;
         _sound = new Sound();
         var_660 = null;
         var_2506 = param3;
         var_831 = param2;
         var_1668 = true;
         var_346 = 0;
         var_596 = [];
         var_2192 = false;
         var_453 = 0;
         var_1034 = false;
         var_1079 = false;
         var_1039 = false;
         var_1315 = 0;
         var_789 = 0;
         var_1463 = 0;
         var_472 = 0;
      }
      
      public function set position(param1:Number) : void
      {
         var_346 = param1 * 44100;
      }
      
      public function get volume() : Number
      {
         return _volume;
      }
      
      public function get position() : Number
      {
         return var_346 / 44100;
      }
      
      public function get ready() : Boolean
      {
         return var_1668;
      }
      
      public function set ready(param1:Boolean) : void
      {
         var_1668 = param1;
      }
      
      public function get finished() : Boolean
      {
         return var_1034;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return var_789 / 44100;
      }
      
      public function set fadeOutSeconds(param1:Number) : void
      {
         var_789 = param1 * 44100;
      }
      
      public function get fadeInSeconds() : Number
      {
         return var_1315 / 44100;
      }
      
      public function set fadeInSeconds(param1:Number) : void
      {
         var_1315 = param1 * 44100;
      }
      
      public function get traxData() : TraxData
      {
         return var_831;
      }
      
      public function set volume(param1:Number) : void
      {
         _volume = param1;
         if(var_660 != null)
         {
            var_660.soundTransform = new SoundTransform(_volume);
         }
      }
      
      public function get length() : Number
      {
         return var_453 / 44100;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            stopImmediately();
            var_831 = null;
            var_2506 = null;
            var_596 = null;
            name_1 = null;
            _sound = null;
            _disposed = true;
         }
      }
      
      public function prepare() : Boolean
      {
         if(!var_1668)
         {
            class_21.log("Cannot start trax playback until samples ready!");
            return false;
         }
         if(!var_2192)
         {
            if(var_831 != null)
            {
               var_2457 = false;
               if(var_831.hasMetaData)
               {
                  var_2457 = var_831.metaCutMode;
               }
               if(var_2457)
               {
                  if(!prepareSequence())
                  {
                     class_21.log("Cannot start playback, prepare sequence failed!");
                     return false;
                  }
               }
               else if(!prepareLegacySequence())
               {
                  class_21.log("Cannot start playback, prepare legacy sequence failed!");
                  return false;
               }
            }
         }
         return true;
      }
      
      private function prepareLegacySequence() : Boolean
      {
         var _loc8_:int = 0;
         var _loc3_:class_55 = null;
         var _loc7_:TraxChannel = null;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc12_:TraxSample = null;
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         if(var_596 == null)
         {
            return false;
         }
         var _loc1_:uint = uint(getTimer());
         _loc8_ = 0;
         while(_loc8_ < var_831.channels.length)
         {
            _loc3_ = new class_55();
            _loc7_ = var_831.channels[_loc8_] as TraxChannel;
            _loc4_ = 0;
            _loc2_ = 0;
            _loc9_ = 0;
            while(_loc9_ < _loc7_.itemCount)
            {
               _loc5_ = _loc7_.getItem(_loc9_).id;
               _loc12_ = var_2506.getValue(_loc5_) as TraxSample;
               _loc12_.setUsageFromSong(var_2766,_loc1_);
               if(_loc12_ == null)
               {
                  class_21.log("Error in prepareLegacySequence(), sample was null!");
                  return false;
               }
               _loc11_ = getSampleBars(_loc12_.length);
               _loc6_ = _loc7_.getItem(_loc9_).length / _loc11_;
               _loc10_ = 0;
               while(_loc10_ < _loc6_)
               {
                  if(_loc5_ != 0)
                  {
                     _loc3_.add(_loc4_,_loc12_);
                  }
                  _loc2_ += _loc11_;
                  _loc4_ = _loc2_ * 88000;
                  _loc10_++;
               }
               if(var_453 < _loc4_)
               {
                  var_453 = _loc4_;
               }
               _loc9_++;
            }
            var_596.push(_loc3_);
            _loc8_++;
         }
         var_2192 = true;
         return true;
      }
      
      private function prepareSequence() : Boolean
      {
         var _loc6_:int = 0;
         var _loc12_:class_55 = null;
         var _loc5_:TraxChannel = null;
         var _loc2_:* = 0;
         var _loc11_:* = 0;
         var _loc13_:Boolean = false;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:TraxSample = null;
         var _loc3_:int = 0;
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:int = 0;
         if(var_596 == null)
         {
            return false;
         }
         var _loc10_:uint = uint(getTimer());
         _loc6_ = 0;
         while(_loc6_ < var_831.channels.length)
         {
            _loc12_ = new class_55();
            _loc5_ = var_831.channels[_loc6_] as TraxChannel;
            _loc2_ = 0;
            _loc11_ = 0;
            _loc13_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.itemCount)
            {
               _loc4_ = _loc5_.getItem(_loc7_).id;
               _loc9_ = var_2506.getValue(_loc4_) as TraxSample;
               _loc9_.setUsageFromSong(var_2766,_loc10_);
               if(_loc9_ == null)
               {
                  class_21.log("Error in prepareSequence(), sample was null!");
                  return false;
               }
               _loc3_ = _loc11_;
               _loc14_ = _loc2_;
               _loc8_ = getSampleBars(_loc9_.length);
               _loc1_ = _loc5_.getItem(_loc7_).length;
               while(_loc3_ < _loc11_ + _loc1_)
               {
                  if(_loc4_ != 0 || _loc13_)
                  {
                     _loc12_.add(_loc14_,_loc9_);
                     _loc13_ = false;
                  }
                  _loc3_ += _loc8_;
                  _loc14_ = _loc3_ * 88000;
                  if(_loc3_ > _loc11_ + _loc1_)
                  {
                     _loc13_ = true;
                  }
               }
               _loc11_ += _loc5_.getItem(_loc7_).length;
               _loc2_ = _loc11_ * 88000;
               if(var_453 < _loc2_)
               {
                  var_453 = _loc2_;
               }
               _loc7_++;
            }
            var_596.push(_loc12_);
            _loc6_++;
         }
         var_2192 = true;
         return true;
      }
      
      public function play(param1:Number = 0) : Boolean
      {
         if(!prepare())
         {
            return false;
         }
         removeFadeoutStopTimer();
         if(var_660 != null)
         {
            stopImmediately();
         }
         if(var_1315 > 0)
         {
            var_1079 = true;
            var_1463 = 0;
         }
         var_1039 = false;
         var_472 = 0;
         var_1034 = false;
         _sound.addEventListener("sampleData",onSampleData);
         var_3131 = param1 * 44100;
         var_1742 = 0;
         var_3152 = 0;
         var_660 = _sound.play();
         volume = _volume;
         return true;
      }
      
      public function render(param1:SampleDataEvent) : Boolean
      {
         if(!prepare())
         {
            return false;
         }
         while(!var_1034)
         {
            onSampleData(param1);
         }
         return true;
      }
      
      public function stop() : Boolean
      {
         if(var_789 > 0 && !var_1034)
         {
            stopWithFadeout();
         }
         else
         {
            playingComplete();
         }
         return true;
      }
      
      private function stopImmediately() : void
      {
         removeStopTimer();
         if(var_660 != null)
         {
            var_660.stop();
            var_660 = null;
         }
         if(_sound != null)
         {
            _sound.removeEventListener("sampleData",onSampleData);
         }
      }
      
      private function stopWithFadeout() : void
      {
         if(var_1140 == null)
         {
            var_1039 = true;
            var_472 = 0;
            var_1140 = new Timer(var_3675 + var_789 / (44100 / 1000),1);
            var_1140.start();
            var_1140.addEventListener("timerComplete",onFadeOutComplete);
         }
      }
      
      private function getSampleBars(param1:uint) : int
      {
         var _loc2_:Number = param1 / 88200;
         if(var_2457)
         {
            return Math.round(_loc2_);
         }
         return Math.floor(_loc2_ + 0.875);
      }
      
      private function getChannelSequenceOffsets() : Array
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:class_55 = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(var_596 != null)
         {
            _loc1_ = int(var_596.length);
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc5_ = var_596[_loc3_];
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length && _loc5_.getKey(_loc4_) < var_346)
               {
                  _loc4_++;
               }
               _loc2_.push(_loc4_ - 1);
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function mixChannelsIntoBuffer() : void
      {
         var _loc6_:int = 0;
         var _loc7_:class_55 = null;
         var _loc14_:int = 0;
         var _loc8_:TraxSample = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc13_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         if(var_596 == null)
         {
            return;
         }
         var _loc4_:Array = getChannelSequenceOffsets();
         var _loc1_:int = int(var_596.length);
         var _loc12_:TraxChannelSample = null;
         _loc6_ = _loc1_ - 1;
         while(_loc6_ >= 0)
         {
            _loc7_ = var_596[_loc6_];
            _loc14_ = int(_loc4_[_loc6_]);
            _loc8_ = _loc7_.getWithIndex(_loc14_);
            if(_loc8_ == null)
            {
               _loc12_ = null;
            }
            else
            {
               _loc2_ = _loc7_.getKey(_loc14_);
               _loc5_ = var_346 - _loc2_;
               if(_loc8_.id == 0 || _loc5_ < 0)
               {
                  _loc12_ = null;
               }
               else
               {
                  _loc12_ = new TraxChannelSample(_loc8_,_loc5_);
               }
            }
            _loc13_ = 8192;
            if(var_453 - var_346 < _loc13_)
            {
               _loc13_ = var_453 - var_346;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc13_)
            {
               _loc3_ = _loc13_;
               if(_loc14_ < _loc7_.length - 1)
               {
                  _loc10_ = _loc7_.getKey(_loc14_ + 1);
                  if(_loc13_ + var_346 >= _loc10_)
                  {
                     _loc3_ = _loc10_ - var_346;
                  }
               }
               if(_loc3_ > _loc13_ - _loc11_)
               {
                  _loc3_ = _loc13_ - _loc11_;
               }
               if(_loc6_ == _loc1_ - 1)
               {
                  if(_loc12_ != null)
                  {
                     _loc12_.setSample(MIXING_BUFFER,_loc11_,_loc3_);
                     _loc11_ += _loc3_;
                  }
                  else
                  {
                     _loc9_ = 0;
                     while(_loc9_ < _loc3_)
                     {
                        MIXING_BUFFER[_loc11_++] = 0;
                        _loc9_++;
                     }
                  }
               }
               else
               {
                  if(_loc12_ != null)
                  {
                     _loc12_.addSample(MIXING_BUFFER,_loc11_,_loc3_);
                  }
                  _loc11_ += _loc3_;
               }
               if(_loc11_ < _loc13_)
               {
                  _loc8_ = _loc7_.getWithIndex(++_loc14_);
                  if(_loc8_ == null || _loc8_.id == 0)
                  {
                     _loc12_ = null;
                  }
                  else
                  {
                     _loc12_ = new TraxChannelSample(_loc8_,0);
                  }
               }
            }
            _loc6_--;
         }
      }
      
      private function checkSongFinishing() : void
      {
         var _loc1_:int = int(var_453 < var_3131 ? var_453 : (var_3131 > 0 ? var_3131 : var_453));
         if(var_346 > _loc1_ + var_3675 * (44100 / 1000) && !var_1034)
         {
            var_1034 = true;
            if(var_829 != null)
            {
               var_829.reset();
               var_829.removeEventListener("timerComplete",onPlayingComplete);
            }
            var_829 = new Timer(2,1);
            var_829.start();
            var_829.addEventListener("timerComplete",onPlayingComplete);
         }
         else if(var_346 > _loc1_ - var_789 && !var_1039)
         {
            var_1079 = false;
            var_1039 = true;
            var_472 = 0;
         }
      }
      
      private function onSampleData(param1:SampleDataEvent) : void
      {
         if(param1.position > var_1742)
         {
            var_3152 = var_3152 + 1;
            class_21.log("Audio buffer under run...");
            var_1742 = param1.position;
         }
         if(volume > 0)
         {
            mixChannelsIntoBuffer();
         }
         var _loc2_:int = 8192;
         if(var_453 - var_346 < _loc2_)
         {
            _loc2_ = var_453 - var_346;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
         }
         if(volume <= 0)
         {
            _loc2_ = 0;
         }
         writeAudioToOutputStream(param1.data,_loc2_);
         var_346 += 8192;
         var_1742 += 8192;
         if(var_660 != null)
         {
            var_3675 = param1.position / 44100 * 1000 - var_660.position;
         }
         checkSongFinishing();
      }
      
      private function writeAudioToOutputStream(param1:ByteArray, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:int = 0;
         if(param2 > 0)
         {
            if(!var_1079 && !var_1039)
            {
               writeMixingBufferToOutputStream(param1,param2);
            }
            else
            {
               if(var_1079)
               {
                  _loc3_ = 1 / var_1315;
                  _loc4_ = var_1463 / var_1315;
                  var_1463 += 8192;
                  if(var_1463 > var_1315)
                  {
                     var_1079 = false;
                  }
               }
               else if(var_1039)
               {
                  _loc3_ = -1 / var_789;
                  _loc4_ = 1 - var_472 / var_789;
                  var_472 += 8192;
                  if(var_472 > var_789)
                  {
                     var_472 = var_789;
                  }
               }
               writeMixingBufferToOutputStreamWithFade(param1,param2,_loc4_,_loc3_);
            }
         }
         var _loc5_:Number = 0;
         _loc6_ = param2;
         while(_loc6_ < 8192)
         {
            param1.writeFloat(_loc5_);
            param1.writeFloat(_loc5_);
            _loc6_++;
         }
      }
      
      private function writeMixingBufferToOutputStream(param1:ByteArray, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = MIXING_BUFFER[_loc3_] * 0.000030517578125;
            param1.writeFloat(_loc4_);
            param1.writeFloat(_loc4_);
            _loc3_++;
         }
      }
      
      private function writeMixingBufferToOutputStreamWithFade(param1:ByteArray, param2:int, param3:Number, param4:Number) : void
      {
         var _loc6_:Number = 0;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            if(param3 < 0 || param3 > 1)
            {
               break;
            }
            _loc6_ = MIXING_BUFFER[_loc5_] * 0.000030517578125 * param3;
            param3 += param4;
            param1.writeFloat(_loc6_);
            param1.writeFloat(_loc6_);
            _loc5_++;
         }
         if(param3 < 0)
         {
            while(_loc5_ < param2)
            {
               param1.writeFloat(0);
               param1.writeFloat(0);
               _loc5_++;
            }
         }
         else if(param3 > 1)
         {
            while(_loc5_ < param2)
            {
               _loc6_ = MIXING_BUFFER[_loc5_] * 0.000030517578125;
               param3 += param4;
               param1.writeFloat(_loc6_);
               param1.writeFloat(_loc6_);
               _loc5_++;
            }
         }
      }
      
      private function onPlayingComplete(param1:TimerEvent) : void
      {
         if(var_1034)
         {
            playingComplete();
         }
      }
      
      private function onFadeOutComplete(param1:TimerEvent) : void
      {
         removeFadeoutStopTimer();
         playingComplete();
      }
      
      private function playingComplete() : void
      {
         stopImmediately();
         name_1.dispatchEvent(new SoundCompleteEvent("SCE_TRAX_SONG_COMPLETE",var_2766));
      }
      
      private function removeFadeoutStopTimer() : void
      {
         if(var_1140 != null)
         {
            var_1140.removeEventListener("timerComplete",onFadeOutComplete);
            var_1140.reset();
            var_1140 = null;
         }
      }
      
      private function removeStopTimer() : void
      {
         if(var_829 != null)
         {
            var_829.reset();
            var_829.removeEventListener("timerComplete",onPlayingComplete);
            var_829 = null;
         }
      }
   }
}

