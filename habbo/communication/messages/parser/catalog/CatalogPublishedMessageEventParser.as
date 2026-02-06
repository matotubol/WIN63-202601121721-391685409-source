package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPublishedMessageEventParser implements IMessageParser
   {
      
      private var var_4281:Boolean;
      
      private var _newFurniDataHash:String;
      
      public function CatalogPublishedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4281 = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            _newFurniDataHash = param1.readString();
         }
         return true;
      }
      
      public function get instantlyRefreshCatalogue() : Boolean
      {
         return var_4281;
      }
      
      public function get newFurniDataHash() : String
      {
         return _newFurniDataHash;
      }
   }
}

