package com.sulake.habbo.avatar.structure.parts
{
   public class ActivePartSet
   {
      
      private var var_197:String;
      
      private var var_406:Array;
      
      public function ActivePartSet(param1:XML)
      {
         super();
         var_197 = String(param1.@id);
         var_406 = [];
         for each(var _loc2_ in param1.activePart)
         {
            var_406.push(String(_loc2_["set-type"]));
         }
      }
      
      public function get parts() : Array
      {
         return var_406;
      }
   }
}

