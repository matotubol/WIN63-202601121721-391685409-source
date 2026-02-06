package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FlatCreatedEventParser implements IMessageParser
   {
      
      private var _flatId:int;
      
      private var var_4357:String;
      
      public function FlatCreatedEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._flatId = param1.readInteger();
         this.var_4357 = param1.readString();
         class_21.log("FLAT CREATED: " + this._flatId + ", " + this.var_4357);
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get flatName() : String
      {
         return var_4357;
      }
   }
}

