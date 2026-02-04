package com.sulake.habbo.sound.trax
{
   public class TraxChannelItem
   {
      
      private var var_197:int;
      
      private var _length:int;
      
      public function TraxChannelItem(param1:int, param2:int)
      {
         super();
         var_197 = param1;
         _length = param2;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get length() : int
      {
         return _length;
      }
   }
}

