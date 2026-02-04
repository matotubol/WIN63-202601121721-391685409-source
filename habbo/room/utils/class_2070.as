package com.sulake.habbo.room.utils
{
   import com.sulake.room.object.IRoomObjectController;
   
   [SecureSWF(rename="true")]
   public class class_2070
   {
      
      private var var_612:IRoomObjectController;
      
      private var var_4319:Boolean;
      
      public function class_2070(param1:IRoomObjectController, param2:Boolean)
      {
         super();
         var_612 = param1;
         var_4319 = param2;
      }
      
      public function get object() : IRoomObjectController
      {
         return var_612;
      }
      
      public function get groupBadge() : Boolean
      {
         return var_4319;
      }
   }
}

