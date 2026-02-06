package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class class_2324 implements IMessageComposer
   {
      
      protected var var_24:Array = [];
      
      public function class_2324(param1:int)
      {
         super();
         var_24.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
   }
}

