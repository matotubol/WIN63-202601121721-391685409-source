package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3569;
   
   [SecureSWF(rename="true")]
   public class WiredValidationErrorEventParser implements IMessageParser
   {
      
      private var _localizationKey:String;
      
      private var _parameters:Array;
      
      public function WiredValidationErrorEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _localizationKey = null;
         _parameters = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _localizationKey = param1.readString();
         _parameters = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _parameters.push(new class_3569(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get localizationKey() : String
      {
         return _localizationKey;
      }
      
      public function get parameters() : Array
      {
         return _parameters;
      }
   }
}

