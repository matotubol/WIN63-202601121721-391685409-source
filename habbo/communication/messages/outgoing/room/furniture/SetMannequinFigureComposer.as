package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetMannequinFigureComposer implements IMessageComposer
   {
      
      private var var_2536:int;
      
      public function SetMannequinFigureComposer(param1:int)
      {
         super();
         var_2536 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2536];
      }
      
      public function dispose() : void
      {
      }
   }
}

