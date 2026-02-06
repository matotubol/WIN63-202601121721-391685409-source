package com.sulake.habbo.communication.messages.incoming.hotlooks
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3684
   {
      
      private var var_111:String;
      
      private var _figureString:String;
      
      public function class_3684(param1:IMessageDataWrapper)
      {
         super();
         var_111 = param1.readString();
         _figureString = param1.readString();
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
   }
}

