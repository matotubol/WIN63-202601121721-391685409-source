package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_4068 implements IMessageParser
   {
      
      private var _pageName:String;
      
      private var var_2228:int;
      
      private var var_4702:int;
      
      private var var_48:String;
      
      public function class_4068()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2228 = param1.readInteger();
         _pageName = param1.readString();
         var_4702 = param1.readInteger();
         var_48 = param1.readString();
         return true;
      }
      
      public function get pageName() : String
      {
         return _pageName;
      }
      
      public function get pageId() : int
      {
         return var_2228;
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

