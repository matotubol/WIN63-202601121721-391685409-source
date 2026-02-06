package com.sulake.habbo.communication.messages.outgoing.game.lobby
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class class_2361 implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function class_2361(param1:int)
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
         var_24 = [];
      }
   }
}

