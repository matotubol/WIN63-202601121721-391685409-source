package com.sulake.habbo.room
{
   public class PetColorResult
   {
      
      private static const COLOR_TAGS:Array = ["Null","Black","White","Grey","Red","Orange","Pink","Green","Lime","Blue","Light-Blue","Dark-Blue","Yellow","Brown","Dark-Brown","Beige","Cyan","Purple","Gold"];
      
      private var var_4573:int;
      
      private var var_3795:String;
      
      private var var_197:String;
      
      private var _primaryColor:int = 0;
      
      private var _secondaryColor:int = 0;
      
      private var var_4383:Boolean = false;
      
      private var var_2860:Array = [];
      
      public function PetColorResult(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Boolean, param7:Array)
      {
         super();
         _primaryColor = param1 & 0xFFFFFF;
         _secondaryColor = param2 & 0xFFFFFF;
         var_4573 = param3;
         var_3795 = param4 > -1 && param4 < COLOR_TAGS.length ? COLOR_TAGS[param4] : "";
         var_197 = param5;
         var_4383 = param6;
         var_2860 = param7;
      }
      
      public function get primaryColor() : int
      {
         return _primaryColor;
      }
      
      public function get secondaryColor() : int
      {
         return _secondaryColor;
      }
      
      public function get breed() : int
      {
         return var_4573;
      }
      
      public function get tag() : String
      {
         return var_3795;
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get isMaster() : Boolean
      {
         return var_4383;
      }
      
      public function get layerTags() : Array
      {
         return var_2860;
      }
   }
}

