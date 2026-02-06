package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1933;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2138;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2409;
   
   [SecureSWF(rename="true")]
   public class CatalogPageMessageEventParser implements IMessageParser
   {
      
      private var var_2228:int;
      
      private var var_327:String;
      
      private var var_1333:String;
      
      private var _localization:class_2409;
      
      private var _offers:Vector.<class_2138>;
      
      private var _offerId:int;
      
      private var var_3043:Boolean;
      
      private var _frontPageItems:Vector.<class_1933>;
      
      public function CatalogPageMessageEventParser()
      {
         super();
      }
      
      public function get pageId() : int
      {
         return var_2228;
      }
      
      public function get catalogType() : String
      {
         return var_327;
      }
      
      public function get layoutCode() : String
      {
         return var_1333;
      }
      
      public function get localization() : class_2409
      {
         return _localization;
      }
      
      public function get offers() : Vector.<class_2138>
      {
         return _offers;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get acceptSeasonCurrencyAsCredits() : Boolean
      {
         return var_3043;
      }
      
      public function get frontPageItems() : Vector.<class_1933>
      {
         return _frontPageItems;
      }
      
      public function flush() : Boolean
      {
         var_2228 = -1;
         var_327 = "";
         var_1333 = "";
         _localization = null;
         _offers = new Vector.<class_2138>(0);
         _offerId = -1;
         var_3043 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2228 = param1.readInteger();
         var_327 = param1.readString();
         var_1333 = param1.readString();
         _localization = new class_2409(param1);
         _offers = new Vector.<class_2138>(0);
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _offers.push(new class_2138(param1));
            _loc3_++;
         }
         _offerId = param1.readInteger();
         var_3043 = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            _frontPageItems = new Vector.<class_1933>(0);
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while(0 < _loc2_)
            {
               _frontPageItems.push(new class_1933(param1));
               _loc3_++;
            }
         }
         return true;
      }
   }
}

