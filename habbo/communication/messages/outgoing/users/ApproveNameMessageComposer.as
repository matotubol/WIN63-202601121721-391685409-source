package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ApproveNameMessageComposer implements IMessageComposer
   {
      
      private var _name:String;
      
      private var var_230:int;
      
      public function ApproveNameMessageComposer(param1:String, param2:int)
      {
         super();
         _name = param1;
         var_230 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [_name,var_230];
      }
      
      public function dispose() : void
      {
      }
   }
}

