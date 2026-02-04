package com.sulake.room.renderer.cache
{
   [SecureSWF(rename="true")]
   public class class_3817
   {
      
      private var var_315:int;
      
      private var var_559:class_3733 = null;
      
      private var var_170:class_3810 = null;
      
      public function class_3817(param1:String)
      {
         super();
         var_559 = new class_3733(param1);
         var_170 = new class_3810();
      }
      
      public function get location() : class_3733
      {
         return var_559;
      }
      
      public function get sprites() : class_3810
      {
         return var_170;
      }
      
      public function dispose() : void
      {
         if(var_559 != null)
         {
            var_559.dispose();
            var_559 = null;
         }
         if(var_170 != null)
         {
            var_170.dispose();
            var_170 = null;
         }
      }
      
      public function set objectId(param1:int) : void
      {
         var_315 = param1;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
   }
}

