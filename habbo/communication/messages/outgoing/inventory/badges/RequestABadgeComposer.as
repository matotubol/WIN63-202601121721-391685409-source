package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RequestABadgeComposer implements IMessageComposer
   {
      
      private var var_4225:String;
      
      public function RequestABadgeComposer(param1:String)
      {
         super();
         var_4225 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_4225);
         return _loc1_;
      }
   }
}

