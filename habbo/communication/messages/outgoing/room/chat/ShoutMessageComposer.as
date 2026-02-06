package com.sulake.habbo.communication.messages.outgoing.room.chat
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ShoutMessageComposer implements IMessageComposer
   {
      
      private var _text:String;
      
      private var var_3109:int = 0;
      
      public function ShoutMessageComposer(param1:String, param2:int = 0)
      {
         super();
         _text = param1;
         var_3109 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [_text,var_3109];
      }
   }
}

