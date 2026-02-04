package com.sulake.habbo.session
{
   import flash.display.BitmapData;
   
   public class BadgeInfo
   {
      
      private var var_48:BitmapData;
      
      private var var_4465:Boolean;
      
      public function BadgeInfo(param1:BitmapData, param2:Boolean)
      {
         super();
         var_48 = param1;
         var_4465 = param2;
      }
      
      public function get image() : BitmapData
      {
         return var_48;
      }
      
      public function get placeHolder() : Boolean
      {
         return var_4465;
      }
   }
}

