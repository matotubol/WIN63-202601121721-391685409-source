package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2375;
   
   [SecureSWF(rename="true")]
   public class HabboClubExtendOfferMessageEventParser implements IMessageParser
   {
      
      private var _offer:class_2375;
      
      public function HabboClubExtendOfferMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _offer = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offer = new class_2375(param1);
         return true;
      }
      
      public function offer() : class_2375
      {
         return _offer;
      }
   }
}

