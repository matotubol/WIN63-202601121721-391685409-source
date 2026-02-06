package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class ModTradingLockMessageComposer implements IMessageComposer, class_13
   {
      
      public static const const_20:int = -1;
      
      private var var_120:Array = [];
      
      public function ModTradingLockMessageComposer(param1:int, param2:String, param3:int, param4:int, param5:int)
      {
         super();
         this.var_120.push(param1);
         this.var_120.push(param2);
         this.var_120.push(param3);
         this.var_120.push(param4);
         if(param5 != -1)
         {
            this.var_120.push(param5);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.var_120;
      }
      
      public function dispose() : void
      {
         this.var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

