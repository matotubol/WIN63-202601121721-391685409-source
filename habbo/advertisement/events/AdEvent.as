package com.sulake.habbo.advertisement.events
{
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class AdEvent extends Event
   {
      
      public static const ROOM_AD_IMAGE_LOADED:String = "AE_ROOM_AD_IMAGE_LOADED";
      
      public static const ROOM_AD_IMAGE_LOADING_FAILED:String = "AE_ROOM_AD_IMAGE_LOADING_FAILED";
      
      public static const ROOM_AD_SHOW:String = "AE_ROOM_AD_SHOW";
      
      private var var_48:BitmapData;
      
      private var var_1951:int;
      
      private var var_319:String;
      
      private var var_3289:String;
      
      private var var_4516:BitmapData;
      
      private var var_4232:BitmapData;
      
      private var var_315:int;
      
      private var var_3874:int;
      
      public function AdEvent(param1:String, param2:int, param3:BitmapData = null, param4:String = "", param5:String = "", param6:BitmapData = null, param7:BitmapData = null, param8:int = -1, param9:int = -1, param10:Boolean = false, param11:Boolean = false)
      {
         super(param1,param10,param11);
         var_48 = param3;
         var_1951 = param2;
         var_319 = param4;
         var_3289 = param5;
         var_4516 = param6;
         var_4232 = param7;
         var_315 = param8;
         var_3874 = param9;
      }
      
      public function get image() : BitmapData
      {
         return var_48;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get imageUrl() : String
      {
         return var_319;
      }
      
      public function get clickUrl() : String
      {
         return var_3289;
      }
      
      public function get adWarningL() : BitmapData
      {
         return var_4516;
      }
      
      public function get adWarningR() : BitmapData
      {
         return var_4232;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get objectCategory() : int
      {
         return var_3874;
      }
   }
}

