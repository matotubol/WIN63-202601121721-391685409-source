package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3930
   {
      
      private var var_2895:int;
      
      private var _figureString:String;
      
      private var var_111:String;
      
      public function class_3930(param1:IMessageDataWrapper)
      {
         super();
         var_2895 = param1.readInteger();
         _figureString = param1.readString();
         var_111 = param1.readString();
      }
      
      public function get slotId() : int
      {
         return var_2895;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
   }
}

