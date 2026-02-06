package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2482
   {
      
      private var var_2851:int;
      
      private var var_4008:String;
      
      private var var_588:Boolean;
      
      public function class_2482(param1:IMessageDataWrapper)
      {
         super();
         var_2851 = param1.readInteger();
         var_4008 = param1.readString();
         var_588 = param1.readBoolean();
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function get categoryName() : String
      {
         return var_4008;
      }
      
      public function get visible() : Boolean
      {
         return var_588;
      }
   }
}

