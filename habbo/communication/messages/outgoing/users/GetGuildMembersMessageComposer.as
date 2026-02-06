package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetGuildMembersMessageComposer implements IMessageComposer
   {
      
      public static const const_358:int = 0;
      
      public static const const_446:int = 1;
      
      public static const const_704:int = 2;
      
      private var var_24:Array = [];
      
      public function GetGuildMembersMessageComposer(param1:int, param2:int, param3:String, param4:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
         var_24.push(param3);
         var_24.push(param4);
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

