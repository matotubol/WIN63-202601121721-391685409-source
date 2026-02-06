package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FlatControllerRemovedEventParser implements IMessageParser
   {
      
      private var _flatId:int;
      
      private var var_1270:int;
      
      public function FlatControllerRemovedEventParser()
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
         this.var_1270 = param1.readInteger();
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
   }
}

