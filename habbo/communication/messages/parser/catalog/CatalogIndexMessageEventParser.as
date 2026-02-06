package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2971;
   
   [SecureSWF(rename="true")]
   public class CatalogIndexMessageEventParser implements IMessageParser
   {
      
      private var var_134:class_2971;
      
      private var var_2609:Boolean;
      
      private var var_327:String;
      
      public function CatalogIndexMessageEventParser()
      {
         super();
      }
      
      public function get root() : class_2971
      {
         return var_134;
      }
      
      public function get newAdditionsAvailable() : Boolean
      {
         return var_2609;
      }
      
      public function get catalogType() : String
      {
         return var_327;
      }
      
      public function flush() : Boolean
      {
         var_134 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_134 = new class_2971(param1);
         var_2609 = param1.readBoolean();
         var_327 = param1.readString();
         return true;
      }
   }
}

