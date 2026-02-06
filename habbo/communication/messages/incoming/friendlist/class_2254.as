package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2254
   {
      
      private var var_2563:int;
      
      private var _requesterName:String;
      
      private var var_4044:int;
      
      private var _figureString:String;
      
      public function class_2254(param1:IMessageDataWrapper)
      {
         super();
         var_2563 = param1.readInteger();
         _requesterName = param1.readString();
         _figureString = param1.readString();
         var_4044 = var_2563;
      }
      
      public function get requestId() : int
      {
         return var_2563;
      }
      
      public function get requesterName() : String
      {
         return _requesterName;
      }
      
      public function get requesterUserId() : int
      {
         return var_4044;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
   }
}

