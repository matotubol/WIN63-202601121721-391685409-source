package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetItemDataMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      private var var_24:String;
      
      private var var_628:String;
      
      public function SetItemDataMessageComposer(param1:int, param2:String = "", param3:String = "")
      {
         super();
         var_315 = param1;
         var_24 = param3;
         var_628 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_315,var_628,var_24];
      }
   }
}

