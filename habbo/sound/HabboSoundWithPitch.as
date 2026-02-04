package com.sulake.habbo.sound
{
   import com.sulake.core.runtime.class_31;
   import flash.media.Sound;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   
   public class HabboSoundWithPitch extends HabboSoundBase implements class_31
   {
      
      private const SILENCE_MS:uint = 50;
      
      private const FADEIN_MS:uint = 175;
      
      private var var_2000:Number;
      
      private var var_2298:Sound;
      
      private var var_503:ByteArray;
      
      private var var_5119:int;
      
      private var var_3055:uint = 0;
      
      private var var_3297:uint = 0;
      
      private var var_3129:Boolean = false;
      
      public function HabboSoundWithPitch(param1:Sound, param2:Number = 1)
      {
         super(param1);
         var_2000 = param2;
         var_2298 = new Sound();
         extractMonoSamples();
         setPitch(var_2000);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2298 = null;
         if(var_503 != null)
         {
            var_503.clear();
            var_503 = null;
         }
      }
      
      override public function play(param1:Number = 0) : Boolean
      {
         stop();
         var_3297 = var_3055;
         var_3129 = false;
         setComplete(false);
         setSoundChannel(var_2298.play(0,0,new SoundTransform(0)));
         return true;
      }
      
      override public function stop() : Boolean
      {
         if(getSoundChannel() != null)
         {
            getSoundChannel().stop();
         }
         return true;
      }
      
      public function update(param1:uint) : void
      {
         var_3055 += param1;
         var _loc2_:uint = var_3055 - var_3297;
         if(var_3297 > 0 && _loc2_ < 50)
         {
            setChannelVolume(0);
         }
         else if(var_3297 > 0 && _loc2_ >= 50 && _loc2_ < 175)
         {
            setChannelVolume(volume * (_loc2_ / 175));
         }
         else if(!var_3129)
         {
            setChannelVolume(volume);
            var_3129 = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_503 == null;
      }
      
      public function setPitch(param1:Number) : void
      {
         var _loc5_:Number = NaN;
         var_2000 = param1;
         var _loc6_:ByteArray = new ByteArray();
         var _loc3_:uint = uint(int(var_503.length / 4 * var_2000));
         var _loc2_:Number = 0;
         var _loc4_:int = 0;
         while(0 < _loc3_ && int(_loc2_) * 4 < var_503.length)
         {
            var_503.position = int(_loc2_) * 4;
            _loc5_ = var_503.readFloat();
            _loc6_.writeFloat(_loc5_);
            _loc6_.writeFloat(_loc5_);
            _loc2_ += var_2000;
            _loc4_++;
         }
         _loc6_.position = 0;
         var_2298.loadPCMFromByteArray(_loc6_,_loc6_.length / 8,"float");
      }
      
      private function extractMonoSamples() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:ByteArray = new ByteArray();
         _soundObject.extract(_loc1_,int(_soundObject.length * 44.1),0);
         var_503 = new ByteArray();
         var_5119 = _loc1_.length / 8;
         _loc1_.position = 0;
         var _loc2_:int = 0;
         while(0 < var_5119)
         {
            _loc3_ = _loc1_.readFloat();
            _loc1_.readFloat();
            var_503.writeFloat(_loc3_);
            _loc2_++;
         }
      }
   }
}

