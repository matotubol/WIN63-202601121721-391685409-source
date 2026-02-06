package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetClothingChangeDataMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      private var var_111:String;
      
      private var var_4384:String;
      
      public function SetClothingChangeDataMessageComposer(param1:int, param2:String, param3:String = "")
      {
         super();
         var_315 = param1;
         var_111 = param2;
         var_4384 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_315,var_111,var_4384];
      }
   }
}

