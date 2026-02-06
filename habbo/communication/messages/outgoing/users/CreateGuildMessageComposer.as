package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CreateGuildMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function CreateGuildMessageComposer(param1:String, param2:String, param3:int, param4:int, param5:int, param6:Array)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
         var_24.push(param3);
         var_24.push(param4);
         var_24.push(param5);
         var_24.push(param6.length);
         var _loc7_:int = 0;
         while(0 < param6.length)
         {
            var_24.push(int(param6[0]));
            _loc7_++;
         }
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

