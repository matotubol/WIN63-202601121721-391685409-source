package com.sulake.habbo.communication.messages.incoming.navigator
{
   [SecureSWF(rename="true")]
   public class class_3691
   {
      
      private var var_3605:int;
      
      private var var_3646:int;
      
      public function class_3691()
      {
         super();
      }
      
      public function getCopy() : class_3691
      {
         var _loc1_:class_3691 = new class_3691();
         _loc1_.var_3605 = this.var_3605;
         _loc1_.var_3646 = this.var_3646;
         return _loc1_;
      }
      
      public function set pos(param1:int) : void
      {
         this.var_3605 = param1;
      }
      
      public function set imgId(param1:int) : void
      {
         this.var_3646 = param1;
      }
      
      public function get pos() : int
      {
         return var_3605;
      }
      
      public function get imgId() : int
      {
         return var_3646;
      }
   }
}

