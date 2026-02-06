package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3292
   {
      
      public static const const_868:int = 0;
      
      private var var_2755:int;
      
      private var var_2493:int;
      
      private var var_605:String;
      
      private var var_3223:int;
      
      private var var_61:int;
      
      public function class_3292(param1:IMessageDataWrapper)
      {
         super();
         var_2755 = param1.readInteger();
         var_2493 = param1.readInteger();
         var_605 = param1.readString();
         var_3223 = param1.readInteger();
         var_61 = param1.readInteger();
      }
      
      public function dispose() : void
      {
         var_2755 = 0;
         var_2493 = 0;
         var_605 = "";
         var_3223 = 0;
      }
      
      public function get achievementId() : int
      {
         return var_2755;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function get badgeId() : String
      {
         return var_605;
      }
      
      public function get requiredLevel() : int
      {
         return var_3223;
      }
      
      public function get enabled() : Boolean
      {
         return var_61 == 0;
      }
      
      public function get state() : int
      {
         return var_61;
      }
   }
}

