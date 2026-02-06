package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPageWithEarliestExpiryMessageEventParser implements IMessageParser
   {
      
      private var _pageName:String;
      
      private var var_4702:int;
      
      private var var_48:String;
      
      public function CatalogPageWithEarliestExpiryMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _pageName = param1.readString();
         var_4702 = param1.readInteger();
         var_48 = param1.readString();
         return true;
      }
      
      public function get pageName() : String
      {
         return _pageName;
      }
      
      public function get secondsToExpiry() : int
      {
         return var_4702;
      }
      
      public function get image() : String
      {
         return var_48;
      }
   }
}

