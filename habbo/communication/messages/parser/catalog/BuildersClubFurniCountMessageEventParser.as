package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubFurniCountMessageEventParser implements IMessageParser
   {
      
      private var var_4175:int;
      
      public function BuildersClubFurniCountMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4175 = param1.readInteger();
         return true;
      }
      
      public function get furniCount() : int
      {
         return var_4175;
      }
   }
}

