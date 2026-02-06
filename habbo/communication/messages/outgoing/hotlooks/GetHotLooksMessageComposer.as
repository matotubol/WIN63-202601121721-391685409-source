package com.sulake.habbo.communication.messages.outgoing.hotlooks
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.util.Byte;
   
   [SecureSWF(rename="true")]
   public class GetHotLooksMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function GetHotLooksMessageComposer(param1:int)
      {
         super();
         var_120.push(new Byte(param1));
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
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

