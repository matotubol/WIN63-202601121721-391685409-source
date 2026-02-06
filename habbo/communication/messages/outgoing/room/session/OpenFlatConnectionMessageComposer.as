package com.sulake.habbo.communication.messages.outgoing.room.session
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class OpenFlatConnectionMessageComposer implements IMessageComposer
   {
      
      private var var_986:Array;
      
      public function OpenFlatConnectionMessageComposer(param1:int, param2:String = "", param3:int = -1)
      {
         super();
         var_986 = [param1,param2,param3];
      }
      
      public function dispose() : void
      {
         var_986 = null;
      }
      
      public function getMessageArray() : Array
      {
         return var_986;
      }
   }
}

