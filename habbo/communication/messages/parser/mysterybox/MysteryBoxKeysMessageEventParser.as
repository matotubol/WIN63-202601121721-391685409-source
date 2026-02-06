package com.sulake.habbo.communication.messages.parser.mysterybox
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MysteryBoxKeysMessageEventParser implements IMessageParser
   {
      
      private var _boxColor:String;
      
      private var _keyColor:String;
      
      public function MysteryBoxKeysMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _boxColor = null;
         _keyColor = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _boxColor = param1.readString();
         _keyColor = param1.readString();
         return true;
      }
      
      public function get boxColor() : String
      {
         return _boxColor;
      }
      
      public function get keyColor() : String
      {
         return _keyColor;
      }
   }
}

