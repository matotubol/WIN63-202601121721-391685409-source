package com.sulake.habbo.communication.messages.parser.campaign
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CampaignCalendarDoorOpenedMessageEventParser implements IMessageParser
   {
      
      private var var_3372:Boolean;
      
      private var _productName:String;
      
      private var var_2679:String;
      
      private var var_2783:String;
      
      public function CampaignCalendarDoorOpenedMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3372 = param1.readBoolean();
         _productName = param1.readString();
         var_2679 = param1.readString();
         var_2783 = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         var_3372 = false;
         _productName = null;
         var_2679 = null;
         var_2783 = null;
         return true;
      }
      
      public function get doorOpened() : Boolean
      {
         return var_3372;
      }
      
      public function get productName() : String
      {
         return _productName;
      }
      
      public function get customImage() : String
      {
         return var_2679;
      }
      
      public function get furnitureClassName() : String
      {
         return var_2783;
      }
   }
}

