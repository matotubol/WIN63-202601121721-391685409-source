package com.sulake.habbo.groups
{
   public class GuildKickData
   {
      
      private var var_4390:int;
      
      private var var_3822:int;
      
      private var var_5085:Boolean;
      
      public function GuildKickData(param1:int, param2:int, param3:Boolean = false)
      {
         super();
         var_4390 = param1;
         var_3822 = param2;
         var_5085 = param3;
      }
      
      public function get kickTargetId() : int
      {
         return var_4390;
      }
      
      public function get kickGuildId() : int
      {
         return var_3822;
      }
      
      public function get targetBlocked() : Boolean
      {
         return var_5085;
      }
   }
}

