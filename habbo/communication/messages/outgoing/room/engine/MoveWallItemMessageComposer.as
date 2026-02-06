package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MoveWallItemMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function MoveWallItemMessageComposer(param1:int, param2:int, param3:String)
      {
         super();
         var_24.push(param1);
         var_24.push(param3);
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
   }
}

