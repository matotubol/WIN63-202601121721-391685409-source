package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2138;
   
   [SecureSWF(rename="true")]
   public class SeasonalCalendarDailyOfferMessageEventParser implements IMessageParser
   {
      
      private var var_2228:int;
      
      private var var_3075:class_2138;
      
      public function SeasonalCalendarDailyOfferMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2228 = -1;
         var_3075 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2228 = param1.readInteger();
         var_3075 = new class_2138(param1);
         return true;
      }
      
      public function get pageId() : int
      {
         return var_2228;
      }
      
      public function get offerData() : class_2138
      {
         return var_3075;
      }
   }
}

