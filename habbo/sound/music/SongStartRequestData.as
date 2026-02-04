package com.sulake.habbo.sound.music
{
   import flash.utils.getTimer;
   
   public class SongStartRequestData
   {
      
      private var var_2766:int;
      
      private var var_3582:Number;
      
      private var _playLength:Number;
      
      private var _playRequestTime:int;
      
      private var var_5038:Number;
      
      private var var_4704:Number;
      
      public function SongStartRequestData(param1:int, param2:Number, param3:Number, param4:Number = 2, param5:Number = 1)
      {
         super();
         var_2766 = param1;
         var_3582 = param2;
         _playLength = param3;
         var_5038 = param4;
         var_4704 = param5;
         _playRequestTime = getTimer();
      }
      
      public function get songId() : int
      {
         return var_2766;
      }
      
      public function get startPos() : Number
      {
         if(var_3582 < 0)
         {
            return 0;
         }
         return var_3582 + (getTimer() - _playRequestTime) / 1000;
      }
      
      public function get playLength() : Number
      {
         return _playLength;
      }
      
      public function get fadeInSeconds() : Number
      {
         return var_5038;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return var_4704;
      }
   }
}

