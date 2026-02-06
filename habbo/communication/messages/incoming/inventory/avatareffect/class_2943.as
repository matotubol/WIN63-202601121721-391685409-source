package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
   [SecureSWF(rename="true")]
   public class class_2943
   {
      
      private var var_230:int;
      
      private var var_3316:int;
      
      private var var_2740:int;
      
      private var var_4968:int;
      
      private var var_4064:int;
      
      private var var_3835:Boolean;
      
      public function class_2943()
      {
         super();
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function set type(param1:int) : void
      {
         var_230 = param1;
      }
      
      public function get subType() : int
      {
         return var_3316;
      }
      
      public function set subType(param1:int) : void
      {
         var_3316 = param1;
      }
      
      public function get duration() : int
      {
         return var_2740;
      }
      
      public function set duration(param1:int) : void
      {
         var_2740 = param1;
      }
      
      public function get inactiveEffectsInInventory() : int
      {
         return var_4968;
      }
      
      public function set inactiveEffectsInInventory(param1:int) : void
      {
         var_4968 = param1;
      }
      
      public function get secondsLeftIfActive() : int
      {
         return var_4064;
      }
      
      public function set secondsLeftIfActive(param1:int) : void
      {
         var_4064 = param1;
      }
      
      public function get isPermanent() : Boolean
      {
         return var_3835;
      }
      
      public function set isPermanent(param1:Boolean) : void
      {
         var_3835 = param1;
      }
   }
}

