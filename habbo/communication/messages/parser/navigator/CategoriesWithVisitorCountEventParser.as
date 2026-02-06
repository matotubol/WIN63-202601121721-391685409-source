package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_3568;
   
   [SecureSWF(rename="true")]
   public class CategoriesWithVisitorCountEventParser implements IMessageParser
   {
      
      private var var_24:class_3568;
      
      public function CategoriesWithVisitorCountEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_3568(param1);
         return true;
      }
      
      public function get data() : class_3568
      {
         return var_24;
      }
   }
}

