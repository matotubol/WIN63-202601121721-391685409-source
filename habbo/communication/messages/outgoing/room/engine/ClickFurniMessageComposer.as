package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class ClickFurniMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      private var var_230:int = 0;
      
      public function ClickFurniMessageComposer(param1:int, param2:int = 0)
      {
         super();
         var_315 = param1;
         var_230 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_315,var_230];
      }
   }
}

