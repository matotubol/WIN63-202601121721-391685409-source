package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3986 implements IMessageParser
   {
      
      private var var_1932:Boolean;
      
      private var var_3815:String;
      
      private var var_5045:String;
      
      private var var_4530:int;
      
      public function class_3986()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1932 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3815 = param1.readString();
         if(var_3815 != "")
         {
            var_1932 = true;
         }
         var_5045 = param1.readString();
         var_4530 = param1.readInteger();
         return true;
      }
      
      public function get available() : Boolean
      {
         return var_1932;
      }
      
      public function get pricePointUrl() : String
      {
         return var_3815;
      }
      
      public function get market() : String
      {
         return var_5045;
      }
      
      public function get lengthInDays() : int
      {
         return var_4530;
      }
   }
}

