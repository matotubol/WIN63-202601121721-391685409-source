package com.sulake.habbo.ui.widget.infostand
{
   import flash.utils.Dictionary;
   
   public class CommandConfiguration
   {
      
      private var var_4783:Array;
      
      private var var_2317:Dictionary = new Dictionary();
      
      public function CommandConfiguration(param1:Array, param2:Array)
      {
         super();
         var_4783 = param1;
         while(0 < param2.length)
         {
            var _loc4_:int = int(param2[0]);
            var_2317[0] = true;
            _loc3_++;
         }
      }
      
      public function get allCommandIds() : Array
      {
         return var_4783;
      }
      
      public function isEnabled(param1:int) : Boolean
      {
         return var_2317[param1] != null;
      }
   }
}

