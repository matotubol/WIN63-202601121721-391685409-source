package com.sulake.habbo.navigator.domain
{
   import com.sulake.core.window.class_1812;
   
   public class RoomLayout
   {
      
      private var var_2493:int;
      
      private var var_4311:int;
      
      private var _name:String;
      
      private var var_18:class_1812;
      
      public function RoomLayout(param1:int, param2:int, param3:String)
      {
         super();
         var_2493 = param1;
         var_4311 = param2;
         _name = param3;
      }
      
      public function get requiredClubLevel() : int
      {
         return var_2493;
      }
      
      public function get tileSize() : int
      {
         return var_4311;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get view() : class_1812
      {
         return var_18;
      }
      
      public function set view(param1:class_1812) : void
      {
         var_18 = param1;
      }
   }
}

